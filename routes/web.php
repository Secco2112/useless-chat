<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('home');
})->middleware('auth');

Auth::routes(['register' => true]);

Route::get('/home', 'HomeController@index')->name('home');

Route::post('/user/info', 'UserController@info')->name('user.info');

Route::get('/chat/private/{id}', 'PrivateChatController@index')->name('chat.private');
Route::post('/chat/private/save', 'PrivateChatController@save')->name('chat.private_save');
