<?php

namespace App\Console\Commands;

use App\Events\InvoiceReminderEvent;
use App\Invoice;
use App\InvoiceSetting;
use App\User;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Arr;

class SendInvoiceReminder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'send-invoice-reminder';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'send invoice reminder to the client before due date of invoice';

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
     * @return mixed
     */
    public function handle()
    {

        $company = \App\Setting::with('currency')->first();
        $invoice_setting = invoice_setting()->send_reminder;
        if ($invoice_setting != 0) {
            $invoices = Invoice::whereNotNull('due_date')
                ->whereDate('due_date', Carbon::now($company->timezone)->addDays($invoice_setting))
                ->where('status', '!=', 'paid')
                ->where('status', '!=', 'canceled')
                ->where('status', '!=', 'draft')
                ->get();
            if ($invoices) {
                foreach ($invoices as $invoice) {
                    $notifyUser = $invoice->client;
                    if (!is_null($notifyUser)) {
                        event(new InvoiceReminderEvent($invoice, $notifyUser, $invoice_setting));
                    }
                }
            }
        }
    }
}