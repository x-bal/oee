<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ActivityModel as Activity;
use App\Models\LineProcess as Line;
use Yajra\DataTables\Facades\DataTables;

class ManageActivityController extends Controller
{
    public function getIndex(Line $lines)
    {
        $line = $lines->all();
        $kategori = [
            'sh' => 'Shut Down',
            'br' => 'Break Down/Failure',
            'se' => 'Set Up and Adjustment',
            'ch' => 'Cutting Tool & Jig Change time = Replacement time',
            'st' => 'Startup Time',
            'ot' => 'Others Down Time',
            'id' => 'Idle Time',
            'mi' => 'Minor Stoppage',
        ];
        return view('pages.admin.activity', [
            'lines' => $line,
            'categories' => $kategori,
        ]);
    }
    public function getListActivity(Activity $activity, $param)
    {
        if ($param == 'all') {
            $activities = $activity
                ->select('mactivitycode.*', 'mline.txtlinename')
                ->join('mline', 'mline.id', '=', 'mactivitycode.line_id')
                ->get();
            } else {
            $activities = $activity
                ->select('mactivitycode.*', 'mline.txtlinename')
                ->join('mline', 'mline.id', '=', 'mactivitycode.line_id')
                ->where('mactivitycode.line_id', $param)
                ->get();
        }
        return DataTables::of($activities)
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
            ->editColumn('txtcategory', function ($row) {
                return strtoupper($row->txtcategory);
            })
            ->rawColumns(['action'])
            ->make(true);
    }
    public function storeActivity(Request $request)
    {
        $name = $request->txtactivityname;
        $item = $request->txtactivityitem;
        $category = $request->txtcategory;
        $line_id = $request->line_id;
        $description = $request->txtdescription;
        $check = Activity::where('txtcategory', $category)
            ->where('line_id', $line_id)
            ->count();
        if ($check > 0) {
            $code = $category . '.' . ($check + 1);
        } else {
            $code = $category . '.1';
        }
        $data = [
            'line_id' => $line_id,
            'txtactivitycode' => $code,
            'txtcategory' => $category,
            'txtactivityname' => $name,
            'txtactivityitem' => $item,
            'txtdescription' => $description,
        ];
        $insert = Activity::insert($data);
        if ($insert) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Activity created successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Activity created Failed',
                ],
                401
            );
        }
    }
    public function editActivity($id)
    {
        $data = Activity::findorfail($id);
        if ($data) {
            return response()->json(
                [
                    'status' => 'success',
                    'activity' => $data,
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
    public function updateActivity($id, Request $request)
    {
        $activity = Activity::findOrfail($id);
        $name = $request->txtactivityname;
        $item = $request->txtactivityitem;
        $category = $request->txtcategory;
        $line_id = $request->line_id;
        $description = $request->txtdescription;
        $data = [
            'line_id' => $line_id,
            'txtcategory' => $category,
            'txtactivityname' => $name,
            'txtactivityitem' => $item,
            'txtdescription' => $description,
        ];
        if ($activity->txtcategory != $category) {
            $check = Activity::where('txtcategory', $category)
                ->where('line_id', $line_id)
                ->count();
            $code = $category . '.' . ($check + 1);
            $data['txtactitvitycode'] = $code;
        }
        if ($activity) {
            $activity->update($data);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Activity created successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Activity not Found',
                ],
                404
            );
        }
    }
    public function destroyActivity($id)
    {
        $activity = Activity::findOrfail($id);
        if ($activity) {
            $activity->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Activity deleted successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Activity deleted Failed',
                ],
                401
            );
        }
    }
}
