@extends('layouts.auth')
@section('title')
    OEE System Login
@endsection
@push('script')
    <script src="{{ asset('assets/plugins/chart.js/dist/chartjs-plugin-datalabels.min.js') }}"></script>
    <script src="{{ asset('assets/js/paho.mqtt.js') }}" type="text/javascript"></script>
    <script>
        function gritter(title, text, status) {
            $.gritter.add({
                title: title,
                text: '<p class="text-light">' + text + '</p>',
                class_name: status,
                time: 1000,
            });
        }
        //AVERAGE OVERALL OEE CHART
        let OeeChart = new Chart(document.getElementById('overall-chart').getContext('2d'), {
            type: 'doughnut',
            plugins: [ChartDataLabels],
            data: {
                labels: ['AR', 'PR', 'QR'],
                datasets: [{
                    data: [],
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

        //AVERAGE OVERALL BY SHIFTS
        var ctx3 = document.getElementById('shifts-chart').getContext('2d');
        var ctx3Bar = ctx3.createLinearGradient(0, 0, 200, 0);
            ctx3Bar.addColorStop(0, 'blue');
            ctx3Bar.addColorStop(1, '#00cc00');
        const ctx3data = {
            labels: [],
            datasets: [{
                label: 'OEE By Shifts',
                data: [],
                backgroundColor: ctx3Bar,
                order: 1
            }, ]
        };
        const ctx3config = {
            type: 'bar',
            data: ctx3data,
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
        let ChartOeeShift = new Chart(ctx3, ctx3config);

        //AVERAGE OVERAL BY MACHINE
        var ctx2 = document.getElementById('machine-chart').getContext('2d');
        var ctx2Bar = ctx2.createLinearGradient(0, 0, 0, 600);
            ctx2Bar.addColorStop(0, '#00cc00');
            ctx2Bar.addColorStop(1, 'blue');
        const ctx2Data = {
            labels: [],
            datasets: [{
                label: 'Output',
                data: [],
                backgroundColor: ctx2Bar,
                order: 1
            }, ]
        };
        const ctx2config = {
            type: 'doughnut',
            data: ctx2Data,
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
                        ticks: {
                            precision: 0
                        }
                    },
                },
                rotation: 270, // start angle in degrees
                circumference: 180,
            },
        };
        let ChartOutput = new Chart(ctx2, ctx2config);

        //AVERAGE OVERALL BY LINEGROUP
        var ctx4 = document.getElementById('linegroup-chart').getContext('2d');
        var ctx4bar = ctx4.createLinearGradient(0, 0, 200, 0);
            ctx4bar.addColorStop(0, 'blue');
            ctx4bar.addColorStop(1, '#00cc00');
        const data = {
            labels: [],
            datasets: [{
                label: 'OEE By Line Group',
                data: [],
                backgroundColor: ctx4bar,
                order: 1
            }, ]
        };
        const ctx4config = {
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
        var chartOeeLine = new Chart(ctx4, ctx4config);
        function refreshOeeChart(){
            $.get("{{ route('oee.data.line') }}", {
                'line_id': "{{ Request::segment(2) }}",
                'tanggal': $('input[name="filter-date"]').val()
            }, function(response) {
                let data = response.oee;
                let ar = (data != null?data.avaibility_rate:0);
                let pr = (data != null?data.performance_rate:0);
                let qr = (data != null?data.quality_rate:0);
                OeeChart.data.datasets[0].data = [parseFloat(ar).toFixed(2), parseFloat(pr).toFixed(2), parseFloat(qr).toFixed(2)];
                OeeChart.update();
            })
        }
        function refreshOeeShiftChart(){
            $.post("{{ route('chart.shift.oee') }}", {
                "_token": "{{ csrf_token() }}",
                'line_id': "{{ Request::segment(2) }}",
                'tanggal': $('input[name="filter-date"]').val()
            }, function(response) {
                let labels = [];
                let data = [];
                $.each(response.oee, function(key, val){
                    labels.push('SHIFT '+val.shift_id);
                    data.push(parseFloat(val.oee).toFixed(2));
                })
                ChartOeeShift.data.labels = labels;
                ChartOeeShift.data.datasets[0].data = data;
                ChartOeeShift.update();
            })
        }
        function refreshChartOutput(){
            $.post("{{ route('chart.line.output') }}", {
                "_token": "{{ csrf_token() }}",
                'line_id': "{{ Request::segment(2) }}",
                'tanggal': $('input[name="filter-date"]').val()
            }, function(response) {
                let labels = [];
                let data = [];
                $.each(response.output, function(key, val){
                    labels.push(val.part_number);
                    data.push(val.total_output);
                })
                ChartOutput.data.labels = labels;
                ChartOutput.data.datasets[0].data = data;
                ChartOutput.update();
            })
        }

        function refreshChartOeeLine(){
            $.post("{{ route('chart.line.oee') }}", {
                "_token": "{{ csrf_token() }}",
                'tanggal': $('input[name="filter-date"]').val()
            }, function(response) {
                let labels = [];
                let data = [];
                $.each(response.oee, function(key, val){
                    labels.push(val.txtlinename);
                    data.push(parseFloat(val.oee).toFixed(2));
                })
                chartOeeLine.data.labels = labels;
                chartOeeLine.data.datasets[0].data = data;
                chartOeeLine.update();
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
        let pahoConfig = {
            hostname: "{{ $broker->txthost }}", //The hostname is the url, under which your FROST-Server resides.
            port: "{{ $broker->intwsport }}", //The port number is the WebSocket-Port,
            clientId: "ClientId-"+(Math.random() + 1).toString(36).substring(16) //Should be unique for every of your client connections.
        }
        client = new Paho.MQTT.Client(pahoConfig.hostname, Number(pahoConfig.port), pahoConfig.clientId);
        client.onConnectionLost = onConnectionLost;
        client.onMessageArrived = onMessageArrived;
        // called when the client connects
        function onConnect() {
            // Once a connection has been made, make a subscription and send a message.
            // console.log("onConnect");
            let topics = @json($topics);
            $.each(topics, function(i, val){
                client.subscribe(topics[i].txttopic);
            })
            filterDate();
        }
        // called when the client loses its connection
        function onConnectionLost(responseObject) {
            if (responseObject.errorCode !== 0) {
                console.log("onConnectionLost:" + responseObject.errorMessage);
            }
        }

        // called when a message arrives
        function onMessageArrived(message) {
            console.log("Pesan dari MQTT: " + message.payloadString);
            filterDate();
        }
        function filterDate(){
            refreshOeeChart();
            refreshOeeShiftChart();
            refreshChartOutput();
            refreshChartOeeLine();
        }
        $(document).ready(function() {
            client.connect({
                onSuccess: onConnect
            });
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
@section('content')
    <!-- BEGIN #header -->
    <div id="header" class="app-header">
        <!-- BEGIN navbar-header -->
        <div class="navbar-header">
            <a href="/" class="navbar-brand">
                <img src="{{ asset('k_logo.jpeg') }}" width="30" height="30"
                    class="d-inline-block align-top" alt="">
                <span class="navbar-logo"></span> <strong>Kelola </strong> <span
                    style="color: #39e600;margin-left:5px;">Biz</span></a>
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
        <h1 class="page-header">Kelola Biz <br> <small>OEES || Overall Equipment Effectiveness
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
        <div class="row mb-3">
            <div class="col-md-6">
                <input type="date" class="form-control" name="filter-date" onchange="filterDate()">
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
                            <button type="submit" class="btn-submit">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    @endsection
