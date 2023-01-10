@extends('layouts.default')

@section('title', 'View My QR')

@push('css')
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">View QR</li>
            </ol>
            <h1 class="page-header mb-0">View QR</h1>
        </div>
    </div>
	<!-- BEGIN panel -->
	<div class="panel panel-inverse">
		<!-- BEGIN panel-heading -->
		<div class="panel-heading">
			<h4 class="panel-title">My QR Code</h4>
			<div class="panel-heading-btn">
				<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
				<a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i class="fa fa-times"></i></a>
			</div>
		</div>
		<!-- END panel-heading -->
		<!-- BEGIN panel-body -->
		<div class="panel-body">
            <div class="row justify-content-center">
                @if (Session::has('success'))
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong>
                    {{ Session::get('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></span>
                </div>
                @endif
                <div class="col-md-6">
                    <div class="card">
                        <div class="text-center py-3">
                            {{ $qr }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mt-3">
                <div class="col-md-12">
                    <div class="text-center">
                        <button class="btn btn-default" onclick="downloadPNG()"><i class="fas fa-download"></i> Download</button>
                        <button class="btn btn-default" onclick="changeQr()">Change</button>
                    </div>
                </div>
            </div>
		</div>
		<!-- END panel-body -->
	</div>
	<!-- END panel -->
@endsection

@push('scripts')
	<script src="/assets/plugins/@highlightjs/cdn-assets/highlight.min.js"></script>
	<script src="/assets/js/demo/render.highlight.js"></script>
    <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
    <script src="/assets/plugins/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        let name = "{{ Auth::user()->txtname }}";
        function downloadPNG(){
            var svg = document.querySelector("svg");

            if (typeof window.XMLSerializer != "undefined") {
                var svgData = (new XMLSerializer()).serializeToString(svg);
            } else if (typeof svg.xml != "undefined") {
                var svgData = svg.xml;
            }

            var canvas = document.createElement("canvas");
            var svgSize = svg.getBoundingClientRect();
            canvas.width = svgSize.width;
            canvas.height = svgSize.height;
            var ctx = canvas.getContext("2d");

            var img = document.createElement("img");
            img.setAttribute("src", "data:image/svg+xml;base64," + btoa(unescape(encodeURIComponent(svgData))) );

            img.onload = function() {
                ctx.drawImage(img, 0, 0);
                var imgsrc = canvas.toDataURL("image/png");

                var a = document.createElement("a");
                a.download = "{{ Auth::user()->txtname }}_Qr_Login.png";
                a.href = imgsrc;
                a.click();
            };
        }
        function changeQr(){
            swal({
                title: 'Are you sure?',
                text: 'You will not be able to recover this data!',
                icon: 'warning',
                buttons: {
                    cancel: {
                        text: 'Cancel',
                        value: null,
                        visible: true,
                        className: 'btn btn-default',
                        closeModal: true,
                    },
                    confirm: {
                        text: 'Change',
                        value: true,
                        visible: true,
                        className: 'btn btn-success',
                        closeModal: true
                    }
                }
            }).then((isConfirm) => {
				if (isConfirm) {
                    window.location.href = "{{ route('view.qr.change') }}";
                }
            });
        }
        $(document).ready(function(){
        })
    </script>
@endpush
