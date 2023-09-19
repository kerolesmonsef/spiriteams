<?php

namespace App\Http\Controllers\Admin;

use App\DataTables\Admin\LeadReportDataTable;
use App\Lead;
use App\LeadAgent;
use App\LeadFollowUp;
use App\LeadSource;
use App\LeadStatus;
use App\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Task;
use App\EmployeeTraget;
use App\EmployeeTragetCurrnet;
use Illuminate\Support\Facades\DB;
class LeadReportController extends AdminBaseController
{
 
     public function __construct()
    {
        parent::__construct();
        $this->pageTitle = 'app.menu.LeadsReport';
        $this->pageIcon = 'icon-calender';
        $this->middleware(function ($request, $next) {
            if (!in_array('leads', $this->user->modules)) {
                abort(403);
            }
            return $next($request);
        });
    }

    public function index()
    {
        $this->leadAgents = LeadAgent::whereHas('user', function($q) {
            $q->where('status', 'active');
        })->get();
        return view('admin.reports.lead.index', $this->data);
    }
    
    public function sorting_traget(Request $request){
       $this->employeeTarget = EmployeeTraget::where('agent_id',$request->assignedTo)->get();
       $this->employeeTargetCurrent = EmployeeTragetCurrnet::where('agent_id',$request->assignedTo)->get();
       //$this->leads = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->get();  
       $this->New_Lead = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',11)->count();  
       $this->Pending = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',1)->count();  
       $this->Wrong = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',12)->count();  
       $this->No = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',13)->count();  
       $this->Negotiation = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',14)->count();  
       $this->Meeting = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',16)->count();  
       $this->Deal = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',17)->count();  
       $this->Lost = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',18)->count();  
       $this->Proposal = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',19)->count();  
       $this->Follow = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',21)->count();  
       $this->Closed = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',22)->count();  
       $this->Visits = Lead::where('created_at','>=',$request->start_date)->where('created_at','<=',$request->end_date)->where('agent_id',$request->assignedTo)->where('status_id',23)->count();  

      return view('admin.reports.lead.single-report', $this->data);
     
    }
 
}