@include('layouts/header')

    <body>
        <main class="main-content">
            @include('layouts/chat-menu')
            <div class="right-content profile-friends">
                <div class="profile-friends">
                    <div class="header">
                        <h3>Amigos</h3>
                        <div class="list-friends">
                            <div class="search-users">
                                <form id="users-search" action="" method="POST">
                                    <div class="form-group">
                                        <label>Busque pelo nome do usuário que deseja adicionar</label>
                                        <input type="text" class="form-control" name="user-name-input" placeholder="Digite o nome do usuário" />
                                    </div>
                                </form>
                                <div class="list-users-result">
                                    <ul class="list-users"></ul>
                                </div>
                            </div>
                            <?php
                                if(count($users_request) > 0) { ?>
                                    <div class="requested-friendship">
                                        <h5 class="title">Solicitações de amizade</h5>
                                        <ul class="list-requests">
                                            <?php foreach ($users_request as $key => $user) { ?>
                                                <li data-user-id="<?= $user->id ?>">
                                                    <div class="info">
                                                        <img src="<?= $user->getAvatar(); ?>" />
                                                        <span><?= $user->name; ?></span>
                                                    </div>
                                                    <div class="options">
                                                        <button title="Aceitar solicitação" class="btn btn-success accept-friend-request"><i class="fa fa-check"></i></button>
                                                        <button title="Recusar solicitação" class="btn btn-danger reject-friend-request"><i class="fa fa-times"></i></button>
                                                    </div>
                                                </li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                <?php }
                            ?>
                            <?php
                                if(count($users_friend) > 0) { ?>
                                    <div class="list-friendship" style="<?= count($users_request) > 0? "border-top: 1px solid #e0e0e0; margin-top: 40px; padding-top: 40px;": ""; ?>">
                                        <h5 class="title">Lista de amigos</h5>
                                        <ul class="list-friendships">
                                            <?php foreach ($users_friend as $key => $user) { ?>
                                                <li data-user-id="<?= $user->id ?>">
                                                    <a href="/chat/private/<?= ChatCodify::crypt($user->id); ?>" class="info">
                                                        <img src="<?= $user->getAvatar(); ?>" />
                                                        <span><?= $user->name; ?></span>
                                                    </a>
                                                    <div class="options">
                                                        <button title="Remover amigo" class="btn btn-danger remove-friend-list"><i class="fa fa-times"></i></button>
                                                    </div>
                                                </li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                <?php } else {
                                    echo "<div>Nenhum amigo encontrado</div>";
                                }
                            ?>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

@include('layouts/footer')