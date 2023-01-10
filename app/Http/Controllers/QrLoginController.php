<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use App\Models\MenuModel as Menu;
use App\Models\LineProcess as Line;
use App\Models\KpiModel as KPI;
use App\Models\User;

class QrLoginController extends Controller
{
    public function getIndex(Request $request)
    {
        $poe = DB::table('mkpi')
            ->where(
                'txtyear',
                !empty($request->year) ? $request->year : date('Y')
            )
            ->first();
        $oee = DB::table('tr_kpi')
            ->selectRaw(
                '
                IFNULL(CAST((SUM(ar)/COUNT(ar)) AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(pr)/COUNT(pr)) AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(qr)/COUNT(qr)) AS DECIMAL(10, 2)), 0) AS qr
            '
            )
            ->where('kpi_id', !empty($poe) ? $poe->id : 0)
            ->first();
        $actual_oee = DB::table('v_calc_poe')
            ->selectRaw(
                '
                id, YEAR(tanggal), SUM(total_output),
                IFNULL(CAST((SUM(operating_time)/SUM(loading_time))*100 AS DECIMAL(10, 2)), 0) AS ar,
                IFNULL(CAST((SUM(net_optime)/SUM(operating_time))*100 AS DECIMAL(10, 2)), 0) AS pr,
                IFNULL(CAST((SUM(value_adding)/SUM(net_optime))*100 AS DECIMAL(10, 2)), 0) AS qr
            '
            )
            ->whereYear(
                'tanggal',
                !empty($request->year) ? $request->year : date('Y')
            )
            ->groupBy(DB::raw('YEAR(tanggal)'))
            ->first();
        $years = KPI::groupBy('txtyear')->get();
        return view('pages.auth.qr-login', [
            'target_poe' => !empty($poe) ? $poe->poe : 0,
            'target_oee' => $oee,
            'actual_oee' => $actual_oee,
            'years' => $years,
            'lines' => Line::all(),
        ]);
    }
    protected function getSubmenu($user_id, $level)
    {
        $access = DB::table('level_access')
            ->where('level_id', $level)
            ->pluck('menu_id')
            ->toArray();
        $menu = Menu::with('submenu')
            ->whereIn('id', $access)
            ->get();
        $filename = $user_id . '.json';
        Storage::disk('public')->put($filename, json_encode($menu));
    }
    public function postLogin(Request $request)
    {
        $user = User::where('txtqrcode', $request->txtqrcode)->first();
        if (Auth::loginUsingId($user->id)) {
            $this->getSubmenu($user->id, $user->level_id);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Login Successfull',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Cant login with this QR !',
                ],
                401
            );
        }
    }
}
