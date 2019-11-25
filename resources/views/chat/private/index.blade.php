@include('layouts/header')

    <body>
        <meta name="receiver_id" content="<?= $receiver->id; ?>">

        <main class="main-content">
            @include('layouts/chat-menu')
            <div class="right-content">
                <div class="chat-content">
                    <div class="header">
                        <div class="info">
                            <span id="at">@</span>
                            <span id="username"><?= $receiver->name; ?></span>
                            <span id="status"></span>
                        </div>
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
                                                        <img src="<?= \App\User::find($group[0]->sender_id)->getAvatar(); ?>" />
                                                    </div>
                                                    <h2 class="meta-info">
                                                        <span id="username"><?= $group[0]->sender()->name; ?></span>
                                                        <time><?= DateTime::createFromFormat("Y-m-d H:i:s", $group[0]->created_at)->format("d/m/Y"); ?></time>
                                                    </h2>
                                                </div>
                                                <div class="content">
                                                    <div class="wrapper">
                                                    <div class="markup<?= $group[0]->deleted? " deleted": ""; ?>"><?= ($group[0]->deleted? "Mensagem apagada": $group[0]->content); ?></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <?php for($i=1; $i<count($group); $i++) { ?>
                                                <div>
                                                    <div class="content">
                                                        <div class="wrapper">
                                                        <div class="markup<?= $group[$i]->deleted? " deleted": ""; ?>"><?= ($group[$i]->deleted? "Mensagem apagada": $group[$i]->content); ?></div>
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
                                    <textarea class="input-message private-message" rows="1" placeholder="Conversar com @<?= $receiver->name; ?>" autocorrect="off"></textarea>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="modal fade" id="user-modal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <div>@<span id="username"></span></div>
                    </div>
                    <div class="modal-body">
                        <div class="content">
                            <img id="user-avatar" />
                            <div class="user-info">
                                <div class="common-groups"></div>
                                <div class="friends-info"></div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    </div>
                </div>
            </div>
        </div>

    </body>

@include('layouts/footer')