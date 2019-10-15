<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use ChatCodify;
use Auth;
use \App\PrivateMessage;

class ChatController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id)
    {
        $user_id = Auth::user()->id;
        $other_user_id = ChatCodify::decrypt($id);

        if($user_id == $other_user_id) {
            return redirect('/');
        }

        $sender = \App\User::find($user_id);
        $receiver = \App\User::find($other_user_id);
        
        $data = new PrivateMessage();
        $data = $data->where(function($query) use ($user_id, $other_user_id) {
            $query->where('sender_id', '=', $user_id);
            $query->where('receiver_id', '=', $other_user_id);
        })->orWhere(function($query) use ($user_id, $other_user_id) {
            $query->where('sender_id', '=', $other_user_id);
            $query->where('receiver_id', '=', $user_id);
        })->orderBy("created_at", "ASC")->get();


        $messages = [];
        $i = 0;
        $it = 0;
        while($i < count($data)) {
            $f = false;
            $messages[$it][] = $data[$i];

            while($i < count($data) - 1 && $data[$i]->sender_id == $data[$i+1]->sender_id) {
                $messages[$it][] = $data[$i+1];
                $i++;
                $f = true;
            }

            $i++;
            #if(!$f) $i++;
            $it++;
        }
        

        $data = [
            "sender" => $sender,
            "receiver" => $receiver,
            "messages" => $messages
        ];

        return view('chat.private.index')->with($data);
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

    public function private_save() {
        if(!empty($_POST)) {
            $sender_id = $_POST["sender"];
            $receiver_id = $_POST["receiver"];
            $message = $_POST["message"];

            $data = new PrivateMessage();
            $data->sender_id = $sender_id;
            $data->receiver_id = ChatCodify::decrypt($receiver_id);
            $data->content = $message;
            $data->save();

            die();
        }
    }
}
