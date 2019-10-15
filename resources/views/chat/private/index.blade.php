@include('layouts/header')

    <body>
        <main class="main-content">
            <div class="left-content">
                
            </div>
            <div class="right-content">
                <div class="chat-content">
                    <div class="header">
                        <span id="at">@</span>
                        <span id="username"><?= $receiver->name; ?></span>
                        <span id="status"></span>
                    </div>
                    <div class="chat-messages">
                        <div class="top">
                            <ul class="list-messages">
                                <?php
                                    foreach($messages as $i => $group) { ?>
                                        <div class='message-container' data-sender-id="<?= $group[0]->sender_id; ?>">
                                            <div>
                                                <div class='header'>
                                                    <div class="avatar">
                                                        <img src="<?= "https://www.gravatar.com/avatar/" . md5(strtolower(trim($group[0]->sender()->email))) . "?s=200"; ?>" />
                                                    </div>
                                                    <h2 class="meta-info">
                                                        <span id="username"><?= $group[0]->sender()->name; ?></span>
                                                        <time><?= DateTime::createFromFormat("Y-m-d H:i:s", $group[0]->created_at)->format("d/m/Y"); ?></time>
                                                    </h2>
                                                </div>
                                                <div class="content">
                                                    <div class="wrapper">
                                                        <div class="markup"><?= $group[0]->content; ?></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <?php for($i=1; $i<count($group); $i++) { ?>
                                                <div>
                                                    <div class="content">
                                                        <div class="wrapper">
                                                            <div class="markup"><?= $group[$i]->content; ?></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php } ?>
                                            <hr class='divider' />
                                        </div>
                                    <?php }
                                ?>
                            </ul>
                        </div>
                        <div class="bottom">
                            <form class="form-send-message" action="" method="post">
                                <div class="wrapper">
                                    <textarea class="input-message" rows="1" placeholder="Conversar com @<?= $receiver->name; ?>" autocorrect="off"></textarea>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

@include('layouts/footer')