@extends('layouts.default')

@section('title', 'Manage Machines')

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
                <li class="breadcrumb-item active">Machines</li>
            </ol>
            <h1 class="page-header mb-0">Machines</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i
                    class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add Machines</a>
        </div>
    </div>
    <!-- BEGIN panel -->
    <div class="panel panel-inverse">
        <!-- BEGIN panel-heading -->
        <div class="panel-heading">
            <h4 class="panel-title">Data Machines</h4>
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
                            <th>Line Name</th>
                            <th>Machine Name</th>
                            <th>Machine Picture</th>
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
                            <label for="Name">Machine Name* :</label>
                            <input type="text" id="Name" name="txtmachinename" class="form-control"
                                placeholder="Enter Machine Name" data-parsley-required="true"
                                oninput="this.value = this.value.toUpperCase()" />
                        </div>
                        <div class="mb-3">
                            <label for="formFile" class="form-label">Machine Picture: </label>
                            <input class="form-control" type="file" id="formFile" name="txtpicture"
                                onchange="preview()">
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="BottleNeck" name="intbottleneck" value="1"/>
                            <label class="form-check-label" for="BottleNeck">Line Bottleneck?</label>
                        </div>
                        <div class="mb-3">
                            <img id="previewImg" src="{{ asset('/assets/img/machine/default.png') }}" alt="Preview Machine"
                                class="img-thumbnail mx-auto d-block" style="width: 50%">
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
            ajax: "{{ route('manage.machine.list') }}",
            processing: true,
            serverSide: true,
            columns: [{
                    data: 'DT_RowIndex'
                },
                {
                    data: 'txtlinename'
                },
                {
                    data: 'txtmachinename'
                },
                {
                    data: 'txtpicture',
                    name: 'Picture',
                    render: function(data) {
                        let img = '<img src="/assets/img/machine/' + data + '" width="64">';
                        return img;
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

        function preview() {
            const gambar = document.querySelector('#formFile');
            const imgPreview = document.querySelector('#previewImg')
            //mengganti preview
            const fileSampul = new FileReader();
            fileSampul.readAsDataURL(gambar.files[0])
            fileSampul.onload = function(e) {
                imgPreview.src = e.target.result;
            }
        }

        function create() {
            $('#userModal').modal('show');
            $('.modal-body form')[0].reset();
            $('.modal-body form').find('input[name="_method"]').remove();
            $('.select2').val(0).trigger('change');
            $('.modal-header h4').html('Create Machines');
            $('.modal-footer .btn-success').text('Save');
            $('img#previewImg').attr('src', '/assets/img/machine/default.jpg');
            action = "{{ route('manage.machine.store') }}";
            method = "POST";
        }

        function edit(id) {
            $('.modal-header h4').html('Edit Machines');
            $('.modal-footer .btn-success').text('Update');
            $('.modal-body form')[0].reset();
            $('.modal-body form').append('<input type="hidden" name="_method" value="PUT">');
            $('#userModal').modal('show');
            action = "{{ route('manage.machine.update', ':id') }}";
            action = action.replace(':id', id);
            method = "POST";
            let editUrl = "{{ route('manage.machine.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response) {
                    $('input[name="txtmachinename"]').val(response.machine.txtmachinename);
                    $('#BottleNeck[value="'+response.machine.intbottleneck+'"]').prop('checked', true);
                    $('select[name="line_id"]').val(response.machine.line_id).trigger('change');
                    $('#previewImg').attr('src', '/assets/img/machine/' + response.machine.txtpicture);
                }
            })
        }

        function destroy(id) {
            let deleteUrl = "{{ route('manage.machine.destroy', ':id') }}";
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
                            daTable.ajax.reload(null, false);
                            orFail = (response.status == 'success' ? 'bg-success' : 'bg-danger');
                            gritter(response.status, response.message, orFail);
                        }
                    })
                }
            });
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
            $('.select2').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Line",
                allowClear: true
            });
            $('.modal-body form').on('submit', function(e) {
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
                    success: function(response) {
                        $('#userModal').modal('hide');
                        $('.modal-body form').find('input[name="_method"]').remove();
                        orFail = (response.status == 'success' ? 'bg-success' : 'bg-danger');
                        daTable.ajax.reload(null, false);
                        gritter(response.status, response.message, orFail);
                    }
                })
            })
        })
    </script>
@endpush
