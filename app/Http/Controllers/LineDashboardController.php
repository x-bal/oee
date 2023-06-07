<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\KpiModel as Kpi;
use App\Models\LineProcess as Line;
use App\Models\OeeModel as Oee;
use App\Models\OeeDrierModel as OeeDrier;
use Illuminate\Support\Facades\Auth;

class LineDashboardController extends Controller
{
    public function getIndex(Request $request)
    {
        $view = Auth::check() ? 'pages.line-dashboard' : 'pages.auth.line';
        $line = Auth::check() ? $request->segment(3) : $request->segment(2);
        $poe = DB::table('mkpi')
            ->where(
                'txtyear',
                !empty($request->year) ? $request->year : date('Y')
            )
            ->first();
        $oee = DB::table('tr_kpi')
            ->selectRaw(
                '
                IFNULL(CAST((SUM(ar)/COUNT(ar)) AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(pr)/COUNT(pr)) AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(qr)/COUNT(qr)) AS DECIMAL(10, 2)), 0) AS qr
            '
            )
            ->where('kpi_id', !empty($poe) ? $poe->id : 0)
            ->first();
        $actual_oee = DB::table('v_shift_oee')
            ->selectRaw(
                '
                id, avaibility_rate AS ar, performance_rate AS pr, quality_rate AS qr, utilization
            '
            )
            ->where('line_id', $line)
            ->first();
        $years = KPI::groupBy('txtyear')->get();
        return view($view, [
            'target_poe' => !empty($poe) ? $poe->poe : 0,
            'target_oee' => $oee,
            'actual_oee' => $actual_oee,
            'years' => $years,
            'lines' => Line::all(),
        ]);
    }
    public function getOeeChart(Request $request)
    {
        $oee = DB::table('v_shift_oee')->where('line_id', $request->line_id)->orderBy('id', 'DESC')->first();
        return response()->json([
            'status' => 'success',
            'oee' => $oee
        ], 200);
    }
}
