<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class GroupChat extends Model
{
    public function users() {
        $group_users = GroupChatUsers::where("group_id", $this->id)->get();
        $users = [];
        foreach ($group_users as $key => $gu) {
            $users[] = User::find($gu->user_id)->toArray();
        }
        return $users;
    }
}
