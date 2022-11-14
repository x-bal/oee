@extends('layouts.default')

@section('title', 'Dashboard')

@push('css')
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
    <div class="row mb-3">
        <div class="col-12">
            <div class="btn-group">
                <a href="{{ route('dashboard.index') }}" class="btn btn-sm btn-primary">All</a>
                @foreach ($lines as $item)
                    <a href="{{ route('dashboard.line.view', $item->id) }}"
                        class="btn btn-sm btn-primary {{ Request::segment(3) == $item->id ? 'active' : '' }}">{{ $item->txtlinename }}</a>
                @endforeach
            </div>
        </div>
    </div>
    <!-- END row -->
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
                    <div class="row mb-3">
                        <form class="row row-cols-lg-auto align-items-center">
                            <div class="col-6">
                                <input type="date" name="tanggal" id="Tanggal" class="form-control">
                            </div>
                            <div class="col-2">
                                <button class="btn btn-sm btn-primary">Filter</button>
                            </div>
                        </form>
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Product Name</td>
                                        <td>:</td>
                                        <td><b>{{ $detail_oee->produk }}</b></td>
                                    </tr>
                                    <tr>
                                        <td>Size</td>
                                        <td>:</td>
                                        <td><b>{{ $detail_oee->floatbatchsize }} gr</b></td>
                                    </tr>
                                    <tr>
                                        <td>Line Process</td>
                                        <td>:</td>
                                        <td><b>{{ App\Models\LineProcess::findOrfail(Request::segment(3))->txtlinename }}</b>
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
                                        <td><b>{{ $detail_oee->okp_packing }}</b></td>
                                    </tr>
                                    <tr>
                                        <td>Production Code</td>
                                        <td>:</td>
                                        <td><b>{{ $detail_oee->production_code }}</b></td>
                                    </tr>
                                    <tr>
                                        <td>Expire Date</td>
                                        <td>:</td>
                                        <td><b>{{ $detail_oee->expired_date }}</b></td>
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
                                        <td><b>{{ $detail_oee->operator }}</b></td>
                                    </tr>
                                    <tr>
                                        <td>Standar Speed</td>
                                        <td>:</td>
                                        <td><b>{{ $detail_oee->floatstdspeed }} kg/Minutes</b></td>
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
                                    <h4 class="panel-title">Key Performance Indicators</h4>
                                </div>
                                <hr>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-4">
                                            <div class="widget-chart-content">
                                                <canvas class="widget-chart-full-width" id="OeeChart"></canvas>
                                            </div>
                                        </div>
                                        <div class="col-8">
                                            <div class="row mb-3">
                                                <div class="col-4">
                                                    <div class="widget-chart-content">
                                                        <canvas class="widget-chart-full-width" id="AvaChart"></canvas>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="widget-chart-content">
                                                        <canvas class="widget-chart-full-width" id="PerChart"></canvas>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="widget-chart-content">
                                                        <canvas class="widget-chart-full-width" id="QuaChart"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-12">
                                                    <div class="table-responsive">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th>SHIFT 1</th>
                                                                    <th>SHIFT 2</th>
                                                                    <th>SHIFT 3</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    @foreach ($oee_shift as $item)
                                                                        <td>
                                                                            <div class="progress" style="height:30px">
                                                                                <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary fw-bold"
                                                                                    style="width: <?= number_format(($item->ar / 100) * ($item->pr / 100) * ($item->qr / 100) * 100, 2) ?>%">
                                                                                    {{ number_format(($item->ar / 100) * ($item->pr / 100) * ($item->qr / 100) * 100, 2) }}%
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    @endforeach
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
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
                                <div class="col-4">
                                    <div class="panel border">
                                        <div class="panel-heading bg-success text-white">
                                            <h3>Good</h3>
                                        </div>
                                        <div class="panel-body text-success">
                                            <h2 class="text-center">{{ $detail_oee->finish_good }}</h2>
                                            <h5 class="text-end">pcs</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="panel border">
                                        <div class="panel-heading bg-primary text-white">
                                            <h3>Rework</h3>
                                        </div>
                                        <div class="panel-body text-primary">
                                            <h2 class="text-center">{{ $detail_oee->rework }}</h2>
                                            <h5 class="text-end">pcs</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="panel border">
                                        <div class="panel-heading bg-danger text-white">
                                            <h3>Reject</h3>
                                        </div>
                                        <div class="panel-body text-danger">
                                            <h2 class="text-center">{{ $detail_oee->reject }}</h2>
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
    <div class="row">
        <div class="col-9">
            <div class="panel bg-light-200" data-sortable-id="index-1">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        Progress
                    </h4>
                </div>
                <canvas id="progress-chart" class="widget-chart-full-width" style="height:330px"></canvas>
            </div>
        </div>
        <div class="col-3">
            <div class="panel bg-light-200" data-sortable-id="index-5">
                <div class="panel-heading ui-sortable-handle">
                    <h4 class="panel-title">List Downtime</h4>
                </div>
                <div class="panel-body p-0">
                    <div class="h-300px p-3 ps ps--active-y" data-scrollbar="true" data-init="true"
                        style="height: 290px;">
                        @if (!empty($detail_oee->listbr))
                            @foreach (json_decode($detail_oee->listbr, true) as $item)
                                <div class="d-flex">
                                    <a href="javascript:;" class="w-60px">
                                        <h4>{{ $item['category'] }}</h4>
                                    </a>
                                    <div class="flex-1 ps-3">
                                        <h5>{{ $item['activitycode'] }}</h5>
                                        <p>{{ $item['remark'] }}</p>
                                    </div>
                                </div>
                                <hr class="bg-gray-500">
                            @endforeach
                        @endif
                        <div class="ps__rail-x" style="left: 0px; bottom: -128px;">
                            <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                        </div>
                        <div class="ps__rail-y" style="top: 128px; height: 300px; right: 0px;">
                            <div class="ps__thumb-y" tabindex="0" style="top: 90px; height: 209px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    @endsection
    @push('scripts')
        <script src="/assets/plugins/d3/d3.min.js"></script>
        <script src="/assets/plugins/nvd3/build/nv.d3.js"></script>
        <script src="/assets/plugins/jvectormap-next/jquery-jvectormap.min.js"></script>
        <script src="/assets/plugins/jvectormap-next/jquery-jvectormap-world-mill.js"></script>
        <script src="/assets/plugins/simple-calendar/dist/jquery.simple-calendar.min.js"></script>
        <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
        <script src="/assets/plugins/chart.js/dist/chart.min.js"></script>
        <script>
            var handleOeeChart = function() {
                // get the canvas element and its context
                var canvas = document.getElementById("OeeChart");
                var ctx = canvas.getContext("2d");
                const data = {
                    labels: ['OEE'],
                    datasets: [{
                        label: 'OEE',
                        data: ["{{ ($oee->ar / 100) * ($oee->pr / 100) * ($oee->qr / 100) * 100 }}",
                            "{{ 100 - ($oee->ar / 100) * ($oee->pr / 100) * ($oee->qr / 100) * 100 }}"
                        ],
                        backgroundColor: ["#00b33c", "#d1e0e0"],
                    }]
                }
                const config = {
                    type: 'doughnut',
                    data: data,
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        cutout: 70,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'OEE Chart'
                            }
                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true,
                            onComplete: function() {
                                const cv = canvas.getBoundingClientRect();
                                var cx = cv.width / 2;
                                var cy = cv.height / 2 + 30;
                                ctx.textAlign = 'center';
                                ctx.textBaseline = 'middle';
                                ctx.font = '32px segoe-ui';
                                ctx.weight = '900'
                                ctx.fillStyle = '#00b33c';
                                ctx.fillText(
                                    "{{ number_format(($oee->ar / 100) * ($oee->pr / 100) * ($oee->qr / 100) * 100, 1) }}" +
                                    "%", cx, cy);
                            }
                        },
                    },
                };

                // calculate the center of the canvas (cx,cy)
                // var cx = canvas.width/2;
                // var cy = canvas.height/2;
                new Chart(ctx, config);
            }
            var handleAvaChart = function() {
                // get the canvas element and its context
                var canvas = document.getElementById("AvaChart");
                var ctx = canvas.getContext("2d");
                const data = {
                    labels: ['AR'],
                    datasets: [{
                        label: 'AR',
                        data: ["{{ $oee->ar }}", "{{ 100 - $oee->ar }}"],
                        backgroundColor: ["#00b33c", "#d1e0e0"],
                    }]
                }
                const config = {
                    type: 'doughnut',
                    data: data,
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        cutout: 30,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'AR Chart'
                            }
                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true,
                            onComplete: function() {
                                const cv = canvas.getBoundingClientRect();
                                var cx = cv.width / 2;
                                var cy = cv.height / 2 + 30;
                                ctx.textAlign = 'center';
                                ctx.textBaseline = 'middle';
                                ctx.font = '14px segoe-ui';
                                ctx.weight = '900'
                                ctx.fillStyle = '#00b33c';
                                ctx.fillText("{{ $oee->ar }}" + "%", cx, cy);
                            }
                        },
                    },
                };
                new Chart(ctx, config);
            }
            var handlePerChart = function() {
                // get the canvas element and its context
                var canvas = document.getElementById("PerChart");
                var ctx = canvas.getContext("2d");
                const data = {
                    labels: ['PR'],
                    datasets: [{
                        label: 'PR',
                        data: ["{{ $oee->pr }}", "{{ 100 - $oee->pr }}"],
                        backgroundColor: ["#ffcc00", "#d1e0e0"],
                    }]
                }
                const config = {
                    type: 'doughnut',
                    data: data,
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        cutout: 30,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'PR Chart'
                            }
                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true,
                            onComplete: function() {
                                const cv = canvas.getBoundingClientRect();
                                var cx = cv.width / 2;
                                var cy = cv.height / 2 + 30;
                                ctx.textAlign = 'center';
                                ctx.textBaseline = 'middle';
                                ctx.font = '14px segoe-ui';
                                ctx.weight = '900'
                                ctx.fillStyle = '#ffcc00';
                                ctx.fillText("{{ $oee->pr }}" + "%", cx, cy);
                            }
                        },
                    },
                };
                new Chart(ctx, config);
            }
            var handleQuaChart = function() {
                // get the canvas element and its context
                var canvas = document.getElementById("QuaChart");
                var ctx = canvas.getContext("2d");
                const data = {
                    labels: ['QR'],
                    datasets: [{
                        label: 'QR',
                        data: ["{{ $oee->qr }}", "{{ 100 - $oee->qr }}"],
                        backgroundColor: ["#00b33c", "#d1e0e0"],
                    }]
                }
                const config = {
                    type: 'doughnut',
                    data: data,
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        cutout: 30,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'QR Chart'
                            }
                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true,
                            onComplete: function() {
                                const cv = canvas.getBoundingClientRect();
                                var cx = cv.width / 2;
                                var cy = cv.height / 2 + 30;
                                ctx.textAlign = 'center';
                                ctx.textBaseline = 'middle';
                                ctx.font = '14px segoe-ui';
                                ctx.weight = '900'
                                ctx.fillStyle = '#00b33c';
                                ctx.fillText("{{ $oee->qr }}" + "%", cx, cy);
                            }
                        },
                    },
                };
                new Chart(ctx, config);
            }
            var handleRateChart = function() {
                // get the canvas element and its context
                var canvas = document.getElementById("RateChart");
                var ctx = canvas.getContext("2d");
                const data = {
                    labels: ['Production Rate'],
                    datasets: [{
                        label: 'Production Rate',
                        data: [203, 400 - 203],
                        backgroundColor: ["#00b33c", "#d1e0e0"],
                    }]
                }
                const config = {
                    type: 'doughnut',
                    data: data,
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        circumference: 180,
                        rotation: -90,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'Production Rate Chart'
                            }
                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true,
                        },
                    },
                };
                new Chart(ctx, config);
            }
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
                handleOeeChart();
                handleAvaChart();
                handlePerChart();
                handleQuaChart();
                handleRateChart();
                handleProgressChart();
            })
        </script>
    @endpush