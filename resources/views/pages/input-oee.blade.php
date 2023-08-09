@extends('layouts.default')

@section('title', 'Input OEE')

@push('css')
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/handsontable/handsontable.full.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Input OEE</li>
            </ol>
            <h1 class="page-header mb-0">Input OEE</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data Line Process</h4>
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
            <button id="save" class="btn btn-primary">Save data</button>
            <div id="handsonTable" class="my-3"></div>
		</div>
		<!-- END panel-body -->
	</div>
	<!-- END panel -->
    <!-- #modal-dialog -->
    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-light">
                <h4 class="modal-title">Modal Dialog</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
            <form action="" method="post" data-parsley-validate="true">
                @csrf
                <div class="mb-3">
                    <label for="Name">Name* :</label>
                    <input type="text" id="Name" name="txtlinename" class="form-control" placeholder="Enter Line Name" data-parsley-required="true" oninput="this.value = this.value.toUpperCase()"/>
                </div>
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-white" data-bs-dismiss="modal">Close</a>
                <button type="submit" class="btn btn-success">Action</button>
            </div>
            </form>
        </div>
        </div>
    </div>
    <!-- End-Modal-Dialog -->
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
    <script src="/assets/plugins/handsontable/handsontable.full.js"></script>
    <script>
        let action = '';
        let method = '';
        var data = [];
        function refreshData(){
            return data;
        }
        const container = document.getElementById('handsonTable');
        const save = document.querySelector('#save');
        $.ajax({
            url: "{{ route('input.oee.list') }}",
            type: "GET",
            dataType: "JSON",
            success: function(response){
                // let datas = JSON.parse(response.data);
                hot.loadData(response.data);
            }
        })
        const hot = new Handsontable(container, {
            data: refreshData(),
            rowHeaders: true,
            colHeaders: true,
            colHeaders: ['Shift', 'Tanggal', 'Start', 'Finish', 'Lama Kejadian (Min)', 'Activity_id', 'Activity Code', 'Deskripsi Kejadian', 'Remarks', 'Operator', 'Produk Code', 'Produk', 'OKP Packing', 'Production Code', 'Expired Date'],
            height: '500',
            contextMenu: true,
            stretchH: 'all',
            columns: [
                {
                    data: 'shift_id'
                },
                {
                    data: 'tanggal',
                    type: 'date',
                    dateFormat: 'YYYY-MM-DD'
                },
                {
                    data: 'start',
                    readOnly: true
                },
                {
                    data: 'finish',
                    readOnly: true
                },
                {
                    data: 'lamakejadian',
                    type: 'numeric'
                },
                {
                    data: 'activity_id',
                },
                {
                    data: 'txtactivitycode',
                    type: 'autocomplete',
                    source: @json($code),
                    strict: true
                },
                {
                    data: 'txtdescription',
                    readOnly: true
                },
                {
                    data: 'remark'
                },
                {
                    data: 'operator'
                },
                {
                    data: 'produk_code'
                },
                {
                    data: 'produk'
                },
                {
                    data: 'okp_packing'
                },
                {
                    data: 'production_code'
                },
                {
                    data: 'expired_date',
                    type: 'date',
                    dateFormat: 'YYYY-MM-DD'
                },
            ],
            width: 'auto',
            filters: true,
            dropdownMenu: true,
            columnSorting: true,
            minSpareRows: 1,
            manualColumnResize: true,
            hiddenColumns: {
                // specify columns hidden by default
                columns: [5]
            },
            afterChange: function(change, row){
                if(change){
                    if (change[0][1] == 'txtactivitycode') {
                        descActivity(change[0][0], change[0][3]);
                    }
                }
            },
            licenseKey: 'non-commercial-and-evaluation' // for non-commercial use only
        });
        Handsontable.dom.addEvent(save, 'click', () => {
            // console.log(hot.getData());
            $.ajax({
                url: "{{ route('input.oee.store') }}",
                type: "POST",
                data: {
                    "_token": "{{ csrf_token() }}",
                    "datas": hot.getData()
                },
                dataType: "JSON",
                success: function(response){
                    gritter(response.status, response.message);
                },
                error: function(response){
                    gritter('error', response.responseJSON.message);
                }
            })
        });

        function descActivity(row, code){
            let actLink = "{{ route('input.oee.activity', ':code') }}";
            actLink = actLink.replace(':code', code);
            $.ajax({
                url: actLink,
                type: "GET",
                dataType: "JSON",
                success: function(response){
                    hot.setDataAtRowProp(row, 'activity_id', response.activity.id);
                    hot.setDataAtRowProp(row, 'txtdescription', response.activity.txtdescription);
                    gritter(response.status, response.message)
                },
                error: function(res){
                    gritter(res.responseJSON.status, res.responseJSON.message);
                },
            })
        }

        function getUrl(){
            return action;
        }
        function getMethod(){
            return method;
        }
        function gritter(title, text){
            let className = (title == 'success'?'bg-success':'bg-danger');
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: className,
                time: 1000,
            });
        }
        $(document).ready(function(){
            $('.modal-body form').on('submit', function(e){
                e.preventDefault();
                let orFail = '';
                $.ajax({
                    url: getUrl(),
                    method: getMethod(),
                    data: $(this).serialize(),
                    dataType: "JSON",
                    success: function(response){
                        $('#userModal').modal('hide');
                        orFail = (response.status == 'success'?'bg-success':'bg-danger');
                        daTable.draw();
                        gritter(response.status, response.message, orFail);
                    }
                })
            })
        })
    </script>
@endpush
