<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\KpiModel as Kpi;
use App\Models\LineProcess as Line;

class DashboardController extends Controller
{
    public function getIndex(Request $request)
    {
        $poe = DB::table('mkpi')->where('txtyear', (!empty($request->year)?$request->year:date('Y')))->first();
        $oee = DB::table('tr_kpi')
            ->selectRaw('
                IFNULL(CAST((SUM(ar)/COUNT(ar)) AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(pr)/COUNT(pr)) AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(qr)/COUNT(qr)) AS DECIMAL(10, 2)), 0) AS qr
            ')
            ->where('kpi_id', (!empty($poe)?$poe->id:0))
            ->first();
        $actual_oee = DB::table('v_calc_poe')
            ->selectRaw('
                id, YEAR(tanggal), SUM(total_output),
                IFNULL(CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)), 0) AS qr
            ')
            ->whereYear('tanggal', (!empty($request->year)?$request->year:date('Y')))
            ->groupBy(DB::raw('YEAR(tanggal)'))
            ->first();
        $years = KPI::groupBy('txtyear')->get();
        return view('pages.dashboard',[
            'target_poe' => (!empty($poe)?$poe->poe:0),
            'target_oee' => $oee,
            'actual_oee' => $actual_oee,
            'years' => $years,
            'lines' => Line::all()
        ]);
    }

    public function setLineOrLeader(Request $request)
    {
        $leader = $request->input('leader_id');
        session()->put('line', $request->input('line_id'));
        if (!empty($leader)) {
            session()->put('leader', $leader);
        }
        return response()->json(
            [
                'status' => 'success',
                'message' => 'Leader Or/And Line has been set',
            ],
            200
        );
    }
}
