<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\StoreLeadRequest;
use App\Http\Resources\LeadResource;
use App\Http\Resources\LeadCollection;
use App\Http\Services\LeadService;
use App\Lead;
use App\LeadAgent;
use App\LeadCategory;
use App\LeadSource;
use App\LeadStatus;
use App\Project;
use Illuminate\Http\Request;

class LeadController extends Controller
{

    protected LeadService $leadService;

    public function __construct()
    {
        $this->middleware(function ($request, $next) {
            if (!in_array('leads', auth()->user()->modules)) {
                abort(403);
            }
            return $next($request);
        });

        $this->leadService = new LeadService;
    }



    public function index()
    {
        $user = auth()->user();
        $leads = collect();
        if ($user->can('view_lead')) {
            $leads =  $this->leadService->getPaginatedAdminLeads(request('search'));
        } else if ($agent = LeadAgent::where('user_id', $user->id)->first()) {
            $leads =  $this->leadService->getPaginatedAgentLeads($agent->id, request('search'));
        }

        return response()->success([
            'leads' => LeadCollection::collection($leads),
        ]);
    }


    public function show($id)
    {
        $user = auth()->user();

        $lead   = Lead::with(['follow'])->findOrFail($id);

        // $fields = $lead->getCustomFieldGroupsWithFields()->fields;
        if (!$user->can('view_lead') && $lead->lead_agent->user_id != $user->id) {
            abort(403);
        }


        return response()->success([
            'lead' => new LeadResource($lead),
        ]);
    }


    public function getCustomFields()
    {
        abort_unless(auth()->user()->can('add_lead'), 403);

        $lead = new Lead();
        $fields = $lead->getCustomFieldGroupsWithFields()->fields;
        return response()->success(
            ['fields'  => $fields]
        );
    }


    public function create()
    {
        return response()->success([
            'projects'              => Project::select(['project_name', 'id'])->get(),
            'sources'               => LeadSource::select(['type', 'id'])->get(),
            'lead_status'           => LeadStatus::select(['type', 'id', 'default'])->orderBy('priority')->get(),
            'categories'            => LeadCategory::select(['category_name', 'id'])->get(),
            // 'value'                 => ,
            // 'qol'                   => [

            // ],
            // 'next_follow_up'        => [
            //     'yes'   => 'yes',
            //     'no'    => 'no',
            // ],
        ]);
    }




    public function store(StoreLeadRequest $request)
    {
        abort_unless(auth()->user()->can('add_lead'), 403);

        $lead = Lead::create($request->validated()['lead_data']);

        if ($request->filled('custom_fields_data')) {
            $lead->updateCustomFieldData($request->validated()['custom_fields_data']);
        }

        $this->logEntryLead($lead);
        $this->logUserActivity(auth()->id(), __('messages.LeadAddedUpdated'));


        return response()->success([], __('lead created successfully'));
    }

    public function destroy($lead)
    {
        abort_unless(auth()->user()->can('delete_lead'), 403);
        Lead::findOrFail($lead)->delete();
        $this->logUserActivity(auth()->id(), __('messages.LeadDeleted'));
        return response()->success([], __('lead deleted successfully'));
    }


    private function logEntryLead($lead)
    {
        //log search
        $this->logSearchEntry($lead->id, $lead->client_name, 'admin.leads.show', 'lead');
        $this->logSearchEntry($lead->id, $lead->client_email, 'admin.leads.show', 'lead');

        if (!is_null($lead->company_name)) {
            $this->logSearchEntry($lead->id, $lead->company_name, 'admin.leads.show', 'lead');
        }
    }
}
