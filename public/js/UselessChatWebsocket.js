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

            if(data.type == "connect") {
                self.clients.push({
                    socketId: data.id,
                    chatId: chatId
                });
            } else if(data.type == "message") {
                self.messages.push({
                    message: data.message,
                    socketId: data.from_id
                });
            }

            console.log(self.clients);
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
}