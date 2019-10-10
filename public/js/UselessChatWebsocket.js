class UselessChatWebsocket{
    constructor(host="localhost", port="8081") {
        this.messages = [];
        this.ws = new WebSocket("ws://" + host + ":" + port);
    }

    start() {
        var self = this;

        this.ws.onopen = function() {
            console.log('Conectado');
        };
        this.ws.onerror = function() {
            console.log('Não foi possível conectar-se ao servidor');
        };
        this.ws.onmessage = function(e) {
            self.messages.push(e.data);
            console.log(self.messages);
        };
    }

    sendMessage(message) {
        if (this.ws.readyState !== this.ws.OPEN) {
            console.log('Problemas na conexão. Tentando reconectar...');
            this.connect(function() {
                this.sendMessage();
            });
            return;
        }

        this.ws.send(message);
    }

    getMessages() {
        return this.messages;
    }
}