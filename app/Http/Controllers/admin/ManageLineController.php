<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\LineProcess as Line;
use Yajra\DataTables\Facades\DataTables;

class ManageLineController extends Controller
{
    public function index(Request $request)
    {
        if ($request->wantsJson()) {
            $lines = Line::all();
            return DataTables::of($lines)
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
            return view('pages.admin.line');
        }
    }
    public function store(Request $request)
    {
        $input = $request->all();
        $line = Line::create($input);
        if ($line) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Line created Succesfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Line created Failed',
                ],
                401
            );
        }
    }
    public function edit($id)
    {
        $line = Line::findOrfail($id);
        if ($line) {
            return response()->json(
                [
                    'status' => 'success',
                    'line' => $line,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Cant find data !',
                ],
                404
            );
        }
    }
    public function update($id, Request $request)
    {
        $line = Line::findOrfail($id);
        $input = $request->all();
        if ($line) {
            $line->update($input);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Data Updated Successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Cant find data!',
                ],
                404
            );
        }
    }
    public function destroy($id)
    {
        $line = Line::findOrfail($id);
        if ($line) {
            $line->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Line deleted Succesfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Line deleted Failed',
                ],
                404
            );
        }
    }
}
