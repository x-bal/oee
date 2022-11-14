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
        $view = Auth::check()?'pages.line-dashboard':'pages.auth.line';
        $line_id = Auth::check()?$request->segment(3):$request->segment(2);
        $detail_oee = Oee::selectRaw('produk, production_code, expired_date, okp_packing, floatbatchsize, floatstdspeed, SUM(finish_good) as    finish_good, SUM(rework) as rework, SUM(reject) as reject, operator,
        JSON_ARRAYAGG(JSON_OBJECT("category", mact.txtcategory, "activitycode", mact.txtactivitycode, "remark", oee.remark)) as listbr')
            ->where('tanggal', (!empty($request->tanggal)?$request->tanggal:date('Y-m-d')))
            ->join('mproduct', 'mproduct.txtartcode','=','oee.produk_code')
            ->join('mactivitycode as mact','mact.id','=','oee.activity_id')
            ->orderBy('oee.id', 'DESC')
            ->first();
        $actual_oee = DB::table('v_calc_poe')
            ->selectRaw('
                id, SUM(total_output),
                IFNULL(CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)), 0) AS qr
            ')
            ->where('tanggal', (!empty($request->tanggal)?$request->tanggal:date('Y-m-d')))
            ->where('line_id', $line_id)
            ->first();
        $oee_shift = DB::table('v_calc_poe')
            ->selectRaw('
                id, shift_id,
                IFNULL(CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)), 0) AS qr
            ')
            ->where('tanggal', (!empty($request->tanggal)?$request->tanggal:date('Y-m-d')))
            ->where('line_id', $line_id)
            ->groupBy('v_calc_poe.shift_id')
            ->get();
        return view($view, [
            'oee' => $actual_oee,
            'oee_shift' => $oee_shift,
            'detail_oee' => $detail_oee,
            'lines' => Line::all()
        ]);
    }
}
