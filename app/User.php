<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Auth;

class User extends Authenticatable
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];


    public function recentlyGroups() {
        $groups = GroupChat::select("group_chats.id")->join("group_chat_users", "group_chat_users.group_id", "=", "group_chats.id")->whereIn("group_chat_users.user_id", [$this->id])->get();
        
        $handle = [];
        foreach ($groups as $key => $group) {
            $group_id = $group->id;
            $group_users = GroupChatUsers::where("group_id", $group_id)->get()->toArray();
            $users = [];
            foreach ($group_users as $key => $group_user) {
                $users[] = User::find($group_user["user_id"])->toArray();
            }
            
            $group_name = $group->name(25);

            $g = $group->toArray();
            $g["name"] = $group_name;
            
            $handle[] = $g;
        }

        return $handle;
    }


    public function recentlyChats() {
        $messages = PrivateMessage::where("sender_id", "=", $this->id)->orWhere("receiver_id", "=", $this->id)->orderBy("created_at", "DESC")->get();

        $handle = [];
        foreach ($messages as $key => $message) {
            $handle[$message->sender_id . "_" . $message->receiver_id] = $message->toArray();
        }
        
        $users_ids = [];
        foreach ($handle as $key => $value) {
            $users_ids[] = $value["sender_id"];
            $users_ids[] = $value["receiver_id"];
        }

        $users_ids = array_filter($users_ids, function($u) {
            return $u != $this->id;
        });
        $users_ids = array_values(array_unique($users_ids));

        $users = [];
        foreach ($users_ids as $key => $id) {
            $user = User::find($id);
            if($user) {
                $users[] = $user;
            }
        }

        return $users;
    }


    public function isFriendOf($user_id) {
        $a = [$this->id, $user_id];
        sort($a);
        
        $check = Friendship::where([
            ["user_id_1", "=", $a[0]],
            ["user_id_2", "=", $a[1]]
        ])->count();

        return $check > 0;
    }


    public function getAvatar() {
        $user = \App\User::find($this->id);
        $avatar = "https://www.gravatar.com/avatar/" . md5(strtolower($user->email));
        $handle = ProfileAvatar::where("user_id", $this->id)->get();
        if($handle->count() > 0) {
            $avatar = \Storage::url($handle[0]->path);
        }

        return $avatar;
    }
}
