<?php

namespace App\Http\Controllers\leader;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ActivityModel as Activity;
use App\Models\OeeModel as Oee;
use App\Models\LineProcess as Line;
use App\Models\User;
use App\Models\WorkingTimeModel as Shift;
use App\Models\KpiModel as Kpi;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Yajra\DataTables\Facades\DataTables;

class LeaderController extends Controller
{
    protected $columns;
    public function __construct()
    {
        $this->columns = ['OEE ID', 'Line ID', 'LINE NAME','Shift', 'Tanggal', 'Start', 'Finish', 'Lama Kejadian (Min)', 'Activity_id', 'Activity Code', 'Deskripsi Kejadian','Remarks', 'Operator', 'OKP Packing', 'Art Code', 'Nama Produk', 'Production Code', 'Expired Date', 'Waiting Technician (min)', 'Technician Name','Repair Problem (min)', 'Start up/Trial Test (min)', 'Category Breakdown 8 Basic Competency', 'Category Breakdown 4 M', 'Category Breakdown AM/PM', 'Finish Good (CB)', 'QC Sample (pcs/alufo)', 'Category Rework', 'Rework (kg)', 'Reject Powder (kg)', 'Reject Category', 'Reject PM (pcs)', 'Jumlah Man Power'];
    }
    public function getMonth(Request $request)
    {
        $nowyear = date('Y');
        if ($request->input('year')) {
            $nowyear = $request->input('year');
        }
        $year = Kpi::groupBy('txtyear')->get();
        $line = Line::findOrfail(session()->get('line'));
        $loop = [];
        $oees = DB::table('v_oee_daily')
                ->selectRaw(
                    'id, tanggal, line_id, SUM(total_output),
                    CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS ar,
                    CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS pr,
                    CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS qr'
                )
                ->where('line_id', session()->get('line'))
                ->whereYear('tanggal', $nowyear)
                ->groupBy(DB::Raw('MONTH(tanggal)'))
                ->get();
        foreach (range(1, 12) as $key => $val) {
            // var_dump($val);

            $loop[] = [
                'link' =>
                'month/' . date('Ym', mktime(0, 0, 0, $val, 5, $nowyear)),
                'month' => date('F', mktime(0, 0, 0, $val, 5, $nowyear)),
                'ar' => !empty($oees[$key]) ? $oees[$key]->ar : 0,
                'pr' => !empty($oees[$key]) ? $oees[$key]->pr : 0,
                'qr' => !empty($oees[$key]) ? $oees[$key]->qr : 0,
            ];
        }
        // echo '<pre>', var_dump($loop),'</pre>';
        // die();
        return view('pages.leader.month', [
            'line' => $line,
            'year' => $year,
            'oee' => $loop,
        ]);
    }
    public function getDate($month)
    {
        // print(substr($month, 0, 4));
        $line = Line::findOrfail(session()->get('line'));
        $pending = Http::withBasicAuth('admin', '@0332022')->get(
            'http://10.175.11.67/api-kmi/api/oee/line',
            [
                'BATCH_TYPE' => $line->txtlinename,
                'decode_content' => false,
                'headers' => [
                    'Content-Type' => 'application/json',
                ],
            ]
        );
        $datapending = json_decode($pending->getBody()->getContents(), true);
        $code = Activity::where('line_id', session()->get('line'))->pluck('txtactivitycode');
        $loop = [];
        $date = mktime(0, 0, 0, substr($month, 4), 1, substr($month, 0, 4));

        return view('pages.leader.date', [
            'dates' => $loop,
            'code' => $code,
            'okp' => collect($datapending['data'])->pluck('BATCH_NO'),
            'line' => $line,
            'columns' => $this->columns
        ]);
    }
    public function getDateList($month)
    {
        $loop = [];
        $shift = Shift::all();
        $date = mktime(0, 0, 0, substr($month, 4), 1, substr($month, 0, 4));
        $oees = DB::table('v_oee_daily')
            ->selectRaw(
                'id, tanggal, line_id, SUM(total_output),
                CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS ar,
                CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS pr,
                CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS qr, SUM(working_time) AS worktime'
            )
            ->where('line_id', session()->get('line'))
            ->whereMonth('tanggal', substr($month, 4))
            ->groupBy('tanggal')
            ->get();
        // echo '<pre>', var_dump($oees[0]), '</pre>';
        // die();
        foreach (range(1, date('t', $date)) as $key => $val) {
            if ($val < 10) {
                $val = '0' . $val;
            }
            $dmY = $val . '-' . substr($month, 4) . '-' . substr($month, 0, 4);

            $loop[] = [
                'dates' => $dmY,
                'ar' => !empty($oees[$key]) ? $oees[$key]->ar : 0,
                'pr' => !empty($oees[$key]) ? $oees[$key]->pr : 0,
                'qr' => !empty($oees[$key]) ? $oees[$key]->qr : 0,
                'worktime' => !empty($oees[$key]) ? $oees[$key]->worktime : 0,
            ];
        }
        // $oee->oee = $loop;
        // var_dump((object) $loop);
        // die();
        return DataTables::of($loop)
            ->addColumn('button', function ($row) use ($shift) {
                $btn = '';
                foreach ($shift as $val) {
                    $btn .=
                        '<button class="btn btn-sm btn-success btn-shift" data-bs-toggle="modal" data-bs-target="#oeeModal" data-date="' .
                        date('Y-m-d', strtotime($row['dates'])) .
                        '" data-shift="' .
                        $val->id .
                        '" ' .
                        (date('Y-m-d', strtotime($row['dates'])) > date('Y-m-d')
                            ? 'disabled'
                            : '') .
                        '>' .
                        $val->txtshiftname .
                        '</button> ';
                }
                return $btn;
            })
            ->addColumn('oee', function ($row) {
                $oee =
                    ($row['ar'] / 100) *
                    ($row['pr'] / 100) *
                    ($row['qr'] / 100) *
                    100;
                $stripe =
                    $oee < 40
                        ? 'bg-danger'
                        : ($oee < 80
                            ? 'bg-primary'
                            : 'bg-success');
                $bar =
                    '<div class="progress progress-striped active">' .
                    '<div class="progress-bar ' .
                    $stripe .
                    ' progress-bar-striped progress-bar-animated rounded-pill fs-10px fw-bold" style="width: ' .
                    number_format($oee) .
                    '%">OEE : ' .
                    number_format($oee, 2) .
                    '%</div>' .
                    '</div>';
                return $bar;
            })
            ->editColumn('ar', function ($row) {
                return ($row['ar'] ?: 0) . '%';
            })
            ->editColumn('pr', function ($row) {
                return ($row['pr'] ?: 0) . '%';
            })
            ->editColumn('qr', function ($row) {
                return ($row['qr'] ?: 0) . '%';
            })
            ->rawColumns(['oee', 'button'])
            ->make(true);
    }
    public function getOeeList(Request $request)
    {
        $fields = [
            'oee.*',
            'mline.id AS line_id',
            'mline.txtlinename',
            'mact.txtactivitycode',
            'mact.txtdescription',
        ];
        $input = Oee::select($fields)
            ->leftJoin(
                'mactivitycode as mact',
                'mact.id',
                '=',
                'oee.activity_id'
            )
            ->join('mline', 'oee.line_id', '=', 'mline.id')
            ->where('shift_id', $request->shift)
            ->where('tanggal', $request->date)
            ->where('oee.line_id', session()->get('line'))
            ->get()
            ->toArray();

        if ($input) {
            return response()->json(
                ['data' => $input, 'status' => 'success'],
                200
            );
        } else {
            $nodata = [
                'line_id' => '',
                'txtlinename' => '',
                'shift_id' => '',
                'tanggal' => '',
                'start' => '',
                'finish' => '',
                'lamakejadian' => '',
                'activity_id' => '',
                'deskripsi' => '',
                'remark' => '',
                'operator' => '',
                'produk_code' => '',
                'produk' => '',
                'okp_packing' => '',
                'production_code' => '',
                'expired_date' => '',
                'finish_good',
                'qc_sample',
                'rework',
                'reject',
                'waiting_tech',
                'tech_name',
                'repair_problem',
                'trial_time',
                'bas_com',
                'category_br',
                'category_ampm',
            ];
            return response()->json(
                ['data' => $nodata, 'status' => 'success'],
                200
            );
        }
    }
    public function getOkpDetail(Request $request)
    {
        $okp = $request->input('okp');
        $response = Http::withBasicAuth('admin', '@0332022')->get(
            'http://10.175.11.67/api-kmi/api/oee/okp',
            [
                'okp' => $okp,
                'decode_content' => false,
                'headers' => [
                    'Content-Type' => 'application/json',
                ],
            ]
        );
        $result = json_decode($response->getBody()->getContents(), true);
        return response()->json(
            [
                'status' => 'success',
                'data' => $result['data'],
            ],
            200
        );
    }
    //Saving OEE data
    public function storeOee(Request $request)
    {
        $result = [];
        foreach ($request->datas as $key => $value) {
            $result[] = [
                'id' => $request->datas[$key][0],
                'line_id' => $request->datas[$key][1],
                'shift_id' => $request->datas[$key][3],
                'tanggal' => $request->datas[$key][4],
                'start' => $request->datas[$key][5],
                'finish' => $request->datas[$key][6],
                'lamakejadian' => $request->datas[$key][7],
                'activity_id' => $request->datas[$key][8],
                'remark' => $request->datas[$key][11],
                'operator' => $request->datas[$key][12],
                'okp_packing' => $request->datas[$key][13],
                'produk_code' => $request->datas[$key][14],
                'produk' => $request->datas[$key][15],
                'production_code' => $request->datas[$key][16],
                'expired_date' => $request->datas[$key][17],
                'waiting_tech' => $request->datas[$key][18],
                'tech_name' => $request->datas[$key][19],
                'repair_problem' => $request->datas[$key][20],
                'trial_time' => $request->datas[$key][21],
                'bas_com' => $request->datas[$key][22],
                'category_br' => $request->datas[$key][23],
                'category_ampm' => $request->datas[$key][24],
                'finish_good' => $request->datas[$key][25],
                'qc_sample' => $request->datas[$key][26],
                'category_rework' => $request->datas[$key][27],
                'rework' => $request->datas[$key][28],
                'reject' => $request->datas[$key][29],
                'category_reject' => $request->datas[$key][30],
                'reject_pcs' => $request->datas[$key][31],
                'jumlah_manpower' => $request->datas[$key][32],
            ];
        }
        foreach ($result as $key => $value) {
            if (!empty($result[$key]['line_id'])) {
                $checkId = Oee::find($result[$key]['id']);
                if (!empty($checkId)) {
                    $check = Oee::find($result[$key]['id']);
                    $check->update($result[$key]);
                } else {
                    Oee::create($result[$key]);
                }
            }
        }
        return response()->json(
            [
                'status' => 'success',
                'message' => 'Data saved Successfully',
            ],
            200
        );
    }
    public function destroyOee($id)
    {
        $oee = Oee::findOrfail($id);
        if ($oee) {
            $oee->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Input Oee deleted succesfully!',
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Row Input ID not Found!',
            ], 404);
        }
    }
}
