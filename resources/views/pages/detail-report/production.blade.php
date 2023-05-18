@extends('layouts.default')
@section('title', 'Detail Report Production')
@push('css')
    <link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/jvectormap-next/jquery-jvectormap.css" rel="stylesheet" />
    <link href="/assets/plugins/simple-calendar/dist/simple-calendar.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/nvd3/build/nv.d3.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
@endpush
@push('scripts')
<script src="/assets/plugins/d3/d3.min.js"></script>
<script src="/assets/plugins/nvd3/build/nv.d3.js"></script>
<script src="/assets/plugins/jvectormap-next/jquery-jvectormap.min.js"></script>
<script src="/assets/plugins/jvectormap-next/jquery-jvectormap-world-mill.js"></script>
<script src="/assets/plugins/simple-calendar/dist/jquery.simple-calendar.min.js"></script>
<script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
<script src="/assets/plugins/chart.js/dist/chart.min.js"></script>
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
<script src="/assets/plugins/select2/dist/js/select2.min.js"></script>
<script src="/assets/plugins/sweetalert/dist/sweetalert.min.js"></script>
<script src="{{ asset('assets/plugins/chart.js/dist/chartjs-plugin-datalabels.min.js') }}"></script>
<script src="{{ asset('assets/js/paho.mqtt.js') }}" type="text/javascript"></script>
<script>
    let url = "";
    let method = "";
    function getUrl(){
        return url;
    }
    function getMethod(){
        return method;
    }
    var handleOverallChart = function() {
        var ctx = document.getElementById('oee-chart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            plugins: [ChartDataLabels],
            data: {
                labels: ['OEE'],
                datasets: [{
                    data: [93, 7],
                    backgroundColor: ['#F57C00', '#EEE', '#C70039'],
                    label: 'OEE'
                }]
            },
            options: {
                responsive: true,
                aspectRatio: 1.3,
                plugins: {
                    datalabels: {
                        color: 'white',
                        font: {
                            weight: 'bold'
                        }
                    },
                }
            },
        })
    }
    //AVERAGE OVERALL BY SHIFTS
    var handleArPrQr = function() {
        var ctx3 = document.getElementById('arprqr-chart').getContext('2d');
        var urBar = ctx3.createLinearGradient(0, 0, 200, 0);
        urBar.addColorStop(0, 'blue');
        urBar.addColorStop(1, '#00cc00');
        var prodByop = ctx3.createLinearGradient(0, 0, 200, 0);
        prodByop.addColorStop(0, '#2596be');
        prodByop.addColorStop(1, '#85eabd');
        const labels = ['Avaibility', 'Performance', 'Quality', 'Utilization'];
        const ur = [86, 97, 95, 95];
        const data = {
            labels: labels,
            datasets: [{
                label: 'OEE',
                data: ur,
                backgroundColor: urBar,
                order: 1
            }, ]
        };
        const config = {
            type: 'bar',
            data: data,
            plugins: [ChartDataLabels],
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    datalabels: {
                        color: 'white',
                        font: {
                            weight: 'bold'
                        }
                    }
                },
                indexAxis: 'y'
            },
        };
        var barChart = new Chart(ctx3, config);
    }
    //AVERAGE OVERALL BY SHIFTS
    var handleOeeShift = function() {
        var ctx3 = document.getElementById('shifts-chart').getContext('2d');
        var urBar = ctx3.createLinearGradient(0, 0, 200, 0);
        urBar.addColorStop(0, 'blue');
        urBar.addColorStop(1, '#00cc00');
        var prodByop = ctx3.createLinearGradient(0, 0, 200, 0);
        prodByop.addColorStop(0, '#2596be');
        prodByop.addColorStop(1, '#85eabd');
        const labels = ['SHIFT 3', 'SHIFT 2', 'SHIFT 1'];
        const ur = [0, 0, 98];
        const data = {
            labels: labels,
            datasets: [{
                label: 'OEE By Shifts',
                data: ur,
                backgroundColor: urBar,
                order: 1
            }, ]
        };
        const config = {
            type: 'bar',
            data: data,
            plugins: [ChartDataLabels],
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    datalabels: {
                        color: 'white',
                        font: {
                            weight: 'bold'
                        }
                    }
                },
                indexAxis: 'y'
            },
        };
        var barChart = new Chart(ctx3, config);
    }
    $(document).ready(function(){
        handleOverallChart();
        handleArPrQr();
        handleOeeShift();
    })
