@extends('layouts.default')

@section('title', 'View OEE')

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
                <li class="breadcrumb-item active">View OEE</li>
            </ol>
            <h1 class="page-header mb-0">View OEE</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data OEE</h4>
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
            <div class="row mb-3">
                <div class="col-md-2">
                    <select name="year" id="Year" class="form-select">
                        @foreach ($years as $item)
                        <option value="{{ $item->txtyear }}">{{ $item->txtyear }}</option>
                        @endforeach
                    </select>
                </div>
                <input type="hidden" name="filter" value="monthly">
                <div class="col-md-2">
                    <select name="line" id="Line" class="form-select">
                        <option value="all">ALL</option>
                        @foreach ($lines as $item)
                        <option value="{{ $item->id }}">{{ $item->txtlinename }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col">
                    <button class="btn btn-sm btn-success btn-filter active" data-filter="monthly">Monthly</button>
                    <button class="btn btn-sm btn-success btn-filter" data-filter="weekly">Weekly</button>
                    <button class="btn btn-sm btn-success btn-filter" data-filter="daily">Daily</button>
                    <button class="btn btn-sm btn-success btn-filter" data-filter="shift">Shift</button>
                </div>
            </div>
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>GROUP</th>
                            <th>AR</th>
                            <th>PR</th>
                            <th>QR</th>
                            <th>OEE</th>
                            <th>UTILIZATION RATE</th>
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
        function getColumns(){
            let arr = [];
            let getCols = ['DT_RowIndex', 'tanggal', 'ar', 'pr', 'qr', 'oee', 'utilization_rate'];
            $.each(getCols, function(i, val){
                // console.log(i);
                arr.push({data: val});
            })
            return arr;
        }
        function btnFilter(val){
            return val;
        }
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        var daTable = $('#daTable').DataTable({
            ajax: {
                url: "{{ route('view.achievement.oee.list') }}",
                type: "POST",
                data: function(data){
                    data.year = $('select[name="year"]').val();
                    data.line = $('select[name="line"]').val();
                    data.filter = $('input[name="filter"]').val();
                }
            },
			processing: true,
        	serverSide: true,
            ordering: false,
            columns: getColumns(),
            columnDefs: [
                {"className": "dt-center", "targets": "_all"},
                {"className": "text-bold", "targets": [2, 3, 4, 5, 6]},
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
            getColumns();
            $('.btn-filter').on('click', function(e){
                e.preventDefault();
                $(this).closest('div').find('.active').removeClass('active');
                $(this).addClass('active');
                $('input[name="filter"]').val($(this).data('filter'));
                daTable.ajax.reload(null, false).draw(false);
            })
        })
    </script>
@endpush
