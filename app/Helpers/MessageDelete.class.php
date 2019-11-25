<?php

    use \App\User;
    use \App\PrivateMessage;
    use \App\GroupChatMessages;

    class MessageDelete {

        private $user_id;
        private $delete_time;
        private $delete_type;

        public function __construct() {}

        public function setUserID($uid) {
            $this->user_id = $uid;
            return $this;
        }

        public function getUserID() {
            return $this->user_id;
        }

        public function setDeleteTime($delete_time) {
            $this->delete_time = $delete_time;
            return $this;
        }

        public function getDeleteTime() {
            return $this->delete_time;
        }

        public function setDeleteType($delete_type) {
            $this->delete_time = $delete_type;
            return $this;
        }

        public function getDeleteType() {
            return $this->delete_type;
        }

        public function init() {
            $users = User::all();
            
            foreach ($users as $key => $user) {
                if($user->accept_delete) {
                    $delete_time = $user->delete_time;
                    $delete_type = $user->delete_type;
                    $valid = true;

                    if($delete_time == 0) {
                        $valid = false;
                    } else if($delete_time == 1) {
                        if($delete_type == "hours") {
                            $delete_type = "hour";
                        } else if($delete_type == "days") {
                            $delete_type = "day";
                        } else if ($delete_type == "minutes") {
                            $delete_type = "minute";
                        }
                    }

                    $string_modify = "-{$delete_time} {$delete_type}";

                    if($valid) {
                        $date_to_compare = DateTime::createFromFormat("Y-m-d H:i:s", date("Y-m-d H:i:s"));
                        $date_to_compare->modify($string_modify);
                        $date = $date_to_compare->format("Y-m-d H:i:s");

                        // Private messages
                        $private_messages = PrivateMessage::where([
                            ["created_at", "<=", $date],
                            ["sender_id", "=", $user->id]
                        ])->get();
                        foreach ($private_messages as $key => $message) {
                            $message->deleted = 1;
                            $message->save();
                        }

                        // Group messages
                        $group_messages = GroupChatMessages::where([
                            ["created_at", "<", $date],
                            ["user_id", "=", $user->id]
                        ])->get();

                        foreach ($group_messages as $key => $message) {
                            $message->deleted = 1;
                            $message->save();
                        }
                    }
                    
                }
            }
        }

    }