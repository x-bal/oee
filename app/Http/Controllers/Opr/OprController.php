<?php

namespace App\Http\Controllers\Opr;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class OprController extends Controller
{
    public function getIndex()
    {
        return view('pages.opr.opr-input');
    }
}
