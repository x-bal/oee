<?php

return [
    /*
    |--------------------------------------------------------------------------
    | View Storage Paths
    |--------------------------------------------------------------------------
    |
    | Most templating systems load templates from disk. Here you may specify
    | an array of paths that should be checked for your views. Of course
    | the usual Laravel view path has already been registered for you.
    |
    */
    'menu' => [
        [
            'icon' => 'ion-md-speedometer bg-gradient-success',
            'title' => 'Dashboard',
            'url' => '/dashboard',
            'route-name' => 'dashboard.index',
        ],
        [
            'icon' => 'ion-md-cog bg-gradient-primary',
            'title' => 'Master Data',
            'url' => 'javascript:;',
            'caret' => true,
            'sub_menu' => [
                [
                    'url' => '/admin/line',
                    'title' => 'Line Process',
                    'highlight' => true,
                    'route-name' => 'manage.line.index',
                    'icon-sub' => 'fa-solid fa-house-signal',
                ],
                [
                    'url' => '/admin/machines',
                    'title' => 'Machines',
                    'route-name' => 'manage.machine.index',
                    'icon-sub' => 'fas fa-cog',
                    'highlight' => true,
                ],
                [
                    'url' => '/admin/product',
                    'title' => 'Products',
                    'route-name' => 'manage.product.index',
                    'icon-sub' => 'fa-brands fa-product-hunt',
                    'highlight' => true,
                ],
                [
                    'url' => '/admin/users',
                    'title' => 'Management Users',
                    'route-name' => 'manage.user.index',
                    'icon-sub' => 'fa-solid fa-users',
                    'highlight' => true,
                ],
            ],
        ],
        [
            'icon' => 'ion-md-time bg-gradient-primary',
            'title' => 'Management Working Time',
            'url' => 'javascript:;',
            'caret' => true,
            'sub_menu' => [
                [
                    'url' => '/admin/shift',
                    'title' => 'Shift Code',
                    'highlight' => true,
                    'route-name' => 'manage.shift.index',
                    'icon-sub' => 'fas fa-user-clock',
                ],
                [
                    'url' => '/admin/machines',
                    'title' => 'Daily Activites',
                    'route-name' => 'manage.machine.index',
                    'icon-sub' => 'fas fa-stopwatch',
                    'highlight' => true,
                ],
            ],
        ],
        [
            'icon' => 'ion-md-cube bg-gradient-yellow-green',
            'title' => 'DB OEE',
            'url' => '/admin/viewoee',
            'route-name' => 'view.oee.index',
        ],
        [
            'icon' => 'ion-md-key bg-gradient-yellow-red',
            'title' => 'Management KPI',
            'url' => '/admin/kpi',
            'route-name' => 'manage.kpi.index',
        ],
        [
            'icon' => 'ion-md-filing bg-gradient-purple-indigo',
            'title' => 'Yield Production',
            'url' => '/admin/line',
            // 'route-name' => 'manage.line.index',
        ],
        [
            'icon' => 'ion-md-infinite bg-gradient-pink',
            'title' => 'Activity Code',
            'url' => '/admin/activity',
            'route-name' => 'manage.activity.index',
        ],
        [
            'icon' => 'ion-md-calendar bg-gradient-white text-dark',
            'title' => 'Production Planning',
            'url' => 'javascript:;',
            'caret' => true,
            'sub_menu' => [
                [
                    'url' => '/admin/planning',
                    'title' => 'Work Order',
                    'highlight' => true,
                    'route-name' => 'manage.planning.index',
                    'icon-sub' => 'fas fa-user-clock',
                ],
                [
                    'url' => '/admin/machines',
                    'title' => 'E-Schedule',
                    'route-name' => 'manage.machine.index',
                    'icon-sub' => 'fas fa-calendar',
                    'highlight' => true,
                ],
            ],
        ],
        [
            'icon' => 'ion-md-clipboard bg-gradient-yellow',
            'title' => 'Input OEE',
            'url' => '/operator/month',
            'route-name' => 'operator.month',
        ],
        [
            'icon' => 'ion-md-podium bg-gradient-lime text-black',
            'title' => 'Manajemen OEE',
            'url' => '/admin/oeemanagement',
            'route-name' => 'management.oee.month',
        ],
        [
            'icon' => 'ion-md-analytics bg-gradient-gray',
            'title' => 'Management Report',
            'url' => '/admin/line',
            // 'route-name' => 'manage.line.index',
        ],
    ],
];
