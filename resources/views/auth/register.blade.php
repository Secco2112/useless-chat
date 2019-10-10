@include('layouts/header')

    <section class="login common-img-bg">
		<div class="container-fluid">
			<div class="row">
                <div class="col-sm-12">
                    <div class="login-card card-block bg-white">
                        <form class="md-float-material" method="POST" action="{{ route('register') }}">
                            @csrf

                            <div class="text-center">
                                <img src="<?= asset('/images/logo-blue.png') ?>" alt="logo">
                            </div>
                            <h3 class="text-center txt-primary">Create an account </h3>
                                <div class="md-input-wrapper">
                                    <input required autofocus name="name" value="{{ old('name') }}" type="text" class="md-form-control" required="" autocomplete="off">
                                    <label>Username</label>
                                </div>
                                <div class="md-input-wrapper">
                                    <input required name="email" value="{{ old('email') }}" type="email" class="md-form-control" required="" autocomplete="off">
                                    <label>Email Address</label>
                                </div>
                                <div class="md-input-wrapper">
                                    <input required name="password" type="password" class="md-form-control" required="" autocomplete="off">
                                    <label>Password</label>
                                </div>
                                <div class="md-input-wrapper">
                                    <input required name="password_confirmation" type="password" class="md-form-control" required="" autocomplete="off">
                                    <label>Confirm Password</label>
                                </div>

                            <div class="rkmd-checkbox checkbox-rotate checkbox-ripple b-none m-b-20">
                                <label class="input-checkbox checkbox-primary">
                                    <input type="checkbox" id="checkbox">
                                    <span class="checkbox"></span>
                                </label>
                                <div class="captions">Remember Me</div>
                            </div>
                            <div class="col-xs-10 offset-xs-1">
                                <button type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light m-b-20">Sign up</button>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 text-center">
                                    <span class="text-muted">Já tem uma conta?</span>
                                    <a href="/login" class="f-w-600 p-l-5"> Entre Aqui</a>

                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
@include('layouts/footer')