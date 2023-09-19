<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class RequestActivity extends Model
{
    protected $guarded = [];

    public static function log()
    {
        self::query()->create([
            'ip' => request()->ip(),
            'request'=> json_encode(request()->all())
        ]);
    }
}
