@extends('layouts.default')

@section('title', 'Select Month')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        .result-icon{
            width: 5%;
            position: relative;
        }
    </style>
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Select Month</li>
            </ol>
            <h1 class="page-header mb-0">OEE Month</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">MONTH OEE</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
				<a type="button" onclick="reloadTable()" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<!-- END panel-heading -->
        <div class="panel-body bg-gray-200">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a href="#default-tab-1" data-bs-toggle="tab" class="nav-link active">Pending</a>
                </li>
                <li class="nav-item">
                    <a href="#default-tab-2" data-bs-toggle="tab" class="nav-link">Work in Process</a>
                </li>
                <li class="nav-item">
                    <a href="#default-tab-3" data-bs-toggle="tab" class="nav-link">Closed</a>
                </li>
                <li class="nav-item">
                    <a href="#default-tab-4" data-bs-toggle="tab" class="nav-link">Completed</a>
                </li>
              </ul>
            <div class="tab-content panel p-3 rounded-0 rounded-bottom">
                <div class="tab-pane fade active show" id="default-tab-1">
                    <div class="table-responsive">
                        <table id="datablePending" class="table table-striped table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>BATCH NUMBER</th>
                                    <th>DATE CREATED</th>
                                    <th>PLAN START</th>
                                    <th>ITEM CODE</th>
                                    <th>PRODUCT NAME</th>
                                    <th>PLAN QTY</th>
                                    <th>LINE PROCESS</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="default-tab-2">
                    <div class="table-responsive">
                        <table id="datableWip" class="table table-striped table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>BATCH NUMBER</th>
                                    <th>DATE CREATED</th>
                                    <th>PLAN START</th>
                                    <th>ACTUAL START</th>
                                    <th>ITEM CODE</th>
                                    <th>PRODUCT NAME</th>
                                    <th>PLAN QTY</th>
                                    <th>LINE PROCESS</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="default-tab-3">
                    <div class="table-responsive">
                        <table id="datableClosed" class="table table-striped table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>BATCH NUMBER</th>
                                    <th>DATE CREATED</th>
                                    <th>PLAN START</th>
                                    <th>ACTUAL START</th>
                                    <th>COMPLETED DATE</th>
                                    <th>ITEM CODE</th>
                                    <th>PRODUCT NAME</th>
                                    <th>PLAN QTY</th>
                                    <th>ACTUAL QTY</th>
                                    <th>LINE PROCESS</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="default-tab-4">
                    <div class="table-responsive">
                        <table id="datableCompleted" class="table table-striped table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>BATCH NUMBER</th>
                                    <th>DATE CREATED</th>
                                    <th>PLAN START</th>
                                    <th>ACTUAL START</th>
                                    <th>COMPLETED DATE</th>
                                    <th>ITEM CODE</th>
                                    <th>PRODUCT NAME</th>
                                    <th>PLAN QTY</th>
                                    <th>ACTUAL QTY</th>
                                    <th>LINE PROCESS</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
	    </div>
    </div>
	<!-- END panel -->
@endsection

@push('scripts')
	<script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
	<script src="/assets/plugins/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
	<script src="/assets/plugins/@highlightjs/cdn-assets/highlight.min.js"></script>
	<script src="/assets/js/demo/render.highlight.js"></script>
    <script src="/assets/plugins/parsleyjs/dist/parsley.min.js"></script>
    <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
    <script src="/assets/plugins/sweetalert/dist/sweetalert.min.js"></script>
    <script src="/assets/plugins/select2/dist/js/select2.min.js"></script>
    <script>
        let action = '';
        let method = '';
        var pending = $('#datablePending').DataTable({
            ajax: "{{ route('management.planning.list', 'Pending') }}",
			processing: true,
        	serverSide: true,
            responsive: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'BATCH_NO'},
                {data: 'CREATION_DATE'},
                {data: 'PLAN_STR_DT'},
                {data: 'ITEM_CODE'},
                {data: 'DESCRIPTION'},
                {
                    data: 'PLAN_QTY', name:'plan_qty',
                    "render": function ( data, type, row, meta )
                    {
                        return data+' '+ row.UOM;
                    }
                },
                {data: 'BATCH_TYPE'}
            ]
        });
        var wip = $('#datableWip').DataTable({
            ajax: "{{ route('management.planning.list', 'WIP') }}",
			processing: true,
        	serverSide: true,
            responsive: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'BATCH_NO'},
                {data: 'CREATION_DATE'},
                {data: 'PLAN_STR_DT'},
                {data: 'ACT_STR_DT'},
                {data: 'ITEM_CODE'},
                {data: 'DESCRIPTION'},
                {
                    data: 'PLAN_QTY', name:'plan_qty',
                    "render": function ( data, type, row, meta )
                    {
                        return data+' '+ row.UOM;
                    }
                },
                {data: 'BATCH_TYPE'}
            ]
        });
        var closed = $('#datableClosed').DataTable({
            ajax: "{{ route('management.planning.list', 'Closed') }}",
			processing: true,
        	serverSide: true,
            responsive: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'BATCH_NO'},
                {data: 'CREATION_DATE'},
                {data: 'PLAN_STR_DT'},
                {data: 'ACT_STR_DT'},
                {data: 'ACTUAL_CMPLT_DATE'},
                {data: 'ITEM_CODE'},
                {data: 'DESCRIPTION'},
                {
                    data: 'PLAN_QTY', name:'plan_qty',
                    "render": function ( data, type, row, meta )
                    {
                        return data+' '+ row.UOM;
                    }
                },
                {
                    data: 'ACTUAL_QTY', name:'actual_qty',
                    "render": function ( data, type, row, meta )
                    {
                        return data+' '+ row.UOM;
                    }
                },
                {data: 'BATCH_TYPE'}
            ]
        });
        var completed = $('#datableCompleted').DataTable({
            ajax: "{{ route('management.planning.list', 'Completed') }}",
			processing: true,
        	serverSide: true,
            responsive: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'BATCH_NO'},
                {data: 'CREATION_DATE'},
                {data: 'PLAN_STR_DT'},
                {data: 'ACT_STR_DT'},
                {data: 'ACTUAL_CMPLT_DATE'},
                {data: 'ITEM_CODE'},
                {data: 'DESCRIPTION'},
                {
                    data: 'PLAN_QTY', name:'plan_qty',
                    "render": function ( data, type, row, meta )
                    {
                        return data+' '+ row.UOM;
                    }
                },
                {
                    data: 'ACTUAL_QTY', name:'actual_qty',
                    "render": function ( data, type, row, meta )
                    {
                        return data+' '+ row.UOM;
                    }
                },
                {data: 'BATCH_TYPE'}
            ]
        });
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        function getUrl(){
            return action;
        }
        function getMethod(){
            return method;
        }
        function reloadTable(){
            daTable.draw();
        }
        function gritter(title, text){
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: status,
                time: 1000,
            });
        }
        $(document).ready(function(){
            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable().columns.adjust().responsive.recalc();
            });
        })
    </script>
@endpush

