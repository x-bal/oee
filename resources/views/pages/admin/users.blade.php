@extends('layouts.default')

@section('title', 'Manage Users')

@push('css')
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Users</li>
            </ol>
            <h1 class="page-header mb-0">Users</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add User</a>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data Users</h4>
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
                            <th>NAMA</th>
                            <th>USERNAME</th>
                            <th>INITIAL</th>
                            <th>QR</th>
                            <th>LEVEL</th>
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
            <form action="" method="post" data-parsley-validate="true">
                @csrf
                <div class="mb-3">
                    <label for="Nama">Nama* :</label>
                    <input type="text" id="Nama" name="txtname" class="form-control" placeholder="Enter Name" data-parsley-required="true" oninput="this.value = this.value.toUpperCase()"/>
                </div>
                <div class="mb-3">
                    <label for="Username">Username* :</label>
                    <input type="text" id="Username" name="txtemail" class="form-control" placeholder="Enter Username" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="Initial">Initial* :</label>
                    <input type="text" id="Initial" name="txtinitial" class="form-control" placeholder="Enter Initial" data-parsley-maxlength="4" data-parsley-required="true" oninput="this.value = this.value.toUpperCase()"/>
                </div>
                <div class="mb-3 password">
                    <label for="Password">Password* :</label>
                    <input type="password" id="Password" name="txtpassword" class="form-control" placeholder="Enter Password"/>
                </div>
                <div class="mb-3">
                    <label for="Level">Level* :</label>
                    <select name="level_id" id="Level" class="select2 form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($level as $item)
                            <option value="{{ $item->id }}">{{ $item->txtlevelname }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3" id="line-row">
                    <label for="Line">Line :</label>
                    <select name="line_id[]" id="Line" class="select2 form-control" multiple>
                        <option value=""></option>
                        @foreach ($lines as $item)
                            <option value="{{ $item->id }}">{{ $item->txtlinename }}</option>
                        @endforeach
                    </select>
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
    <!-- #modal-dialog -->
    <div class="modal fade" id="resetPassModal" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-light">
                <h4 class="modal-title">Modal Dialog</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
            <form action="" method="post" data-parsley-validate="true">
                @csrf
                <div class="mb-3 reset-password">
                    <label for="NewPassword">New Password* :</label>
                    <input type="password" id="NewPassword" name="newpassword" class="form-control" placeholder="Enter New Password" data-parsley-required="true"/>
                </div>
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-white" data-bs-dismiss="modal">Close</a>
                <button type="submit" class="btn btn-success">Update</button>
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
    <script src="/assets/plugins/select2/dist/js/select2.min.js"></script>
    <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
    <script src="/assets/plugins/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        let action = '';
        let method = '';
        var daTable = $('#daTable').DataTable({
            ajax: "{{ route('manage.user.index') }}",
			processing: true,
        	serverSide: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'txtname'},
                {data: 'txtusername'},
                {data: 'txtinitial'},
                {data: 'txtqrcode'},
                {data: 'txtlevelname'},
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
            $('.select2').val(0).trigger('change');
            $('.modal-header h4').html('Create User');
            $('.modal-footer .btn-success').text('Save');
            $('.password').css('display', 'block');
            $('#line-row').hide();
            $('input[name="txtpassword"]').attr('data-parsley-required', true);
            action = "{{ route('manage.user.store') }}";
            method = "POST";
        }
        function edit(id){
            $('.modal-header h4').html('Edit User');
            $('.modal-footer .btn-success').text('Update');
            $('.password').css('display', 'none');
            $('input[name="txtpassword"]').attr('data-parsley-required', false);
            $('#userModal').modal('show');
            action = "{{ route('manage.user.update', ':id') }}";
            action = action.replace(':id', id);
            method = "PUT";
            let editUrl = "{{ route('manage.user.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response){
                    $('input[name="txtname"]').val(response.user.txtname);
                    $('input[name="txtemail"]').val(response.user.txtusername);
                    $('input[name="txtinitial"]').val(response.user.txtinitial);
                    $('select[name="level_id"]').val(response.user.level_id).trigger('change');
                    $('select[name="line_id[]"]').val(response.line_id).trigger('change');
                    showOrhideLine(response.user.level_id);

                }
            })
        }
        function pass(id){
            $('.modal-header h4').html('Change Password');
            $('#resetPassModal').modal('show');
            method = "PUT";
            action = "{{ route('manage.password.update', ':id') }}";
            action = action.replace(':id', id);
        }
        function destroy(id){
            let deleteUrl = "{{ route('manage.user.destroy', ':id') }}";
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
        function showOrhideLine(level){
            if (level !== 7 || level !== 6) {
                $('#line-row').show();
            } else {
                $('#line-row').hide();
            }
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
            $('select[name="level_id"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Level",
                allowClear: true
            });
            $('select[name="line_id[]"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Line",
                allowClear: true
            });
            $('select[name="level_id"]').on('change', function(e){
                e.preventDefault();
                const level = $(this).val();
                showOrhideLine(level);
            })
            $('.modal-body form').on('submit', function(e){
                e.preventDefault();
                let orFail = '';
                $.ajax({
                    url: getUrl(),
                    method: getMethod(),
                    data: $(this).serialize(),
                    dataType: "JSON",
                    success: function(response){
                        $('#userModal, #resetPassModal').modal('hide');
                        orFail = (response.status == 'success'?'bg-success':'bg-danger');
                        daTable.ajax.reload(null, false);
                        gritter(response.status, response.message, orFail);
                    },
                    error: function(response){
                        console.log(response.responseJSON.fields);
                        let fields = response.responseJSON.fields;
                        $.each(fields, function(i, val){
                            for (let index = 0; index < val.length; index++) {
                                gritter('error', val[index], 'bg-danger');
                            }
                        })
                    }
                })
            })
        })
    </script>
@endpush
