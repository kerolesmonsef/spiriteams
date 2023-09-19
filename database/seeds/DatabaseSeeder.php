<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\App;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */

    public function run() {
        // Set Seeding to true check if data is seeding.
        // This is required to stop notification in installation
//        config(['app.seeding' => true]);
//
       $this->call(RolesTableSeeder::class);
       $this->call(UsersTableSeeder::class);
       $this->call(CurrencySeeder::class);
       $this->call(OrganisationSettingsTableSeeder::class);
       $this->call(EmailSettingSeeder::class);
       $this->call(SmtpSettingsSeeder::class);
       $this->call(ThemeSettingsTableSeeder::class);
//
//
//
//        config(['app.seeding' => false]);
    }

}
