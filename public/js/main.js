'use strict';

var tl = Turbolinks;
tl.start();

$.fn.scroolToBottom = function() {
    $(this).scrollTop($(this)[0].scrollHeight);
}

$(".list-messages").scroolToBottom();

$(document).ready(function() {
    handleMessages();
});


var socket = new UselessChatWebsocket("localhost", "8081");
socket.start();


function handleMessages() {
    var userInfo = null,
        current_user_id = $("meta[name=current_user_id]").attr("content");
    $.ajax({
        url: '/user/info',
        type: 'POST',
        dataType: 'json',
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        data: ({
            user_id: current_user_id
        }),
        success: function(data) {
            userInfo = data;
        }
    });

    $('textarea.input-message').keypress(function(e) {
        if(e.keyCode == 13) {
            e.preventDefault();

            var message = $(this).val();
            $(this).val("");

            socket.sendMessage(message);

            var handle = window.location.href.split("/"),
                receiver_id = handle[handle.length-1];


            var last_message_box_sender_id = $(".list-messages .message-container").last().data("sender-id");
            if(last_message_box_sender_id == current_user_id) {
                var html = "<div>";
                        html += "<div class='content'>";
                            html += "<div class='wrapper'>";
                                html += "<div class='markup'>" + message + "</div>";
                            html += "</div>";
                        html += "</div>";
                    html += "</div>";

                $(html).insertAfter($(".list-messages .message-container > div").last());

                $(".list-messages").scroolToBottom();
            } else {
                var today = new Date();
                var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();

                var html = "<div class='message-container' data-sender-id='" + current_user_id + "'>";
                    html += "<div>";
                        html += "<div class='header'>";
                            html += "<div class='avatar'>";
                                html += "<img src='" + userInfo.image + "' />";
                            html += "</div>";
                            html += "<h2 class='meta-info'>";
                                html += "<span id='username'>" + userInfo.name + "</span>";
                                html += "<time></time>";
                            html += "</h2>";
                        html += "</div>";
                        html += "<div class='content'>";
                            html += "<div class='wrapper'>";
                                html += "<div class='markup'>" + message + "</div>";
                            html += "</div>";
                        html += "</div>";
                    html += "</div>";
                html += "</div>";

                $(html).insertAfter($(".list-messages .message-container").last());

                $(".list-messages").scroolToBottom();
            }


            $.ajax({
                url: "/chat/private_save",
                type: "POST",
                dataType: "json",
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                data: ({
                    sender: current_user_id,
                    receiver: receiver_id,
                    message: message
                })
            });

            return false;
        }
    });
}