<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FolowupsMention extends Model
{
    protected $guarded = ['id'];
    

    public function username($Id){
        $user  = User::findorfail($Id);
        return ' @'.$user->name;
    }

}
