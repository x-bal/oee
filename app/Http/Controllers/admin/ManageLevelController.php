<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;
use App\Models\LevelModel as Level;
use App\Models\MenuModel as Menu;

class ManageLevelController extends Controller
{
    public function getLevel()
    {
        $menus = Menu::all();
        return view('pages.admin.level', [
            'menus' => $menus
        ]);
    }
    public function getLevelList()
    {
        $levels = Level::all();
        return DataTables::of($levels)
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
            ->rawColumns(['action'])
            ->make(true);
    }
    public function storeLevel(Request $request)
    {
        $menu_id = $request->menu_id;
        $input = [
            'txtlevelname' => $request->txtlevelname,
        ];
        if ($request->has('intsessline')) {
            $input['intsessline'] = $request->intsessline;
        }
        $create = Level::create($input);
        $result = [];
        foreach ($menu_id as $key => $val) {
            $result[] = [
                'level_id' => $create->id,
                'menu_id' => $menu_id[$key]
            ];
        }
        if ($create) {
            DB::table('level_access')->insert($result);
            return response()->json([
                'status' => 'success',
                'message' => 'Level created successfully'
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Level created failed'
            ], 200);
        }
    }
    public function editLevel($id)
    {
        $data = Level::findOrfail($id);
        $access = DB::table('level_access')->where('level_id', $id)->pluck('menu_id');
        if ($data) {
            return response()->json([
                'data' => $data,
                'access' => $access,
                'status' => 'success'
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Level not found'
            ], 404);
        }
    }
    public function updateLevel($id, Request $request)
    {
        $data = Level::findOrfail($id);
        $menu_id = $request->menu_id;
        $input = [
            'txtlevelname' => $request->txtlevelname
        ];
        if ($request->has('intsessline')) {
            $input['intsessline'] = $request->intsessline;
        }
        $result = [];
        foreach ($menu_id as $key => $val) {
            $result[] = [
                'level_id' => $id,
                'menu_id' => $menu_id[$key]
            ];
        }
        if ($data) {
            $data->update($input);
            DB::table('level_access')->where('level_id', $id)->delete();
            DB::table('level_access')->insert($result);
            return response()->json([
                'message' => 'Level updated successfully',
                'status' => 'success'
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Level not found'
            ], 404);
        }
    }
    public function destroyLevel($id)
    {
        $data = Level::findOrfail($id);
        if ($data) {
            $data->delete();
            DB::table('level_access')->where('level_id', $id)->delete();
            return response()->json([
                'message' => 'Level deleted successfully',
                'status' => 'success'
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Level not found'
            ], 404);
        }
    }
}
