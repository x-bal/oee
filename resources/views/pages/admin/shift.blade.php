@extends('layouts.default')

@section('title', 'Manage Shift')

@push('css')
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Shift</li>
            </ol>
            <h1 class="page-header mb-0">Shift</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add Shift</a>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data Shift</h4>
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
                            <th>Shift Name</th>
                            <th>Shift Start</th>
                            <th>Shift Finish</th>
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
            <form action="" method="post" data-parsley-validate="true">
                @csrf
                <div class="mb-3">
                    <label for="Name">Shift Name* :</label>
                    <input type="text" id="Name" name="txtshiftname" class="form-control" placeholder="Enter Shift Name" data-parsley-required="true" oninput="this.value = this.value.toUpperCase()"/>
                </div>
                <div class="mb-3">
                    <label for="Start">Start* :</label>
                    <input type="time" id="Start" name="tmstart" class="form-control" placeholder="Shift Start" data-parsley-required="true">
                </div>
                <div class="mb-3">
                    <label for="Finish">Finish* :</label>
                    <input type="time" id="Finish" name="tmfinish" class="form-control" placeholder="Shift Finish" data-parsley-required="true">
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="Interval" name="intinterval" value="1"/>
                    <label class="form-check-label" for="Interval">Finish tomorrow?</label>
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
    <script>
        let action = '';
        let method = '';
        var daTable = $('#daTable').DataTable({
            ajax: "{{ route('manage.shift.index') }}",
			processing: true,
        	serverSide: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'txtshiftname'},
                {data: 'tmstart'},
                {data: 'tmfinish'},
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
            daTable.draw();
        }
        function create(){
            $('#userModal').modal('show');
            $('.modal-body form')[0].reset();
            $('.select2').val(0).trigger('change');
            $('.modal-header h4').html('Create Shift');
            $('.modal-footer .btn-success').text('Save');
            action = "{{ route('manage.shift.store') }}";
            method = "POST";
        }
        function edit(id){
            $('.modal-header h4').html('Edit Shift');
            $('.modal-footer .btn-success').text('Update');
            $('#userModal').modal('show');
            action = "{{ route('manage.shift.update', ':id') }}";
            action = action.replace(':id', id);
            method = "PUT";
            let editUrl = "{{ route('manage.shift.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response){
                    $('input[name="txtshiftname"]').val(response.shift.txtshiftname);
                    $('input[name="tmstart"]').val(response.shift.tmstart);
                    $('input[name="tmfinish"]').val(response.shift.tmfinish);
                    $('#Interval[value="'+response.shift.intinterval+'"]').prop('checked', true);
                }
            })
        }
        function destroy(id){
            let deleteUrl = "{{ route('manage.shift.destroy', ':id') }}";
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
                    },
                    error: function(response){
                        gritter(response.responseJSON.status, response.responseJSON.message, 'bg-danger');
                    },
                })
            })
        })
    </script>
@endpush
