<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DetailReportContoller extends Controller
{
    public function production()
    {
        return view('pages.detail-report.production');
    }
}
