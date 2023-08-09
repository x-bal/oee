@extends('layouts.default')

@section('title', 'Manage Plan Order')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Plan Order</li>
            </ol>
            <h1 class="page-header mb-0">Plan Order</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add Plan Order</a>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data Plan Order</h4>
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
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>LINE NAME</th>
                            <th>PRODUCT NAME</th>
                            <th>BATCH CODE</th>
                            <th>TARGET</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
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
                    <label for="Product">Product* :</label>
                    <select name="product_id" id="Product" class="select2 form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($products as $item)
                            <option value="{{ $item->id }}">{{ $item->txtartcode.' - '.$item->txtproductname }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="Target">Target :</label>
                    <input type="number" id="Target" name="inttarget" class="form-control" placeholder="Enter Target"  data-parsley-required="true"/>
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
    <script>
        let action = '';
        let method = '';
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        var daTable = $('#daTable').DataTable({
            ajax: "{{ route('manage.planorder.index') }}",
			processing: true,
        	serverSide: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'txtlinename'},
                {data: 'part_name'},
                {data: 'txtbatchcode'},
                {data: 'inttarget'},
                {data: 'status'},
                {data: 'action'}
            ]
        });
        function getUrl(){
            return action;
        }
        function getMethod(){
            return method;
        }
        function reloadTable(){
            daTable.ajax.reload(null, false);
        }
        function create(){
            $('#userModal').modal('show');
            $('.modal-body form')[0].reset();
            $('.modal-body form').find('input[name="_method"]').remove();
            $('.select2').val(0).trigger('change');
            $('.modal-header h4').html('Create Plan Order');
            $('.modal-footer .btn-success').text('Save');
            $('img#previewImg').attr('src','/assets/img/machine/default.jpg');
            action = "{{ route('manage.planorder.store') }}";
            method = "POST";
        }
        function edit(id){
            $('.modal-body form')[0].reset();
            $('.modal-body form').append('<input type="hidden" name="_method" value="PUT">');
            action = "{{ route('manage.planorder.update', ':id') }}";
            action = action.replace(':id', id);
            method = "POST";
            let editUrl = "{{ route('manage.planorder.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response){
                    $('.modal-header h4').html('Edit Plan Order '+response.plan.txtbatchcode);
                    $('.modal-footer .btn-success').text('Update');
                    $('#userModal').modal('show');
                    $('input[name="inttarget"]').val(response.plan.inttarget);
                    $('select[name="line_id"]').val(response.plan.line_id).trigger('change');
                    $('select[name="product_id"]').val(response.plan.product_id).trigger('change');
                }
            })
        }
        function destroy(id){
            let deleteUrl = "{{ route('manage.planorder.destroy', ':id') }}";
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
                            daTable.ajax.reload(null, false);
                            orFail = (response.status == 'success'?'bg-success':'bg-danger');
                            gritter(response.status, response.message, orFail);
                        }
                    })
                }
            });
        }
        function release(id){
            let releaseUrl = "{{ route('manage.planorder.release', ':id') }}";
            releaseUrl = releaseUrl.replace(':id', id);
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
                        text: 'Release',
                        value: true,
                        visible: true,
                        className: 'btn btn-primary',
                        closeModal: true
                    }
                }
            }).then((isConfirm) => {
				if (isConfirm) {
                    $.ajax({
                        url: releaseUrl,
                        data: {
                            "_token": "{{ csrf_token() }}",
                        },
                        type: "PUT",
                        dataType: "JSON",
                        success: function(response){
                            daTable.ajax.reload(null, false);
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
            $('select[name="product_id"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Product",
                allowClear: true
            });
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
                        daTable.ajax.reload(null, false);
                        gritter(response.status, response.message, orFail);
                    }
                })
            })
        })
    </script>
@endpush
