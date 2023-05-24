<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\DailyActivityModel as Daily;
use App\Models\WorkingTimeModel as Working;
use App\Models\ActivityModel as Activity;
use App\Models\LineProcess as Line;
use Illuminate\Support\Facades\Validator;
use Yajra\DataTables\Facades\DataTables;

class ManageDailyController extends Controller
{
    public function index(Request $request){
        if ($request->wantsJson()) {
            $data = Daily::join('mactivitycode AS mact', 'mact.id', '=', 'mdailyactivities.activity_id')
                ->join('mline', 'mline.id', '=', 'mdailyactivities.line_id')
                ->orderBy('mdailyactivities.id', 'DESC')
                ->get(['mdailyactivities.*', 'mline.txtlinename', 'mact.txtdescription', 'mact.txtactivitycode']);
            return DataTables::of($data)
                ->addIndexColumn()
                ->addColumn('activity', function ($row) {
                    return $row->txtactivitycode.' - '.$row->txtdescription;
                })
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
                ->rawColumns(['activity', 'action'])
                ->make(true);
        } else {
            return view('pages.admin.daily-activities', [
                'lines' => Line::all()
            ]);
        }
    }
    public function store(Request $request)
    {
        $input = $request->only(['line_id', 'activity_id', 'tmstart', 'tmfinish']);
        $validator = Validator::make($input, Daily::rules(), [], Daily::attributes());
        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'fields' => $validator->errors()
            ], 401);
        } else {
            $create = Daily::create($input);
            if ($create) {
                return response()->json([
                    'status' => 'success',
                    'message' => 'Daily Activity successfully Created !'
                ], 200);
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Internal server error'
                ], 500);
            }
        }
    }
    public function edit($id)
    {
        $data = Daily::find($id);
        if ($data) {
            return response()->json([
                'status' => 'success',
                'data' => $data
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'data not found'
            ], 404);
        }
    }
    public function update(Request $request, $id)
    {
        $input = $request->only(['line_id', 'activity_id', 'tmstart', 'tmfinish']);
        $validator = Validator::make($input, Daily::rules(), [], Daily::attributes());
        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'fields' => $validator->errors()
            ], 401);
        } else {
            $data = Daily::find($id);
            if ($data) {
                $data->update($input);
                return response()->json([
                    'status' => 'success',
                    'message' => 'Daily Activity Updated Successfully'
                ], 200);
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'data not found'
                ], 404);
            }
        }
    }
    public function destroy($id)
    {
        $data = Daily::find($id);
        if ($data) {
            $data->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Daily Activity Deleted Successfully'
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'data not found'
            ], 404);
        }
    }
}
