<?php
    
    class ChatCodify {

        private function __construct() {}
        
        public static function crypt($s) {
            $secret_key = config('app.secret_key');
            $secret_iv = config('app.iv');
        
            $output = false;
            $encrypt_method = config('app.cipher');
            $key = hash('sha256', $secret_key);
            $iv = substr(hash('sha256', $secret_iv), 0, 16);
        
            $output = base64_encode(openssl_encrypt($s, $encrypt_method, $key, 0, $iv));
        
            return $output;
        }

        public static function decrypt($s) {
            $secret_key = config('app.secret_key');
            $secret_iv = config('app.iv');
        
            $output = false;
            $encrypt_method = config('app.cipher');
            $key = hash('sha256', $secret_key);
            $iv = substr(hash('sha256', $secret_iv), 0, 16);
        
            $output = openssl_decrypt(base64_decode($s), $encrypt_method, $key, 0, $iv);
        
            return $output;
        }

    }