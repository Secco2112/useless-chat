'use strict';

$(document).ready(function() {
    handleMessages();
});


var socket = new UselessChatWebsocket("localhost", "8081");
socket.start();


function handleMessages() {
    $('textarea.input-message').keypress(function(e){
        if(e.keyCode == 13) {
            e.preventDefault();

            var message = $(this).val();

            socket.sendMessage(message);

            return false;
        }
    });
}