<?php

namespace App\Http\Controllers\Opr;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;
use App\Models\PlanOrderModel as Planorder;
use App\Models\OeeModel as Oee;
use App\Models\TopicModel as Topic;
use App\Models\ServerModel as Server;
use App\Models\ActivityModel as Activity;

class OprController extends Controller
{
    public function getIndex(Request $request)
    {
        $planorder = Planorder::where('mplanorder.line_id', session()->get('line_id'))
            ->whereNotNull('is_released')
            ->whereNull('is_completed')
            ->orderBy('is_released', 'ASC')
            ->first();
        if ($request->wantsJson()) {
            $oee = Oee::leftJoin('mactivitycode', 'mactivitycode.id', '=', 'oee.activity_id')
                ->where('planorder_id', $planorder->id)
                ->orderBy('id', 'DESC')
                ->get(['oee.*', 'mactivitycode.txtactivityname']);
            return DataTables::of($oee)
                ->addIndexColumn()
                ->addColumn('action', function ($row) {
                    $btn_report =
                        '<a type="button" class="btn btn-sm btn-square btn-info" onclick="OeeModal(' .
                        $row->id .
                        ')"><i class="fas fa-eye"></i></a>';
                    $btn = $btn_report;
                    return $btn;
                })
                ->editColumn('lamakejadian', function($row){
                    return number_format($row->lamakejadian/60, 2, ',', '.');
                })
                ->rawColumns(['action'])
                ->make(true);
        } else {
            $broker = Server::where('intactive', 1)->first();
            $topics = Topic::selectRaw(
                'mtopic.*, mach.txtmachinename, trt.*,
                CONCAT(`mbroker`.`txthost`, " - ", `mbroker`.`intport`) AS broker'
            )
            ->join('mmachines AS mach', 'mach.id', '=', 'mtopic.machine_id')
            ->join('mbroker', 'mbroker.id', '=', 'mtopic.broker_id')
            ->join('tr_topic AS trt','trt.topic_id','=','mtopic.id')
            ->get();
            $bascom = [
                'Fastener', 'Lubrication', 'Pneumatic', 'Hydralic', 'Drive', 'Electric', 'Safety', 'Process Condition'
            ];
            $catbr = [
                'Man', 'Machine Weakness', 'Machine Deterioration', 'Material', 'Method'
            ];
            return view('pages.opr.opr-input', [
                'broker' => $broker,
                'topics' => $topics,
                'bascom' => $bascom,
                'catbr' => $catbr
            ]);
        }
    }
    public function getDetails()
    {
        $planorder = Planorder::select('mplanorder.*', 'mproduct.txtartcode', 'mproduct.txtproductname', 'mline.txtlinename', 'mproduct.floatstdspeed')
            ->join('mproduct', 'mproduct.id', '=', 'mplanorder.product_id')
            ->join('mline', 'mline.id', '=', 'mplanorder.line_id')
            ->where('mplanorder.line_id', session()->get('line_id'))
            ->whereNotNull('is_released')
            ->whereNull('is_completed')
            ->orderBy('is_released', 'ASC')
            ->first();
        return response()->json([
            'status' => 'success',
            'planorder' => $planorder
        ], 200);
    }
    public function getOeeDetail($id)
    {
        $oee = Oee::find($id);
        if ($oee) {
            return response()->json(
                [
                    'status' => 'success',
                    'oee' => $oee,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Cant find data !',
                ],
                404
            );
        }
    }
    public function getListActivity()
    {
        $activity = Activity::where('line_id', session()->get('line_id'))->where('txtcategory', '<>', 'pr')->get();
        if ($activity) {
            return response()->json(
                [
                    'status' => 'success',
                    'activity' => $activity,
                    'line' => session()->get('line_id')
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Cant find data !'
                ],
                404
            );
        }
    }
    public function putInputOee($id, Request $request)
    {
        $oee = Oee::find($id);
        if ($oee) {
            $data = [
                'activity_id' => $request->activity_id,
                'waiting_tech' => $request->waiting_tech,
                'repair_problem' => $request->repair_problem,
                'trial_time' => $request->trial_time,
                'tech_name' => $request->tech_name,
                'bas_com' => $request->bascom,
                'category_br' => $request->catbr,
                'category_ampm' => $request->catampm
            ];
            $oee->update($data);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Oee Activity updated !',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Cant find data !',
                ],
                404
            );
        }
    }
}
