<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Useless Chat</title>
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
        <meta name="description" content="Phoenixcoded">
        <meta name="keywords" content=", Responsive, Landing, Bootstrap, App, Template, Mobile, iOS, Android, apple, creative app">
        <meta name="author" content="Phoenixcoded">
        <link rel="shortcut icon" href="<?= asset('/images/favicon.png'); ?>" type="image/x-icon">
        <link rel="icon" href="<?= asset('/images/favicon.ico'); ?>" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
        <link href="<?= asset('/css/font-awesome.min.css'); ?>" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="<?= asset('/icon/icofont/css/icofont.css'); ?>">
        <link rel="stylesheet" type="text/css" href="<?= asset('/plugins/bootstrap/css/bootstrap.min.css'); ?>">
        <link rel="stylesheet" type="text/css" href="<?= asset('/css/main.css'); ?>">
        <link rel="stylesheet" type="text/css" href="<?= asset('/css/responsive.css'); ?>">
        <link rel="stylesheet" type="text/css" href="<?= asset('/css/color/color-1.min.css'); ?>" id="color"/>
        <?php
            if(\Auth::check()) { ?>
                <meta name="current_user_id" content="<?= Auth::user()->id; ?>">
            <?php }
        ?>

    </head>
    <body>