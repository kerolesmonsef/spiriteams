<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">


    <link rel="icon" type="image/png" sizes="16x16" href="{{ $setting->favicon_url }}">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="{{ $setting->favicon_url }}">
    <meta name="theme-color" content="#ffffff">

    <title>{{ $setting->company_name }}</title>

    <link href="{{ asset('plugins/bootstrap/dist/css/bootstrap.min.css') }}" rel="stylesheet">
    <link href="{{ asset('less/icons/font-awesome/css/font-awesome.css') }}" rel="stylesheet">
    <link href="{{ asset('css/auth.css') }}" rel="stylesheet">
    <script>
        window.Laravel = {!! json_encode([
            'csrfToken' => csrf_token(),
        ]) !!};
    </script>
    @if(file_exists(public_path().'/css/admin-custom.css'))
    <link href="{{ asset('css/admin-custom.css') }}" rel="stylesheet">
    @endif

    <style>
        #auth-logo {
            background: {{ $setting->logo_background_color }};
        }
    </style>

</head>
<body>

<div class="container-fluid">
  <div class="row">
    <div class="col-xs-12 col-lg-5" id="form-section">
        <div id="auth-logo">
            <img src="{{ $setting->logo_url }}" style="max-height: 50px" alt="Logo" />
        </div>

        <div id="auth-form">


            @yield('content')

        </div>
    </div>

    <div class="col-lg-7 visible-lg" id="background-section">
       <img src="{{ $setting->login_background_url }}" style="background-position: center;background-repeat: no-repeat;background-size: cover;width:98%;margin-top:25%;margin-right:10px;" />
    </div>
  </div>
</div>

<script src="{{ asset('plugins/bower_components/jquery/dist/jquery.min.js') }}"></script>
<script src="{{ asset('plugins/bootstrap/dist/js/bootstrap.min.js') }}"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>

</body>
</html>
