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
                <img src="{{ asset('assets/img/logo/kalbe.png') }}" width="30" height="30"
                    class="d-inline-block align-top" alt="">
                <span class="navbar-logo"></span> <strong>Kalbe </strong> <span
                    style="color: #39e600;margin-left:5px;">Nutritionals</span></a>
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
        <h1 class="page-header">PT Kalbe Morinaga Indonesia <br> <small>OEES || Overall Equipment Effectiveness
                System</small>
        </h1>
        <!-- END page-header -->
        <!-- BEGIN row -->
        <div class="row mb-3">
            <div class="col-md-12">
                <div class="btn-group btn-group-sm">
                    <a href="{{ route('auth.login') }}" class="btn btn-sm btn-primary">All</a>
                    @foreach ($lines as $item)
                        <a href="{{ route('auth.line.view', $item->id) }}"
                            class="btn btn-sm btn-primary {{ Request::segment(2) == $item->id ? 'active' : '' }}">{{ $item->txtlinename }}</a>
                    @endforeach
                </div>
            </div>
        </div>
        <!-- END row -->
        <!-- BEGIN row -->
        @include('pages.charts')
        <!-- END row -->
        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content clearfix">
                    <div class="modal-body">
                        <form action="" method="post" id="loginForm">
                            @csrf
                            <h4 class="title">
                                {{-- <strong>KALBE</strong><span style="color: #84c425;"> Nutritionals</span> --}}
                                <img src="{{ asset('assets/img/logo/dharma.png') }}" alt="login-kalbe-logo"
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
    <script src="{{ asset('assets/plugins/chart.js/dist/chartjs-plugin-datalabels.min.js') }}"></script>
        <script>
            let year = "{{ empty(Request::input('year')) ? date('Y') : Request::input('year') }}";
            let month = "{{ empty(Request::input('month')) ? '' : Request::input('month') }}";
            let oee = @json($actual_oee);
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
            //AVERAGE OVERALL OEE CHART
            var handleOverallChart = function() {
                var ctx = document.getElementById('overall-chart').getContext('2d');
                new Chart(ctx, {
                    type: 'doughnut',
                    plugins: [ChartDataLabels],
                    data: {
                        labels: ['AR', 'PR', 'QR'],
                        datasets: [{
<<<<<<< HEAD
                            data: [97, 95, 99],
=======
                            data: oee?[oee.ar, oee.pr, oee.qr]:[90,85,92],
>>>>>>> 445a60842b123ce4beff7a07246b38f6e7768584
                            backgroundColor: ['#388E3C', '#3D5AFE', '#C70039'],
                            borderWidth: 2,
                            label: 'OEE'
                        }]
                    },
                    options: {
                        responsive: true,
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
            var handleOeeShift = function() {
                var ctx3 = document.getElementById('shifts-chart').getContext('2d');
                var urBar = ctx3.createLinearGradient(0, 0, 200, 0);
                urBar.addColorStop(0, 'blue');
                urBar.addColorStop(1, '#00cc00');
                var prodByop = ctx3.createLinearGradient(0, 0, 200, 0);
                prodByop.addColorStop(0, '#2596be');
                prodByop.addColorStop(1, '#85eabd');
                const labels = ['SHIFT 3', 'SHIFT 2', 'SHIFT 1'];
<<<<<<< HEAD
                const ur = [80, 80, 96];
=======
                const ur = oee?[0, 0, (((oee.ar/100)*(oee.pr/100)*(oee.qr/100)*(oee.utilization/100))*100).toFixed(2)]:[0,0,0];
>>>>>>> 445a60842b123ce4beff7a07246b38f6e7768584
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

            //AVERAGE OVERAL BY MACHINE
            var handleOeeMachine = function(line, poe) {
                var ctx2 = document.getElementById('machine-chart').getContext('2d');
                var barGradient = ctx2.createLinearGradient(0, 0, 0, 600);
                barGradient.addColorStop(0, '#00cc00');
                barGradient.addColorStop(1, 'blue');
                const labels = ['5120-BZ001', '53208-BZ340', '53840-BZ160', '53840-BZ150', '53840-BZD60'];
                const actual = [55, 49, 44, 24, 15];
                const data = {
                    labels: labels,
                    datasets: [{
                        label: 'Actual',
                        data: actual,
                        backgroundColor: barGradient,
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

            //AVERAGE OVERALL BY LINEGROUP
            var handleOeeLine = function() {
                var ctx3 = document.getElementById('linegroup-chart').getContext('2d');
                var urBar = ctx3.createLinearGradient(0, 0, 200, 0);
                urBar.addColorStop(0, 'blue');
                urBar.addColorStop(1, '#00cc00');
                var prodByop = ctx3.createLinearGradient(0, 0, 200, 0);
                prodByop.addColorStop(0, '#2596be');
                prodByop.addColorStop(1, '#85eabd');
                const labels = ['STAMPING', 'PP MEMBER 74', 'GPARTS D03', 'PP MEMBER D03', 'SPOT', 'SUSPENSION'];
                const ur = [69.6, 71, 74.7, 78.8, 76.8, 76.8];
                const data = {
                    labels: labels,
                    datasets: [{
                        label: 'OEE By Line Group',
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
                            title: {
                                display: true,
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
            function gritter(title, text, status) {
                $.gritter.add({
                    title: title,
                    text: '<p class="text-light">' + text + '</p>',
                    class_name: status,
                    time: 1000,
                });
            }
            $(document).ready(function() {
                handleOverallChart();
                handleOeeShift();
                handleOeeMachine();
                handleOeeLine();
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
