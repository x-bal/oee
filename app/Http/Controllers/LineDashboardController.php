<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\KpiModel as Kpi;
use App\Models\LineProcess as Line;
use App\Models\ServerModel as Server;
use App\Models\TopicModel as Topic;
use Illuminate\Support\Facades\Auth;

class LineDashboardController extends Controller
{
    public function getIndex(Request $request)
    {
        $view = Auth::check() ? 'pages.line-dashboard' : 'pages.auth.line';
        $broker = Server::where('intactive', 1)->first();
        $topics = Topic::join('tr_topic AS trt', 'mtopic.id','=','trt.topic_id')->get();
        $line = Auth::check() ? $request->segment(3) : $request->segment(2);
        return view($view, [
            'lines' => Line::all(),
            'broker' => $broker,
            'topics' => $topics
        ]);
    }
    public function getOeeChart(Request $request)
    {
        $oee = DB::table('v_shift_oee')->selectRaw("
                shift_id, line_id, (SUM(avaibility_rate)/COUNT(avaibility_rate)) AS avaibility_rate,
                IFNULL((SUM(performance_rate)/COUNT(performance_rate)), 0) AS performance_rate,
                (SUM(quality_rate)/COUNT(quality_rate)) AS quality_rate,
                (SUM(utilization)/COUNT(utilization)) AS utilization
            ")
            ->where('line_id', $request->line_id)
            ->when($request->filled('tanggal'), function($query) use ($request){
                return $query->where('tanggal', $request->tanggal);
            })
            ->when(empty($request->filled('tanggal')), function($query){
                return $query->where('tanggal', date('Y-m-d'));
            })
            ->groupBy('tanggal')
            ->orderBy('id', 'DESC')
            ->first();
        return response()->json([
            'status' => 'success',
            'oee' => $oee
        ], 200);
    }
    public function getOeeShift(Request $request){
        $oee = DB::table('v_shift_oee')
            ->selectRaw("`tanggal`, `shift_id`, `avaibility_rate`, `performance_rate`, `quality_rate`, `utilization`,
            ((`avaibility_rate`+`performance_rate`+`quality_rate`+`utilization`)/4) AS `oee`")
            ->where('line_id', $request->line_id)
            ->when($request->filled('tanggal'), function($query) use ($request){
                return $query->where('tanggal', $request->tanggal);
            })
            ->when(empty($request->filled('tanggal')), function($query){
                return $query->where('tanggal', date('Y-m-d'));
            })
            ->get();
        return response()->json([
            'status' => 'success',
            'oee' => $oee
        ], 200);
    }
    public function getLineOutput(Request $request){
        $output = DB::table('v_shift_oee')
            ->selectRaw("line_id, shift_id, part_number, SUM(total_output) AS total_output")
            ->where('line_id', $request->line_id)
            ->whereNotNull('part_number')
            ->when($request->filled('tanggal'), function($query) use ($request){
                return $query->where('tanggal', $request->tanggal);
            })
            ->when(empty($request->filled('tanggal')), function($query){
                return $query->where('tanggal', date('Y-m-d'));
            })
            ->get();
        return response()->json([
            'status' => 'success',
            'output' => $output
        ], 200);
    }

    public function getOeeLine(Request $request){
        $oee = DB::table('v_shift_oee')
            ->selectRaw("`tanggal`, `txtlinename`, `shift_id`, `avaibility_rate`, `performance_rate`, `quality_rate`, `utilization`,
            ((`avaibility_rate`+`performance_rate`+`quality_rate`+`utilization`)/4) AS `oee`")
            ->join('mline', 'mline.id', '=', 'v_shift_oee.line_id')
            ->when($request->filled('tanggal'), function($query) use ($request){
                return $query->where('tanggal', $request->tanggal);
            })
            ->when(empty($request->filled('tanggal')), function($query){
                return $query->where('tanggal', date('Y-m-d'));
            })
            ->groupBy('line_id')
            ->get();
        return response()->json([
            'status' => 'success',
            'oee' => $oee
        ], 200);
    }
}
