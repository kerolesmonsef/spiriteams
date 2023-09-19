<?php

namespace App\Console\Commands;

use App\User;
use Illuminate\Console\Command;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class GenerateUserNameForUsers extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'username:generate';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'php artisan tenants:run username:generate';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {

        // $user = new User;
        // $user->setConnection('tenant');
        // dd( $user->get() );
        // $database = $this->argument('database');
        // $users = DB::table('users')->get();

        $users = User::all();
        foreach ($users as $user) {
            $username = Str::before($user->email, '@');

            if (User::where('username', $username)->where('id', '!=', $user->id)->exists()) {
                $username .= '-' . rand(1000, 9999);
            }
            $user->username = $username;
            $user->save();
        }

        $this->info('Usernames have been updated!');
    }
}
