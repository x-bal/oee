<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\OeeModel as Oee;
use App\Models\ActivityModel as Activity;

class OeeController extends Controller
{
    public function getActivity(Request $request)
    {
        $activity = Activity::where('line_id', $request->line_id)
            ->where('txtactivitycode', $request->code)
            ->first();
        if ($activity) {
            return response()->json(
                [
                    'activity' => $activity,
                    'status' => 'success',
                    'message' => 'Activity Code berhasil diubah',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Activity Code tidak ditemukan',
                ],
                404
            );
        }
    }
    public function storeOee(Request $request)
    {
        $result = [];
        foreach ($request->datas as $key => $value) {
            $result[] = [
                'shift_id' => $request->datas[$key][0],
                'tanggal' => $request->datas[$key][1],
                'start' => $request->datas[$key][2],
                'finish' => $request->datas[$key][3],
                'lamakejadian' => $request->datas[$key][4],
                'activity_id' => $request->datas[$key][5],
                'remark' => $request->datas[$key][8],
                'operator' => $request->datas[$key][9],
                'produk_code' => $request->datas[$key][10],
                'produk' => $request->datas[$key][11],
                'okp_packing' => $request->datas[$key][12],
                'production_code' => $request->datas[$key][13],
                'expired_date' => $request->datas[$key][14],
            ];
        }
    }
}
