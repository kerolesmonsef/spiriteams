<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    protected $table = 'companies';
    protected $fillable = [
       'name', 'tax_number', 'logo', 'person_name', 'person_email', 'nerc_num', 'adderss','phone',
    ];

    public function toArray()
    {
        $data['id'] = $this->id;
        $data['name'] = $this->Serv_name;
    }

    public function proposal()
    {
        return $this->hasMany(Proposal::class);
    }
    
    
}