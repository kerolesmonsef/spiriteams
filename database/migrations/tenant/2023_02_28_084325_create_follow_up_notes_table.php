<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFollowUpNotesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('follow_up_notes', function (Blueprint $table) {
            $table->id();
            $table->string('type')->nullable();
            $table->text('note')->nullable();
            $table->text('attachments')->nullable();


            // $table->integer('lead_id')->unsigned();
            // $table->foreign('lead_id')->references('id')->on('leads')->onDelete('cascade')->onUpdate('cascade');

            $table->integer('user_id')->unsigned();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade')->onUpdate('cascade');

            $table->integer('lead_follow_up_id')->unsigned();
            $table->foreign('lead_follow_up_id')->references('id')->on('lead_follow_up')->onDelete('cascade')->onUpdate('cascade');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('follow_up_notes');
    }
}