</script>
@endpush
@section('content')
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">Dashboard</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">PT Dharma Polimetal <br> <small>OEES || Overall Equipment Effectiveness System</small>
    </h1>
    <!-- END page-header -->
    <!-- BEGIN row -->
    <div class="row">
        <div class="col-12">
            <div class="panel">
                <div class="panel-body">
                    <div class="row">
                        <!-- KOLOM 1 -->
                        <div class="col-3">
                            <div class="panel panel-inverse">
                                <div class="panel-heading bg-blue-700 text-white">
                                    <h4 class="panel-title">Avaibility</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <span class="float-start">Planned Production Time</span><span class="float-end">455 min</span><br>
                                    <span class="float-start">Actual Runtime</span><span class="float-end">390 min</span><br>
                                    <span class="float-start">Unplanned Downtime</span><span class="float-end">65 min</span>
                                </div>
                            </div>
                            <div class="panel panel-inverse">
                                <div class="panel-heading bg-blue-700 text-white">
                                    <h4 class="panel-title">Performance</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <span class="float-start">Operating Time</span><span class="float-end">390 min</span><br>
                                    <span class="float-start">Actual CT</span><span class="float-end">380 min</span>
                                </div>
                            </div>
                            <div class="panel panel-inverse">
                                <div class="panel-heading bg-blue-700 text-white">
                                    <h4 class="panel-title">Quality</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <span class="float-start">Actual QTY</span><span class="float-end">200 pcs</span><br>
                                    <span class="float-start">Reject QTY</span><span class="float-end">10 pcs</span>
                                </div>
                            </div>
                            <div class="panel panel-inverse">
                                <div class="panel-heading bg-blue-700 text-white">
                                    <h4 class="panel-title">Utilization</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <span class="float-start">Planning Production</span><span class="float-end">190 pcs</span><br>
                                    <span class="float-start">Capacity Production</span><span class="float-end">200 pcs</span>
                                </div>
                            </div>
                        </div>
                        <!-- KOLOM 2 -->
                        <div class="col-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">OEE</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <div class="row">
                                        <div class="col-6">
                                            <canvas id="oee-chart" class="widget-chart-full-width"></canvas>
                                        </div>
                                        <div class="col-6">
                                            <canvas id="arprqr-chart" class="widget-chart-full-width"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">OEE by Shifts</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <canvas id="shifts-chart" class="widget-chart-full-width"></canvas>
                                </div>
                            </div>
                        </div>
                        <!-- KOLOM 3 -->
                        <div class="col-3">
                            <div class="panel">
                                <div class="panel-heading bg-orange-700 text-white">
                                    <h4 class="panel-title">Downtime Machine Stoppage</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <span class="float-start">Change Nozle</span><span class="float-end">20 min</span><br>
                                    <span class="float-start">Change Kaptip</span><span class="float-end">10 min</span><br>
                                    <span class="float-start">Change Wire</span><span class="float-end">10 min</span><br>
                                    <span class="float-start">Sensor Problem</span><span class="float-end">10 min</span><br>
                                    <span class="float-start">Jig Problem</span><span class="float-end">10 min</span><br>
                                    <span class="float-start">Others Stop</span><span class="float-end">5 min</span><br>
                                </div>
                            </div>
                            <div class="panel">
                                <div class="panel-heading bg-yellow-700 text-white">
                                    <h4 class="panel-title">Quality Reject</h4>
                                </div>
                                <div class="panel-body bg-default">
                                    <span class="float-start">Undercut</span><span class="float-end">3 pcs</span><br>
                                    <span class="float-start">Overlap</span><span class="float-end">5 pcs</span><br>
                                    <span class="float-start">Porosity</span><span class="float-end">1 pcs</span><br>
                                    <span class="float-start">Incomplete Penetration</span><span class="float-end">1 pcs</span><br>
                                    <span class="float-start">Others</span><span class="float-end">1 pcs</span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END row -->
    <!-- #modal-dialog -->
    <div class="modal fade" id="oeeModal" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-light">
                <h4 class="modal-title">Modal Dialog</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
            <form action="" method="post" data-parsley-validate="true">
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-white" data-bs-dismiss="modal">Close</a>
                <button type="submit" class="btn btn-success">Save</button>
            </div>
            </form>
        </div>
        </div>
    </div>
    <!-- End-Modal-Dialog -->
    @endsection
