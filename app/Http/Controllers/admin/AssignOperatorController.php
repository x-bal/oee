<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;
use App\Models\LineProcess as Line;
use App\Models\User;
use App\Models\AssignModel as Assign;

class AssignOperatorController extends Controller
{
    public function getAssign(Request $request)
    {
        if ($request->wantsJson()) {
            $lines = Line::all();
            return DataTables::of($lines)
                ->addIndexColumn()
                ->addColumn('action', function ($row) {
                    $btn_assign =
                        '<a type="button" class="btn btn-sm btn-square btn-success" onclick="assign(' .$row->id .')"><i class="fas fa-users"></i><a>';
                    $btn = $btn_assign;
                    return $btn;
                })
                ->rawColumns(['action'])
                ->make(true);
        } else {
            return view('pages.admin.assign-operator');
        }
    }
    public function getCheckerOption($id)
    {
        $assigned = Assign::where('line_id', '<>', $id)->get(['user_id'])->toArray();
        $user = User::where('level_id', 17)->whereNotIn('id', $assigned)->get(['id', 'txtname', 'txtinitial']);
        return response()->json([
            'status' => 'success',
            'checker' => $user
        ], 200);
    }
    public function storeAssignOperator(Request $request, $id_line)
    {
        $checkers = $request->checker_id;
        $list = Assign::where('line_id', $id_line)->get();
        if (!empty($list)) {
            Assign::where('line_id', $id_line)->delete();
        }
        foreach ($checkers as $i => $val) {
            DB::table('massign_line')->insert([
                'line_id' => $id_line,
                'user_id' => $val
            ]);
        }
        return response()->json(
            [
                'status' => 'success',
                'message' => 'Assign Checker Succesfully',
            ],
            200
        );
    }
    public function editAssignOperator($id)
    {
        # code...
    }
}
