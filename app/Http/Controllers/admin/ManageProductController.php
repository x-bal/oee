<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\LineProcess as Line;
use App\Models\ProductModel as Product;
use Yajra\DataTables\Facades\DataTables;

class ManageProductController extends Controller
{
    public function getIndex(Line $line, Request $request)
    {
        if ($request->wantsJson()) {
            $data = Product::select('mproduct.*', 'mline.txtlinename')
                ->join('mline', 'mline.id', '=', 'mproduct.line_id')
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
        } else {
            return view('pages.admin.product', [
                'lines' => $line->all(),
            ]);
        }
    }
    public function storeProduct(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'line_id' => 'required',
            'txtpartnumber' => 'required|unique:mproduct,txtartcode',
            'txtpartname' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'data' => $validator->errors(),
                'response' => 401,
                'status' => 'error',
            ]);
        } else {
            $input = [
                'line_id' => $request->line_id,
                'txtartcode' => $request->txtpartnumber,
                'txtproductname' => $request->txtpartname,
                'txtproductcode' => $request->txtpartcode,
                'floatstdspeed' => $request->floatstdspeed,
                'intpcskarton' => $request->intpcskanban
            ];
            if ($request->hasFile('txtpartimage')) {
                $file = $request->file('txtpartimage');
                $filename = str_replace(' ','_', date('YmdHis') . $file->getClientOriginalName());
                $request
                    ->file('txtpartimage')
                    ->move(public_path('assets/img/part/'), $filename);
                $input['txtpartimage'] = $filename;
            }
            $product = Product::create($input);
            if ($product) {
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'Product created successfully',
                    ],
                    200
                );
            } else {
                return response()->json(
                    [
                        'status' => 'error',
                        'message' => 'Product failed successfully',
                    ],
                    401
                );
            }
        }
    }
    public function editProduct($id)
    {
        $data = Product::findorfail($id);
        if ($data) {
            return response()->json(
                [
                    'status' => 'success',
                    'product' => $data,
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
    public function updateProduct($id, Request $request)
    {
        $input = [
            'line_id' => $request->line_id,
            'txtartcode' => $request->txtpartnumber,
            'txtproductname' => $request->txtpartname,
            'txtproductcode' => $request->txtpartcode,
            'floatstdspeed' => $request->floatstdspeed,
            'intpcskarton' => $request->intpcskanban
        ];
        $product = Product::findOrfail($id);
        $validator = Validator::make($input, [
            'line_id' => 'required',
            'txtpartnumber' => 'required|unique:mproduct,txtartcode,' . $id,
            'txtpartname' => 'required',
        ]);
        if ($validator) {
            if ($request->hasFile('txtpartimage')) {
                unlink('assets/img/part/'. $product->txtpartimage);
                $file = $request->file('txtpartimage');
                $filename = str_replace(' ','_', date('YmdHis') . $file->getClientOriginalName());
                $request
                    ->file('txtpartimage')
                    ->move(public_path('assets/img/part/'), $filename);
                $input['txtpartimage'] = $filename;
            }
            $update = $product->update($input);
            if ($update) {
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'Product update Success',
                    ],
                    200
                );
            } else {
                return response()->json(
                    [
                        'status' => 'error',
                        'message' => 'Product update Failed',
                    ],
                    404
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
    public function destroyProduct($id)
    {
        $product = Product::findOrfail($id);
        if ($product) {
            $product->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Product deleted successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Product deleted Failed',
                ],
                401
            );
        }
    }
}
