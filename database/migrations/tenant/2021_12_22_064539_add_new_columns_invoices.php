<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddNewColumnsInvoices extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('invoices', function(Blueprint $table){
            $table->Integer('invoice_refund_id')->nullable()->after('invoice_recurring_id');
            $table->string('invoice_refund')->nullable()->after('invoice_recurring_id');
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
