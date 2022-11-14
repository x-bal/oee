<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Support\Facades\DB;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as KPI;
use Illuminate\Http\Request;

class ViewOeeController extends Controller
{
    public function getIndex()
    {
        $kpi = KPI::groupBy('txtyear')->get();
        $lines = Line::all();
        return view('pages.admin.dboee', [
            'lines' => $lines,
            'years' => $kpi
        ]);
    }
    public function listViewOee(Request $request)
    {
        if ($request->input('line') == 'all') {
            $oees = DB::table('v_calc_poe')
                ->join('mline', 'mline.id', '=', 'v_calc_poe.line_id')
                ->orderBy('tanggal', 'ASC')
                ->orderBy('shift_id', 'ASC')
                ->orderBy('okp', 'ASC')
                ->whereYear('tanggal', $request->input('year'))
                ->get();
        } else {
            $oees = DB::table('v_calc_poe')
                ->join('mline', 'mline.id', '=', 'v_calc_poe.line_id')
                ->orderBy('tanggal', 'ASC')
                ->orderBy('shift_id', 'ASC')
                ->orderBy('okp', 'ASC')
                ->where('v_calc_poe.line_id', $request->input('line'))
                ->whereYear('tanggal', $request->input('year'))
                ->get();
        }
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
