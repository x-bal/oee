<?php

namespace App\Http\Controllers\leader;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Support\Facades\DB;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as KPI;

class ViewOeeController extends Controller
{
    public function getIndex()
    {
        $kpi = KPI::groupBy('txtyear')->get();
        return view('pages.leader.dboee', [
            'years' => $kpi
        ]);
    }
    public function listViewOee(Request $request)
    {
        $oees = DB::table('v_calc_poe')
            ->join('mline', 'mline.id', '=', 'v_calc_poe.line_id')
            ->orderBy('tanggal', 'ASC')
            ->orderBy('shift_id', 'ASC')
            ->orderBy('okp', 'ASC')
            ->where('v_calc_poe.line_id', session()->get('line'))
            ->whereYear('tanggal', $request->input('year'))
            ->get();
        return DataTables::of($oees)
            ->addIndexColumn()
            ->editColumn('value_adding', function ($row) {
                return number_format($row->value_adding, 2);
            })
            ->editColumn('ar', function ($row) {
                return ($row->ar?:0).'%';
            })
            ->editColumn('pr', function ($row) {
                return ($row->pr?:0).'%';
            })
            ->editColumn('qr', function ($row) {
                return ($row->qr?:0).'%';
            })
            ->editColumn('oee', function ($row) {
                return ($row->oee?:0).'%';
            })
            ->editColumn('utilization_rate', function ($row) {
                return ($row->utilization_rate?:0).'%';
            })
            ->make(true);
    }
}
