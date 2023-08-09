<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\LineProcess as Line;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Yajra\DataTables\Facades\DataTables;

class ManageUserController extends Controller
{
    public function index(Request $request)
    {
        if ($request->wantsJson()) {
            $users = User::join('mlevels', 'mlevels.id', '=', 'musers.level_id')
            ->get(['musers.*', 'mlevels.txtlevelname']);
        return DataTables::of($users)
            ->addIndexColumn()
            ->addColumn('action', function ($row) {
                $btn_pass =
                    '<a type="button" class="btn btn-sm btn-square btn-warning" onclick="pass(' .
                    $row->id .
                    ')"><i class="fas fa-key"></i></a>';
                $btn_edit =
                    '<a type="button" class="btn btn-sm btn-square btn-success" onclick="edit(' .
                    $row->id .
                    ')"><i class="fas fa-edit"></i></a>';
                $btn_delete =
                    '<a type="button" class="btn btn-sm btn-square btn-danger" onclick="destroy(' .
                    $row->id .
                    ')"><i class="fas fa-trash"></i></a>';
                $btn = $btn_pass . ' ' . $btn_edit . ' ' . $btn_delete;
                return $btn;
            })
            ->editColumn('txtqrcode', function($row)
            {
                return QrCode::generate($row->txtusername.'|'.$row->txtqrcode);
            })
            ->rawColumns(['action'])
            ->make(true);
        } else {
            $level = DB::table('mlevels')->get();
            return view('pages.admin.users', [
                'level' => $level,
                'lines' => Line::all(),
            ]);
        }
    }
    public function uniqueQr()
    {
        $qr = Str::random(64);
        if (User::where('txtqrcode', $qr)->first()) {
            $this->uniqueQr();
        } else {
            return $qr;
        }
    }
    public function store(Request $request)
    {
        $input = [
            'txtname' => $request->input('txtname'),
            'txtusername' => $request->input('txtemail'),
            'txtinitial' => $request->input('txtinitial'),
            'password' => Hash::make($request->input('txtpassword')),
            'level_id' => $request->input('level_id'),
            'txtqrcode' => $this->uniqueQr()
        ];
        $validator = Validator::make($input, User::rules());
        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'fields' => $validator->errors()
            ], 400);
        } else {
            $user = User::create($input);
            if (!empty($request->input('line_id'))) {
                $input['line_id'] = $request->input('line_id');
                foreach ($input['line_id'] as $key => $value) {
                    DB::table('line_users')->insert([
                        'user_id' => $user->id,
                        'line_id' => $value
                    ]);
                }
            }
            if ($user) {
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'User created Succesfully',
                    ],
                    200
                );
            } else {
                return response()->json(
                    [
                        'status' => 'error',
                        'message' => 'User created Failed',
                    ],
                    401
                );
            }
        }
    }
    public function edit($id)
    {
        $user = User::findOrfail($id);
        if ($user) {
            $line = DB::table('line_users')->where('user_id', $id)->pluck('line_id');
            return response()->json(
                [
                    'status' => 'success',
                    'user' => $user,
                    'line_id' => $line
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
        $user = User::findOrfail($id);
        $input = [
            'txtname' => $request->input('txtname'),
            'txtusername' => $request->input('txtemail'),
            'txtinitial' => $request->input('txtinitial'),
            'level_id' => $request->input('level_id'),
        ];
        if ($user) {
            $validator = Validator::make($input, User::rules($id));
            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'fields' => $validator->errors()
                ], 400);
            } else {
                $user->update($input);
                if (!empty($request->input('line_id'))) {
                    DB::table('line_users')->where('user_id', $id)->delete();
                    $input['line_id'] = $request->input('line_id');
                    foreach ($input['line_id'] as $key => $value) {
                        DB::table('line_users')->insert([
                            'user_id' => $id,
                            'line_id' => $value
                        ]);
                    }
                }
                return response()->json(
                    [
                        'status' => 'success',
                        'message' => 'Data Updated Successfully',
                    ],
                    200
                );
            }
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
    public function updatePassword($id, Request $request)
    {
        $user = User::findOrfail($id);
        $input['password'] = Hash::make($request->input('newpassword'));
        if ($user) {
            $user->update($input);
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
        $user = User::findOrfail($id);
        if ($user) {
            $user->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'User deleted Succesfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'User deleted Failed',
                ],
                404
            );
        }
    }
}
