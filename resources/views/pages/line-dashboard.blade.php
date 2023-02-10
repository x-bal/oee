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
    @include('pages.charts')
@endsection
@push('scripts')
    <script src="/assets/plugins/d3/d3.min.js"></script>
    <script src="/assets/plugins/nvd3/build/nv.d3.js"></script>
    <script src="/assets/plugins/jvectormap-next/jquery-jvectormap.min.js"></script>
    <script src="/assets/plugins/jvectormap-next/jquery-jvectormap-world-mill.js"></script>
    <script src="/assets/plugins/simple-calendar/dist/jquery.simple-calendar.min.js"></script>
    <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
    <script src="/assets/plugins/chart.js/dist/chart.min.js"></script>
    <script src="{{ asset('assets/plugins/chart.js/dist/chartjs-plugin-datalabels.min.js') }}"></script>
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
        //AVERAGE OVERALL OEE CHART
        var handleOverallChart = function() {
            var ctx = document.getElementById('overall-chart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                plugins: [ChartDataLabels],
                data: {
                    labels: ['AR', 'PR', 'QR'],
                    datasets: [{
                        data: [30, 30, 40],
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
            const ur = [94, 90, 91];
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
        })
    </script>
@endpush
