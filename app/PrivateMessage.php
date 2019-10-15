<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PrivateMessage extends Model
{
    public function sender() {
        return User::find($this->sender_id);
    }

    public function receiver() {
        return User::find($this->receiver_id);
    }
}
