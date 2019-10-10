@include('layouts/header')

    <body>
        <main class="main-content">
            <div class="left-content">
                
            </div>
            <div class="right-content">
                <div class="chat-content">
                    <div class="header">
                        <span id="at">@</span>
                        <span id="username">FreakStory</span>
                        <span id="status"></span>
                    </div>
                    <div class="chat-messages">
                        <div class="top">
                            <ul class="list-messages">

                            </ul>
                        </div>
                        <div class="bottom">
                            <form class="form-send-message" action="" method="post">
                                <div class="wrapper">
                                    <textarea class="input-message" rows="1" placeholder="Conversar com @FreakStory" autocorrect="off"></textarea>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

@include('layouts/footer')