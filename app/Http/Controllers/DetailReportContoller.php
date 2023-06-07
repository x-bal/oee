<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\LineProcess as line;
use Illuminate\Http\Request;

class DetailReportContoller extends Controller
{
    public function _chartOee($line = false)
    {
        $oee = DB::table('v_shift_oee')
            ->when($line, function($q) use ($line){
                $q->where('line_id', $line);
            }, function($q){
                $q->where('line_id', 1);
            })->first();
        return $oee;
    }
    public function production(Request $request)
    {
        $lines = Line::all();
        return view('pages.detail-report.production', [
            'lines' => $lines,
            'oee' => $this->_chartOee($request->line_id)
        ]);
    }
}
