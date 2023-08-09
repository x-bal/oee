<?php

namespace App\Http\Controllers;

use App\Events\MqttSubscribe;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\MenuModel as Menu;
use App\Models\KpiModel as Kpi;
use App\Models\LineProcess as Line;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
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
        return view('pages.auth.login', [
            'target_poe' => !empty($poe) ? $poe->poe : 0,
            'target_oee' => $oee,
            'actual_oee' => $actual_oee,
            'years' => $years,
            'lines' => Line::all(),
        ]);
    }
    //Chart POE
    public function getChartPOE(Request $request)
    {
        $year = $request->year;
        $month = $request->month;
        $actual_poe = DB::table('v_year_poe')
            ->selectRaw(
                '
                YEAR(tanggal) AS `date`,
                JSON_ARRAYAGG(JSON_OBJECT(
                    "line", mline.txtlinename,
                    "oee", IFNULL(CAST(oee AS DECIMAL(10, 2)), 0),
                    "target_oee", CAST(((IFNULL(tr_kpi.ar, 0)/100)*(IFNULL(tr_kpi.pr, 0)/100)*(IFNULL(tr_kpi.qr, 0)/100))*100 AS DECIMAL(10, 2))
                    )) AS line,
                SUM(hasil) AS poe
            '
            )
            ->join('mline', 'mline.id', '=', 'v_year_poe.line_id')
            ->join('mkpi', function ($join) use ($year) {
                $join->on(
                    'mkpi.txtyear',
                    '=',
                    DB::raw(!empty($year) ? $year : date('Y'))
                );
            })
            ->leftJoin('tr_kpi', function ($query) {
                $query
                    ->on('tr_kpi.kpi_id', '=', 'mkpi.id')
                    ->on('mline.id', '=', 'tr_kpi.line_id');
            })
            ->whereYear('tanggal', !empty($year) ? $year : date('Y'))
            ->groupBy(DB::raw('YEAR(tanggal)'))
            ->first();
        return response()->json(
            [
                'status' => 'success',
                'poe' => $actual_poe,
            ],
            200
        );
    }
    //Chart Utilization Rate
    public function getChartUR(Request $request)
    {
        $year = $request->year;
        $month = $request->month;
        $ur = DB::table('v_year_poe AS vyp')
            ->select('mline.txtlinename', 'vyp.utilization_rate')
            ->join('mline', 'mline.id', '=', 'vyp.line_id')
            ->whereYear('vyp.tanggal', !empty($year) ? $year : date('Y'))
            ->get();
        return response()->json(
            [
                'status' => 'success',
                'urate' => $ur,
            ],
            200
        );
    }
    //Function Login
    public function postLogin(Request $request)
    {
        $this->validate($request, [
            'email' => 'required',
            'password' => 'required',
        ]);
        $email = $request->input('email');
        $password = $request->input('password');
        $credentials = [
            'txtusername' => $email,
            'password' => $password,
        ];
        if (Auth::attempt($credentials)) {
            $this->getSubmenu(Auth::user()->id, Auth::user()->level_id);
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
                    'message' => 'Email or Password are wrong !',
                ],
                401
            );
        }
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

    public function getLogout()
    {
        Storage::delete('public/' . Auth::user()->id . '.json');
        Auth::logout();
        session()->flush();
        return redirect()->route('auth.login');
    }
}
