<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;
use App\Models\ServerModel as Server;
use App\Models\Machine;
use App\Models\TopicModel as Topic;
use Illuminate\Support\Facades\DB;

class ManageTopicController extends Controller
{
    public function index(Request $request)
    {
        if ($request->wantsJson()) {
            $topics = Topic::selectRaw(
                'mtopic.*, mach.txtmachinename,
                CONCAT(`mbroker`.`txthost`, " - ", `mbroker`.`intport`) AS broker'
            )
                ->join('mmachines AS mach', 'mach.id', '=', 'mtopic.machine_id')
                ->join('mbroker', 'mbroker.id', '=', 'mtopic.broker_id')
                ->get();
            return DataTables::of($topics)
                ->addIndexColumn()
                ->addColumn('topic_detail', function ($row) {
                    $topics = DB::table('tr_topic')
                        ->where('topic_id', $row->id)
                        ->get();
                    return json_encode($topics);
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
                ->rawColumns(['topic_detail', 'action'])
                ->make(true);
        } else {
            $brokers = Server::all();
            return view('pages.admin.topic', [
                'brokers' => $brokers,
                'machines' => Machine::select('mmachines.id', 'mmachines.txtmachinename', 'mline.txtlinename')
                    ->join('mline', 'mline.id','=','mmachines.line_id')
                    ->where('intbottleneck', 1)
                    ->get(),
            ]);
        }
    }
    public function store(Request $request)
    {
        $broker_id = $request->broker_id;
        $machine_id = $request->machine_id;
        $topicname = $request->txtname;
        $topic = $request->txttopic;
        $activity = $request->activity_id;
        $create = Topic::create([
            'broker_id' => $broker_id,
            'machine_id' => $machine_id,
        ]);
        if ($create) {
            // $file = 'cd ../../mqtt_php && sub.bat';
            // exec('TASKKILL /FI "WindowTitle eq Subscribe"');
            // exec($file);
            $result = [];
            foreach ($topicname as $key => $val) {
                $result[] = [
                    'topic_id' => $create->id,
                    'txtname' => $topicname[$key],
                    'txttopic' => $topic[$key],
                    'activity_id' => $activity[$key]
                ];
            }
            $insert = DB::table('tr_topic')->insert($result);
            if ($insert) {
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'Topic created Successfully',
                    ],
                    200
                );
            }
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Topic created failed',
                ],
                401
            );
        }
    }
    public function edit($id)
    {
        $topic = Topic::find($id);
        $topics = DB::table('tr_topic')
            ->where('topic_id', $id)
            ->get();
        if ($topic) {
            return response()->json(
                [
                    'topic' => $topic,
                    'topics' => $topics,
                    'status' => 'success',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'message' => 'Topic not found',
                    'status' => 'error',
                ],
                404
            );
        }
    }
    public function update($id, Request $request)
    {
        $broker_id = $request->broker_id;
        $machine_id = $request->machine_id;
        $topicname = $request->txtname;
        $txttopic = $request->txttopic;
        $activity = $request->activity_id;
        $data = [
            'broker_id' => $broker_id,
            'machine_id' => $machine_id,
        ];
        $topic = Topic::find($id);
        if ($topic) {
            // $file = 'cd ../../mqtt_php && sub.bat';
            // exec('TASKKILL /FI "WindowTitle eq Subscribe"');
            // exec($file);
            $topic->update($data);
            $result = [];
            foreach ($topicname as $key => $val) {
                $result[] = [
                    'topic_id' => $id,
                    'txtname' => $topicname[$key],
                    'txttopic' => $txttopic[$key],
                    'activity_id' => $activity[$key]
                ];
            }
            DB::table('tr_topic')
                ->where('topic_id', $id)
                ->delete();
            DB::table('tr_topic')->insert($result);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Topic created Successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Topic not found',
                ],
                404
            );
        }
    }
    public function destroy($id)
    {
        $topic = Topic::find($id);
        if ($topic) {
            // $file = 'cd ../../mqtt_php && sub.bat';
            // exec('TASKKILL /FI "WindowTitle eq Subscribe"');
            // exec($file);
            $topic->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Topic successfully Deleted',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Topic deleted Failed',
                ],
                404
            );
        }
    }
}
