@extends('layouts.default')

@section('title', 'Select Month')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        .result-icon{
            width: 5%;
            position: relative;
        }
    </style>
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">Select Month</li>
            </ol>
            <h1 class="page-header mb-0">OEE Month {{ $line->txtlinename }}</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">MONTH OEE {{ $line->txtlinename }}</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
				<a type="button" onclick="reloadTable()" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<!-- END panel-heading -->
        <div class="panel-body bg-gray-200">
            <div class="row mb-3">
                <div class="col-md-4">
                    <form action="" method="get">
                        <div class="row">
                            <div class="col-md-8">
                                <select name="year" id="Year" class="form-select">
                                    @foreach ($year as $item)
                                        <option value="{{ $item->txtyear }}">{{ $item->txtyear }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-success btn-sm">Filter</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- BEGIN widget-list -->
			<div class="widget-list rounded mb-4" data-id="widget">
                @foreach ($oee as $key => $item)
                @php
                    $oee = (($item['ar']/100)*($item['pr']/100)*($item['qr']/100))*100;
                @endphp
				<a href="{{ $item['link'] }}" class="widget-list-item">
					<div class="widget-list-media icon">
						<i class="fa fa-calendar bg-dark text-white"></i>
					</div>
					<div class="widget-list-content">
						<h4 class="widget-list-title">{{ $item['month'] }}</h4>
					</div>
					<div class="widget-list-content">
						<div class="progress progress-striped active">
                            <div class="progress-bar bg-indigo progress-bar-striped progress-bar-animated rounded-pill fs-10px fw-bold" style="width: {{ number_format($oee) }}%">OEE = {{ number_format($oee, 2) }}%</div>
                        </div>
					</div>
                    <div class="widget-list-content text-blue">
                        <p>
                            <i class="ion-md-analytics"></i> Avaibility rate: {{ $item['ar'] }}%
                        </p>
                    </div>
                    <div class="widget-list-content text-blue">
                        <p>
                            <i class="ion-md-podium"></i> Performance rate: {{ $item['pr'] }}%
                        </p>
                    </div>
                    <div class="widget-list-content text-blue">
                        <p>
                            <i class="ion-md-ribbon"></i> Quality rate: {{ $item['qr'] }}%
                        </p>
                    </div>
					<div class="widget-list-action">
						<button class="btn btn-gradient-primary"><i class="fas fa-eye"></i> View</button>
					</div>
				</a>
                @endforeach
			</div>
			<!-- END widget-list -->
	    </div>
    </div>
	<!-- END panel -->
@endsection

@push('scripts')
	<script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
	<script src="/assets/plugins/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
	<script src="/assets/plugins/@highlightjs/cdn-assets/highlight.min.js"></script>
	<script src="/assets/js/demo/render.highlight.js"></script>
    <script src="/assets/plugins/parsleyjs/dist/parsley.min.js"></script>
    <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
    <script src="/assets/plugins/sweetalert/dist/sweetalert.min.js"></script>
    <script src="/assets/plugins/select2/dist/js/select2.min.js"></script>
    <script>
        let action = '';
        let method = '';
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        function getUrl(){
            return action;
        }
        function getMethod(){
            return method;
        }
        function reloadTable(){
            daTable.draw();
        }
        function gritter(title, text){
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: status,
                time: 1000,
            });
        }
        $(document).ready(function(){
        })
    </script>
@endpush

