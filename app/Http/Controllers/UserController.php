<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use \App\ProfileAvatar;
use Illuminate\Support\Facades\Storage;
use \App\GroupChat;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit()
    {
        $user = \App\User::find(Auth::user()->id);
        $avatar = "https://www.gravatar.com/avatar/" . md5(strtolower($user->email));
        $handle = ProfileAvatar::where("user_id", Auth::user()->id)->get();
        if($handle->count() > 0) {
            $avatar = Storage::url($handle[0]->path);
        }

        $data = [
            "user" => $user,
            "avatar" => $avatar
        ];

        return view("users.edit")->with($data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        // Imagem
        if($_FILES["user-avatar"]["error"] == 0) {
            $upload = $request->file("user-avatar")->store('public');
            if($upload) {
                $check = ProfileAvatar::where("user_id", Auth::user()->id)->count();
                if($check == 0) {
                    $data = new ProfileAvatar();
                    $data->user_id = Auth::user()->id;
                    $data->path = $upload;
                    $data->save();
                } else {
                    $data = ProfileAvatar::where("user_id", Auth::user()->id)->update(["path" => $upload]);
                }
            }
        }
        
        $user = \App\User::find(Auth::user()->id);
        $user->name = $_POST["username"];
        if(isset($_POST["accept-delete"])) {
            $user->accept_delete = 1;
            $user->delete_time = $_POST["time-to-delete"];
            $user->delete_type = $_POST["delete-type"];
        } else {
            $user->accept_delete = 0;
        }
        $user->save();

        return redirect('profile/edit');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function info() {
        if(!empty($_POST)) {
            $user_id = $_POST;

            $user = \App\User::find($user_id);
            $user = $user[0];
            $user->image = $user->getAvatar();

            echo json_encode($user);
            die();
        }
    }

    public function panel_info() {
        if(!empty($_POST)) {
            $user_id = $_POST["user_id"];

            $user = \App\User::find($user_id);
            $user->image = "https://www.gravatar.com/avatar/" . md5(strtolower(trim($user->email))) . "?s=200";

            $logged_user = Auth::user();
            $friendship = $logged_user->isFriendOf($user->id);
            $a = [$logged_user->id, $user->id];
            sort($a);

            if($friendship) {
                $friendship_info = \App\Friendship::where([
                    ["user_id_1", "=", $a[0]],
                    ["user_id_2", "=", $a[1]]
                ])->get();
                
                $user->friends = true;
                $user->friends_since = \DateTime::createFromFormat("Y-m-d H:i:s", $friendship_info[0]->created_at)->format("d/m/Y H:i");
            } else {
                $check_friend_request = \App\FriendRequest::where([
                    ["user_request", "=", $logged_user->id],
                    ["user_to_accept", "=", $user_id]
                ])->count();

                if($check_friend_request > 0) {
                    $user->request_friendship = true;
                } else {
                    $check_friend_requested = \App\FriendRequest::where([
                        ["user_request", "=", $user_id],
                        ["user_to_accept", "=", $logged_user->id]
                    ])->count();

                    if($check_friend_requested > 0) {
                        $user->requested_friendship = true;
                    }
                }

                $user->friends = false;
            }

            
            $user_1_groups = \App\GroupChatUsers::select("group_id")->where("user_id", $logged_user->id)->get()->toArray();
            $user_2_groups = \App\GroupChatUsers::select("group_id")->where("user_id", $user->id)->get()->toArray();
            $user_1_groups = array_map(function($g) {
                return $g["group_id"];
            }, $user_1_groups);
            $user_2_groups = array_map(function($g) {
                return $g["group_id"];
            }, $user_2_groups);

            $common_groups_ids = array_intersect($user_1_groups, $user_2_groups);

            if(count($common_groups_ids)) {
                $common_groups = [];
                foreach ($common_groups_ids as $key => $cg) {
                    $group = \App\GroupChat::find($cg)->toArray();

                    $group_name = GroupChat::find($cg)->name(25);

                    $common_groups[] = [
                        "id" => $group["id"],
                        "name" => $group_name
                    ];
                }
                $user->common_groups = $common_groups;
            } else {
                $user->common_groups = false;
            }


            echo json_encode($user);
            die();
        }
    }

    public function restore_avatar() {
        $data = ProfileAvatar::where("user_id", Auth::user()->id)->delete();
        return redirect('profile/edit');
    }

    public function request_friendship() {
        $request_user = $_POST["request_user"];
        $user_to_add = $_POST["user_to_add"];

        $check = \App\FriendRequest::where([
            ["user_request", "=", $request_user],
            ["user_to_accept", "=", $user_to_add]
        ])->count();

        if($check == 0) {
            $data = new \App\FriendRequest();
            $data->user_request = $request_user;
            $data->user_to_accept = $user_to_add;
            $data->save();
        }

        die(true);
    }

    public function accept_friendship_request() {
        $request_user = $_POST["request_user"];
        $user_to_add = $_POST["user_to_add"];

        $check = \App\FriendRequest::where([
            ["user_request", "=", $request_user],
            ["user_to_accept", "=", $user_to_add]
        ])->count();

        if($check > 0) {
            $data = \App\FriendRequest::where([
                ["user_request", "=", $request_user],
                ["user_to_accept", "=", $user_to_add]
            ])->delete();

            $users = [$request_user, $user_to_add];
            sort($users);

            $data = new \App\Friendship();
            $data->user_id_1 = $users[0];
            $data->user_id_2 = $users[1];
            $data->save();
        }

        die(true);
    }

    public function reject_friend_request() {
        $request_user = $_POST["request_user"];
        $user_to_add = $_POST["user_to_add"];

        $check = \App\FriendRequest::where([
            ["user_request", "=", $request_user],
            ["user_to_accept", "=", $user_to_add]
        ])->count();

        if($check > 0) {
            $data = \App\FriendRequest::where([
                ["user_request", "=", $request_user],
                ["user_to_accept", "=", $user_to_add]
            ])->delete();
        }

        die(true);
    }

    public function remove_friend() {
        $request_user = $_POST["request_user"];
        $user_to_add = $_POST["user_to_add"];

        $users = [$request_user, $user_to_add];
        sort($users);

        $check = \App\Friendship::where([
            ["user_id_1", "=", $users[0]],
            ["user_id_2", "=", $users[1]]
        ])->count();

        if($check > 0) {
            $data = \App\Friendship::where([
                ["user_id_1", "=", $users[0]],
                ["user_id_2", "=", $users[1]]
            ])->delete();
        }

        die(true);
    }

    public function friends() {
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

    public function search() {
        $query = $_POST["query"];

        $results = \App\User::where("name", "like", "%" . $query . "%")->where("id", "!=", Auth::user()->id)->get();

        
        $users = [];
        foreach ($results as $key => $result) {
            $ids = [Auth::user()->id, $result->id];
            sort($ids);

            $f_handle = \App\Friendship::where([
                ["user_id_1", "=", $ids[0]],
                ["user_id_2", "=", $ids[1]]
            ])->count();

            if($f_handle > 0) {
                $result->friends = true;
            } else {
                $check_friend_request = \App\FriendRequest::where([
                    ["user_request", "=", Auth::user()->id],
                    ["user_to_accept", "=", $result->id]
                ])->count();

                if($check_friend_request > 0) {
                    $result->request_friendship = true;
                } else {
                    $check_friend_requested = \App\FriendRequest::where([
                        ["user_request", "=", $result->id],
                        ["user_to_accept", "=", Auth::user()->id]
                    ])->count();

                    if($check_friend_requested > 0) {
                        $result->requested_friendship = true;
                    }
                }

                $result->friends = false;
            }

            $result->avatar = $result->getAvatar();

            $users[] = $result;
        }

        echo json_encode($users);
        die();
    }
}
