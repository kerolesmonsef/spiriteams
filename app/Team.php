<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Team extends BaseModel
{
    // use SoftDeletes;

    protected $guarded = [];

    public function members()
    {
        return $this->hasMany(EmployeeTeam::class, 'team_id');
    }

    public function team_members()
    {
        return $this->hasMany(EmployeeDetails::class, 'department_id');
    }

}
