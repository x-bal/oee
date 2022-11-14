<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as Kpi;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class ManageKpiController extends Controller
{
    public function getIndex()
    {
        return view('pages.admin.kpi');
    }
    public function getListKpi()
    {
        $data = Kpi::all();
        return DataTables::of($data)
            ->addIndexColumn()
            ->addColumn('action', function ($row) {
                $btn_detail =
                    '<a href="'.route('manage.kpi.detail', $row->txtyear).'" class="btn btn-sm btn-square btn-primary"><i class="fas fa-pencil"></i></a>';
                $btn_edit =
                    '<a type="button" class="btn btn-sm btn-square btn-success" onclick="edit(' .
                    $row->id .
                    ')"><i class="fas fa-edit"></i></a>';
                $btn_delete =
                    '<a type="button" class="btn btn-sm btn-square btn-danger" onclick="destroy(' .
                    $row->id .
                    ')"><i class="fas fa-trash"></i></a>';
                $btn = $btn_detail.' '.$btn_edit . ' ' . $btn_delete;
                return $btn;
            })
            ->rawColumns(['action'])
            ->make(true);
    }
    public function storeKpi(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'txtyear' => 'unique:mkpi,txtyear',
        ],[
            'txtyear.unique' => 'Tahun sudah diinputkan!'
        ]);
        if ($validator->fails()) {
            return response()->json([
                'data' => $validator->errors(),
                'response' => 401,
                'status' => 'error',
            ]);
        } else {
            $kpi = Kpi::create($input);
            if ($kpi) {
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'Kpi created successfully',
                    ],
                    200
                );
            } else {
                return response()->json(
                    [
                        'status' => 'error',
                        'message' => 'Kpi failed successfully',
                    ],
                    401
                );
            }
        }
    }
    public function editKpi($id)
    {
        $data = Kpi::findorfail($id);
        if ($data) {
            return response()->json(
                [
                    'status' => 'success',
                    'kpi' => $data,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Data not Found!',
                ],
                404
            );
        }
    }
    public function updateKpi($id, Request $request)
    {
        $input = $request->all();
        $kpi = Kpi::findorfail($id);
        if ($kpi) {
            $validator = Validator::make($input, [
                'txtyear' => 'required|unique:mkpi,txtyear,'.$kpi->id,
            ],[
                'txtyear.unique' => 'Tahun sudah diinputkan!'
            ]);
            if ($validator->fails()) {
                return response()->json([
                    'data' => $validator->errors(),
                    'response' => 401,
                    'status' => 'error',
                ]);
            } else {
                $kpi->update($request->all());
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'KPI update Success',
                    ],
                    200
                );
            }
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Data not found!',
                ],
                404
            );
        }
    }
    public function destroyKpi($id)
    {
        $kpi = Kpi::findOrfail($id);
        if ($kpi) {
            $kpi->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'KPI deleted successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'KPI deleted Failed',
                ],
                401
            );
        }
    }

    //Manage KPI Detail
    public function getKpiDetail($year)
    {
        $kpi = Kpi::where('txtyear', $year)->first();
        return view('pages.admin.kpi_detail', [
            'lines' => Line::all(),
            'kpi' => $kpi
        ]);
    }
    public function getListKpiDetail($idkpi)
    {
        $data = DB::table('tr_kpi')->select('tr_kpi.*', 'mkpi.txtyear','mline.txtlinename')
            ->join('mkpi', 'mkpi.id', '=', 'tr_kpi.kpi_id')
            ->join('mline', 'mline.id', '=', 'tr_kpi.line_id')
            ->where('tr_kpi.kpi_id', $idkpi)
            ->get();
        return DataTables::of($data)
            ->addIndexColumn()
            ->addColumn('action', function ($row) {
                $btn_edit =
                    '<a type="button" class="btn btn-sm btn-square btn-success" onclick="edit(' .
                    $row->id .
                    ')"><i class="fas fa-edit"></i></a>';
                $btn_delete =
                    '<a type="button" class="btn btn-sm btn-square btn-danger" onclick="destroy(' .
                    $row->id .
                    ')"><i class="fas fa-trash"></i></a>';
                $btn = $btn_edit . ' ' . $btn_delete;
                return $btn;
            })
            ->rawColumns(['action'])
            ->make(true);
    }
    public function storeKpiDetail(Request $request)
    {
        $input = [
            'kpi_id' => $request->idkpi,
            'line_id' => $request->line_id,
            'ar' => $request->ar,
            'pr' => $request->pr,
            'qr' => $request->qr,
        ];
        $validator = Validator::make($input, [
            'line_id' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'data' => $validator->errors(),
                'response' => 401,
                'status' => 'error',
            ]);
        } else {
            $kpi = DB::table('tr_kpi')->insert($input);
            if ($kpi) {
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'Kpi created successfully',
                    ],
                    200
                );
            } else {
                return response()->json(
                    [
                        'status' => 'error',
                        'message' => 'Kpi failed successfully',
                    ],
                    401
                );
            }
        }
    }
    public function editKpiDetail($id)
    {
        $data = DB::table('tr_kpi')->where('id', $id)->first();
        if ($data) {
            return response()->json(
                [
                    'status' => 'success',
                    'kpi' => $data,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Data not Found!',
                ],
                404
            );
        }
    }
    public function updateKpiDetail($id, Request $request)
    {
        $input = [
            'kpi_id' => $request->idkpi,
            'line_id' => $request->line_id,
            'ar' => $request->ar,
            'pr' => $request->pr,
            'qr' => $request->qr,
        ];
        $update = DB::table('tr_kpi')->where('id', $id)->update($input);
        if ($update) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'KPI update Success',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'KPI update Failed',
                ],
                404
            );
        }
    }
    public function destroyKpiDetail($id)
    {
        DB::table('tr_kpi')->where('id', $id)->delete();
        return response()->json(
            [
                'status' => 'success',
                'message' => 'KPI deleted successfully',
            ],
            200
        );
    }
}
