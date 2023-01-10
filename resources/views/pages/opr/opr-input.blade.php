@extends('layouts.default')

@section('title', 'Dashboard')

@push('css')
    <link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/jvectormap-next/jquery-jvectormap.css" rel="stylesheet" />
    <link href="/assets/plugins/simple-calendar/dist/simple-calendar.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/nvd3/build/nv.d3.css" rel="stylesheet" />
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
            <div class="panel panel-inverse">
                {{-- <div class="panel-heading">
                  <h4 class="panel-title">Panel Title</h4>
                  <div class="panel-heading-btn">
                    <a href="#" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand">
                      <i class="fa fa-expand"></i>
                    </a>
                  </div>
                </div> --}}
                <div class="panel-body">
                    <div class="row">
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Product Name</td>
                                        <td>:</td>
                                        <td><b>PRODUK</b></td>
                                    </tr>
                                    <tr>
                                        <td>Size</td>
                                        <td>:</td>
                                        <td><b>SIZE</b></td>
                                    </tr>
                                    <tr>
                                        <td>Line Process</td>
                                        <td>:</td>
                                        <td><b>PP MEMBER 72</b>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Batch Order</td>
                                        <td>:</td>
                                        <td><b>DUMMY DATA</b></td>
                                    </tr>
                                    <tr>
                                        <td>Production Code</td>
                                        <td>:</td>
                                        <td><b>DUMMY DATA</b></td>
                                    </tr>
                                    <tr>
                                        <td>Expire Date</td>
                                        <td>:</td>
                                        <td><b>DUMMY DATA</b></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Production Release</td>
                                        <td>:</td>
                                        <td><b>16/10/2022</b></td>
                                    </tr>
                                    <tr>
                                        <td>Operator</td>
                                        <td>:</td>
                                        <td><b>OPR</b></td>
                                    </tr>
                                    <tr>
                                        <td>Standar Speed</td>
                                        <td>:</td>
                                        <td><b>2 pcs/minutes</b></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="note note-success">
                                <div class="note-content text-light">
                                    <h5>Active</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-9">
                            <div class="panel border">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Input Downtime</h4>
                                </div>
                                <hr>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="table-responsive">
                                            <table id="daTable" class="table table-striped table-bordered align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>START</th>
                                                        <th>FINISH</th>
                                                        <th>DURATION</th>
                                                        <th>ACTIVITY</th>
                                                        <th>ACTION</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="row">
                                <div class="panel border">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">Production Rate</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="widget-chart-content">
                                            <canvas class="widget-chart-full-width" id="RateChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="panel border">
                                        <div class="panel-heading bg-success text-white">
                                            <h3>Good</h3>
                                        </div>
                                        <div class="panel-body text-success">
                                            <h2 class="text-center">0</h2>
                                            <h5 class="text-end">pcs</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="panel border">
                                        <div class="panel-heading bg-danger text-white">
                                            <h3>Reject</h3>
                                        </div>
                                        <div class="panel-body text-danger">
                                            <h2 class="text-center">0</h2>
                                            <h5 class="text-end">pcs</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END row -->

    @endsection
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
        <script>
            var daTable = $('#daTable').DataTable();
            var handleProgressChart = function() {
                var ctx3 = document.getElementById('progress-chart').getContext('2d');
                const labels = ['Progress'];
                const data = {
                    labels: labels,
                    datasets: [{
                            label: 'PR',
                            data: '20',
                            backgroundColor: 'green'
                        },
                        {
                            label: 'BR',
                            data: '50',
                            backgroundColor: 'red'
                        },
                    ]
                };
                const config = {
                    type: 'bar',
                    data: data,
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: "Progress",
                            }
                        },
                        indexAxis: 'y',
                        scales: {
                            x: {
                                stacked: true,
                            },
                            y: {
                                stacked: true
                            }
                        }
                    },
                };
                var barChart = new Chart(ctx3, config);
            }
            $(document).ready(function() {
                handleProgressChart();
            })
        </script>
    @endpush
