@include('layouts/header')

    <body>
        <main class="main-content">
            @include('layouts/chat-menu')
            <div class="right-content edit-profile">
                <div class="edit-profile">
                    <div class="header">
                        <h3>Editar perfil</h3>
                        <div class="form-wrapper">
                            <form id="edit-user-form" action="/profile/edit" method="POST" enctype="multipart/form-data">
                                @csrf
                                <div class="row" style="flex-wrap: initial;">
                                    <div class="form-group avatar">
                                        <img class="profile-avatar" src="<?= $avatar; ?>" />
                                        <div class="custom-file">
                                            <input name="user-avatar" type="file" class="custom-file-input" id="customFile">
                                            <label class="custom-file-label" for="customFile">Escolha uma imagem para o avatar...</label>
                                        </div>
                                        <a href="/profile/restore-avatar">Restaurar</a>
                                    </div>
                                    <div class="form-group">
                                        <label>Nome de usuário: </label>
                                        <input name="username" value="<?= $user->name; ?>" class="form-control" />
                                    </div>
                                </div>
                                <div class="row delete-messages">
                                    <span>Esta configuração define se o usuário deseja que suas mensagens sejam excluídas após um tempo especificado. O tempo em dias ou horas é definido abaixo:</span>
                                    <?php
                                        $accept_delete = ($user->accept_delete == 1? true: false);
                                        $delete_time = $user->delete_time;
                                        $delete_type = $user->delete_type;
                                    ?>
                                    
                                    <div class="form-check">
                                        <input <?= $accept_delete? "checked": ""; ?> type="checkbox" id="accept-delete" name="accept-delete" value="<?= $user->accept_delete; ?>" class="form-check-input" />
                                        <label for="accept-delete">Desejo deletar minhas mensagens</label>
                                    </div>
                                    <div class="form-group">
                                        <div class="wrapper col-md-6">
                                            <label>Tempo para deletar: </label>
                                            <input <?= $accept_delete? "": "disabled"; ?> type="number" name="time-to-delete" value="<?= $delete_time; ?>" class="form-control<?= $accept_delete? "": " disabled" ?>" />
                                            <select <?= $accept_delete? "": "disabled"; ?> class="form-control" name="delete-type">
                                                <option <?= $delete_type == "minutes"? "selected": ""; ?> value="minutes">Minutos</option>
                                                <option <?= $delete_type == "" || $delete_type == "hours"? "selected": ""; ?> value="hours">Horas</option>
                                                <option <?= $delete_type == "days"? "selected": ""; ?> value="days">Dias</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row button">
                                    <button class="btn btn-success">Salvar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

@include('layouts/footer')