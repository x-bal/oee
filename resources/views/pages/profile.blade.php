@extends('layouts.default')

@section('title', 'Dashboard')

@push('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
	<link rel="stylesheet" href="{{ asset('assets/plugins/superbox/superbox.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/lity/dist/lity.min.css') }}">
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
@endpush

@section('content')
	<!-- BEGIN profile -->
	<div class="profile">
		<div class="profile-header">
			<!-- BEGIN profile-header-cover -->
			<div class="profile-header-cover"></div>
			<!-- END profile-header-cover -->
			<!-- BEGIN profile-header-content -->
			<div class="profile-header-content">
				<!-- BEGIN profile-header-img -->
				<div class="profile-header-img">
					<img src="{{ asset('assets/img/user/'.$user->txtphoto) }}" alt="Photo Profile" id="previewImg"/>
				</div>
				<!-- END profile-header-img -->
				<!-- BEGIN profile-header-info -->
				<div class="profile-header-info">
					<h4 class="mt-0 mb-1">{{ $user->txtname }}</h4>
					<p class="mb-2">{{ $user->txtlevelname }}</p>
				</div>
				<!-- END profile-header-info -->
			</div>
			<!-- END profile-header-content -->
			<!-- BEGIN profile-header-tab -->
			<ul class="profile-header-tab nav nav-tabs">
				<li class="nav-item"><a href="#profile-about" class="nav-link active" data-bs-toggle="tab">ABOUT</a></li>
				<li class="nav-item"><a href="#profile-password" class="nav-link" data-bs-toggle="tab">CHANGE PASSWORD</a></li>
			</ul>
			<!-- END profile-header-tab -->
		</div>
	</div>
	<!-- END profile -->
	<!-- BEGIN profile-content -->
	<div class="profile-content">
		<!-- BEGIN tab-content -->
		<div class="tab-content p-0">
			<!-- BEGIN #profile-about tab -->
			<div class="tab-pane active show" id="profile-about">
				<!-- BEGIN table -->
				<div class="table-responsive form-inline">
					<table class="table table-profile align-middle">
						<thead>
							<tr>
								<th></th>
								<th>
									<h4>{{ $user->txtname }} <small>{{ $user->txtlevelname }}</small></h4>
								</th>
							</tr>
						</thead>
						<tbody>
                            <form action="" method="post" id="ChangeProfile" data-parsley-validate="true" enctype="multipart/form-data">
                            @csrf
                            <input type="hidden" name="_method" value="PUT">
							<tr class="highlight">
								<td class="field">Initial</td>
								<td><strong>{{ $user->txtinitial }}</strong></td>
							</tr>
							<tr>
								<td class="field">Username</td>
								<td><strong>{{ $user->txtusername }}</strong></td>
							</tr>
                            @php
                                $lines = json_decode($user->line, true);
                                $colors = [
                                        'primary',
                                        'warning',
                                        'lime',
                                        'green',
                                        'info',
                                        'purple',
                                        'indigo',
                                        'dark',
                                        'pink',
                                        'secondary'
                                    ];
                            @endphp
                            @if (!empty($lines))
							    <tr>
                                    <td class="field">Line Process</td>
                                    <td>
                                            @foreach ($lines as $item)
                                                <span class="badge rounded-pill bg-{{ $colors[rand(0, 9)] }}">{{ $item['txtlinename'] }}</span>
                                            @endforeach
                                        </td>
                                </tr>
                            @endif
                            <tr>
								<td class="field">Photo</td>
								<td>
									<input type="file" name="txtphoto" id="formFile" class="form-control w-200px" onchange="preview()" data-parsley-required="true">
								</td>
							</tr>
							<tr>
								<td class="field">Password</td>
								<td>
									<input type="password" name="txtpassword" id="Password" class="form-control w-200px" placeholder="Current Password to update Profile" title="Current Password to update Profile" data-parsley-required="true">
								</td>
							</tr>
							<tr class="divider">
								<td colspan="2"></td>
							</tr>
							<tr class="highlight">
								<td class="field">&nbsp;</td>
								<td class="">
									<button type="submit" class="btn btn-primary w-150px">Update</button>
									<button onclick="resetFieldProfile()" type="button" class="btn btn-white border-0 w-150px ms-5px">Cancel</button>
								</td>
							</tr>
                            </form>
						</tbody>
					</table>
				</div>
				<!-- END table -->
			</div>
			<!-- END #profile-about tab -->
			<!-- BEGIN #profile-password tab -->
			<div class="tab-pane" id="profile-password">
				<!-- BEGIN table -->
				<div class="table-responsive form-inline">
					<table class="table table-profile align-middle">
						<thead>
							<tr>
								<th></th>
								<th>
									<h4>{{ $user->txtname }} <small>{{ $user->txtlevelname }}</small></h4>
								</th>
							</tr>
						</thead>
						<tbody>
                            <form action="" method="post" id="ChangePass" data-parsley-validate="true">
                            @csrf
                            <input type="hidden" name="_method" value="PUT">
							<tr>
								<td class="field">Current Password</td>
								<td>
									<input type="password" name="txtcurrentpassword" id="CurrentPassword" class="form-control w-300px" placeholder="Current Password" title="Current Password" data-parsley-required="true">
								</td>
							</tr>
							<tr>
								<td class="field">New Password</td>
								<td>
									<input type="password" name="txtnewpassword" id="NewPassword" class="form-control w-300px" placeholder="New Password" title="New Password" data-parsley-required="true">
								</td>
							</tr>
							<tr>
								<td class="field">Confirm New Password</td>
								<td>
									<input type="password" name="txtconfirmpassword" id="ConfirmPassword" class="form-control w-300px" placeholder="Confirm Password" title="Confirm Password" data-parsley-required="true">
								</td>
							</tr>
							<tr class="divider">
								<td colspan="2"></td>
							</tr>
							<tr class="highlight">
								<td class="field">&nbsp;</td>
								<td class="">
									<button type="submit" class="btn btn-primary w-150px">Update</button>
									<button type="button" onclick="resetFieldPassword()" class="btn btn-white border-0 w-150px ms-5px">Cancel</button>
								</td>
							</tr>
                            </form>
						</tbody>
					</table>
				</div>
				<!-- END table -->
			</div>
			<!-- END #profile-password tab -->
		</div>
		<!-- END tab-content -->
	</div>
	<!-- END profile-content -->
@endsection
@push('scripts')
    <script src="{{ asset('assets/plugins/superbox/jquery.superbox.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/lity/dist/lity.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/parsleyjs/dist/parsley.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/gritter/js/jquery.gritter.js') }}"></script>
	<script src="/assets/plugins/@highlightjs/cdn-assets/highlight.min.js"></script>
	<script src="/assets/js/demo/render.highlight.js"></script>
    <script>
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
        const gambar = document.querySelector('#formFile');
        const imgPreview = document.querySelector('#previewImg');
        function preview(){
            //mengganti preview
            const fileSampul = new FileReader();
            fileSampul.readAsDataURL(gambar.files[0])
            fileSampul.onload = function(e) {
                imgPreview.src = e.target.result;
            }
        }
        function resetFieldProfile(){
            const password = document.querySelector('#Password');
            password.value = "";
            gambar.value = "";
            imgPreview.src = "{{ asset('assets/img/user/'.$user->txtphoto) }}";
        }
        function resetFieldPassword(){
            const currentpassword = document.querySelector('#CurrentPassword');
            const newpassword = document.querySelector('#NewPassword');
            const confirmpassword = document.querySelector('#ConfirmPassword');
            currentpassword.value = "";
            newpassword.value = "";
            confirmpassword.value = "";
        }
        function urlUpdate(url){
            let ajaxLink = url.replace(':id', "{{ Auth::user()->id }}");
            return ajaxLink;
        }
        function gritter(title, text, status){
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: status,
                time: 1000,
            });
        }
        $(document).ready(function(){
            $('form#ChangeProfile').on('submit', function(e){
                e.preventDefault();
                var formData = new FormData($(this)[0]);
                $.ajax({
                    url: urlUpdate("{{ route('user.update.profile', ':id') }}"),
                    method: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "JSON",
                    success: function(response){
                        gritter(response.status, response.message, 'bg-success');
                        location.reload();
                    },
                    error: function(res){
                        if (res.status == 400) {
                            $.each(res.responseJSON.data, function(i, val){
                                for (let i = 0; i < val.length; i++) {
                                    gritter('Error', val[i], 'bg-danger');
                                };
                            });
                        } else {
                            gritter('Error', res.responseJSON.message, 'bg-danger');
                        }
                    }
                })
            })
            $('form#ChangePass').on('submit', function(e){
                e.preventDefault();
                var formData = new FormData($(this)[0]);
                $.ajax({
                    url: urlUpdate("{{ route('user.update.password', ':id') }}"),
                    method: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "JSON",
                    success: function(response){
                        gritter(response.status, response.message, 'bg-success');
                    },
                    error: function(res){
                        if (res.status == 400) {
                            $.each(res.responseJSON.data, function(i, val){
                                for (let i = 0; i < val.length; i++) {
                                    gritter('Error', val[i], 'bg-danger');
                                };
                            });
                        } else {
                            gritter('Error', res.responseJSON.message, 'bg-danger');
                        }
                    }
                })
            })
        })
    </script>
@endpush
