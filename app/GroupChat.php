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

    public function name($limit=null) {
        $users = $this->users();
        $name = "";
        foreach ($users as $key => $user) {
            if(count($users) - 1 == $key) {
                if(count($users) == 1) $name .= $user["name"];
                else $name .= " e " . $user["name"]; 
            }
            else if($key == 0) $name .= $user["name"];
            else $name .= ", " . $user["name"];
        }
        if($limit) {
            if(strlen($name) <= $limit) {
                return $name;
            } else {
                $y=substr($name, 0, $limit) . '...';
                return $y;
            }
        }
        return $name;
    }
}
