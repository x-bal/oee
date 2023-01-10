@extends('layouts.default')

@section('title', 'OEE Management')

@push('css')
    <link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/handsontable/handsontable.full.css" rel="stylesheet" />
    <style>
        .htCore>tbody>tr:nth-child(even)>td {
            background-color: #eee;
        }

        .htCore>tbody>tr:nth-child(odd)>td {
            background-color: #fff;
        }
    </style>
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">OEE Management</li>
            </ol>
            <h1 class="page-header mb-0">OEE Management {{ $line->txtlinename }}</h1>
        </div>
    </div>
    <!-- BEGIN panel -->
    <div class="panel panel-inverse">
        <!-- BEGIN panel-heading -->
        <div class="panel-heading">
            <h4 class="panel-title">Data OEE Management {{ $line->txtlinename }}</h4>
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
            <button id="save" class="btn btn-primary">Save data</button>
            <div id="handsonTable" class="my-3"></div>
        </div>
        <!-- END panel-body -->
    </div>
    <!-- END panel -->
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
        let bascom = [
            'Fastener', 'Lubrication', 'Pneumatic', 'Hydralic', 'Drive', 'Electric', 'Safety', 'Process Condition'
        ];
        let cat_br = [
            'Man', 'Machine Weakness', 'Machine Deterioration', 'Material', 'Method'
        ];
        let ampm = ['AM', 'PM'];

        function refreshData() {
            return data;
        }
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
            colHeaders: ['OEE ID', 'Line ID', 'LINE NAME', 'Shift', 'Tanggal', 'Start', 'Finish', 'Lama Kejadian (Min)',
                'Activity_id', 'Activity Code', 'Deskripsi Kejadian', 'Remarks', 'Operator', 'OKP Packing',
                'Art Code', 'Nama Produk', 'Production Code', 'Expired Date', 'Waiting Technician (min)',
                'Technician Name', 'Repair Problem (min)', 'Start up/Trial Test (min)',
                'Category Breakdown 8 Basic Competency', 'Category Breakdown 4 M', 'Category Breakdown AM/PM',
                'Finish Good (CB)', 'QC Sample (pcs/alufo)', 'Category Rework', 'Rework (kg)', 'Reject Powder (kg)',
                'Reject Category', 'Reject PM (pcs)', 'Jumlah Man Power'
            ],
            height: '500',
            contextMenu: true,
            stretchH: 'all',
            columns: [{
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
                    data: 'okp_packing',
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
                    data: 'tech_name',
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
                    data: 'qc_sample',
                },
                {
                    data: 'category_rework',
                    type: 'dropdown',
                    source: cat_rework,
                },
                {
                    data: 'rework'
                },
                {
                    data: 'reject',
                },
                {
                    data: 'category_reject',
                    type: 'dropdown',
                    source: cat_reject,
                },
                {
                    data: 'reject_pcs',
                },
                {
                    data: 'jumlah_manpower',
                    type: 'numeric',
                }
            ],
            width: 'auto',
            filters: true,
            dropdownMenu: true,
            columnSorting: true,
            minSpareRows: 1,
            manualColumnResize: true,
            hiddenColumns: {
                // specify columns hidden by default
                columns: [0, 1, 8]
            },
            afterChange: function(change, row) {
                if (change) {
                    if (change[0][1] == 'txtactivitycode') {
                        descActivity(change[0][0], change[0][3]);
                    }
                    if (change[0][1] == 'okp_packing') {
                        okpDetail(change[0][0], change[0][3]);
                    }
                }
            },
            beforeChange: function(change, row) {
                if (change[0][1] == 'lamakejadian') {
                    startTime(change[0][0], change[0][3]);
                }
            },
            beforeRemoveRow: function(index, amount, datas) {
                for (let i = 0; i < amount; i++) {
                    removeRow(hot.getDataAtCell(datas[i], 0));
                }
            },
            licenseKey: 'non-commercial-and-evaluation' // for non-commercial use only
        };
        $.ajax({
            url: "{{ route('management.oee.list') }}",
            type: "POST",
            data: {
                "_token": "{{ csrf_token() }}",
                month: '{{ $month }}',
                line: '{{ $line_id }}'
            },
            dataType: "JSON",
            success: function(response) {
                hot.loadData(response.data);
            }
        })
        const hot = new Handsontable(container, config);
        Handsontable.dom.addEvent(save, 'click', () => {
            // console.log(hot.getData());
            $.ajax({
                url: "{{ route('management.oee.store') }}",
                type: "POST",
                data: {
                    "_token": "{{ csrf_token() }}",
                    "datas": hot.getData()
                },
                dataType: "JSON",
                success: function(response) {
                    gritter(response.status, response.message);
                },
                error: function(response) {
                    gritter('error', response.responseJSON.message);
                }
            })
        });

        function descActivity(row, code) {
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
                success: function(response) {
                    hot.setDataAtRowProp(row, 'activity_id', response.activity.id);
                    hot.setDataAtRowProp(row, 'txtdescription', response.activity.txtdescription);
                    gritter(response.status, response.message)
                },
                error: function(res) {
                    gritter(res.responseJSON.status, res.responseJSON.message);
                },
            })
        }

        function okpDetail(row, okp) {
            $.ajax({
                url: "{{ route('operator.oee.okp') }}",
                data: {
                    "_token": "{{ csrf_token() }}",
                    okp: okp
                },
                type: "POST",
                dataType: "JSON",
                success: function(response) {
                    hot.setDataAtRowProp(row, 'produk_code', response.data.ITEM_CODE);
                    hot.setDataAtRowProp(row, 'produk', response.data.DESCRIPTION);
                },
                error: function(res) {
                    gritter(res.responseJSON.status, res.responseJSON.message);
                },
            })
        }

        function startTime(row, data) {
            hot.setDataAtRowProp(row, 'line_id', "{{ $line->id }}");
            hot.setDataAtRowProp(row, 'txtlinename', "{{ $line->txtlinename }}");
            const val = hot.getDataAtRowProp((row - 1), 'finish');
            if (val === null) {
                var finish = moment('07:00:00', 'H:mm:ss').add(data, 'minutes').format('H:mm:ss');
                hot.setDataAtRowProp(row, 'start', '07:00:00');
                hot.setDataAtRowProp(row, 'finish', finish);
            } else {
                var finish = moment(val, 'H:mm:ss').add(data, 'minutes').format('H:mm:ss');
                hot.setDataAtRowProp(row, 'start', val);
                hot.setDataAtRowProp(row, 'finish', finish);
            }
        }

        function removeRow(id) {
            let url = "{{ route('operator.oee.destroy', ':id') }}";
            url = url.replace(':id', id);
            $.ajax({
                url: url,
                data: {
                    "_token": "{{ csrf_token() }}",
                },
                type: "DELETE",
                dataType: "JSON",
                success: function(res) {
                    gritter(res.status, res.message);
                    hot.render();
                },
                error: function(res) {
                    gritter(res.responseJSON.status, res.responseJSON.message);
                },
            })
        }

        function getUrl() {
            return action;
        }

        function getMethod() {
            return method;
        }

        function gritter(title, text) {
            let className = (title == 'success' ? 'bg-success' : 'bg-danger');
            $.gritter.add({
                title: title,
                text: '<p class="text-light">' + text + '</p>',
                class_name: className,
                time: 1000,
            });
        }
        $(document).ready(function() {
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
