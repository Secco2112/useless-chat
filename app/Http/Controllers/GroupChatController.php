<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use \App\GroupChat;
use \App\GroupChatMessages;
use \App\GroupChatUsers;
use MessageDelete;
use Auth;
use \App\User;

class GroupChatController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id)
    {
        // Delete user messages
        $delete_handler = new MessageDelete();
        $delete_handler->init();

        // Verifica se o grupo está disponível
        $check = GroupChatUsers::where([
            ["group_id", "=", $id],
            ["user_id", "=", Auth::user()->id]
        ])->count();

        if($check == 0) {
            abort(404,'Page not found.');
        }

        $receivers = [];
        $users = GroupChat::find($id)->users();
        foreach ($users as $key => $user) {
            $receivers[] = $user["id"];
        }

        $group_name = GroupChat::find($id)->name();

        $data = GroupChatMessages::where("group_id", $id)->orderBy("created_at", "ASC")->get();

        $messages = [];
        $i = 0;
        $it = 0;
        while($i < count($data)) {
            $f = false;
            $messages[$it][] = $data[$i];

            while($i < count($data) - 1 && $data[$i]->user_id == $data[$i+1]->user_id) {
                $messages[$it][] = $data[$i+1];
                $i++;
                $f = true;
            }

            $i++;
            $it++;
        }

        foreach ($messages as $i => $group) {
            foreach ($group as $j => &$message) {
                $user = \App\User::find($message->user_id);
                $message->username = $user->name;
                $message->email = $user->email;
            }
        }

        $data = [
            "group_id" => $id,
            "receivers" => $receivers,
            "messages" => $messages,
            "group_name" => $group_name
        ];
        return view('chat.group.index')->with($data);
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
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
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

    public function save() {
        $sender = $_POST["sender"];
        $group_id = $_POST["group_id"];
        $message = $_POST["message"];

        $data = new GroupChatMessages();
        $data->group_id = $group_id;
        $data->user_id = $sender;
        $data->content = $message;
        $data->save();

        die();
    }

    public function search() {
        $query = $_POST["query"];
        $group_id = $_POST["group_id"];

        $current_user = Auth::user();

        $results = \App\User::where("name", "like", "%" . $query . "%")->where("id", "!=", Auth::user()->id)->get();

        $users = [];
        foreach ($results as $key => $result) {
            if($current_user->isFriendOf($result->id)) {
                $user = [];
                $user["id"] = $result->id;
                $user["name"] = $result->name;
                $user["avatar"] = $result->getAvatar();

                $data = GroupChatUsers::where([
                    ["group_id", "=", $group_id],
                    ["user_id", "=", $result->id]
                ])->count();

                $user["in_group"] = $data > 0;

                $users[] = $user;
            }
        }

        return $users;
    }

    public function add_user() {
        $user_id = $_POST["id"];
        $group_id = $_POST["group_id"];

        $add = new GroupChatUsers();
        $add->group_id = $group_id;
        $add->user_id = $user_id;
        $add->save();

        $group_name = GroupChat::find($group_id)->name();

        echo json_encode(array("name" => $group_name));
        die();
    }
}
