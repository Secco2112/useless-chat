<!DOCTYPE html>
<html lang="en">
    <head>
        <title>URI Chat</title>
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->


        <!-- Meta -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <link rel="shortcut icon" href="<?= asset('/images/favicon.png'); ?>" type="image/x-icon" data-turbolinks-track="true">
        <link rel="icon" href="<?= asset('/images/favicon.ico'); ?>" type="image/x-icon" data-turbolinks-track="true">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet" data-turbolinks-track="true">
        <link href="<?= asset('/css/font-awesome.min.css'); ?>" rel="stylesheet" type="text/css" data-turbolinks-track="true">
        <link rel="stylesheet" type="text/css" href="<?= asset('/icon/icofont/css/icofont.css'); ?>" data-turbolinks-track="true">
        <link rel="stylesheet" type="text/css" href="<?= asset('/plugins/bootstrap/css/bootstrap.min.css'); ?>" data-turbolinks-track="true">
        <link rel="stylesheet" type="text/css" href="<?= asset('/css/main.css'); ?>" data-turbolinks-track="true">
        <link rel="stylesheet" type="text/css" href="<?= asset('/css/responsive.css'); ?>" data-turbolinks-track="true">
        <link rel="stylesheet" type="text/css" href="<?= asset('/css/color/color-1.min.css'); ?>" id="color" data-turbolinks-track="true"/>

        <meta name="csrf-token" content="{{ csrf_token() }}" />

        <?php
            if(\Auth::check()) { ?>
                <meta name="current_user_id" content="<?= Auth::user()->id; ?>">
                <meta name="current_username" content="<?= Auth::user()->name; ?>">
                <meta name="current_user_mail" content="<?= Auth::user()->email; ?>">
                <meta name="current_user_photo" content="<?= "https://www.gravatar.com/avatar/" . md5(strtolower(Auth::user()->email)); ?>">
            <?php }
        ?>

    </head>
    <body>