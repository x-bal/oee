@extends('layouts.auth')
@section('title')
    OEE System Login
@endsection
@section('content')
    <!-- BEGIN #header -->
    <div id="header" class="app-header">
        <!-- BEGIN navbar-header -->
        <div class="navbar-header">
            <a href="/" class="navbar-brand">
                <img src="{{ asset('assets/img/logo/dharma.png') }}" width="30" height="30"
                    class="d-inline-block align-top" alt="">
                <span class="navbar-logo"></span> <strong>Dharma </strong> <span
                    style="color: #39e600;margin-left:5px;">Polimetal</span></a>
        </div>
        <!-- END navbar-header -->
        <!-- BEGIN header-nav -->
        <div class="navbar-nav">
            <button type="button" class="btn btn-default" data-bs-toggle="modal" data-bs-target="#loginModal">Login
                <i class="fas fa-sign-in-alt"></i></button>
        </div>
        <!-- END header-nav -->
    </div>
    <!-- END #header -->

    <!-- BEGIN #sidebar -->
    <div id="sidebar" class="app-sidebar">
        <!-- BEGIN scrollbar -->
        <div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
            <!-- BEGIN menu -->
            <div class="menu">
                <div class="menu-header">Navigation</div>
                <div class="menu-item has-sub active">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="ion-ios-pulse"></i>
                        </div>
                        <div class="menu-text">Dashboard</div>
                    </a>
                </div>

                <!-- BEGIN minify-button -->
                <div class="menu-item d-flex">
                    <a href="javascript:;" class="app-sidebar-minify-btn ms-auto" data-toggle="app-sidebar-minify"><i
                            class="ion-ios-arrow-back"></i>
                        <div class="menu-text">Collapse</div>
                    </a>
                </div>
                <!-- END minify-button -->
            </div>
            <!-- END menu -->
        </div>
        <!-- END scrollbar -->
    </div>
    <div class="app-sidebar-bg"></div>
    <div class="app-sidebar-mobile-backdrop"><a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a>
    </div>
    <!-- END #sidebar -->

    <!-- BEGIN #content -->
    <div id="content" class="app-content">
        <!-- BEGIN breadcrumb -->
        <ol class="breadcrumb float-xl-end">
            <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
            <li class="breadcrumb-item active">Dashboard</li>
        </ol>
        <!-- END breadcrumb -->
        <!-- BEGIN page-header -->
        <h1 class="page-header">PT Dharma Polimetal <br> <small>OEES || Overall Equipment Effectiveness
                System</small></h1>
        <!-- END page-header -->
        <!-- BEGIN row -->
        <div class="row mb-3">
            <div class="col-4">
                <form action="" method="GET">
                    <div class="row">
                        <div class="col-4">
                            <select class="form-select" name="year" id="Year">
                                @foreach ($years as $item)
                                    <option value="{{ $item->txtyear }}"
                                        {{ Request::input('year') == $item->txtyear ? 'selected' : '' }}>
                                        {{ $item->txtyear }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-4">
                            <button class="btn btn-sm btn-success" type="submit">Filter</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- END row -->
        <!-- BEGIN row -->
        <div class="row mb-3">
            <div class="col-12">
                <div class="btn-group">
                    <button type="button" class="btn btn-sm btn-primary active">All</button>
                    @foreach ($lines as $item)
                        <a href="{{ route('auth.line.view', $item->id) }}"
                            class="btn btn-sm btn-primary">{{ $item->txtlinename }}</a>
                    @endforeach
                </div>
            </div>
        </div>
        <!-- END row -->
        <!-- BEGIN row -->
        <div class="row">
            <!-- BEGIN col-3 -->
            <div class="col-xl-3 col-md-6">
                <div class="widget widget-stats bg-white text-dark">
                    <div class="stats-icon stats-icon-square bg-gradient-cyan-blue text-white"><i
                            class="ion-ios-analytics"></i></div>
                    <div class="stats-content poe">
                        <div class="stats-title text-dark text-opacity-75">POE Actual</div>
                        <div class="stats-number">0%</div>
                        <div class="stats-progress progress">
                            <div class="progress-bar"></div>
                        </div>
                        <div class="stats-desc text-dark text-opacity-75">Target: {{ $target_poe }}%</div>
                    </div>
                </div>
            </div>
            <!-- END col-3 -->
            <!-- BEGIN col-3 -->
            <div class="col-xl-3 col-md-6">
                <div class="widget widget-stats bg-white text-dark">
                    <div class="stats-icon stats-icon-square bg-gradient-cyan-blue text-white"><i
                            class="ion-md-analytics"></i></div>
                    <div class="stats-content">
                        <div class="stats-title text-dark text-opacity-75">Actual Avaibility Rate</div>
                        <div class="stats-number">{{ $actual_oee ? $actual_oee->ar : 0 }}%</div>
                        <div class="stats-progress progress">
                            <div class="progress-bar" style="width: {{ $actual_oee ? $actual_oee->ar : 0 }}%;">
                            </div>
                        </div>
                        <div class="stats-desc text-dark text-opacity-75">Target: {{ $target_oee->ar }}%</div>
                    </div>
                </div>
            </div>
            <!-- END col-3 -->
            <!-- BEGIN col-3 -->
            <div class="col-xl-3 col-md-6">
                <div class="widget widget-stats bg-white text-dark">
                    <div class="stats-icon stats-icon-square bg-gradient-cyan-blue text-white"><i class="ion-md-podium"></i>
                    </div>
                    <div class="stats-content">
                        <div class="stats-title text-dark text-opacity-75">Actual Performance Rate</div>
                        <div class="stats-number">{{ $actual_oee ? $actual_oee->pr : 0 }}%</div>
                        <div class="stats-progress progress">
                            <div class="progress-bar" style="width: {{ $actual_oee ? $actual_oee->pr : 0 }}%;">
                            </div>
                        </div>
                        <div class="stats-desc text-dark text-opacity-75">Target: {{ $target_oee->pr }}%</div>
                    </div>
                </div>
            </div>
            <!-- END col-3 -->
            <!-- BEGIN col-3 -->
            <div class="col-xl-3 col-md-6">
                <div class="widget widget-stats bg-white text-dark">
                    <div class="stats-icon stats-icon-square bg-gradient-cyan-blue text-white"><i
                            class="ion-md-ribbon"></i></div>
                    <div class="stats-content">
                        <div class="stats-title text-dark text-opacity-75">Actual Quality Rate</div>
                        <div class="stats-number">{{ $actual_oee ? $actual_oee->qr : 0 }}%</div>
                        <div class="stats-progress progress">
                            <div class="progress-bar" style="width: {{ $actual_oee ? $actual_oee->qr : 0 }}%;">
                            </div>
                        </div>
                        <div class="stats-desc text-dark text-opacity-75">Target: {{ $target_oee->qr }}%</div>
                    </div>
                </div>
            </div>
            <!-- END col-3 -->
        </div>
        <!-- END row -->
        <!-- BEGIN row -->
        <div class="row">
            <!-- BEGIN col-8 -->
            <div class="col-xl-8">
                <div class="widget-chart with-sidebar">
                    <div class="widget-chart-content">
                        <h4 class="chart-title text-dark">
                            POE Analytics
                            <small>PT Dharma Polimetal</small>
                        </h4>
                        <canvas id="poe-chart" class="widget-chart-full-width" style="height: 260px;"></canvas>
                    </div>
                    <div class="widget-chart-sidebar bg-light doughnut-poe">
                        <div class="chart-number text-dark">
                        </div>
                        <div class="flex-grow-1 d-flex align-items-center">
                            <div id="visitors-donut-chart" style="height: 180px"></div>
                        </div>
                        <ul class="chart-legend fs-11px">
                            <li class="text-dark"><i class="fa fa-circle fa-fw text-blue fs-9px me-5px t-minus-1"></i>
                                {{ $target_poe }}%
                                <span>Target</span>
                            </li>
                            <li class="text-dark actual"><i class="fa fa-circle fa-fw text-teal fs-9px me-5px t-minus-1"></i>
                                <span>Actual</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- END col-8 -->
            <!-- BEGIN col-4 -->
            <div class="col-xl-4">
                <div class="panel bg-light-200" data-sortable-id="index-1">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            Utilization Rate vs Productivity
                        </h4>
                    </div>
                    <canvas id="utilization-chart" class="widget-chart-full-width" style="height:380px"></canvas>
                </div>
            </div>
            <!-- END col-4 -->
        </div>
        <!-- END row -->
    </div>
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content clearfix">
                <div class="modal-body">
                    <form action="" method="post" id="loginForm">
                        @csrf
                        <h4 class="title">
                            {{-- <strong>KALBE</strong><span style="color: #84c425;"> Nutritionals</span> --}}
                            <img src="{{ asset('assets/img/logo/dharma.png') }}" alt="login-Dharma-logo"
                                width="256">
                        </h4>
                        <p class="description">Login here Using Username & Password</p>
                        <div class="form-group">
                            <span class="input-icon"><i class="fa fa-user"></i></span>
                            <input type="text" name="email" class="form-control" placeholder="Enter Username">
                        </div>
                        <div class="form-group">
                            <span class="input-icon"><i class="fas fa-key"></i></span>
                            <input type="password" name="password" class="form-control" placeholder="Password">
                        </div>
                        {{-- <div class="form-group checkbox">
                    <input type="checkbox">
                    <label>Remember me</label>
                </div> --}}
                        {{-- <a href="" class="forgot-pass">Forgot Password?</a> --}}
                        <button type="submit" class="btn">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
@push('script')
    <script>
        let year = "{{ empty(Request::input('year')) ? date('Y') : Request::input('year') }}";
        let month = "{{ empty(Request::input('month')) ? '' : Request::input('month') }}";

        function ajaxLink(link) {
            let ajaxLink = link.replace(':year', year);
            return ajaxLink;
        }

        function gritter(title, text, status) {
            $.gritter.add({
                title: title,
                text: '<p class="text-light">' + text + '</p>',
                class_name: status,
                time: 1000,
            });
        }
        var handleVisitorsDonutChart = function(actual) {
            var color1 = ($('#visitors-donut-chart').attr('data-color') == 'black') ? app.color.black : app.color.blue;
            var color2 = ($('#visitors-donut-chart').attr('data-color') == 'black') ? 'rgba(' + app.color.blackRgb +
                ', .5)' : app.color.teal;

            var visitorDonutChartData = [{
                    'label': 'Target',
                    'value': {{ $target_poe }},
                    'color': color1
                },
                {
                    'label': 'Actual',
                    'value': actual,
                    'color': color2
                }
            ];
            var arcRadius = [{
                    inner: 0.65,
                    outer: 0.93
                },
                {
                    inner: 0.6,
                    outer: 1
                }
            ];

            nv.addGraph(function() {
                var donutChart = nv.models.pieChart()
                    .x(function(d) {
                        return d.label
                    })
                    .y(function(d) {
                        return d.value
                    })
                    .margin({
                        'left': 10,
                        'right': 10,
                        'top': 10,
                        'bottom': 10
                    })
                    .showLegend(false)
                    .donut(true)
                    .growOnHover(false)
                    .arcsRadius(arcRadius)
                    .donutRatio(0.5);

                donutChart.labelFormat(d3.format(',.0f'));

                d3.select('#visitors-donut-chart').append('svg')
                    .datum(visitorDonutChartData)
                    .transition().duration(3000)
                    .call(donutChart);

                return donutChart;
            });
        };
        var handlePoeChart = function(line) {
            var ctx2 = document.getElementById('poe-chart').getContext('2d');
            var barGradient = ctx2.createLinearGradient(0, 0, 0, 600);
            barGradient.addColorStop(0, '#00cc00');
            barGradient.addColorStop(1, 'blue');
            const labels = [];
            const actual = [];
            const target = [];
            $.each(line, function(i, val) {
                labels.push(line[i].line);
                actual.push(line[i].oee);
                target.push(line[i].target_oee);
            })
            const data = {
                labels: labels,
                datasets: [{
                        label: 'Actual',
                        data: actual,
                        backgroundColor: barGradient,
                        order: 1
                    },
                    {
                        label: 'Target',
                        data: target,
                        borderColor: '#3385ff',
                        backgroundColor: '#3385ff',
                        type: 'line',
                        order: 0
                    }
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
                            text: "Achievement YTD {{ date('Y') }}",
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                drawBorder: true,
                            },
                        },
                        y: {
                            grid: {
                                drawBorder: true,
                            },
                        },
                    }
                },
            };
            var barChart = new Chart(ctx2, config);
        }
        var handleUtilizationChart = function(collection) {
            var ctx3 = document.getElementById('utilization-chart').getContext('2d');
            var urBar = ctx3.createLinearGradient(0, 0, 200, 0);
            urBar.addColorStop(0, 'blue');
            urBar.addColorStop(1, '#00cc00');
            var prodByop = ctx3.createLinearGradient(0, 0, 200, 0);
            prodByop.addColorStop(0, '#2596be');
            prodByop.addColorStop(1, '#85eabd');
            const labels = [];
            const ur = [];
            $.each(collection, function(i, val) {
                labels.push(collection[i].txtlinename);
                ur.push(collection[i].utilization_rate);
            })
            const data = {
                labels: labels,
                datasets: [{
                    label: 'Utilization Rate',
                    data: ur,
                    backgroundColor: urBar,
                    order: 1
                }, ]
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
                            text: "Achievement YTD {{ date('Y') }}",
                        }
                    },
                    indexAxis: 'y'
                },
            };
            var barChart = new Chart(ctx3, config);
        }
        $(document).ready(function() {
            $.ajax({
                url: "{{ route('chart.poe') }}",
                data: {
                    "_token": "{{ csrf_token() }}",
                    year: year,
                    month: month,
                },
                type: "POST",
                dataType: "JSON",
                success: function(response) {
                    $('.poe').find('.stats-number').text(response.poe.poe + "%");
                    $('.doughnut-poe').find('.chart-number').html(response.poe.poe + "% <small>Actual</small>");
                    $('.doughnut-poe').find('li.actual span').before(response.poe.poe+"%");
                    $('.poe').find('.progress-bar').attr("style", "width:" + response.poe.poe + "%");
                    handlePoeChart(JSON.parse(response.poe.line));
                    handleVisitorsDonutChart(response.poe.poe);
                }
            })
            $.ajax({
                url: "{{ route('chart.urate') }}",
                data: {
                    "_token": "{{ csrf_token() }}",
                    year: year,
                    month: month
                },
                type: "POST",
                dataType: "JSON",
                success: function(response) {
                    let collection = response.urate;
                    handleUtilizationChart(collection);
                }
            })
            $('.modal-body form').on('submit', function(e) {
                e.preventDefault();
                $.ajax({
                    url: "{{ route('auth.post.login') }}",
                    type: "POST",
                    data: $(this).serialize(),
                    dataType: "JSON",
                    success: function(response) {
                        $('#loginModal').modal('hide');
                        gritter(response.status, response.message, 'bg-success');
                        window.location.href = "{{ route('dashboard.index') }}";
                    },
                    error: function(response) {
                        $('input[name="password"]').val('');
                        $('#loginModal').modal('hide');
                        gritter(response.responseJSON.status, response.responseJSON.message,
                            'bg-danger');
                    }
                })
            })
        })
    </script>
@endpush
