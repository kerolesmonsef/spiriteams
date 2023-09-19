<?php

use App\Role;
use App\Team;
use App\UniversalSearch;
use Illuminate\Database\Seeder;
use App\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\App;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     * @throws \Froiden\RestAPI\Exceptions\RelatedResourceNotFoundException
     */

    public function run() {

        \DB::table('users')->delete();
        \DB::table('employee_details')->delete();
        \DB::table('universal_search')->delete();

        \DB::statement('ALTER TABLE users AUTO_INCREMENT = 1');
        \DB::statement('ALTER TABLE employee_details AUTO_INCREMENT = 1');
        \DB::statement('ALTER TABLE universal_search AUTO_INCREMENT = 1');


        $faker = \Faker\Factory::create();

        $user = new User();
        $user->name = $faker->name;
        $user->email = 'admin@example.com';
        $user->password = Hash::make('123456');
        $user->save();

        $employee = new \App\EmployeeDetails();
        $employee->user_id = $user->id;
        $employee->employee_id = 'emp-'.$user->id;
        $employee->address = $faker->address;
        $employee->hourly_rate = $faker->numberBetween(15, 100);
        $employee->save();

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
