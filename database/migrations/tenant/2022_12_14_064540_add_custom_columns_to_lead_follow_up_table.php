<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddCustomColumnsToLeadFollowUpTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('lead_follow_up', function (Blueprint $table) {
            $table->text('first_call_discussion')->after('remark')->nullable();
            $table->text('first_call_action')->after('first_call_discussion')->nullable();
            $table->text('seconed_call_discussion')->after('first_call_action')->nullable();
            $table->text('seconed_call_action')->after('seconed_call_discussion')->nullable();
            $table->text('first_meeting_mom')->after('seconed_call_action')->nullable();
            $table->text('first_meeting_action')->after('first_meeting_mom')->nullable();
            $table->integer('created_by')->after('remark')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('invoices', function(Blueprint $table){
            $table->dropColumn(['invoice_refund_id']);
            $table->dropColumn(['invoice_refund']);
        });
    }
}
