<?php

namespace App\Http\Controllers\adminCg;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Support\Facades\DB;
use App\Models\LineProcess as Line;
use Illuminate\Support\Facades\Auth;
use App\Models\KpiModel as KPI;

class ViewOeeController extends Controller
{
    public function getIndex()
    {
        $lines = DB::table('line_users')->where('user_id', Auth::user()->id)->pluck('line_id')->toArray();
        $kpi = KPI::groupBy('txtyear')->get();
        return view('pages.admin-cg.dboee', [
            'years' => $kpi,
            'lines' => Line::whereIn('id', $lines)->get()
        ]);
    }
    public function listViewOee(Request $request)
    {
        if ($request->input('line') == 'all') {
            $lines = DB::table('line_users')->where('user_id', Auth::user()->id)->pluck('line_id')->toArray();
            $oees = DB::table('v_calc_poe')
                ->join('mline', 'mline.id', '=', 'v_calc_poe.line_id')
                ->orderBy('tanggal', 'ASC')
                ->orderBy('shift_id', 'ASC')
                ->orderBy('okp', 'ASC')
                ->whereIn('v_calc_poe.line_id', $lines)
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
