@extends('layouts.default')

@section('title', 'Manage Topic')

@push('css')
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
                <li class="breadcrumb-item active">Manage Topic</li>
            </ol>
            <h1 class="page-header mb-0">Manage Topic</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i
                    class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add New Topic</a>
        </div>
    </div>
    <!-- BEGIN panel -->
    <div class="panel panel-inverse">
        <!-- BEGIN panel-heading -->
        <div class="panel-heading">
            <h4 class="panel-title">Data Topic</h4>
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
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>MACHINE</th>
                            <th>BROKER</th>
                            <th>TOPIC</th>
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
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-light">
                    <h4 class="modal-title">Modal Dialog</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
                </div>
                <div class="modal-body">
                    <form action="" method="post" data-parsley-validate="true">
                        @csrf
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="Machine">Machine* :</label>
                                <select name="machine_id" id="Machine" class="select2 form-control"
                                    data-parsley-required="true">
                                    <option value=""></option>
                                    @foreach ($machines as $item)
                                        <option value="{{ $item->id }}">{{ $item->txtmachinename }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="Server">Server* :</label>
                                <select name="broker_id" id="Server" class="select2 form-control"
                                    data-parsley-required="true">
                                    <option value=""></option>
                                    @foreach ($brokers as $item)
                                        <option value="{{ $item->id }}">{{ $item->txthost . ' - ' . $item->intport }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <button type="button" class="btn btn-primary btn-sm float-end mb-3" onclick="newEntry()">ADD
                                FIELD</button>
                        </div>
                        <div class="mb-3">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>NAME</th>
                                        <th>TOPIC</th>
                                        <th>ACTION</th>
                                    </tr>
                                </thead>
                                <tbody class="entry">

                                </tbody>
                            </table>
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
        let index = 1;
        var daTable = $('#daTable').DataTable({
            ajax: "{{ route('manage.topic.index') }}",
            processing: true,
            serverSide: true,
            columns: [{
                    data: 'DT_RowIndex'
                },
                {
                    data: 'txtmachinename'
                },
                {
                    data: 'broker'
                },
                {
                    data: 'topic_detail',
                    name: 'topics',
                    render: function(data) {
                        let topic = JSON.parse(data);
                        console.log(topic);
                        let list = '';
                        $.each(topic, function(i, val) {
                            list += '<li class="list-group-item">' + topic[i].txtname + ' - ' + topic[i].txttopic + '</li>';
                        })
                        return '<ul class="list-group">' + list + '</ul>';
                    }
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
            daTable.ajax.reload(null, false);
        }

        function defaultEntry() {
            let wrapper = $('.entry');
            let field = '<tr>' +
                '<td>' + index + '</td>' +
                '<td><input type="text" id="TopicName' + index +
                '" name="txtname[]" class="form-control" placeholder="TOPIC NAME" data-parsley-required="true"/></td>' +
                '<td><input type="text" id="Topic' + index +
                '" name="txttopic[]" class="form-control topic" placeholder="TOPIC" data-parsley-required="true"/></td>' +
                '<td>Unavailable</td>' +
                '</tr>';
            wrapper.append(field);
        }

        function newEntry() {
            index++;
            let wrapper = $('.entry');
            let field = '<tr>' +
                '<td>' + index + '</td>' +
                '<td><input type="text" id="TopicName' + index +
                '" name="txtname[]" class="form-control" placeholder="TOPIC NAME" data-parsley-required="true"/></td>' +
                '<td><input type="text" id="Topic' + index +
                '" name="txttopic[]" class="form-control topic" placeholder="TOPIC" data-parsley-required="true"/></td>' +
                '<td><button type="button" class="btn btn-sm btn-danger btn-delete">Delete</button></td>' +
                '</tr>';
            wrapper.append(field);
        }

        function editEntry(data) {
            let wrapper = $('.entry');
            let entry = '';
            $.each(data, function(i, val) {
                index = (i + 1);
                entry += '<tr>' +
                    '<td>' + (i + 1) + '</td>' +
                    '<td><input type="text" id="TopicName' + (i + 1) +
                    '" name="txtname[]" class="form-control" placeholder="TOPIC NAME" data-parsley-required="true" value="' +
                    data[i].txtname + '"/></td>' +
                    '<td><input type="text" id="Topic' + (i + 1) +
                    '" name="txttopic[]" class="form-control topic" placeholder="TOPIC" data-parsley-required="true" value="' +
                    data[i].txttopic + '"/></td>' +
                    (index > 1 ?
                        '<td><button type="button" class="btn btn-sm btn-danger btn-delete">Delete</button></td>' :
                        'Unavailable') +
                    '</tr>';
            })
            wrapper.append(entry);
        }

        function resetEntry() {
            index = 1;
            let wrapper = $('.entry');
            wrapper.find('tr').remove();
        }

        function create() {
            $('#userModal').modal('show');
            $('.modal-body form')[0].reset();
            $('.modal-header h4').html('Create New Topic');
            $('.modal-footer .btn-success').text('Save');
            defaultEntry();
            action = "{{ route('manage.topic.store') }}";
            method = "POST";
        }

        function edit(id) {
            $('.modal-header h4').html('Edit Topic');
            $('.modal-footer .btn-success').text('Update');
            action = "{{ route('manage.topic.update', ':id') }}";
            action = action.replace(':id', id);
            method = "PUT";
            let editUrl = "{{ route('manage.topic.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response) {
                    $('#userModal').modal('show');
                    $('select[name="broker_id"]').val(response.topic.broker_id).trigger('change');
                    $('select[name="machine_id"]').val(response.topic.machine_id).trigger('change');
                    editEntry(response.topics);
                },
            })
        }

        function destroy(id) {
            let deleteUrl = "{{ route('manage.topic.destroy', ':id') }}";
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
            let activateUrl = "{{ route('manage.server.activate', ':id') }}";
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

        function gritter(title, text, status) {
            $.gritter.add({
                title: title,
                text: '<p class="text-light">' + text + '</p>',
                class_name: status,
                time: 1000,
            });
        }
        $(document).ready(function() {
            $('select[name="machine_id"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Machine",
                allowClear: true
            });
            $('select[name="broker_id"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Server",
                allowClear: true
            });
            $('.topic').on('input', function() {
                return $(this).val($(this).val().toLowerCase().replace(/\s/g, ""));
            })
            $('.entry').on('click', '.btn-delete', function(e) {
                e.preventDefault();
                index--;
                $(this).closest('tr').remove();
            })
            $('#userModal').on('hidden.bs.modal', function(e) {
                e.preventDefault();
                resetEntry();
            })
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
