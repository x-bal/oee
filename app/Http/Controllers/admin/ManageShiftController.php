<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\WorkingTimeModel as Working;
use Illuminate\Support\Facades\Log;
use Yajra\DataTables\Facades\DataTables;
use PhpMqtt\Client\Facades\MQTT;

class ManageShiftController extends Controller
{
    public function index(Request $request)
    {
        if ($request->wantsJson()) {
            $data = Working::all();
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
        } else {
            return view('pages.admin.shift');
        }
    }
    public function store(Request $request)
    {
        $input = $request->all();
        $insert = Working::create($input);
        if ($insert) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Shift created Successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Shift created Failed',
                ],
                401
            );
        }
    }
    public function edit($id)
    {
        $data = Working::findOrfail($id);
        if ($data) {
            return response()->json(
                [
                    'status' => 'success',
                    'shift' => $data,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Shift Deleted Failed',
                ],
                404
            );
        }
    }
    public function update($id, Request $request)
    {
        $data = Working::findOrfail($id);
        if ($data) {
            $data->update($request->all());
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Shift Updated Successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Shift not Found',
                ],
                404
            );
        }
    }
    public function destroy($id)
    {
        $data = Working::findOrfail($id);
        if ($data) {
            $data->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Shift Deleted Successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Shift not Found',
                ],
                404
            );
        }
    }

    public function getResetCount()
    {
        $tmstart = [];
        $data = Working::selectRaw("LEFT(`tmstart`, 5) AS start")->get();
        foreach ($data as $key => $value) {
            $tmstart[] = $value->start;
        }
        if (in_array(date('H:i'), $tmstart)) {
            MQTT::publish('topic/reset/counting', 'reset');
        }
    }
}
