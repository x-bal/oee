<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class UserController extends Controller
{
    public function getProfile()
    {
        $user = User::selectRaw("musers.*, mlevels.txtlevelname, JSON_ARRAYAGG(JSON_OBJECT('txtlinename', mline.txtlinename)) AS line")
            ->join('line_users AS lu', 'lu.user_id','=','musers.id')
            ->join('mline', 'mline.id','=','lu.line_id')
            ->join('mlevels', 'mlevels.id','=','musers.level_id')
            ->where('musers.id', Auth::user()->id)
            ->first();
        return view('pages.profile', [
            'user' => $user
        ]);
    }
    public function updateProfile($id, Request $request)
    {
        $validator = Validator::make($request->all(), [
            'txtphoto' => 'required',
            'txtpassword' => 'required',
        ],[
            'txtphoto.required' => 'Masukkan Photo Profile Baru anda',
            'txtpassword.required' => 'Masukkan password anda saat ini'
        ]);
        if ($validator->fails()) {
            return response()->json([
                'data' => $validator->errors(),
                'status' => 'error',
            ], 400);
        } else {
            $user = User::findOrfail($id);
            if ($user) {
                if (Hash::check($request->txtpassword, $user->password)) {
                    if ($request->hasFile('txtphoto')) {
                        unlink('assets/img/user/'. $user->txtphoto);
                        $file = $request->file('txtphoto');
                        $filename = date('YmdHis') . $file->getClientOriginalName();
                        $request
                            ->file('txtphoto')
                            ->move(public_path('assets/img/user/'), $filename);
                        $user->update(['txtphoto' => $filename]);
                        return response()->json([
                            'status' => 'Success',
                            'message' => 'Photo profile berhasil diupdate'
                        ], 200);
                    }
                } else {
                    return response()->json([
                        'message' => 'Password Salah!',
                        'status' => 'error',
                    ], 403);
                }
            } else {
                return response()->json([
                    'message' => 'User tidak ditemukan',
                    'status' => 'error',
                ], 404);
            }
        }
    }
    public function updatePassword($id, Request $request)
    {
        $validator = Validator::make($request->all(), [
            'txtcurrentpassword' => 'required',
            'txtnewpassword' => 'required|min:6|max:16|same:txtconfirmpassword',
            'txtconfirmpassword' => 'required|min:6|max:16|same:txtnewpassword',
        ],[
            'txtcurrentpassword.required' => 'Masukkan password Anda saat ini',
            'txtnewpassword.required' => 'Masukkan password baru Anda',
            'txtconfirmpassword.required' => 'Masukkan ulang password baru Anda',
            'txtnewpassword.min' => 'Password baru minimal 6 karakter',
            'txtnewpassword.min' => 'Password baru maksimal 16 karakter',
            'txtnewpassword.same' => 'Pastikan password baru dan konfirmasi password sama',
            'txtconfirmpassword.same' => 'Pastikan password baru dan konfirmasi password sama',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'data' => $validator->errors(),
                'status' => 'error',
            ], 400);
        } else {
            $user = User::findOrfail($id);
            if ($user) {
                if (Hash::check($request->txtcurrentpassword, $user->password)) {
                    $newpassword = Hash::make($request->txtnewpassword);
                    $user->update(['password' => $newpassword]);
                    return response()->json([
                        'message' => 'Password berhasil diubah!',
                        'status' => 'Success',
                    ], 200);
                } else {
                    return response()->json([
                        'message' => 'Password Salah!',
                        'status' => 'error',
                    ], 403);
                }
            }
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
    public function getMyQr()
    {
        $qr = QrCode::size(250)->generate(Auth::user()->txtusername.'|'.Auth::user()->txtqrcode);
        return view('pages.my-qr', [
            'qr' => $qr
        ]);
    }
    public function getChangeQr()
    {
        $user = User::find(Auth::user()->id);
        $user->update(['txtqrcode' => $this->uniqueQr()]);
        return redirect()->route('view.qr.index')->with('success', 'QR changed Successfully !');
    }
}
