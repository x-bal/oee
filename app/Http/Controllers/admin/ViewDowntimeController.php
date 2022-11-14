<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as Kpi;
use App\Models\ActivityModel as Activity;
use Yajra\DataTables\Facades\DataTables;

class ViewDowntimeController extends Controller
{
    public function getIndex()
    {
        $arrCat = [
            'sh' => 'Shut Down',
            'br' => 'Break Down/Failure',
            'se' => 'Set Up and Adjustment',
            'ch' => 'Cutting Tool & Jig Change time = Replacement time',
            'st' => 'Startup Time',
            'ot' => 'Others Down Time',
            'id' => 'Idle Time',
            'mi' => 'Minor Stoppage',
        ];
        $kpi = KPI::groupBy('txtyear')->get();
        return view('pages.admin.viewdowntime', [
            'years' => $kpi,
            'lines' => Line::all(),
            'categories' => $arrCat
        ]);
    }

    public function postListDowntime(Request $request)
    {
        $year = !empty($request->input('year'))
            ? $request->input('year')
            : date('Y');
        $line = $request->line;
        $category = $request->category;
        switch ($request->filter) {
            case 'monthly':
                $downtimes = $this->daTableMonth($year, $line, $category);
                break;
            case 'weekly':
                $downtimes = $this->daTableWeek($year, $line, $category);
                break;
            case 'daily':
                $downtimes = $this->daTableDaily($year, $line, $category);
                break;
            case 'shift':
                $downtimes = $this->daTableShift($year, $line, $category);
                break;
        }
        return DataTables::of($downtimes)
            ->addIndexColumn()
            ->addColumn('action', function ($row) {
                $data = json_encode($row->detail);
                $btn = "<button data-detail='$data' type='button' data-bs-target='#modal-detail' data-bs-toggle='modal' class='btn btn-info btn-sm btn-detail'><i class='fas fa-eye'></i></button>";
                return $btn;
            })
            ->make(true);
    }
    public function daTableMonth($year, $line, $category)
    {
        $downtimes = DB::table('v_downtime_month')
            ->select('v_downtime_month.month AS date','v_downtime_month.*','mline.txtlinename')
            ->join('mline', 'mline.id','=','v_downtime_month.line_id')
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line)
            {
                return $query->where('line_id', $line);
            })
            ->when($category != 'all', function ($query) use ($category)
            {
                return $query->where('txtcategory', $category);
            })
            ->get();
        return $downtimes;
    }
    public function daTableWeek($year, $line, $category)
    {
        $downtimes = DB::table('v_downtime_week')
            ->select('v_downtime_week.week AS date','v_downtime_week.*','mline.txtlinename')
            ->join('mline', 'mline.id','=','v_downtime_week.line_id')
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line)
            {
                return $query->where('line_id', $line);
            })
            ->when($category != 'all', function ($query) use ($category)
            {
                return $query->where('txtcategory', $category);
            })
            ->get();
        return $downtimes;
    }
    public function daTableDaily($year, $line, $category)
    {
        $downtimes = DB::table('v_downtime_day')
            ->select('v_downtime_day.tanggal AS date','v_downtime_day.*','mline.txtlinename')
            ->join('mline', 'mline.id','=','v_downtime_day.line_id')
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line)
            {
                return $query->where('line_id', $line);
            })
            ->when($category != 'all', function ($query) use ($category)
            {
                return $query->where('txtcategory', $category);
            })
            ->orderBy('tanggal', 'ASC')
            ->orderBy('line_id', 'ASC')
            ->get();
        return $downtimes;
    }
    public function daTableShift($year, $line, $category)
    {
        $downtimes = DB::table('v_downtime_shift')
            ->select('v_downtime_shift.shift AS date','v_downtime_shift.*','mline.txtlinename')
            ->join('mline', 'mline.id','=','v_downtime_shift.line_id')
            ->whereYear('tanggal', $year)
            ->when($line != 'all', function ($query) use ($line)
            {
                return $query->where('line_id', $line);
            })
            ->when($category != 'all', function ($query) use ($category)
            {
                return $query->where('txtcategory', $category);
            })
            ->get();
        return $downtimes;
    }
}
