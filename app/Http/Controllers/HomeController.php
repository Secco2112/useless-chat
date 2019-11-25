<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $user = \App\User::find(Auth::user()->id);

        $handle_request = \App\FriendRequest::where("user_to_accept", $user->id)->get()->toArray();
        $users_request = [];
        foreach ($handle_request as $key => $value) {
            $users_request[] = \App\User::find($value["user_request"]);
        }

        $handle_friends = \App\Friendship::where("user_id_1", $user->id)->orWhere("user_id_2", $user->id)->get()->toArray();
        $users_friend = [];
        foreach ($handle_friends as $key => $value) {
            if($value["user_id_1"] == $user->id) {
                $users_friend[] = \App\User::find($value["user_id_2"]);
            } else {
                $users_friend[] = \App\User::find($value["user_id_1"]);
            }
        }

        $data = [
            "user" => $user,
            "users_request" => $users_request,
            "users_friend" => $users_friend
        ];

        return view("users.friends")->with($data);
    }
}
