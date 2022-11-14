<?php

namespace App\Http\Controllers\operator;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ActivityModel as Activity;
use App\Models\OeeDrierModel as OeeDrier;
use App\Models\LineProcess as Line;
use App\Models\User;
use App\Models\WorkingTimeModel as Shift;
use App\Models\KpiModel as Kpi;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class OperatorDrierController extends Controller
{
    protected $columns;
    public function __construct()
    {
        $this->columns = [
            'OEE ID',
            'Line ID',
            'Shift',
            'Tanggal',
            'Start',
            'Finish',
            'Lama Kejadian (Min)',
            'Activity_id',
            'Activity Code',
            'Deskripsi Kejadian',
            'Remark',
            'Operator',
            'OKP Drier',
            'Art Code',
            'Nama Produk',
            'Output (BIN)',
            'Output (KG)',
            'Technician Name',
        ];
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
        $oees = DB::table('v_drier_daily')
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
                    'month-drier/' .
                    date('Ym', mktime(0, 0, 0, $val, 5, $nowyear)),
                'month' => date('F', mktime(0, 0, 0, $val, 5, $nowyear)),
                'ar' => !empty($oees[$key]) ? $oees[$key]->ar : 0,
                'pr' => !empty($oees[$key]) ? $oees[$key]->pr : 0,
                'qr' => !empty($oees[$key]) ? $oees[$key]->qr : 0,
            ];
        }
        // echo '<pre>', var_dump($loop),'</pre>';
        // die();
        return view('pages.operator_drier.month', [
            'line' => $line,
            'year' => $year,
            'oee' => $loop,
        ]);
    }
    public function getDate($month)
    {
        // print(substr($month, 0, 4));
        $line = Line::findOrfail(session()->get('line'));
        $leader = User::findOrfail(session()->get('leader'));
        $pending = Http::withBasicAuth('admin', '@0332022')->get(
            'http://10.175.11.67/api-kmi/api/oee/line',
            [
                'BATCH_TYPE' => 'BASE POWDER',
                'decode_content' => false,
                'headers' => [
                    'Content-Type' => 'application/json',
                ],
            ]
        );
        $datapending = json_decode($pending->getBody()->getContents(), true);
        $code = Activity::where('line_id', session()->get('line'))->pluck(
            'txtactivitycode'
        );
        $loop = [];
        $date = mktime(0, 0, 0, substr($month, 4), 1, substr($month, 0, 4));
        $shift = Shift::all();
        $oees = DB::table('v_drier_daily')
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
        // echo '<pre>', var_dump($loop), '</pre>';
        // die();

        return view('pages.operator_drier.date', [
            'dates' => $loop,
            'code' => $code,
            'okp' => collect($datapending['data'])->pluck('BATCH_NO'),
            'line' => $line,
            'leader' => $leader,
            'shift' => $shift,
            'columns' => $this->columns,
        ]);
    }
    public function getOeeList(Request $request)
    {
        $fields = [
            'oee_drier.*',
            'mline.id AS line_id',
            'mline.txtlinename',
            'mact.txtactivitycode',
            'mact.txtdescription',
        ];
        $input = OeeDrier::select($fields)
            ->leftJoin(
                'mactivitycode as mact',
                'mact.id',
                '=',
                'oee_drier.activity_id'
            )
            ->join('mline', 'oee_drier.line_id', '=', 'mline.id')
            ->where('shift_id', $request->shift)
            ->where('tanggal', $request->date)
            ->get()
            ->toArray();

        if ($input) {
            return response()->json(
                ['data' => $input, 'status' => 'success'],
                200
            );
        } else {
            $nodata = [
                'id' => '',
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
                'okp_drier' => '',
                'output_bin' => '',
                'output_kg' => '',
                'rework' => '',
                'reject' => '',
                'waiting_tech' => '',
                'repair_problem' => '',
                'trial_time' => '',
                'bas_com' => '',
                'category_br' => '',
                'category_ampm' => '',
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
                'shift_id' => $request->datas[$key][2],
                'tanggal' => $request->datas[$key][3],
                'start' => $request->datas[$key][4],
                'finish' => $request->datas[$key][5],
                'lamakejadian' => $request->datas[$key][6],
                'activity_id' => $request->datas[$key][7],
                'remark' => $request->datas[$key][10],
                'operator' => $request->datas[$key][11],
                'okp_drier' => $request->datas[$key][12],
                'produk_code' => $request->datas[$key][13],
                'produk' => $request->datas[$key][14],
                'output_bin' => $request->datas[$key][15],
                'output_kg' => $request->datas[$key][16],
                'tech_name' => $request->datas[$key][17],
            ];
        }
        foreach ($result as $key => $value) {
            if (!empty($result[$key]['line_id'])) {
                $checkId = OeeDrier::find($result[$key]['id']);
                if (!empty($checkId)) {
                    $check = OeeDrier::find($result[$key]['id']);
                    $check->update($result[$key]);
                } else {
                    OeeDrier::create($result[$key]);
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
}
