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
                } else if(data.scope == "group") {
                    appendMessage(data.sender.chatId, data.sender, data.message);
                }
            }

            else if(data.type == "friend_request") {
                var request_user = data.request_user,
                    user_to_add = data.user_to_add;

                iziToast.show({
                    theme: 'dark',
                    icon: 'icon-person',
                    timeout: false,
                    title: 'Pedido de amizade',
                    message: '<strong style="font-weight: bold;">' + request_user.name + '</strong> lhe enviou uma solicitação de amizade!',
                    position: 'bottomRight',
                    progressBar: false,
                    progressBarColor: 'rgb(0, 255, 184)',
                    displayMode: 2,
                    buttons: [
                        ['<button>Aceitar</button>', function (instance, toast) {
                            $.ajax({
                                url: '/user/accept_friendship_request',
                                type: 'POST',
                                dataType: 'json',
                                headers: {
                                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                },
                                data: ({
                                    request_user: request_user.chatId,
                                    user_to_add: user_to_add.chatId
                                }),
                                success: function(data) {
                                    instance.hide({
                                        transitionOut: 'fadeOutUp'
                                    }, toast);

                                    // Envia ao usuário que enviou a solicitação via socket
                                    var body = {
                                        type: "accept_friend_request",
                                        request_user: request_user.chatId,
                                        user_to_add: user_to_add.chatId
                                    };

                                    self.sendMessage(JSON.stringify(body));
                                }
                            });
                        }],
                        ['<button>Recusar</button>', function (instance, toast) {
                            $.ajax({
                                url: '/user/reject_friend_request',
                                type: 'POST',
                                dataType: 'json',
                                headers: {
                                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                },
                                data: ({
                                    request_user: request_user.chatId,
                                    user_to_add: user_to_add.chatId
                                }),
                                success: function(data) {
                                    instance.hide({
                                        transitionOut: 'fadeOutUp'
                                    }, toast);

                                    // Envia ao usuário que enviou a solicitação via socket
                                    var body = {
                                        type: "reject_friend_request",
                                        request_user: request_user.chatId,
                                        user_to_add: user_to_add.chatId
                                    };

                                    self.sendMessage(JSON.stringify(body));
                                }
                            });
                        }]
                    ]
                });
            } else if(data.type == "accept_friend_request") {
                // Adiciona na lista lateral de amigos
                // Remove o botão de 'Solicitação enviada'
                // Monta tabela na página de amigos

                if($(".list-private-chat").length > 0) {
                    var check_user_to_add = $(".list-private-chat").find("li[data-user-id=" + data.user_to_add.chatId + "]");
                    if($(check_user_to_add).length > 0) {
                        if($(check_user_to_add).find("i").length == 0) {
                            $(check_user_to_add).append('<i class="fa fa-user friendship"></i>');
                        }
                    }

                    var check_request_user = $(".list-private-chat").find("li[data-user-id=" + data.request_user.chatId + "]");
                    if($(check_request_user).length > 0) {
                        if($(check_request_user).find("i").length == 0) {
                            $(check_request_user).append('<i class="fa fa-user friendship"></i>');
                        }
                    }
                }

                var modal_open = $("#user-modal").css("display") == "block";
                if(modal_open) {
                    $("#user-modal").find(".friends-info button").removeAttr("disabled").removeClass("btn-secondary").addClass("remove-friend-panel").addClass("btn-danger").text("Desfazer amizade");
                }
            } else if(data.type == "reject_friend_request") {
                // Remove o botão de 'Solicitação enviada'

                var modal_open = $("#user-modal").css("display") == "block";
                if(modal_open) {
                    $("#user-modal").find(".friends-info button").removeAttr("disabled").removeClass("btn-secondary").addClass("add-friend-panel").addClass("btn-success").text("Adicionar como amigo");
                }
            } else if(data.type == "remove_friend") {
                if($(".list-private-chat").length > 0) {
                    var check_user_to_add = $(".list-private-chat").find("li[data-user-id=" + data.user_to_add.chatId + "]");
                    if($(check_user_to_add).length > 0) {
                        $(check_user_to_add).find("i").remove();
                    }

                    var check_request_user = $(".list-private-chat").find("li[data-user-id=" + data.request_user.chatId + "]");
                    if($(check_request_user).length > 0) {
                        $(check_request_user).find("i").remove()
                    }
                }
            } else if(data.type == "initial_online_status") {
                if(data) {
                    var users = data.users;
                    $.each(users, function(u, status) {
                        if($(".list-private-chat").length > 0) {
                            if(status) {
                                $(document).find(".list-private-chat li[data-user-id=" + (u * 1) + "] i").css("color", "#0bca0b");
                            } else {
                                $(document).find(".list-private-chat li[data-user-id=" + (u * 1) + "] i").css("color", "#ff9898");
                            }
                        }
                    });
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



// var tl = Turbolinks;
// tl.start();

$.fn.scroolToBottom = function() {
    if($(this).length > 0) {
        $(this).scrollTop($(this)[0].scrollHeight);
    }
}

String.prototype.identicon = function() {
    var salt = 0;
    var rounds = 1;
    var size = 90;
    var outputType = "B64";
    var hashtype = "SHA-512";
    var shaObj = new jsSHA(this+salt, "TEXT");
    var options = {
        // foreground: [0, 0, 0, 255],
        background: [255, 255, 255, 0],
        margin: 0,
        size: 90
    };
    var hash = shaObj.getHash(hashtype, outputType, rounds);
    var data = new Identicon(hash, options).toString();
    return "data:image/png;base64," + data;
};



$(".list-messages").scroolToBottom();


var socket = new UselessChatWebsocket("localhost", "8081");
socket.start();

$(document).ready(function() {
    handleServerStarts();
    handlePrivateMessages();
    handleGroupMessages();

    edit_user();
    user_modal_info();

    add_friend();
    remove_friend();

    accept_friend_request();

    check_users_online();

    search_users();


    if($(".list-groups li").length > 0) {
        $(".list-groups li").each(function() {
            var name = $(this).find("a span").text();
            var salt = 0;
            var rounds = 1;
            var size = 90;
            var outputType = "B64";
            var hashtype = "SHA-512";
            var shaObj = new jsSHA(name+salt, "TEXT");
            var options = {
                // foreground: [0, 0, 0, 255],
                background: [255, 255, 255, 0],
                margin: 0,
                size: 90
            };
            var hash = shaObj.getHash(hashtype, outputType, rounds);
            var data = new Identicon(hash, options).toString();
            $(this).find("img").attr("src", "data:image/png;base64," + data);
        });
    }


    $(".edit-profile .custom-file-input").on("change", function() {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);

        var input = this;
        var url = $(this).val();
        var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
        if (input.files && input.files[0]&& (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $(input).closest(".form-group").find("img").attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        } else {
            $('#img').attr('src', '/assets/no_preview.png');
        }
    });
});


function handleServerStarts() {
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
            } else if(page[4] == "group") {
                var group_id = $("meta[name=group_id]").attr("content"),
                    users = $("meta[name=receivers]").attr("content");

                var body = {
                    type: "clients_sets",
                    scope: "group",
                    group_id: group_id,
                    users: users
                }

                socket.sendMessage(JSON.stringify(body));
            }
        }
    }, 500);
}


