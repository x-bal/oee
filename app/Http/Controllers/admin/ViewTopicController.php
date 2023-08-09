<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;
use App\Models\TopicModel as Topic;
use App\Models\ServerModel as Server;
use Illuminate\Support\Facades\DB;

class ViewTopicController extends Controller
{
    public function getResults(Request $request)
    {
        if ($request->wantsJson()) {
            $topics = Topic::selectRaw(
                'mtopic.*, mach.txtmachinename, trt.*,
                CONCAT(`mbroker`.`txthost`, " - ", `mbroker`.`intport`) AS broker'
            )
            ->join('mmachines AS mach', 'mach.id', '=', 'mtopic.machine_id')
            ->join('mbroker', 'mbroker.id', '=', 'mtopic.broker_id')
            ->join('tr_topic AS trt','trt.topic_id','=','mtopic.id')
            ->get();
        return DataTables::of($topics)
            ->addIndexColumn()
            ->addColumn('message', function ($row) {
                $topics = '<span id="'.$row->topic_id.'-'.$row->txtname.'" title="Broker not Connected"><i style="color: red;" class="fas fa-exclamation-triangle fa-2x"></i></span>';
                return $topics;
            })
            ->addColumn('action', function ($row) {
                $btn_edit =
                    '<a type="button" class="btn btn-sm btn-square btn-success" onclick="edit(' .
                    $row->id .
                    ')"><i class="fas fa-edit"></i></a>';
                $btn_delete =
                    '<a type="button" class="btn btn-sm btn-square btn-danger" onclick="destroy(' .
                    $row->id .
                    ')"><i class="fas fa-trash"></i></a>';
                $btn = $btn_edit . ' ' . $btn_delete;
                return $btn;
            })
            ->rawColumns(['message', 'action'])
            ->make(true);
        } else {
            $broker = Server::where('intactive', 1)->first();
            $topics = Topic::join('tr_topic AS trt', 'mtopic.id','=','trt.topic_id')->get();
            return view('pages.admin.topic-results', [
                'broker' => $broker,
                'topics' => $topics
            ]);
        }
    }
    public function getDetail(Request $request)
    {
        $topic = Server::select('trt.*')
            ->join('mtopic', 'mbroker.id','=','mtopic.broker_id')
            ->join('tr_topic AS trt','trt.topic_id','=','mtopic.id')
            ->where('mbroker.intactive', 1)
            ->where('trt.txttopic', $request->topic)
            ->first();
        if ($topic) {
            return response()->json([
                'status' => 'success',
                'data' => $topic
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Topic not Found'
            ], 404);
        }
    }
}
