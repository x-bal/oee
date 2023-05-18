@php
	$appSidebarClass = (!empty($appSidebarTransparent)) ? 'app-sidebar-transparent' : '';
@endphp
<!-- BEGIN #sidebar -->
<div id="sidebar" class="app-sidebar">
	<!-- BEGIN scrollbar -->
	<div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
		<div class="menu">
			@if (!$appSidebarSearch)
			<div class="menu-profile">
				<a href="javascript:;" class="menu-profile-link" data-toggle="app-sidebar-profile" data-target="#appSidebarProfileMenu">
					<div class="menu-profile-image">
						<img src="{{ asset('/assets/img/user/'. Auth::user()->txtphoto) }}" alt="" />
					</div>
					<div class="menu-profile-info">
						<div class="d-flex align-items-center">
							<div class="flex-grow-1">
								{{ Auth::user()->txtname }}
							</div>
						</div>
					</div>
				</a>
			</div>
			@endif

			@if ($appSidebarSearch)
			<div class="menu-search mb-n3">
        <input type="text" class="form-control" placeholder="Sidebar menu filter..." data-sidebar-search="true" />
			</div>
			@endif

			<div class="menu-header">Navigation</div>

			@php
                $menus = json_decode(Storage::get('public/'.Auth::user()->id.'.json'), true);
				$currentUrl = (Request::path() != '/') ? '/'. Request::path() : '/';
			@endphp
            @foreach ($menus as $item)
                @if ($item['submenu'])
                @php
                    $active = collect($item['submenu']);
                    $isAct = $active->where('txtroute', Route::currentRouteName())->first()?'active':'';
                @endphp
                <div class="menu-item has-sub {{ $isAct }}">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="{{ $item['txticon'] }}"></i>
                        </div>
                        <div class="menu-text">{{ $item['txttitle'] }}</div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        @foreach ($item['submenu'] as $sub)
                        <div class="menu-item {{ Route::currentRouteName() == $sub['txtroute']?'active':''; }}">
                            <a href="{{ $sub['txturl'] }}" class="menu-link"><div class="menu-text"><i class="{{ $sub['txticon'] }} text-theme ms-1"></i> {{ $sub['txttitle'] }}</div></a>
                        </div>
                        @endforeach
                    </div>
                </div>
                @else
                <div class="menu-item {{ Route::currentRouteName() == $item['txtroute']?'active':'' }}">
                    <a href="{{ $item['txturl'] }}" class="menu-link">
                        <div class="menu-icon">
                            <i class="{{ $item['txticon']}}"></i>
                        </div>
                        <div class="menu-text">{{ $item['txttitle'] }}</div>
                    </a>
                </div>
                @endif
            @endforeach
			<!-- BEGIN minify-button -->
			<div class="menu-item d-flex">
				<a href="javascript:;" class="app-sidebar-minify-btn ms-auto" data-toggle="app-sidebar-minify"><i class="fa fa-angle-double-left"></i></a>
			</div>
			<!-- END minify-button -->

		</div>
		<!-- END menu -->
	</div>
	<!-- END scrollbar -->
</div>
<div class="app-sidebar-bg"></div>
<div class="app-sidebar-mobile-backdrop"><a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a></div>
<!-- END #sidebar -->

