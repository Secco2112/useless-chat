'use strict';


class UselessChatWebsocket{
    constructor(host="localhost", port="8081") {
        this.messages = [];
        this.clients = [];
        this.ws = new WebSocket("ws://" + host + ":" + port);
    }

    start() {
        var self = this;

        this.ws.onopen = function() {
            
        };
        this.ws.onerror = function() {
            
        };
        this.ws.onmessage = function(e) {
            var chatId = $("meta[name=current_user_id]").attr("content");
            var data = JSON.parse(e.data);
            
            if(data.type == "first_connection") {
                var client = self.findClientBy("socketId", data.id);
                if(client == false) {
                    self.clients.push({
                        chatId: parseInt(chatId),
                        socketId: parseInt(data.id)
                    });

                    client = {
                        chatId: parseInt(chatId),
                        socketId: parseInt(data.id)
                    };
                }
                var name = $("meta[name=current_username]").attr("content"),
                    email = $("meta[name=current_user_mail]").attr("content"),
                    image = $("meta[name=current_user_photo]").attr("content");

                client.type = "first_connection_client_info";
                client.name = name;
                client.email = email;
                client.image = image;

                // Envia info do cliente atual para o servidor socket
                self.sendMessage(JSON.stringify(client));
            }

            else if(data.type == "receive_message") {
                if(data.scope == "private") {
                    var id = $("meta[name=receiver_id]").attr("content");
                    appendMessage(id, data.sender, data.message);
                }
            }
        };
    }

    sendMessage(message) {
        if (this.ws.readyState !== this.ws.OPEN) {
            this.start();
            this.sendMessage(message);
            return;
        }

        this.ws.send(message);
    }

    getMessages() {
        return this.messages;
    }

    getClients() {
        return this.clients;
    }

    findClientBy(attr, value) {
        if(this.clients.length > 0) {
            var client = false;
            this.clients.forEach(function(el, i) {
                if(el[attr] == value) {
                    client = el;
                }
            });
            return client;
        }
        return false;
    }
}



var tl = Turbolinks;
tl.start();

$.fn.scroolToBottom = function() {
    $(this).scrollTop($(this)[0].scrollHeight);
}

$(".list-messages").scroolToBottom();

$(document).ready(function() {
    var socket = new UselessChatWebsocket("localhost", "8081");
    socket.start();

    handleServerStarts(socket);
    handlePrivateMessages(socket);
});


function handleServerStarts(socket) {
    setTimeout(function() {
        var page = window.location.href.split("/");
        if(page[3] == "chat") {
            if(page[4] == "private") {
                var sender_id = parseInt($("meta[name=current_user_id]").attr("content")),
                    receiver_id = parseInt($("meta[name=receiver_id]").attr("content"));

                var sender_client = socket.findClientBy("chatId", sender_id),
                    receiver_client = socket.findClientBy("chatId", receiver_id);
                
                var body = {
                    type: "clients_sets",
                    scope: "private",
                    sender_chat_id: sender_id,
                    sender_socket_id: sender_client.socketId,
                    receiver_chat_id: receiver_id
                };

                socket.sendMessage(JSON.stringify(body));
            }
        }
    }, 500);
}


function handlePrivateMessages(socket) {
    var userInfo = null,
        current_user_id = parseInt($("meta[name=current_user_id]").attr("content")),
        receiver_id = parseInt($("meta[name=receiver_id]").attr("content"));
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

            var sender = socket.findClientBy("chatId", current_user_id);

            var body = {
                type: "message",
                scope: "private",
                sender_chat_id: current_user_id,
                sender_socket_id: sender.socketId,
                receiver_id: receiver_id,
                message: message
            };

            socket.sendMessage(JSON.stringify(body));

            appendMessage(current_user_id, userInfo, message);

            $.ajax({
                url: "/chat/private/save",
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



function appendMessage(current_user_id, sender, message) {
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
                        html += "<img src='" + sender.image + "' />";
                    html += "</div>";
                    html += "<h2 class='meta-info'>";
                        html += "<span id='username'>" + sender.name + "</span>";
                        html += "<time>" + date + "</time>";
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
}