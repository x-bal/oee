<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;
use App\Models\ServerModel as Server;

class ManageServerController extends Controller
{
    public function getServer(Request $request)
    {
        if ($request->wantsJson()) {
            $servers = Server::all();
            return DataTables::of($servers)
                ->addIndexColumn()
                ->addColumn('switch', function ($row) {
                    $switch =
                        '<input onclick="activateBroker(' .
                        $row->id .
                        ')" value="1" class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" ' .
                        ($row->intactive ? 'checked' : '') .
                        '>';
                    return '<div class="form-check form-switch">' .
                        $switch .
                        '</div>';
                })
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
                ->rawColumns(['switch', 'action'])
                ->make(true);
        } else {
            return view('pages.admin.server');
        }
    }
    public function storeServer(Request $request)
    {
        $input = $request->all();
        $create = Server::create($input);
        if ($create) {
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Server created successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Server created failed',
                ],
                401
            );
        }
    }
    public function editServer($id)
    {
        $server = Server::find($id);
        if ($server) {
            return response()->json(
                [
                    'status' => 'success',
                    'server' => $server,
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Server data not found !',
                ],
                404
            );
        }
    }
    public function switchServer($id)
    {
        $server = Server::find($id);
        if ($server) {
            Server::where('intactive', 1)->update(['intactive' => 0]);
            $server->update(['intactive' => 1]);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Server activated successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Server data not found !',
                ],
                404
            );
        }
    }
    public function activateServer($param)
    {
        if ($param == 'stop') {
            $command = 'sudo /bin/systemctl stop phpmqtt.service';
            exec($command, $output);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Server Stopped successfully',
                    'output' => $output,
                ],
                200
            );
        } else {
            // chdir('../../mqtt_php');
            $command = 'sudo /bin/systemctl start phpmqtt.service';
            exec($command, $output);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Server activated successfully',
                    'output' => $output,
                ],
                200
            );
        }
    }
    public function checkServerStatus()
    {
        $command = 'systemctl status phpmqtt';
        $status = exec($command, $output, $return_var);
        return response()->json(
            [
                'message' => $status,
                'output' => $output,
                'status' => $return_var,
            ],
            200
        );
    }
    public function updateServer($id, Request $request)
    {
        $input = $request->all();
        $server = Server::find($id);
        if ($server) {
            $server->update($input);
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Server updated successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Server data not found !',
                ],
                404
            );
        }
    }
    public function destroyServer($id)
    {
        $server = Server::find($id);
        if ($server) {
            $server->delete();
            return response()->json(
                [
                    'status' => 'success',
                    'message' => 'Server deleted successfully',
                ],
                200
            );
        } else {
            return response()->json(
                [
                    'status' => 'error',
                    'message' => 'Server data not found !',
                ],
                404
            );
        }
    }
}
