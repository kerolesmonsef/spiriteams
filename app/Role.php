<?php

namespace App;

use Trebol\Entrust\EntrustRole;

class Role extends EntrustRole
{

    protected $guarded = [];

    public function permissions()
    {
        return $this->hasMany(PermissionRole::class, 'role_id');
    }

    public function p_permissions()
    {
        return $this->belongsToMany(Permission::class);
    }

    public function roleuser()
    {
        return $this->hasMany(RoleUser::class, 'role_id');
    }

}
