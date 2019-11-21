<div class="left-content">
    <div class="content">
        <div class="user-header">
            <div class="wrapper">
                <img src="<?= "https://www.gravatar.com/avatar/" . md5(strtolower(Auth::user()->email)); ?>" />
                <span class="username"><?= Auth::user()->name; ?></span>
                <i class="fa fa-chevron-down"></i>
            </div>
            <ul class="user-menu">
                <li>
                    <a href="/profile/edit">Editar perfil</a>
                </li>
                <li>
                    <a href="/profile/friends">Lista de amigos</a>
                </li>
                <li class="separator"></li>
                <li>
                    <a href="/logout">Sair</a>
                </li>
            </ul>
        </div>

        <?php
            $user_id = Auth::user()->id;
            $user = App\User::find($user_id);
            $recently_groups = $user->recentlyGroups();

            if(count($recently_groups) > 0) { ?>
                <div class="groups-wrapper">
                    <h3>Grupos ativos</h3>
                    <ul class="list-groups">
                        <?php foreach ($recently_groups as $key => $group) { ?>
                            <li>
                                <a href="/chat/group/<?= $group["id"]; ?>">
                                    <img src="" />
                                    <span><?= $group["name"]; ?></span>
                                </a>
                            </li>
                        <?php } ?>
                    </ul>
                </div>
            <?php }
        ?>
        

        <?php
            $user_id = Auth::user()->id;
            $user = App\User::find($user_id);
            $recently_chats = $user->recentlyChats();
            if(count($recently_chats) > 0) { ?>
                <div class="private-wrapper">
                    <h3>Conversas recentes</h3>
                    <ul class="list-private-chat">
                        <?php foreach ($recently_chats as $key => $rc) { ?>
                            <li data-user-id="<?= $rc->id; ?>">
                                <a href="/chat/private/<?= ChatCodify::crypt($rc->id); ?>">
                                    <img src="<?= "https://www.gravatar.com/avatar/" . md5(strtolower($rc->email)); ?>" />
                                    <span><?= $rc->name; ?></span>
                                </a>
                                <?php
                                    if($user->isFriendOf($rc->id)) { ?>
                                        <i class="fa fa-user friendship"></i>
                                    <?php }
                                ?>
                            </li>
                        <?php } ?>
                    </ul>
                </div>
            <?php }
        ?>
    </div>
</div>