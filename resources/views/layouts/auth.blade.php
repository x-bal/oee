<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>@yield('title')</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <link rel="icon" type="image/x-icon" href="{{ asset('k_logo.ico') }}">

    <!-- ================== BEGIN core-css ================== -->
    <link href="{{ asset('assets/css/vendor.min.css') }}" rel="stylesheet" />
    <link href="{{ asset('assets/css/app.min.css') }}" rel="stylesheet" />
    <link href="{{ asset('assets/plugins/ionicons/css/ionicons.min.css') }}" rel="stylesheet" />
    <!-- ================== END core-css ================== -->

    <!-- ================== BEGIN page-css ================== -->
    <link href="{{ asset('assets/plugins/jvectormap-next/jquery-jvectormap.css') }}" rel="stylesheet" />
    <link href="{{ asset('assets/plugins/gritter/css/jquery.gritter.css') }}" rel="stylesheet" />
    <link href="{{ asset('assets/plugins/nvd3/build/nv.d3.css') }}" rel="stylesheet" />
    <link href="{{ asset('assets/plugins/simple-calendar/dist/simple-calendar.css') }}" rel="stylesheet" />
    <!-- ================== END page-css ================== -->
    <style>
        .modal-box {
            font-family: 'Poppins', sans-serif;
        }

        .show-modal {
            color: #fff;
            background: linear-gradient(to right, #33a3ff, #0675cf, #49a6fd);
            font-size: 18px;
            font-weight: 600;
            text-transform: capitalize;
            padding: 10px 15px;
            margin: 200px auto 0;
            border: none;
            outline: none;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            display: block;
            transition: all 0.3s ease 0s;
        }

        .show-modal:hover,
        .show-modal:focus {
            color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
            outline: none;
        }

        .modal-dialog {
            width: 400px;
            margin: 70px auto 0;
        }

        .modal-dialog {
            transform: scale(0.5);
        }

        .modal-dialog {
            transform: scale(1);
        }

        .modal-dialog .modal-content {
            text-align: center;
            border: none;
        }

        .modal-content .close {
            color: #fff;
            background: linear-gradient(to right, #33a3ff, #0675cf, #4cd5ff);
            font-size: 25px;
            font-weight: 400;
            text-shadow: none;
            line-height: 27px;
            height: 25px;
            width: 25px;
            border-radius: 50%;
            overflow: hidden;
            opacity: 1;
            position: absolute;
            left: auto;
            right: 8px;
            top: 8px;
            z-index: 1;
            transition: all 0.3s;
        }

        .modal-content .close:hover {
            color: #fff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
        }

        .close:focus {
            outline: none;
        }

        .modal-body {
            padding: 60px 40px 40px !important;
        }

        .modal-body .title {
            color: #026fd4;
            font-size: 33px;
            font-weight: 700;
            letter-spacing: 1px;
            margin: 0 0 10px;
        }

        .modal-body .description {
            color: #9A9EA9;
            font-size: 16px;
            margin: 0 0 20px;
        }

        .modal-body .form-group {
            text-align: left;
            margin-bottom: 20px;
            position: relative;
        }

        .modal-body .input-icon {
            color: #777;
            font-size: 18px;
            transform: translateY(-50%);
            position: absolute;
            top: 50%;
            left: 20px;
        }

        .modal-body .form-control {
            font-size: 17px;
            height: 45px;
            width: 100%;
            padding: 6px 0 6px 50px;
            margin: 0 auto;
            border: 2px solid #eee;
            border-radius: 5px;
            box-shadow: none;
            outline: none;
        }

        .form-control::placeholder {
            color: #AEAFB1;
        }

        .form-group.checkbox {
            width: 130px;
            margin-top: 0;
            display: inline-block;
        }

        .form-group.checkbox label {
            color: #9A9EA9;
            font-weight: normal;
        }

        .form-group.checkbox input[type=checkbox] {
            margin-left: 0;
        }

        .modal-body .forgot-pass {
            color: #7F7FD5;
            font-size: 13px;
            text-align: right;
            width: calc(100% - 135px);
            margin: 2px 0;
            display: inline-block;
            vertical-align: top;
            transition: all 0.3s ease 0s;
        }

        .forgot-pass:hover {
            color: #9A9EA9;
            text-decoration: underline;
        }

        .modal-content .modal-body .btn-submit {
            color: #fff;
            background: linear-gradient(to right, rgb(10, 100, 255), #009900, #03b703);
            font-size: 16px;
            font-weight: 500;
            letter-spacing: 1px;
            text-transform: uppercase;
            line-height: 38px;
            width: 100%;
            height: 40px;
            padding: 0;
            border: none;
            border-radius: 5px;
            border: none;
            display: inline-block;
            transition: all 0.6s ease 0s;
        }

        .modal-content .modal-body .btn-submit:hover {
            color: #fff;
            letter-spacing: 2px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .modal-content .modal-body .btn-submit:focus {
            outline: none;
        }

        @media only screen and (max-width: 480px) {
            .modal-dialog {
                width: 95% !important;
            }

            .modal-content .modal-body {
                padding: 60px 20px 40px !important;
            }
        }
    </style>
    @stack('css')
</head>

<body>
    <!-- BEGIN #loader -->
    <div id="loader" class="app-loader">
        <span class="spinner"></span>
    </div>
    <!-- END #loader -->

    <!-- BEGIN #app -->
    <div id="app" class="app app-header-fixed app-sidebar-minified">
        @yield('content')
    </div>
    <!-- END #app -->

    <!-- ================== BEGIN core-js ================== -->
    <script src="{{ asset('assets/js/vendor.min.js') }}"></script>
    <script src="{{ asset('assets/js/app.min.js') }}"></script>
    <!-- ================== END core-js ================== -->

    <!-- ================== BEGIN page-js ================== -->
    <script src="{{ asset('assets/plugins/d3/d3.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/nvd3/build/nv.d3.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/jvectormap-next/jquery-jvectormap.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/jvectormap-next/jquery-jvectormap-world-mill.js') }}"></script>
    <script src="{{ asset('assets/plugins/simple-calendar/dist/jquery.simple-calendar.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/gritter/js/jquery.gritter.js') }}"></script>
    <script src="{{ asset('assets/plugins/chart.js/dist/chart.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/apexcharts/dist/apexcharts.min.js') }}"></script>
    {{-- <script src="/assets/js/demo/dashboard-v2.js"></script> --}}
    @stack('script')
    <!-- ================== END page-js ================== -->
</body>

</html>
<script></script>
