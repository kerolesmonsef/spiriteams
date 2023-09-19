<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddColumnToFollowUpNotes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('follow_up_notes', function (Blueprint $table) {
            $table->string('local_id')->nullable()->after('lead_follow_up_id');
            $table->longText('wave_data')->nullable()->after('local_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('follow_up_notes', function (Blueprint $table) {
            $table->dropColumn(['local_id','wave_data']);
        });
    }
}
