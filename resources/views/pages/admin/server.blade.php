@extends('layouts.default')

@section('title', 'Manage Server')

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
                <li class="breadcrumb-item active">Manage Server</li>
            </ol>
            <h1 class="page-header mb-0">Manage Server</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i
                    class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add Server</a>
        </div>
    </div>
    <!-- BEGIN panel -->
    <div class="panel panel-inverse">
        <!-- BEGIN panel-heading -->
        <div class="panel-heading">
            <h4 class="panel-title">Data Server</h4>
            <div class="panel-heading-btn">
                <a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i
                        class="fa fa-expand"></i></a>
                <a type="button" onclick="reloadTable()" class="btn btn-xs btn-icon btn-success"
                    data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i
                        class="fa fa-minus"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i
                        class="fa fa-times"></i></a>
            </div>
        </div>
        <!-- END panel-heading -->
        <!-- BEGIN panel-body -->
        <div class="panel-body">
            <div class="row mb-3">
                <div class="col-md-4 btn-toggle">
                    <button onclick="toggleBtn('activate')" class="btn btn-sm btn-success"><i class="fas fa-wifi"></i>
                        Activate</button>
                    <button onclick="toggleBtn('stop')" class="btn btn-sm btn-danger"><i class="fas fa-power-off"></i>
                        Stop</button>
                </div>
            </div>
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>HOST</th>
                            <th>PORT</th>
                            <th>USERNAME</th>
                            <th>SWITCH</th>
                            <th>ACTION</th>
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
                            <label for="Host">Host* :</label>
                            <input type="text" id="Host" name="txthost" class="form-control"
                                placeholder="Enter Host" data-parsley-required="true" />
                        </div>
                        <div class="mb-3">
                            <label for="Port">Port* :</label>
                            <input type="number" id="Port" name="intport" class="form-control" placeholder="1883"
                                data-parsley-required="true" />
                        </div>
                        <div class="mb-3">
                            <label for="WsPort">Websocket Port* :</label>
                            <input type="number" id="WsPort" name="intwsport" class="form-control" placeholder="8000"
                                data-parsley-required="true" />
                        </div>
                        <div class="mb-3">
                            <label for="Username">Username :</label>
                            <input type="text" id="Username" name="txtusername" class="form-control"
                                placeholder="Enter Username" />
                        </div>
                        <div class="mb-3">
                            <label for="Password">Password :</label>
                            <input type="password" id="Password" name="txtpassword" class="form-control"
                                placeholder="Enter Password" />
                        </div>
                        <div class="mb-3">
                            <label for="ClientID">ClientID* :</label>
                            <input type="text" id="ClientID" name="txtclientid" class="form-control"
                                placeholder="Enter Password" data-parsley-required="true" />
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
            ajax: "{{ route('manage.server.index') }}",
            processing: true,
            serverSide: true,
            columns: [{
                    data: 'DT_RowIndex'
                },
                {
                    data: 'txthost'
                },
                {
                    data: 'intport'
                },
                {
                    data: 'txtusername'
                },
                {
                    data: 'switch'
                },
                {
                    data: 'action'
                }
            ]
        });

        function getUrl() {
            return action;
        }

        function getMethod() {
            return method;
        }

        function reloadTable() {
            daTable.draw();
        }

        function create() {
            $('#userModal').modal('show');
            $('.modal-body form')[0].reset();
            $('.modal-header h4').html('Create New Server');
            $('.modal-footer .btn-success').text('Save');
            action = "{{ route('manage.server.store') }}";
            method = "POST";
        }

        function edit(id) {
            $('.modal-header h4').html('Edit Server');
            $('.modal-footer .btn-success').text('Update');
            action = "{{ route('manage.server.update', ':id') }}";
            action = action.replace(':id', id);
            method = "PUT";
            let editUrl = "{{ route('manage.server.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response) {
                    $('#userModal').modal('show');
                    $('input[name="txthost"]').val(response.server.txthost);
                    $('input[name="intport"]').val(response.server.intport);
                    $('input[name="intwsport"]').val(response.server.intwsport);
                    $('input[name="txtusername"]').val(response.server.txtusername);
                    $('input[name="txtpassword"]').val(response.server.txtpassword);
                    $('input[name="txtclientid"]').val(response.server.txtclientid);
                },
            })
        }

        function destroy(id) {
            let deleteUrl = "{{ route('manage.server.destroy', ':id') }}";
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
                        success: function(response) {
                            daTable.draw();
                            orFail = (response.status == 'success' ? 'bg-success' : 'bg-danger');
                            gritter(response.status, response.message, orFail);
                        }
                    })
                }
            });
        }

        function activateBroker(id) {
            let activateUrl = "{{ route('manage.server.switch', ':id') }}";
            activateUrl = activateUrl.replace(':id', id);
            $.ajax({
                url: activateUrl,
                data: {
                    "_token": "{{ csrf_token() }}",
                },
                method: "PUT",
                dataType: "JSON",
                success: function(response) {
                    daTable.draw();
                    gritter(response.status, response.message, (response.status == 'success' ? 'bg-success' :
                        'bg-danger'));
                }
            })
        }

        function checkStatus() {
            $.ajax({
                url: "{{ route('manage.server.status') }}",
                type: "GET",
                dataType: "JSON",
                success: function(response) {
                    console.log(response);
                    if (response.message.replace(/\D/g, '') > 0) {
                        $('.btn-toggle').find('.btn-success').addClass('disabled');
                    } else {
                        $('.btn-toggle').find('.btn-danger').addClass('disabled');
                    }
                }
            })
        }

        function toggleBtn(param) {
            if (param == "stop") {
                $.ajax({
                    url: "{{ route('manage.server.activate', 'stop') }}",
                    type: "GET",
                    dataType: "JSON",
                    success: function(response) {
                        console.log(response);
                        $('.btn-toggle').find('.btn-danger').addClass('disabled');
                        $('.btn-toggle').find('.btn-success').removeClass('disabled');
                        gritter('Success', response.message, 'bg-success');
                    }
                })
            } else {
                setTimeout(function() {
                    location.reload();
                }, 3000);
                $.ajax({
                    url: "{{ route('manage.server.activate', 'active') }}",
                    type: "GET",
                    dataType: "JSON",
                    success: function(response) {
                        console.log(response);
                        $('.btn-toggle').find('.btn-success').addClass('disabled');
                        $('.btn-toggle').find('.btn-danger').removeClass('disabled');
                        gritter('Success', response.message, 'bg-success');
                    }
                })
            }
        }

        function gritter(title, text, status) {
            $.gritter.add({
                title: title,
                text: '<p class="text-light">' + text + '</p>',
                class_name: status,
                time: 1000,
            });
        }
        $(document).ready(function() {
            checkStatus();
            $('.modal-body form').on('submit', function(e) {
                e.preventDefault();
                let orFail = '';
                $.ajax({
                    url: getUrl(),
                    method: getMethod(),
                    data: $(this).serialize(),
                    dataType: "JSON",
                    success: function(response) {
                        $('#userModal').modal('hide');
                        orFail = (response.status == 'success' ? 'bg-success' : 'bg-danger');
                        daTable.draw();
                        gritter(response.status, response.message, orFail);
                    }
                })
            })
        })
    </script>
@endpush