function handlePrivateMessages() {
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

    $('textarea.input-message.private-message').keypress(function(e) {
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



function handleGroupMessages() {
    var userInfo = null,
        current_user_id = parseInt($("meta[name=current_user_id]").attr("content")),
        group_id = parseInt($("meta[name=group_id]").attr("content"));
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

    $('textarea.input-message.group-message').keypress(function(e) {
        if(e.keyCode == 13) {
            e.preventDefault();

            var message = $(this).val();
            $(this).val("");

            var sender = socket.findClientBy("chatId", current_user_id);

            var body = {
                type: "message",
                scope: "group",
                group_id: group_id,
                sender_chat_id: current_user_id,
                sender_socket_id: sender.socketId,
                message: message
            };

            socket.sendMessage(JSON.stringify(body));

            appendMessage(current_user_id, userInfo, message);

            $.ajax({
                url: "/chat/group/save",
                type: "POST",
                dataType: "json",
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                data: ({
                    sender: current_user_id,
                    group_id: group_id,
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


function edit_user() {
    $("input[name=accept-delete]").on("change", function() {
        var checked = $(this).prop("checked");

        if(checked) {
            $("input[name=time-to-delete]").removeAttr("disabled").removeClass("disabled");
            $("select[name=delete-type]").removeAttr("disabled").removeClass("disabled");

            var delele_time = $("input[name=time-to-delete]").val();
            if(delele_time == "") {
                $("input[name=time-to-delete]").val("7");
            }
        } else {
            $("input[name=time-to-delete]").attr("disabled", "disabled").addClass("disabled");
            $("select[name=delete-type]").attr("disabled", "disabled").addClass("disabled");
        }
    });
}


function user_modal_info(){
    var current_user_id = $("meta[name=current_user_id]").attr("content");

    $(".message-container .header .avatar, .message-container .header .meta-info").on("click", function() {
        var id = $(this).closest(".message-container").data("sender-id");

        if(id != current_user_id) {
            $("#user-modal").modal();

            $.ajax({
                url: '/user/panel_info',
                type: 'POST',
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                data: ({
                    user_id: id
                }),
                success: function(data) {
                    var modal = $("#user-modal");
                    if(data) {
                        $(modal).find(".modal-header #username").text(data.name);
                        $(modal).find(".modal-body #user-avatar").attr("src", data.image);
                        $(".user-info .common-groups").empty();
                        $(".user-info .friends-info").empty();

                        if(data.common_groups != false) {
                            var common_groups = data.common_groups;
                            $.each(common_groups, function(i, el) {
                                el.image = el.name.identicon();
                            });
                            
                            var html = "";
                            $.each(common_groups, function(i, cg) {
                                html += "<div class='group'>";
                                    html += "<img src='" + cg.image + "' />";
                                    html += "<span id='name'>" + cg.name + "</span>"
                                html += "</div>";
                            });

                            $(".user-info .common-groups").append("<h5>Grupos em comum:</h5>");
                            $(".user-info .common-groups").append(html);
                        } else {
                            $(".user-info .common-groups").remove();
                        }

                        if(data.friends) {
                            var info = "<span>Amigos desde " + data.friends_since + "</span>";
                            var button = "<button class='btn btn-danger remove-friend-panel'>Desfazer amizade</button>";
                            $(".user-info .friends-info").append(info);
                            $(".user-info .friends-info").append(button);
                        } else {
                            if(data.request_friendship) {
                                var button = "<button class='btn btn-secondary' disabled>Solicitação de amizade enviada</button>";
                                $(".user-info .friends-info").append(button);
                            } else if(data.requested_friendship) {
                                var button1 = "<button class='btn btn-success accept-friend-request'>Aceitar solicitação</button>";
                                var button2 = "<button class='btn btn-danger reject-friend-request'>Rejeitar solicitação</button>";
                                $(".user-info .friends-info").append(button1);
                                $(".user-info .friends-info").append(button2);
                            } else {
                                var button = "<button class='btn btn-success add-friend-panel'>Adicionar como amigo</button>";
                                $(".user-info .friends-info").append(button);
                            }
                        }

                        $(modal).attr("data-user-id", id);

                        $(modal).modal();
                    }
                }
            });
        }
    });
}


function add_friend() {
    $(document).on("click", ".add-friend-panel", function() {
        var self = this,
            current_user_id = $("meta[name=current_user_id]").attr("content"),
            user_to_add_id = $(this).closest(".modal").data("user-id");
        
        $(self).attr("disabled", "disabled");

        $.ajax({
            url: "/user/request_friendship",
            type: "POST",
            dataType: "json",
            data: ({
                request_user: current_user_id,
                user_to_add: user_to_add_id
            }),
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            success: function(data) {
                if(data) {
                    $(self).text("Solicitação de amizade enviada").removeClass("btn-success").removeClass("add-friend-panel").addClass("btn-secondary");

                    // Envia informação para o outro usuário via socket
                    var body = {
                        type: "friend_request",
                        request_user: current_user_id,
                        user_to_add: user_to_add_id
                    };

                    socket.sendMessage(JSON.stringify(body));
                }
            }
        })
    });

    $(document).on("click", ".add-friend-list", function() {
        var self = this,
            current_user_id = $("meta[name=current_user_id]").attr("content"),
            user_to_add_id = $(this).closest("li").data("user-id");
        
        $(self).attr("disabled", "disabled");

        $.ajax({
            url: "/user/request_friendship",
            type: "POST",
            dataType: "json",
            data: ({
                request_user: current_user_id,
                user_to_add: user_to_add_id
            }),
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            success: function(data) {
                if(data) {
                    $(self).text("Solicitação de amizade enviada").removeClass("btn-success").removeClass("add-friend-panel").addClass("btn-secondary");

                    // Envia informação para o outro usuário via socket
                    var body = {
                        type: "friend_request",
                        request_user: current_user_id,
                        user_to_add: user_to_add_id
                    };

                    socket.sendMessage(JSON.stringify(body));
                }
            }
        })
    });
}


function remove_friend() {
    $(document).on("click", ".remove-friend-panel", function() {
        var self = this,
            current_user_id = $("meta[name=current_user_id]").attr("content"),
            user_to_add_id = $(this).closest(".modal").data("user-id");

        $.ajax({
            url: "/user/remove_friend",
            type: "POST",
            dataType: "json",
            data: ({
                request_user: current_user_id,
                user_to_add: user_to_add_id
            }),
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            success: function(data) {
                if(data) {
                    $(self).text("Adicionar como amigo").removeClass("btn-danger").addClass("btn-success").addClass("add-friend-panel");

                    // Envia informação para o outro usuário via socket
                    var body = {
                        type: "remove_friend",
                        request_user: current_user_id,
                        user_to_add: user_to_add_id
                    };

                    socket.sendMessage(JSON.stringify(body));
                }
            }
        })
    });

    $(document).on("click", ".remove-friend-list", function() {
        var self = this,
            current_user_id = $("meta[name=current_user_id]").attr("content"),
            user_to_add_id = $(this).closest("li").data("user-id");

        $.ajax({
            url: "/user/remove_friend",
            type: "POST",
            dataType: "json",
            data: ({
                request_user: current_user_id,
                user_to_add: user_to_add_id
            }),
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            success: function(data) {
                if(data) {
                    $(self).text("Adicionar como amigo").removeClass("btn-danger").addClass("btn-success").addClass("add-friend-panel");

                    // Envia informação para o outro usuário via socket
                    var body = {
                        type: "remove_friend",
                        request_user: current_user_id,
                        user_to_add: user_to_add_id
                    };

                    socket.sendMessage(JSON.stringify(body));

                    window.location.reload(1);
                }
            }
        })
    });
}


function accept_friend_request() {
    $(document).on("click", ".accept-friend-request", function() {
        var self = this,
            current_user_id = $("meta[name=current_user_id]").attr("content"),
            user_to_accept = $(this).closest("li").data("user-id");

            $.ajax({
                url: '/user/accept_friendship_request',
                type: 'POST',
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                data: ({
                    request_user: user_to_accept,
                    user_to_add: current_user_id
                }),
                success: function(data) {
                    // Envia ao usuário que enviou a solicitação via socket
                    var body = {
                        type: "accept_friend_request",
                        request_user: user_to_accept,
                        user_to_add: current_user_id
                    };

                    socket.sendMessage(JSON.stringify(body));

                    window.location.reload(1);
                }
            });
    });
}


function check_users_online() {
    setInterval(function() {
        var current_user_id = $("meta[name=current_user_id]").attr("content");
        var friends_list = $(document).find(".list-private-chat li");

        if($(friends_list).length > 0) {
            var users_id = [];
            friends_list.map(function(i, user) {
                users_id.push($(user).data("user-id"));
            });

            var body = {
                type: "initial_online_status",
                users: users_id
            };

            body["request_user"] = current_user_id;

            socket.sendMessage(JSON.stringify(body));
        }
    }, 5000);
}


function search_users() {
    $("form#users-search").on("submit", function(e) {
        e.preventDefault();

        var self = this,
            value = $(this).find("input[name=user-name-input]").val().trim();

        if(value.length > 0) {
            $.ajax({
                url: '/user/search',
                type: 'POST',
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                data: ({
                    query: value
                }),
                beforeSend: function() {
                    $(".list-users-result .list-users").removeClass("show");
                },
                success: function(data) {
                    var list = $(".list-users-result .list-users");

                    $(list).empty();

                    if(data.length > 0) {
                        $.each(data, function(i, user) {
                            var html = "<li data-user-id='" + user.id + "'>";
                                    html += "<div class='info'>";
                                        html += "<img src='" + user.avatar + "' />";
                                        html += "<span>" + user.name + "</span>";
                                    html += "</div>";
                                    html += "<div class='options'>";
                                        if(user.friends) {
                                            html += "<span>Este usuário já é seu amigo</span>";
                                        } else if(user.request_friendship) {
                                            html += "<button disabled class='btn btn-secondary'>Solicitação de amizade enviada</button>";
                                        } else if(user.requested_friendship) {
                                            html += "<button class='btn btn-success accept-friend-request'>Aceitar</button>";
                                            html += "<button style='margin-left: 7px;' class='btn btn-danger reject-friend-request'>Recusar</button>";
                                        } else {
                                            html += "<button class='btn btn-success add-friend-list'>Adicionar como amigo</button>";
                                        }
                                    html += "</div>";
                                html += "</li>";


                            $(list).append(html);
                        });
                    } else {

                    }

                    $(list).addClass("show");
                }
            });
        }
    });
}