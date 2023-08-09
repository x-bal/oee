<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Support\Facades\DB;
use App\Models\KpiModel as KPI;
use App\Models\LineProcess as Line;
use Illuminate\Http\Request;

class AchievementOeeController extends Controller
{
    public function getIndex()
    {
        $kpi = KPI::groupBy('txtyear')->get();
        return view('pages.admin.achievement.oee', [
            'years' => $kpi,
            'lines' => Line::all(),
        ]);
    }
    public function getListOee(Request $request)
    {
        $year = !empty($request->input('year'))
            ? $request->input('year')
            : date('Y');
        $line = $request->line;
        switch ($request->filter) {
            case 'monthly':
                $oees = $this->daTableMonth($year, $line);
                break;
            case 'weekly':
                $oees = $this->daTableWeek($year, $line);
                break;
            case 'daily':
                $oees = $this->daTableDaily($year, $line);
                break;
            case 'shift':
                $oees = $this->daTableShift($year, $line);
                break;

            default:
                $oees = $this->daTableMonth($year, $line);
                break;
        }
        return DataTables::of($oees)
            ->addIndexColumn()
            ->editColumn('ar', function ($row) {
                return ($row->ar ?: 0) . '%';
            })
            ->editColumn('pr', function ($row) {
                return ($row->pr ?: 0) . '%';
            })
            ->editColumn('qr', function ($row) {
                return ($row->qr ?: 0) . '%';
            })
            ->editColumn('oee', function ($row) {
                return ($row->oee ?: 0) . '%';
            })
            ->editColumn('utilization_rate', function ($row) {
                return ($row->utilization_rate ?: 0) . '%';
            })
            ->make(true);
    }
    public function daTableMonth($year, $line)
    {
        $oee = DB::table('v_calc_poe')
            ->selectRaw(
                '
                id, MONTHNAME(tanggal) as tanggal, SUM(total_output),
                CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS ar,
                CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS pr,
                CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS qr,
                CAST(((SUM(operating_time)/SUM(loading_time))*(SUM(net_optime)/SUM(operating_time))*(SUM(value_adding)/SUM(net_optime)))*100 AS DECIMAL(10, 2)) AS oee,
                CAST((SUM(loading_time)/SUM(working_time))*100 AS DECIMAL(10, 2)) AS utilization_rate
            '
            )
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line) {
                return $query->where('line_id', $line);
            })
            ->groupBy(DB::raw('MONTH(tanggal)'))
            ->get();
        return $oee;
    }
    public function daTableWeek($year, $line)
    {
        $oee = DB::table('v_calc_poe')
            ->selectRaw(
                '
                id, CONCAT(WEEK(tanggal)," - ", MONTHNAME(tanggal)) as tanggal, SUM(total_output),
                CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS ar,
                CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS pr,
                CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS qr,
                CAST(((SUM(operating_time)/SUM(loading_time))*(SUM(net_optime)/SUM(operating_time))*(SUM(value_adding)/SUM(net_optime)))*100 AS DECIMAL(10, 2)) AS oee,
                CAST((SUM(loading_time)/SUM(working_time))*100 AS DECIMAL(10, 2)) AS utilization_rate
            '
            )
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line) {
                return $query->where('line_id', $line);
            })
            ->groupBy(DB::raw('WEEK(tanggal)'))
            ->get();
        return $oee;
    }
    public function daTableDaily($year, $line)
    {
        $oee = DB::table('v_calc_poe')
            ->selectRaw(
                '
                id, tanggal, SUM(total_output),
                CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS ar,
                CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS pr,
                CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS qr,
                CAST(((SUM(operating_time)/SUM(loading_time))*(SUM(net_optime)/SUM(operating_time))*(SUM(value_adding)/SUM(net_optime)))*100 AS DECIMAL(10, 2)) AS oee,
                CAST((SUM(loading_time)/SUM(working_time))*100 AS DECIMAL(10, 2)) AS utilization_rate
            '
            )
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line) {
                return $query->where('line_id', $line);
            })
            ->groupBy(DB::raw('tanggal'))
            ->get();
        return $oee;
    }
    public function daTableShift($year, $line)
    {
        $oee = DB::table('v_calc_poe')
            ->selectRaw(
                '
                id, CONCAT(tanggal," - SHIFT ",shift_id) AS tanggal, SUM(total_output),
                CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS ar,
                CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS pr,
                CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS qr,
                CAST(((SUM(operating_time)/SUM(loading_time))*(SUM(net_optime)/SUM(operating_time))*(SUM(value_adding)/SUM(net_optime)))*100 AS DECIMAL(10, 2)) AS oee,
                CAST((SUM(loading_time)/SUM(working_time))*100 AS DECIMAL(10, 2)) AS utilization_rate
            '
            )
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line) {
                return $query->where('line_id', $line);
            })
            ->groupBy('tanggal', 'shift_id')
            ->get();
        return $oee;
    }
}
