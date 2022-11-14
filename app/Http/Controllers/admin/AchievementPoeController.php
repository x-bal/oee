<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as Kpi;
use Illuminate\Database\Eloquent\Collection;
use Yajra\DataTables\Facades\DataTables;

class AchievementPoeController extends Controller
{
    public function getIndex()
    {
        $year = Kpi::groupBy('txtyear')->get();
        return view('pages.admin.viewpoe', [
            'column' => $this->getColumns(),
            'years' => $year,
        ]);
    }
    public function getColumns()
    {
        $columns = new Collection();
        $line = Line::join(
            'v_calc_poe as vcp',
            'vcp.line_id',
            '=',
            'mline.id'
        )->get(['txtlinename']);
        $arr['date'] = 'GROUP BY';
        $arr['poe'] = 'ACHIEVEMENT';
        foreach ($line as $i => $item) {
            $arr[str_replace(' ', '', $item->txtlinename)] = $item->txtlinename;
        }
        $columns->push($arr);
        return $columns;
    }
    public function getListPoe(Request $request)
    {
        $year = !empty($request->input('year'))
            ? $request->input('year')
            : date('Y');
        switch ($request->filter) {
            case 'daily':
                $datas = DB::table('v_daily_poe')
                    ->selectRaw(
                        'tanggal AS `date`,
                        JSON_ARRAYAGG(JSON_OBJECT("line", mline.txtlinename, "percent", CAST(IFNULL((percent*100), 0) AS DECIMAL(10, 2)))) AS line,
                        IFNULL(SUM(hasil), 0) AS poe'
                    )
                    ->join('mline', 'mline.id', '=', 'v_daily_poe.line_id')
                    ->whereYear('v_daily_poe.tanggal', $year)
                    ->groupBy('tanggal')
                    ->get();
                break;
            case 'weekly':
                $datas = DB::table('v_week_poe')
                    ->selectRaw(
                        'CONCAT(`week`," - ",`month`) AS `date`,
                        JSON_ARRAYAGG(JSON_OBJECT("line", mline.txtlinename, "percent", CAST(percent*100 AS DECIMAL(10, 2)))) AS line,
                        SUM(hasil) AS poe'
                    )
                    ->join('mline', 'mline.id', '=', 'v_week_poe.line_id')
                    ->where('year', $year)
                    ->groupBy('week')
                    ->get();
                break;

            default:
                $datas = DB::table('v_month_poe')
                    ->selectRaw(
                        'MONTHNAME(tanggal) AS `date`,
                    JSON_ARRAYAGG(JSON_OBJECT("line", mline.txtlinename, "percent", CAST(percent*100 AS DECIMAL(10, 2)))) AS line,
                    SUM(hasil) AS poe'
                    )
                    ->join('mline', 'mline.id', '=', 'v_month_poe.line_id')
                    ->whereYear('v_month_poe.tanggal', $year)
                    ->groupBy(DB::raw('MONTH(tanggal)'))
                    ->get();
                break;
        }
        $list = new Collection();
        foreach ($datas as $key => $val) {
            $line = json_decode($val->line, true);
            $arr['date'] = $val->date;
            $arr['poe'] = $val->poe . '%';
            foreach ($line as $i => $item) {
                $arr[str_replace(' ', '', $item['line'])] =
                    $item['percent'] . '%';
            }

            $list->push($arr);
        }

        return DataTables::of($list)->make(true);
    }

    //Achievement: Achievement POE
    public function getAchievementPoe(){
        $kpi = KPI::groupBy('txtyear')->get();
        return view('pages.admin.achievement.poe', [
            'years' => $kpi
        ]);
    }
    public function postListPoe(Request $request)
    {
        $year = !empty($request->input('year'))
            ? $request->input('year')
            : date('Y');
        switch ($request->input('filter')) {
            case 'year':
                $poes = $this->daTableYear($year);
                break;
            case 'monthly':
                $poes = $this->daTableMonth($year);
                break;
            case 'weekly':
                $poes = $this->daTableWeek($year);
                break;
            case 'daily':
                $poes = $this->daTableDay($year);
                break;

            default:
                $poes = $this->daTableYear($year);
                break;
        }
        return DataTables::of($poes)
            ->addIndexColumn()
            ->editColumn('ar', function ($row) {
                return number_format(($row->ar?:0), 2).'%';
            })
            ->editColumn('pr', function ($row) {
                return number_format(($row->pr?:0), 2).'%';
            })
            ->editColumn('qr', function ($row) {
                return number_format(($row->qr?:0), 2).'%';
            })
            ->editColumn('poe', function ($row) {
                return ($row->poe?:0).'%';
            })
            ->make(true);
    }
    public function daTableYear($year)
    {
        $datas = DB::table('v_year_poe')
                    ->selectRaw(
                        'YEAR(tanggal) AS `date`,
                        AVG(ar) as ar, AVG(pr) as pr, AVG(qr) as qr,
                        IFNULL(SUM(hasil), 0) AS poe'
                    )
                    ->whereYear('v_year_poe.tanggal', $year)
                    ->groupBy(DB::raw('YEAR(tanggal)'))
                    ->get();
        return $datas;
    }
    public function daTableMonth($year)
    {
        $datas = DB::table('v_month_poe')
                    ->selectRaw(
                        'MONTHNAME(tanggal) AS `date`,
                        AVG(ar) as ar, AVG(pr) as pr, AVG(qr) as qr,
                        IFNULL(SUM(hasil), 0) AS poe'
                    )
                    ->whereYear('v_month_poe.tanggal', $year)
                    ->groupBy(DB::raw('MONTH(tanggal)'))
                    ->get();
        return $datas;
    }
    public function daTableWeek($year)
    {
        $datas = DB::table('v_week_poe')
                    ->selectRaw(
                        'CONCAT(week," - ",month) AS `date`,
                        AVG(ar) as ar, AVG(pr) as pr, AVG(qr) as qr,
                        IFNULL(SUM(hasil), 0) AS poe'
                    )
                    ->where('v_week_poe.year', $year)
                    ->groupBy('week')
                    ->get();
        return $datas;
    }
    public function daTableDay($year)
    {
        $datas = DB::table('v_daily_poe')
                    ->selectRaw(
                        'tanggal AS `date`,
                        AVG(ar) as ar, AVG(pr) as pr, AVG(qr) as qr,
                        IFNULL(SUM(hasil), 0) AS poe'
                    )
                    ->whereYear('v_daily_poe.tanggal', $year)
                    ->groupBy('v_daily_poe.tanggal')
                    ->get();
        return $datas;
    }
}
