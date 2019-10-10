<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Schema::defaultStringLength(191);

        $ip = \Request::ip();
        $geo = geoip($ip);
        
        $country = $geo['country'];

        if($country == "Brazil") {
            \App::setLocale("pt_br");
        } else {
            \App::setLocale("en");
        }
    }
}
