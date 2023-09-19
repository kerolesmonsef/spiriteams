<?php

namespace App\Http\Services;

use App\EmployeeDetails;
use App\Models\Tenant;
use App\Role;
use App\UniversalSearch;
use App\User;

class TenantService
{
    private array $args;


    public function __construct(array $args)
    {
        $this->args = $args;
    }

    public function build()
    {
        $tenant = $this->createTenant();
        $domain = $this->createDomain($tenant);

        tenancy()->initialize($tenant);
        $this->createAdmin();

        return ['tenant' => $tenant, 'domain' => $domain];
    }

    private function createTenant()
    {
        $tenant = Tenant::create([
            'name'         => $this->args['name'],
            'company_code' => explode('.',$this->args['domain'])[0]
        ]);
        return $tenant;
    }


    private function createDomain(Tenant $tenant)
    {
        $domain = $tenant->domains()->create([
            'domain' => $this->args['domain'],
        ]);
        return $domain;
    }

    private function createAdmin()
    {

        $user = User::create([
            'email' => $this->args['email'],
            'uuid' => $this->args['uuid'],
            'name' => "super admin",
            'password' => bcrypt("123456"),
        ]);

        EmployeeDetails::create([
            'user_id' => $user->id,
            'employee_id' => 'emp-' . $user->id,
            'address' => 'address',
            'hourly_rate' => 12,
        ]);

        $search = new UniversalSearch();
        $search->searchable_id = $user->id;
        $search->title = $user->name;
        $search->route_name = 'admin.employees.show';
        $search->save();

        $adminRole = Role::where('name', 'admin')->first();
        $employeeRole = Role::where('name', 'employee')->first();

        $user->roles()->attach($adminRole->id); // id only
        $user->roles()->attach($employeeRole->id); // id only
    }

}
