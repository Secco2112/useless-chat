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

Route::get('/', 'HomeController@index')->name('home');
Route::get('/home', 'HomeController@index')->name('home');

Auth::routes(['register' => true]);

Route::post('/user/info', 'UserController@info')->name('user.info');
Route::post('/user/panel_info', 'UserController@panel_info')->name('user.panel_info');
Route::post('/user/request_friendship', 'UserController@request_friendship')->name('user.request_friendship');
Route::post('/user/accept_friendship_request', 'UserController@accept_friendship_request')->name('user.accept_friendship_request');
Route::post('/user/reject_friend_request', 'UserController@reject_friend_request')->name('user.reject_friend_request');
Route::post('/user/remove_friend', 'UserController@remove_friend')->name('user.remove_friend');
Route::post('/user/search', 'UserController@search')->name('user.search');

Route::get('/chat/private/{id}', 'PrivateChatController@index')->name('chat.private')->middleware('auth');
Route::post('/chat/private/save', 'PrivateChatController@save')->name('chat.private_save')->middleware('auth');

Route::get('/chat/group/{id}', 'GroupChatController@index')->name('chat.group')->middleware('auth');
Route::post('/chat/group/save', 'GroupChatController@save')->name('chat.group_save')->middleware('auth');
Route::post('/chat/group/search', 'GroupChatController@search')->name('chat.group.search')->middleware('auth');
Route::post('/chat/group/add_user', 'GroupChatController@add_user')->name('chat.group.add_user')->middleware('auth');

Route::get('/profile/edit', 'UserController@edit')->name('user.edit')->middleware('auth');
Route::get('/profile/friends', 'UserController@friends')->name('user.friends')->middleware('auth');
Route::post('/profile/edit', 'UserController@update')->name('user.update')->middleware('auth');
Route::get('/profile/restore-avatar', 'UserController@restore_avatar')->name('user.restore_avatar')->middleware('auth');
