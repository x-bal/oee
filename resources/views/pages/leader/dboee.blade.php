@extends('layouts.default')

@section('title', 'DB OEE View')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" />

    <style>
        .text-bold{
            font-weight: bold;
        }
    </style>
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">View DB OEE</li>
            </ol>
            <h1 class="page-header mb-0">View DB OEE</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data DB OEE</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
				<a type="button" onclick="reloadTable()" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<!-- END panel-heading -->
		<!-- BEGIN panel-body -->
		<div class="panel-body">
            <div class="col-md-6">
                <div class="row mb-5">
                    <div class="col-md-4">
                        <div class="row">
                            <label for="Year" class="col-form-label col-md-4">Year :</label>
                            <div class="col-md-8">
                                <select name="year_filter" id="Year" class="form-select">
                                    @foreach ($years as $year)
                                        <option value="{{ $year->txtyear }}">{{ $year->txtyear }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <button type="button" id="filterBtn" class="btn btn-primary btn-sm">Filter</button>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tanggal</th>
                            <th>Line</th>
                            <th align="middle">Shift</th>
                            <th>OKP</th>
                            <th>Produk</th>
                            <th>Std Speed</th>
                            <th>Actual Speed</th>
                            <th>Speed Loss</th>
                            <th>Defect Loss</th>
                            <th>Downtime Loss</th>
                            <th>Total Minor Stop</th>
                            <th>Total Shut Down</th>
                            <th>Total Downtime</th>
                            <th>Working Time</th>
                            <th>Loading Time</th>
                            <th>Operating Time</th>
                            <th>Net Operating Time</th>
                            <th>Value-adding Operating Time</th>
                            <th text-align="middle">Avaibility Rate</th>
                            <th text-align="middle">Performance Rate</th>
                            <th text-align="middle">Quality Rate</th>
                            <th text-align="middle">OEE</th>
                            <th text-align="middle">Utilization Rate</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
		</div>
		<!-- END panel-body -->
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
    <script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/assets/plugins/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
    <script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="/assets/plugins/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
    <script src="/assets/plugins/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="/assets/plugins/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
    <script src="/assets/plugins/datatables.net-buttons/js/buttons.colVis.min.js"></script>
    <script src="/assets/plugins/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="/assets/plugins/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="/assets/plugins/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="/assets/plugins/pdfmake/build/pdfmake.min.js"></script>
    <script src="/assets/plugins/pdfmake/build/vfs_fonts.js"></script>
    <script src="/assets/plugins/jszip/dist/jszip.min.js"></script>
    <script>
        let action = '';
        let method = '';
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        var daTable = $('#daTable').DataTable({
            ajax: {
                url: "{{ route('leader.list.dboee') }}",
                type: "POST",
                data: function(data){
                    data.year = $('select[name="year_filter"]').val();
                }
            },
			processing: true,
        	serverSide: true,
            ordering: false,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'tanggal'},
                {data: 'txtlinename'},
                {data: 'shift_id'},
                {data: 'okp'},
                {data: 'product'},
                {data: 'std_speed'},
                {data: 'actual_speed'},
                {data: 'speed_loss'},
                {data: 'defect_loss'},
                {data: 'downtime_loss'},
                {data: 'total_mi'},
                {data: 'total_sh'},
                {data: 'total_downtime'},
                {data: 'working_time'},
                {data: 'loading_time'},
                {data: 'operating_time'},
                {data: 'net_optime'},
                {data: 'value_adding'},
                {data: 'ar'},
                {data: 'pr'},
                {data: 'qr'},
                {data: 'oee'},
                {data: 'utilization_rate'},
            ],
                "columnDefs": [{
                    "targets":[6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
                    "visible": false
                },
                {"className": "dt-center", "targets": [0, 1, 2, 3, 4, 19, 20, 21, 22, 23]},
                {"className": "text-bold", "targets": [22, 23]},
            ],
            dom: '<"row"<"col-sm-4"l><"col-sm-5"B><"col-sm-3"fr>>t<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                {
                    extend: 'copy',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-copy"></i> Copy'
                },
                {
                    extend: 'csv',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-file-csv"></i> CSV'
                },
                {
                    extend: 'excel',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-file-excel"></i> Excel'
                },
                {
                    extend: 'pdf',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-file-pdf"></i> Pdf'
                },
                {
                    extend: 'print',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-print"></i> Print'
                }
            ],
        });
        function gritter(title, text, status){
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: status,
                time: 1000,
            });
        }

        $(document).ready(function(){
            $('#filterBtn').on('click', function(e){
                e.preventDefault();
                daTable.ajax.reload(null, false).draw(false);
            })
        })
    </script>
@endpush
