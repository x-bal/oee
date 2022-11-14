@extends('layouts.default')

@section('title', 'Manage Activity')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Activity</li>
            </ol>
            <h1 class="page-header mb-0">Activity</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add Activity</a>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data Activity</h4>
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
            <div class="col-md-4">
                <div class="row mb-3">
                    <label for="Line" class="col-form-label col-md-4">Filter Line :</label>
                    <div class="col-md-8">
                        <select name="line_filter" id="Line" class="form-select">
                            <option value="all">All</option>
                            @foreach ($lines as $line)
                                <option value="{{ $line->id }}">{{ $line->txtlinename }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Line Name</th>
                            <th>Category</th>
                            <th>Activity Item</th>
                            <th>Activity Code</th>
                            <th>Activity Name</th>
                            <th>Description</th>
                            <th>Aksi</th>
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
    <!-- #modal-dialog -->
    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-light">
                <h4 class="modal-title">Modal Dialog</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
            <form action="" method="post" data-parsley-validate="true" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="Line">Line* :</label>
                    <select name="line_id" id="Line" class="select2 form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($lines as $item)
                            <option value="{{ $item->id }}">{{ $item->txtlinename }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="Category">Category* :</label>
                    <select name="txtcategory" id="Category" class="select2 form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($categories as $key => $item)
                            <option value="{{ $key }}">{{ $item }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="Name">Activity Name* :</label>
                    <input type="text" id="Name" name="txtactivityname" class="form-control" placeholder="Enter Activity Name" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="ActivityItem">Activity Item :</label>
                    <input type="text" id="ActivityItem" name="txtactivityitem" class="form-control" placeholder="Enter Activity Item"/>
                </div>
                <div class="mb-3">
                    <label for="Description">Description :</label>
                    <textarea name="txtdescription" id="Description" rows="2" class="form-control"></textarea>
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
        let ajaxLink = "{{ route('manage.activity.list', ':param') }}";
        function newAjax(param = 'all'){
            let varLink = ajaxLink.replace(':param', param);
            return varLink;
        }
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        var daTable = $('#daTable').DataTable({
            ajax: {
                url: newAjax(),
                type: "GET"
            },
			processing: true,
        	serverSide: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'txtlinename'},
                {data: 'txtcategory'},
                {data: 'txtactivityitem'},
                {data: 'txtactivitycode'},
                {data: 'txtactivityname'},
                {data: 'txtdescription'},
                {data: 'action'}
            ],
            dom: '<"row"<"col-sm-4"l><"col-sm-5"B><"col-sm-3"fr>>t<"row"<"col-sm-5"i><"col-sm-7"p>>',
            buttons: [
                {
                    extend: 'copy',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-copy"></i> Copy',
                    exportOptions: {
                        columns: ':visible th:not(:last-child)'
                    }
                },
                {
                    extend: 'csv',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-file-csv"></i> CSV',
                    exportOptions: {
                        columns: ':visible th:not(:last-child)'
                    }
                },
                {
                    extend: 'excel',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-file-excel"></i> Excel',
                    exportOptions: {
                        columns: ':visible th:not(:last-child)'
                    }
                },
                {
                    extend: 'pdf',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-file-pdf"></i> Pdf',
                    exportOptions: {
                        columns: ':visible th:not(:last-child)'
                    }
                },
                {
                    extend: 'print',
                    className: 'btn-sm btn-success',
                    text: '<i class="fas fa-print"></i> Print',
                    exportOptions: {
                        columns: ':visible th:not(:last-child)'
                    }
                }
            ],
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
        function create(){
            $('#userModal').modal('show');
            $('.modal-body form')[0].reset();
            $('.modal-body form').find('input[name="_method"]').remove();
            $('.select2').val(0).trigger('change');
            $('.modal-header h4').html('Create Activity');
            $('.modal-footer .btn-success').text('Save');
            action = "{{ route('manage.activity.store') }}";
            method = "POST";
        }
        function edit(id){
            $('.modal-header h4').html('Edit Activity');
            $('.modal-footer .btn-success').text('Update');
            $('.modal-body form')[0].reset();
            $('.modal-body form').append('<input type="hidden" name="_method" value="PUT">');
            $('#userModal').modal('show');
            action = "{{ route('manage.activity.update', ':id') }}";
            action = action.replace(':id', id);
            method = "POST";
            let editUrl = "{{ route('manage.activity.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response){
                    $('input[name="txtactivityname"]').val(response.activity.txtactivityname);
                    $('input[name="txtactivityitem"]').val(response.activity.txtactivityitem);
                    $('select[name="line_id"]').val(response.activity.line_id).trigger('change');
                    $('select[name="txtcategory"]').val(response.activity.txtcategory).trigger('change');
                    $('textarea[name="txtdescription"]').val(response.activity.txtdescription);
                }
            })
        }
        function destroy(id){
            let deleteUrl = "{{ route('manage.activity.destroy', ':id') }}";
            deleteUrl = deleteUrl.replace(':id', id);
            let orFail = '';
            swal({
                title: 'Are you sure?',
                text: 'You will not be able to recover this data!',
                icon: 'warning',
                buttons: {
                    cancel: {
                        text: 'Cancel',
                        value: null,
                        visible: true,
                        className: 'btn btn-default',
                        closeModal: true,
                    },
                    confirm: {
                        text: 'Delete',
                        value: true,
                        visible: true,
                        className: 'btn btn-danger',
                        closeModal: true
                    }
                }
            }).then((isConfirm) => {
				if (isConfirm) {
                    $.ajax({
                        url: deleteUrl,
                        data: {
                            "_token": "{{ csrf_token() }}",
                        },
                        type: "DELETE",
                        dataType: "JSON",
                        success: function(response){
                            daTable.draw();
                            orFail = (response.status == 'success'?'bg-success':'bg-danger');
                            gritter(response.status, response.message, orFail);
                        }
                    })
                }
            });
        }
        function gritter(title, text, status){
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: status,
                time: 1000,
            });
        }
        $(document).ready(function(){
            $('select[name="line_id"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Line",
                allowClear: true
            });
            $('select[name="line_filter"]').select2({
                placeholder: "Select Line",
                allowClear: true
            });
            $('select[name="txtcategory"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Category",
                allowClear: true
            });
            $('select[name="line_filter"]').on('change', function(e){
                e.preventDefault();
                const line = $(this).val();
                daTable.ajax.url(newAjax(line));
                daTable.ajax.reload(null, false).draw(false);
            })
            $('.modal-body form').on('submit', function(e){
                e.preventDefault();
                let orFail = '';
                var formData = new FormData($(this)[0]);
                $.ajax({
                    url: getUrl(),
                    method: getMethod(),
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "JSON",
                    success: function(response){
                        $('#userModal').modal('hide');
                        $('.modal-body form').find('input[name="_method"]').remove();
                        orFail = (response.status == 'success'?'bg-success':'bg-danger');
                        daTable.draw();
                        gritter(response.status, response.message, orFail);
                    }
                })
            })
        })
    </script>
@endpush
