@extends('layouts.default')

@section('title', 'Manage Products')

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
                <li class="breadcrumb-item active">Products</li>
            </ol>
            <h1 class="page-header mb-0">Products</h1>
        </div>
        <div class="ms-auto">
            <a type="button" class="btn btn-success btn-rounded px-4" onclick="create()"><i class="fa fa-plus fa-lg me-2 ms-n2 text-success-900"></i> Add Product</a>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Data Products</h4>
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
                            <th>Line Name</th>
                            <th>Art Code</th>
                            <th>Product Name</th>
                            <th>Product Code</th>
                            <th>Line Code</th>
                            <th>Batch Size</th>
                            <th>Standard Speed</th>
                            <th>Pcs/karton</th>
                            <th>Net Fill</th>
                            <th>Category</th>
                            <th>Focus Category</th>
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
                    <label for="Line">Line* :</label>
                    <select name="line_id" id="Line" class="select2 form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($lines as $item)
                            <option value="{{ $item->id }}">{{ $item->txtlinename }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="Code">Art Code* :</label>
                    <input type="text" id="Code" name="txtartcode" class="form-control" placeholder="Enter Art Code" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="LineCode">Line Code* :</label>
                    <input type="text" id="LineCode" name="txtlinecode" class="form-control" placeholder="Enter Line Code" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="ProductCode">Product Code* :</label>
                    <input type="text" id="ProductCode" name="txtproductcode" class="form-control" placeholder="Enter Product Code" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="Name">Product Name* :</label>
                    <input type="text" id="Name" name="txtproductname" class="form-control" placeholder="Enter Product Name" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="batchSize">Batch Size* :</label>
                    <input type="text" id="batchSize" name="floatbatchsize" class="form-control" placeholder="Enter Batch Size" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="StdSpeed">Standar Speed :</label>
                    <input type="text" id="StdSpeed" name="floatstdspeed" class="form-control" placeholder="Enter Std Speed"/>
                </div>
                <div class="mb-3">
                    <label for="pcsKarton">Pcs / Karton :</label>
                    <input type="number" id="pcsKarton" name="intpcskarton" class="form-control" placeholder="Enter PCS/Karton"/>
                </div>
                <div class="mb-3">
                    <label for="NetFill">Net Fill :</label>
                    <input type="number" id="NetFill" name="intnetfill" class="form-control" placeholder="Enter Net Fill"/>
                </div>
                <div class="mb-3">
                    <label for="Category">Category* :</label>
                    <input type="text" id="Category" name="txtcategory" class="form-control" placeholder="Enter Category" data-parsley-required="true"/>
                </div>
                <div class="mb-3">
                    <label for="FocusCategory">Focus Category* :</label>
                    <input type="text" id="FocusCategory" name="txtfocuscategory" class="form-control" placeholder="Enter Focus Category" data-parsley-required="true"/>
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
    <script src="/assets/js/jquery.mask.min.js"></script>
    <script>
        let action = '';
        let method = '';
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        var daTable = $('#daTable').DataTable({
            ajax: "{{ route('manage.product.list') }}",
			processing: true,
        	serverSide: true,
            columns: [
                {data: 'DT_RowIndex'},
                {data: 'txtlinename'},
                {data: 'txtartcode'},
                {data: 'txtproductname'},
                {data: 'txtproductcode'},
                {data: 'txtlinecode'},
                {data: 'floatbatchsize'},
                {data: 'floatstdspeed'},
                {data: 'intpcskarton'},
                {data: 'intnetfill'},
                {data: 'txtcategory'},
                {data: 'txtfocuscategory'},
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
            $('.modal-header h4').html('Create Product');
            $('.modal-footer .btn-success').text('Save');
            action = "{{ route('manage.product.store') }}";
            method = "POST";
        }
        function edit(id){
            $('.modal-header h4').html('Edit Product');
            $('.modal-footer .btn-success').text('Update');
            $('.modal-body form')[0].reset();
            $('#userModal').modal('show');
            action = "{{ route('manage.product.update', ':id') }}";
            action = action.replace(':id', id);
            method = "PUT";
            let editUrl = "{{ route('manage.product.edit', ':id') }}";
            editUrl = editUrl.replace(':id', id);
            $.ajax({
                url: editUrl,
                type: "GET",
                dataType: "JSON",
                success: function(response){
                    $('input[name="txtartcode"]').val(response.product.txtartcode);
                    $('input[name="txtlinecode"]').val(response.product.txtlinecode);
                    $('input[name="txtproductname"]').val(response.product.txtproductname);
                    $('input[name="txtproductcode"]').val(response.product.txtproductcode);
                    $('input[name="floatbatchsize"]').val(response.product.floatbatchsize);
                    $('input[name="floatstdspeed"]').val(response.product.floatstdspeed);
                    $('input[name="intpcskarton"]').val(response.product.intpcskarton);
                    $('input[name="intnetfill"]').val(response.product.intnetfill);
                    $('input[name="txtcategory"]').val(response.product.txtcategory);
                    $('input[name="txtfocuscategory"]').val(response.product.txtfocuscategory);
                    $('select[name="line_id"]').val(response.product.line_id).trigger('change');
                }
            })
        }
        function destroy(id){
            let deleteUrl = "{{ route('manage.product.destroy', ':id') }}";
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
            $("#batchSize").mask("000000.00", {reverse: true});
            $("#DrierStdSpeed").mask("000000.00", {reverse: true});
            $("#packingSpeed").mask("000000.00", {reverse: true});
            $("#shelfLife").mask("000000.00", {reverse: true});
            $('select[name="line_id"]').select2({
                dropdownParent: $('#userModal'),
                placeholder: "Select Line",
                allowClear: true
            });
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