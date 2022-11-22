<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Machine;
use App\Models\LineProcess as Line;
use Yajra\DataTables\Facades\DataTables;

class ManageMachineController extends Controller
{
    public function getindex(Line $lines)
    {
        $line = $lines->all();
        return view('pages.admin.machine', [
            'lines' => $line,
        ]);
    }
    public function getListMachines(Machine $machine)
    {
        $machines = $machine
            ->select('mmachines.*', 'mline.txtlinename')
            ->join('mline', 'mline.id', '=', 'mmachines.line_id')
            ->get();
        return DataTables::of($machines)
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
    public function storeMachine(Request $request)
    {
        $input = [
            'line_id' => $request->input('line_id'),
            'txtmachinename' => $request->input('txtmachinename'),
        ];
        if ($request->hasFile('txtpicture')) {
            $file = $request->file('txtpicture');
            $filename = date('YmdHis') . $file->getClientOriginalName();
            $request
                ->file('txtpicture')
                ->move(public_path('assets/img/machine/'), $filename);
            $input['txtpicture'] = $filename;
        }
        $store = Machine::create($input);
        if ($store) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Machine created Succesfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Machine created Failed',
                ],
                401
            );
        }
    }
    public function editMachine($id)
    {
        $machine = Machine::findOrfail($id);
        if ($machine) {
            return response()->json(
                [
                    'status' => 'success',
                    'machine' => $machine,
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
    public function updateMachine($id, Request $request)
    {
        $machine = Machine::findOrfail($id);
        $input = [
            'line_id' => $request->input('line_id'),
            'txtmachinename' => $request->input('txtmachinename'),
        ];
        if ($request->hasFile('txtpicture')) {
            if ($machine->txtpicture != 'default.png') {
                unlink('assets/img/machine/' . $machine->txtpicture);
            }
            $file = $request->file('txtpicture');
            $filename = date('YmdHis') . $file->getClientOriginalName();
            $request
                ->file('txtpicture')
                ->move(public_path('assets/img/machine/'), $filename);
            $input['txtpicture'] = $filename;
        }
        if ($machine) {
            $machine->update($input);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Machine updated Succesfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Machine updated Failed',
                ],
                401
            );
        }
    }
    public function destroyMachine($id)
    {
        $machine = Machine::findOrfail($id);
        if ($machine) {
            $machine->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Machine deleted Succesfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Machine deleted Failed',
                ],
                404
            );
        }
    }
}
