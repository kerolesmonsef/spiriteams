<?php


namespace App\Helper;


use App\User;

class JWTUtil
{

    private static $header = array(
        'alg' => 'HS256',
        'typ' => 'JWT'
    );
    const PREFIX = "MELESBS::";

    const SECRET = 'MjUxNTZjMmFjMjkwODg5ZjNhMzJkZjI5OTI0ZmJhZGE5M2Y5YmY5Y2JhM2Q5NTJhZmMxN2VhMjkwM2ZhMjc1Yg';
    private static $expiration = 3600 * 24;


    /**
     * @param $payload
     * @return string
     */
    public static function encode($payload)
    {
        $header = base64_encode(json_encode(self::$header));
        $payload['exp'] = time() + self::$expiration;
        $payload = base64_encode(json_encode($payload));
        $signature = hash_hmac('sha256', $header . '.' . $payload, self::SECRET, true);
        $signature = base64_encode($signature);

        return base64_encode(self::PREFIX . $header . '.' . $payload . '.' . $signature);
    }

    /**
     * @param $token
     * @return bool|mixed
     * @throws \Exception
     */
    public static function decode($token)
    {
        $token = base64_decode($token);
        $token = explode(self::PREFIX,$token)[1];

        list($header, $payload, $signature) = explode('.', $token);

        if (base64_encode(hash_hmac('sha256', $header . '.' . $payload, self::SECRET, true)) !== $signature) {

            return false;
        }


        $payload = json_decode(base64_decode($payload), true);

        if (time() > $payload['exp']) {
            return false;
        }

        return $payload;
    }

    /**
     * @param $token
     * @return bool|mixed
     * @throws \Exception
     */
    public static function getUser($token)
    {
        $payload = self::decode($token);

        if ($payload === false or !isset($payload['uuid'])) {
            return false;
        }


        return User::query()->where("uuid", $payload['uuid'])->first();
    }
}

