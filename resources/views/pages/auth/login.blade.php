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
            <button type="button" class="btn btn-default" data-bs-toggle="modal" data-bs-target="#loginModal">Login <i class="fas fa-sign-in-alt"></i></button>
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
        @include('pages.layouts')
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
                        <button type="submit" class="btn-submit">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
@push('script')
    <script src="{{ asset('assets/plugins/chart.js/dist/chartjs-plugin-datalabels.min.js') }}"></script>
    <script>
        const color = ['FF0000', 'FFFF00', '00CC00', 'FFFFFFF'];
        const MachineID = ['Spot1', 'Spot2', 'Spot3', 'Spot4', 'Spot5', 'Spot6',
            'Robot1', 'Robot2', 'Robot3', 'Robot4', 'Robot5',
            'Mainline', 'SubAssy', 'SpotAssy', 'Retapping',
            'D03SA1', 'D03SA2', 'D03GA1', 'D03GA11', 'D03GA2', 'D03GA3', 'D03GA4', 'D03GA5',
            'D74SA1', 'D74SA2', 'D74GA1', 'D74GA11', 'D74GA2', 'D74GA3', 'D74GA4', 'D74GA5'];
        function changeColor(){
            let rand = Math.floor(Math.random(1, 2) * 4);
            console.log(rand);
            $.each(MachineID, function(i, val){
                $('#'+MachineID[i]).css('fill', '#'+color[rand]);
            })
        }
        $(document).ready(function() {
            setInterval(changeColor, 1000);
        })
    </script>
@endpush
