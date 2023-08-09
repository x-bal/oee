@extends('layouts.default')

@section('title', 'Input Data OEE')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
    <link href="/assets/plugins/handsontable/handsontable.full.css" rel="stylesheet" />
    <style>
        .htCore > tbody > tr:nth-child(even) > td {
            background-color: #eee;
        }

        .htCore > tbody > tr:nth-child(odd) > td {
            background-color: #fff;
        }
    </style>
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Input Data OEE</li>
            </ol>
            <h1 class="page-header mb-0">Input Data OEE</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">Input Data OEE</h4>
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
                            <th>Date</th>
                            <th>Achievement</th>
                            <th>Avaibility Rate</th>
                            <th>Performance Rate</th>
                            <th>Quality Rate</th>
                            <th>Working Time</th>
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
    <div class="modal fade" id="oeeModal" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header text-light" style="background-image: linear-gradient(to right, #009933, #00e64d);">
                <h4 class="modal-title">Input Data {{ $line->txtlinename }}</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
                <div id="handsonTable" class="my-3"></div>
                <div class="alert alert-dark log-table" role="alert">
                    Log History akan memunculkan notifikasi error !
                </div>
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-white" data-bs-dismiss="modal">Close</a>
                <button id="save" class="btn btn-success">Save</button>
            </div>
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
    <script src="/assets/plugins/handsontable/handsontable.full.js"></script>
    <script src="/assets/plugins/moment/moment.js"></script>
    <script>
        let action = '';
        let method = '';
        let segment = "{{ Request::segment(3) }}";
        let daTable = "{{ route('admin-cg.date.list',':month') }}";
        daTable = daTable.replace(':month', segment);
        $('#daTable').DataTable({
            ajax: daTable,
			processing: true,
        	serverSide: true,
            columns: [
                {data: 'dates'},
                {data: 'oee'},
                {data: 'ar'},
                {data: 'pr'},
                {data: 'qr'},
                {data: 'worktime'},
                {data: 'button'}
            ],
            columnDefs: [
                {"className": "dt-center", "targets": [0, 2, 3, 4, 5, 6]},
            ]
        });
        let bascom = [
            'Fastener', 'Lubrication', 'Pneumatic', 'Hydralic', 'Drive', 'Electric', 'Safety', 'Process Condition'
        ];
        let cat_br = [
            'Man', 'Machine Weakness', 'Machine Deterioration', 'Material', 'Method'
        ];
        let ampm = ['AM', 'PM'];
        let cat_rework = [
            'SIEVER DRIER',
            'BAG STATION DRIER',
            'TBF',
            'AKHIR OKP DRIER',
            'FLUSHING FLAVOUR',
            'FLUSHING BASE',
            'SIEVER F&P',
            'FILLING',
            'EJECTOR',
            'PACKING',
            'KALENG CEKUNG/RO',
            'TOP UP 1 CAN FILL',
            'TOP UP 2 CAN FILL',
            'AKHIR PROSES F&P',
            'OTHER',
        ];
        let cat_reject = [
            'CAN',
            'BOTTOM LID',
            'PLASTIC LID',
            'SCOOP',
            'Carton Box',
            'Folding Box',
            'Alufo (kg)',
        ];
        const container = document.getElementById('handsonTable');
        const save = document.querySelector('#save');
        const config = {
            rowHeaders: true,
            colHeaders: true,
            colHeaders: @json($columns),
            height: '500',
            contextMenu: true,
            stretchH: 'all',
            columns: [
                {
                    data: 'id',
                    readOnly: true
                },
                {
                    data: 'line_id',
                    readOnly: true
                },
                {
                    data: 'txtlinename',
                    readOnly: true
                },
                {
                    data: 'shift_id',
                    readOnly: true
                },
                {
                    data: 'tanggal',
                    type: 'date',
                    dateFormat: 'YYYY-MM-DD',
                    readOnly: true
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
                    type: 'numeric',
                    readOnly:true
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
                    data: 'operator',
                    readOnly: true
                },
                {
                    data: 'okp_packing',
                    source: @json($okp),
                    type: 'autocomplete',
                    strict: false
                },
                {
                    data: 'produk_code'
                },
                {
                    data: 'produk'
                },
                {
                    data: 'production_code'
                },
                {
                    data: 'expired_date',
                    type: 'date',
                    dateFormat: 'YYYY-MM-DD'
                },
                {
                    data: 'waiting_tech',
                    type: 'numeric'
                },
                {
                    data: 'tech_name'
                },
                {
                    data: 'repair_problem',
                    type: 'numeric'
                },
                {
                    data: 'trial_time',
                    type: 'numeric'
                },
                {
                    data: 'bas_com',
                    type: 'dropdown',
                    source: bascom
                },
                {
                    data: 'category_br',
                    type: 'dropdown',
                    source: cat_br
                },
                {
                    data: 'category_ampm',
                    type: 'dropdown',
                    source: ampm
                },
                {
                    data: 'finish_good'
                },
                {
                    data: 'qc_sample'
                },
                {
                    data: 'category_rework',
                    type: 'dropdown',
                    source: cat_rework
                },
                {
                    data: 'rework'
                },
                {
                    data: 'reject'
                },
                {
                    data: 'category_reject',
                    type: 'dropdown',
                    source: cat_reject
                },
                {
                    data: 'reject_pcs'
                },
                {
                    data: 'jumlah_manpower',
                    type: 'numeric'
                }
            ],
            width: 'auto',
            filters: true,
            undo: false,
            dropdownMenu: true,
            columnSorting: true,
            minSpareRows: 1,
            hiddenColumns: {
                // specify columns hidden by default
                columns: [0, 1, 8]
            },
            licenseKey: 'non-commercial-and-evaluation' // for non-commercial use only
        };
        var data = [];
        function refreshData(){
            return data;
        }
        function getData(shift, date){
            const hot = new Handsontable(container, config);
            $('#oeeModal').on('shown.bs.modal', function(e){
                $.ajax({
                    url: "{{ route('leaderCg.oee.list') }}",
                    type: "POST",
                    data: {
                        "_token": "{{ csrf_token() }}",
                        shift: shift,
                        date: date,
                        line: "{{ $line->id }}"
                    },
                    dataType: "JSON",
                    success: function(response){
                        hot.updateSettings({
                            afterChange: function(change, row){
                                if(change){
                                    if (change[0][1] == 'txtactivitycode') {
                                        descActivity(change[0][0], change[0][3]);
                                    }
                                    if (change[0][1] == 'okp_packing') {
                                        okpDetail(change[0][0], change[0][3]);
                                    }
                                }
                            },
                            beforeChange: function(change, row){
                                if (change[0][1] == 'lamakejadian') {
                                    startTime(change[0][0], change[0][3], shift);
                                    shiftAndDate(change[0][0], shift, date);
                                    logHistory(change[0][0], shift);
                                }
                            },
                            beforeRemoveRow: function(index, amount, datas){
                                removeRow(hot.getDataAtCell(index, 0));
                            }
                        });
                        hot.loadData(response.data);
                        hot.render();
                    }
                })
            })
            Handsontable.dom.addEvent(save, 'click', () => {
                // console.log(hot.getData());
                $.ajax({
                    url: "{{ route('leaderCg.oee.store') }}",
                    type: "POST",
                    data: {
                        "_token": "{{ csrf_token() }}",
                        "datas": hot.getData()
                    },
                    dataType: "JSON",
                    success: function(response){
                        $('#oeeModal').modal('hide');
                        gritter(response.status, response.message);
                    },
                    error: function(response){
                        gritter('error', response.responseJSON.message);
                    }
                })
            });
            function descActivity(row, code){
                let actLink = "{{ route('input.oee.activity') }}";
                $.ajax({
                    url: actLink,
                    data: {
                        "_token": "{{ csrf_token() }}",
                        code: code,
                        line_id: "{{ $line->id }}"
                    },
                    type: "POST",
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
            function okpDetail(row, okp){
                $.ajax({
                    url: "{{ route('leaderCg.oee.okp') }}",
                    data: {
                        "_token": "{{ csrf_token() }}",
                        okp:okp
                    },
                    type: "POST",
                    dataType: "JSON",
                    success: function(response){
                        hot.setDataAtRowProp(row, 'produk_code', response.data.ITEM_CODE);
                        hot.setDataAtRowProp(row, 'produk', response.data.DESCRIPTION);
                    },
                    error: function(res){
                        gritter(res.responseJSON.status, res.responseJSON.message);
                    },
                })
            }
            function startTime(row, data, shift){
                const val = hot.getDataAtRowProp((row-1), 'finish');
                if (val === null) {
                    if (shift == 1) {
                        var finish = moment('07:00:00', 'H:mm:ss').add(data, 'minutes').format('H:mm:ss');
                        hot.setDataAtRowProp(row, 'start', '07:00:00');
                        hot.setDataAtRowProp(row, 'finish', finish);
                    } else if(shift == 2){
                        var finish = moment('15:00:00', 'H:mm:ss').add(data, 'minutes').format('H:mm:ss');
                        hot.setDataAtRowProp(row, 'start', '15:00:00');
                        hot.setDataAtRowProp(row, 'finish', finish);
                    } else if(shift == 3){
                        var finish = moment('23:00:00', 'H:mm:ss').add(data, 'minutes').format('H:mm:ss');
                        hot.setDataAtRowProp(row, 'start', '23:00:00');
                        hot.setDataAtRowProp(row, 'finish', finish);
                    }
                } else {
                    var finish = moment(val, 'H:mm:ss').add(data, 'minutes').format('H:mm:ss');
                    hot.setDataAtRowProp(row, 'start', val);
                    hot.setDataAtRowProp(row, 'finish', finish);
                }
            }
            function shiftAndDate(row, shift, date){
                hot.setDataAtRowProp(row, 'line_id', "{{ $line->id }}");
                hot.setDataAtRowProp(row, 'txtlinename', "{{ $line->txtlinename }}");
                hot.setDataAtRowProp(row, 'shift_id', shift);
                hot.setDataAtRowProp(row, 'tanggal', date);
            }
            function logHistory(row, shift){
                const finish = hot.getDataAtRowProp(row, 'finish');
                switch (shift) {
                    case 1:
                        if (moment(finish, 'H:mm:ss') > moment('15:00:00', 'H:mm:ss')) {
                            $('.log-table').removeClass('alert-dark').addClass('alert-danger');
                            $('.log-table').text('Melebihi Working Time');
                            save.disabled = true;
                        } else {
                            $('.log-table').removeClass('alert-danger').addClass('alert-dark');
                            $('.log-table').text('Data Dapat disimpan');
                            save.disabled = false;
                        }
                        break;
                }
            }
            function removeRow(id){
                let url = "{{ route('leaderCg.oee.destroy', ':id') }}";
                url = url.replace(':id', id);
                $.ajax({
                    url: url,
                    data: {
                        "_token": "{{ csrf_token() }}",
                    },
                    type: "DELETE",
                    dataType: "JSON",
                    success: function(res){
                        gritter(res.status, res.message);
                        hot.render();
                    },
                    error: function(res){
                        gritter(res.responseJSON.status, res.responseJSON.message);
                    },
                })
            }
            $('#oeeModal').on('hidden.bs.modal', function(e){
                e.preventDefault();
                location.reload();
                //hot.destroy();
                // if (Handsontable.hooks.isDestroyed()) {
                //     gritter('Success', 'Successfully Destroyed!');
                // } else {
                //     gritter('Error', 'Failed Destroyed!');
                // }
            })
            // function addClassesToRows(TD, row, column, prop, value, cellProperties) {
            //     console.log(TD, row);
            //     // if (row % 2 === 0) {
            //     //     Handsontable.dom.addClass('background', '#333');
            //     // }
            // }
        }

        function getUrl(){
            return action;
        }
        function getMethod(){
            return method;
        }
        function reloadTable(){
            daTable.draw();
        }
        function gritter(title, text){
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: 'bg-success',
                time: 1000,
            });
        }
        $(document).ready(function(){
            $('#daTable').on('click','.btn-shift', function(e){
                e.preventDefault();
                const shift = $(this).data('shift');
                const date = $(this).data('date');
                getData(shift, date);
            })
        })
    </script>
@endpush

