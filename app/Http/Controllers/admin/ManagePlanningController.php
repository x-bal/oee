<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Yajra\DataTables\Facades\DataTables;

class ManagePlanningController extends Controller
{
    public function getIndex()
    {
        return view('pages.admin.planning');
    }
    public function getListPlanning($status)
    {
        switch ($status) {
            case 'Pending':
                $response = Http::withBasicAuth('admin', '@0332022')->get(
                    'http://10.175.11.67/api-kmi/api/oee/status',
                    [
                        'status' => $status,
                        'decode_content' => false,
                        'headers' => [
                            'Content-Type' => 'application/json',
                        ],
                    ]
                );
                break;
            case 'WIP':
                $response = Http::withBasicAuth('admin', '@0332022')->get(
                    'http://10.175.11.67/api-kmi/api/oee/status',
                    [
                        'status' => $status,
                        'decode_content' => false,
                        'headers' => [
                            'Content-Type' => 'application/json',
                        ],
                    ]
                );
                break;
            case 'Closed':
                $response = Http::withBasicAuth('admin', '@0332022')->get(
                    'http://10.175.11.67/api-kmi/api/oee/statusfinish',
                    [
                        'status' => $status,
                        'decode_content' => false,
                        'headers' => [
                            'Content-Type' => 'application/json',
                        ],
                    ]
                );
                break;
            case 'Completed':
                $response = Http::withBasicAuth('admin', '@0332022')->get(
                    'http://10.175.11.67/api-kmi/api/oee/statusfinish',
                    [
                        'status' => $status,
                        'decode_content' => false,
                        'headers' => [
                            'Content-Type' => 'application/json',
                        ],
                    ]
                );
                break;
        }
        $result = json_decode($response->getBody()->getContents(), true);
        $datas = collect($result['data'])->all();
        return DataTables::of($datas)
            ->addIndexColumn()
            ->make(true);
    }
}
