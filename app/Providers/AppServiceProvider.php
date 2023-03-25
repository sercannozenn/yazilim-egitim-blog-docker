<?php

namespace App\Providers;

use Carbon\Carbon;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
//        Paginator::useBootstrapFive();
        Paginator::defaultView("vendor.pagination.yazilimegitimPagination");

        Carbon::setLocale(config("app.locale"));

        URL::forceScheme('https');
    }
}
