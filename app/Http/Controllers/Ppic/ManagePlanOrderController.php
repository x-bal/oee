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
    public function getPlanOrder(Request $request)
    {
        if ($request->wantsJson()) {
            $planorder = PlanOrder::select('mplanorder.*', 'mline.txtlinename', 'mproduct.txtartcode')
                ->join('mline', 'mline.id', '=', 'mplanorder.line_id')
                ->join('mproduct', 'mproduct.id', '=', 'mplanorder.product_id')
                ->orderBy('id', 'DESC')
                ->get();
            return DataTables::of($planorder)
                ->addIndexColumn()
                ->addColumn('action', function($row){
                    if ($row->intstatus == 0) {
                        $btn_release = '<a type="button" class="btn btn-sm btn-primary">Release</a>';
                        $btn_edit = '<a type="button" class="btn btn-sm btn-success" onclick="edit('.$row->id.')">Edit</a>';
                        $btn_delete = '<a type="button" class="btn btn-sm btn-danger">Delete</a>';
                        return $btn_release.' '.$btn_edit.' '.$btn_delete;
                    } else {
                        $notif = 'Unavailable';
                        return $notif;
                    }
                })
                ->addColumn('status', function($row){
                    switch ($row->intstatus) {
                        case 0:
                            $status = '<span class="badge bg-purple">Created</span>';
                            break;
                        case 1:
                            $status = '<span class="badge bg-primary">Released</span>';
                            break;
                        case 2:
                            $status = '<span class="badge bg-primary">Processed</span>';
                            break;
                        case 3:
                            $status = '<span class="badge bg-primary">Step Processed</span>';
                            break;
                        case 4:
                            $status = '<span class="badge bg-primary">Step Released</span>';
                            break;
                        case 5:
                            $status = '<span class="badge bg-success">Finish Order</span>';
                            break;

                        default:
                            $status = '<span class="badge bg-secondary">Created</span>';
                            break;
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
    public function storePlanOrder(Request $request)
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
    public function editPlanOrder($id)
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
                    'message' => 'Server data not found !',
                ],
                404
            );
        }
    }
    public function updatePlanOrder($id, Request $request)
    {
        # code...
    }
    public function destroyPlanOrder($id)
    {
        # code...
    }

    //Release Plan Order
    public function putReleasePlanOrder($id, Request $request)
    {
        # code...
    }
}
