<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use \App\GroupChat;
use \App\GroupChatMessages;
use MessageDelete;

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

        $receivers = [];
        $users = GroupChat::find($id)->users();
        $receivers = array_map(function($u) {
            return $u["id"];
        }, $users);

        $group_name = "";
        foreach ($users as $key => $user) {
            if(count($users) - 1 == $key) $group_name .= " e " . $user["name"];
            else if($key == 0) $group_name .= $user["name"];
            else $group_name .= ", " . $user["name"];
        }

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
}
