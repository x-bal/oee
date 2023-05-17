<?php

namespace App\Http\Controllers\Ppic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;
use App\Models\PlanOrderModel as PlanOrder;
use App\Models\LineProcess as Line;
use App\Models\ProductModel as Product;

class ManagePlanOrderController extends Controller
{
    public function index(Request $request)
    {
        if ($request->wantsJson()) {
            $planorder = PlanOrder::select('mplanorder.*', 'mline.txtlinename', 'tb_m_item_parts.part_name', 'tb_m_item_parts.part_number')
                ->join('mline', 'mline.id', '=', 'mplanorder.line_id')
                ->join('tb_m_item_parts', 'tb_m_item_parts.id', '=', 'mplanorder.item_part_id')
                ->orderBy('id', 'DESC')
                ->get();
            return DataTables::of($planorder)
                ->addIndexColumn()
                ->addColumn('action', function($row){
                    $btn_release = '<a type="button" class="btn btn-sm btn-primary" onclick="release('.$row->id.')"><i class="fas fa-step-forward"></i></a>';
                    $btn_edit = '<a type="button" class="btn btn-sm btn-success" onclick="edit('.$row->id.')"><i class="fas fa-pen"></i></a>';
                    $btn_delete = '<a type="button" class="btn btn-sm btn-danger" onclick="destroy('.$row->id.')"><i class="fas fa-trash"></i></a>';
                    if (is_null($row->is_released) && is_null($row->is_completed)) {
                        return $btn_release.' '.$btn_edit.' '.$btn_delete;
                    } else {
                        return 'Unavailable';
                    }
                })
                ->addColumn('status', function($row){
                    if (is_null($row->is_released) && is_null($row->is_completed)) {
                        $status = '<span class="badge bg-purple">Created</span>';
                    } elseif (is_null($row->is_completed)) {
                        $status = '<span class="badge bg-primary">Released</span>';
                    } else {
                        $status = '<span class="badge bg-success">Completed</span>';
                    }
                    return $status;
                })
                ->rawColumns(['status', 'action'])
                ->make(true);
        } else {
            return view('pages.ppic.planorder', [
                'lines' => Line::all(),
                'products' => Product::all()
            ]);
        }
    }
    public function store(Request $request)
    {
        $input = $request->all();
        $create = PlanOrder::create($input);
        if ($create) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Plan Order created successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Plan Order created failed',
                ],
                401
            );
        }
    }
    public function edit($id)
    {
        $planorder = PlanOrder::find($id);
        if ($planorder) {
            return response()->json(
                [
                    'status' => 'success',
                    'plan' => $planorder,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Plan Order not found !',
                ],
                404
            );
        }
    }
    public function update($id, Request $request)
    {
        # code...
    }
    public function destroy($id)
    {
        $planorder = PlanOrder::find($id);
        if ($planorder) {
            $planorder->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Plan Order deleted successfully'
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Plan Order not found !',
                ],
                404
            );
        }
    }

    //Release Plan Order
    public function putReleasePlanOrder($id, Request $request)
    {
        $planorder = PlanOrder::find($id);
        if ($planorder) {
            $planorder->update([
                'is_released' => date('Y-m-d H:i:s')
            ]);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Plan Order Released Successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Plan Order not found !',
                ],
                404
            );
        }
    }
}
