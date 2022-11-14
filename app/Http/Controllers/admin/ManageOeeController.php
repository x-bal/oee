<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\OeeModel as Oee;
use App\Models\OeeDrierModel as OeeDrier;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as KPI;
use App\Models\ActivityModel as Activity;
use Illuminate\Support\Facades\DB;

class ManageOeeController extends Controller
{
    public function getIndex(Request $request)
    {
        $lines = Line::all();
        $kpi = KPI::groupBy('txtyear')->get();
        $oees = DB::table('v_calc_poe')
            ->selectRaw(
                'tanggal, line_id, shift_id,
                    CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)) AS daily_ar,
                    CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)) AS daily_pr,
                    CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)) AS daily_qr,
                    CAST(((SUM(operating_time)/SUM(loading_time))*(SUM(net_optime)/SUM(operating_time))*(SUM(value_adding)/SUM(net_optime)))*100 AS DECIMAL(10, 2)) AS daily_oee'
            )
            ->whereYear('tanggal', $request->year_filter ?: date('Y'))
            ->where('line_id', $request->line_filter ?: '1')
            ->groupBy(DB::Raw('MONTH(tanggal)'))
            ->get();
        $loop = [];
        $link =
            $request->line_filter == 5
                ? 'oeedriermanagement/'
                : 'oeemanagement/';
        foreach (range(1, 12) as $key => $val) {
            $loop[] = [
                'link' =>
                    $link .
                    date(
                        'Ym',
                        mktime(
                            0,
                            0,
                            0,
                            $val,
                            5,
                            $request->year_filter ?: date('Y')
                        )
                    ) .
                    ($request->line_filter ?: '1'),
                'month' => date(
                    'F',
                    mktime(0, 0, 0, $val, 5, $request->year_filter ?: date('Y'))
                ),
                'ar' => !empty($oees[$key]) ? $oees[$key]->daily_ar : 0,
                'pr' => !empty($oees[$key]) ? $oees[$key]->daily_pr : 0,
                'qr' => !empty($oees[$key]) ? $oees[$key]->daily_qr : 0,
                'oee' => !empty($oees[$key]) ? $oees[$key]->daily_oee : 0,
            ];
        }

        return view('pages.admin.oee', [
            'lines' => $lines,
            'years' => $kpi,
            'oees' => $loop,
        ]);
    }
    public function getOeeManagement($month)
    {
        $bulan = substr($month, 4, 2);
        $year = substr($month, 0, 4);
        $line = substr($month, 6);
        $linename = Line::where('id', substr($month, 6))->first();
        $code = Activity::where('line_id', $line)->pluck('txtactivitycode');
        $pending = Http::withBasicAuth('admin', '@0332022')->get(
            'http://10.175.11.67/api-kmi/api/oee/line',
            [
                'BATCH_TYPE' => $linename->txtlinename,
                'decode_content' => false,
                'headers' => [
                    'Content-Type' => 'application/json',
                ],
            ]
        );
        $datapending = json_decode($pending->getBody()->getContents(), true);

        return view('pages.admin.oee-management', [
            'line_id' => $line,
            'year' => $year,
            'month' => $bulan,
            'code' => $code,
            'line' => $linename,
            'okp' => collect($datapending['data'])->pluck('BATCH_NO'),
        ]);
    }
    public function getOeeList(Request $request)
    {
        $fields = [
            'oee.id',
            'mline.id AS line_id',
            'mline.txtlinename',
            'oee.shift_id',
            'oee.tanggal',
            'oee.start',
            'oee.finish',
            'oee.lamakejadian',
            'oee.activity_id',
            'mact.txtactivitycode',
            'mact.txtdescription',
            'oee.remark',
            'oee.operator',
            'oee.produk_code',
            'oee.produk',
            'oee.okp_packing',
            'oee.production_code',
            'oee.expired_date',
            'oee.finish_good',
            'oee.qc_sample',
            'oee.rework',
            'oee.reject',
            'oee.waiting_tech',
            'oee.repair_problem',
            'oee.trial_time',
            'oee.bas_com',
            'oee.category_br',
            'oee.category_ampm',
            'oee.category_rework',
            'oee.category_reject',
            'oee.reject_pcs',
            'oee.jumlah_manpower',
        ];
        $input = Oee::select($fields)
            ->leftJoin(
                'mactivitycode as mact',
                'mact.id',
                '=',
                'oee.activity_id'
            )
            ->join('mline', 'oee.line_id', '=', 'mline.id')
            ->whereMonth('tanggal', $request->month)
            ->where('oee.line_id', $request->line)
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
                'id AS line_id' => '',
                'txtlinename' => '',
                'shift_id' => '',
                'tanggal' => '',
                'start' => '',
                'finish' => '',
                'lamakejadian' => '',
                'activity_id' => '',
                'txtactivitycode' => '',
                'txtdescription' => '',
                'remark' => '',
                'operator' => '',
                'produk_code' => '',
                'produk' => '',
                'okp_packing' => '',
                'production_code' => '',
                'expired_date' => '',
                'finish_good' => '',
                'qc_sample' => '',
                'rework' => '',
                'reject' => '',
                'waiting_tech' => '',
                'repair_problem' => '',
                'trial_time' => '',
                'bas_com' => '',
                'category_br' => '',
                'category_ampm' => '',
                'category_rework' => '',
                'category_reject' => '',
                'reject_pcs' => '',
                'jumlah_manpower' => '',
            ];
            return response()->json(
                ['data' => $nodata, 'status' => 'success'],
                200
            );
        }
    }
    public function storeOee(Request $request)
    {
        $result = [];
        foreach ($request->datas as $key => $value) {
            $result[] = [
                'id' => @$request->datas[$key][0],
                'line_id' => @$request->datas[$key][1],
                'shift_id' => @$request->datas[$key][3],
                'tanggal' => @$request->datas[$key][4],
                'start' => @$request->datas[$key][5],
                'finish' => @$request->datas[$key][6],
                'lamakejadian' => @$request->datas[$key][7],
                'activity_id' => @$request->datas[$key][8],
                'remark' => @$request->datas[$key][11],
                'operator' => @$request->datas[$key][12],
                'okp_packing' => @$request->datas[$key][13],
                'produk_code' => @$request->datas[$key][14],
                'produk' => @$request->datas[$key][15],
                'production_code' => @$request->datas[$key][16],
                'expired_date' => @$request->datas[$key][17],
                'waiting_tech' => @$request->datas[$key][18],
                'tech_name' => @$request->datas[$key][19],
                'repair_problem' => @$request->datas[$key][20],
                'trial_time' => @$request->datas[$key][21],
                'bas_com' => @$request->datas[$key][22],
                'category_br' => @$request->datas[$key][23],
                'category_ampm' => @$request->datas[$key][24],
                'finish_good' => @$request->datas[$key][25],
                'qc_sample' => @$request->datas[$key][26],
                'category_rework' => @$request->datas[$key][27],
                'rework' => @$request->datas[$key][28],
                'reject' => @$request->datas[$key][29],
                'category_reject' => @$request->datas[$key][30],
                'reject_pcs' => @$request->datas[$key][31],
                'jumlah_manpower' => @$request->datas[$key][32],
            ];
        }
        foreach ($result as $key => $value) {
            if (!empty($result[$key])) {
                $check = Oee::find($result[$key]['id']);
                if ($check) {
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

    //OEE Drier Management
    public function getDrierManagement($month)
    {
        $bulan = substr($month, 4, 2);
        $year = substr($month, 0, 4);
        $line = substr($month, 6);
        $linename = Line::where('id', substr($month, 6))->first();
        $code = Activity::where('line_id', $line)->pluck('txtactivitycode');
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

        return view('pages.admin.drier-management', [
            'line_id' => $line,
            'year' => $year,
            'month' => $bulan,
            'code' => $code,
            'line' => $linename,
            'okp' => collect($datapending['data'])->pluck('BATCH_NO'),
        ]);
    }
    public function getDrierList(Request $request)
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
            ->whereMonth('tanggal', $request->month)
            ->where('oee_drier.line_id', $request->line)
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
    public function storeDrier(Request $request)
    {
        $result = [];
        foreach ($request->datas as $key => $value) {
            $result[] = [
                'id' => @$request->datas[$key][0],
                'line_id' => @$request->datas[$key][1],
                'shift_id' => @$request->datas[$key][3],
                'tanggal' => @$request->datas[$key][4],
                'start' => @$request->datas[$key][5],
                'finish' => @$request->datas[$key][6],
                'lamakejadian' => @$request->datas[$key][7],
                'activity_id' => @$request->datas[$key][8],
                'remark' => @$request->datas[$key][11],
                'operator' => @$request->datas[$key][12],
                'okp_drier' => @$request->datas[$key][13],
                'produk_code' => @$request->datas[$key][14],
                'produk' => @$request->datas[$key][15],
                'waiting_tech' => @$request->datas[$key][16],
                'tech_name' => @$request->datas[$key][17],
                'repair_problem' => @$request->datas[$key][18],
                'trial_time' => @$request->datas[$key][19],
                'bas_com' => @$request->datas[$key][20],
                'category_br' => @$request->datas[$key][21],
                'category_ampm' => @$request->datas[$key][22],
                'output_bin' => @$request->datas[$key][23],
                'output_kg' => @$request->datas[$key][24],
                'rework' => @$request->datas[$key][25],
                'category_rework' => @$request->datas[$key][26],
                'reject' => @$request->datas[$key][27],
                'jumlah_manpower' => @$request->datas[$key][28],
            ];
        }
        foreach ($result as $key => $value) {
            if (!empty($result[$key])) {
                $check = OeeDrier::find($result[$key]['id']);
                if ($check) {
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
