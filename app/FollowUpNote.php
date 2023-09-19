<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FollowUpNote extends BaseModel
{
    protected $guarded = [];
    protected $casts = [
        'attachments'   => 'array'
    ];

    public function creator()
    {
        return $this->belongsTo(User::class, 'user_id')->withDefault();
    }
}
