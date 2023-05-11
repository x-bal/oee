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
        <div class="col-4">
            <form action="" method="GET">
                <div class="row">
                    <div class="col-4">
                        <select class="form-select" name="year" id="Year">
                            @foreach ($years as $item)
                                <option value="{{ $item->txtyear }}"
                                    {{ Request::input('year') == $item->txtyear ? 'selected' : '' }}>{{ $item->txtyear }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    {{-- <div class="col-4">
                        <select class="form-select" name="month" id="Month">
                            <option value="all">ALL</option>
                            @foreach (range(1, 12) as $i => $item)
                            <option value="{{ $i+1 }}">{{ date('F', strtotime(date('Y').'-'.($i+1).'-01')) }}</option>
                            @endforeach
                        </select>
                    </div> --}}
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
                <button href="{{ route('dashboard.index') }}" class="btn btn-sm btn-primary active">All</button>
                @foreach ($lines as $item)
                    <a href="{{ route('dashboard.line.view', $item->id) }}"
                        class="btn btn-sm btn-primary">{{ $item->txtlinename }}</a>
                @endforeach
            </div>
        </div>
    </div>
    <!-- END row -->
    <!-- BEGIN row -->
    @include('pages.layouts')
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
    <script src="{{ asset('assets/plugins/chart.js/dist/chartjs-plugin-datalabels.min.js') }}"></script>
    <script>
        const color = ['FF0000', 'FFFF00', '00CC00', 'FFFFFFF'];
        const MachineID = ['Spot1', 'Spot2', 'Spot3', 'Spot4', 'Spot5', 'Spot6',
            'Robot1', 'Robot2', 'Robot3', 'Robot4', 'Robot5',
            'Mainline', 'SubAssy', 'SpotAssy', 'Retapping',
            'D03SA1', 'D03SA2', 'D03GA1', 'D03GA11', 'D03GA2', 'D03GA3', 'D03GA4', 'D03GA5',
            'D74SA1', 'D74SA2', 'D74GA1', 'D74GA11', 'D74GA2', 'D74GA3', 'D74GA4', 'D74GA5'
        ];

        function changeColor() {
            let rand = Math.floor(Math.random(1, 2) * 4);
            console.log(rand);
            $.each(MachineID, function(i, val) {
                $('#' + MachineID[i]).css('fill', '#' + color[rand]);
            })
        }

        $(document).ready(function() {
            setInterval(changeColor, 1000);
        })
    </script>
@endpush
