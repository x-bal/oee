<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AssignOperatorController extends Controller
{
    public function getAssign(Request $request)
    {
        if ($request->wantsJson()) {
            # code...
        } else {
            return view('pages.admin.assign-operator');
        }
    }
    public function storeAssignOperator(Request $request)
    {
        # code...
    }
    public function editAssignOperator($id)
    {
        # code...
    }
}
