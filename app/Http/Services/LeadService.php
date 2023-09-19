<?php

namespace App\Http\Services;

use App\Lead;
use Carbon\Carbon;

use function Clue\StreamFilter\fun;

class LeadService
{


    public function getPaginatedAdminLeads($search = null)
    {
        $currentDate = Carbon::now()->format('Y-m-d');

        // $leads =  Lead::select(
        //     'leads.id',
        //     'leads.client_id',
        //     'leads.next_follow_up',
        //     'leads.updated_at',
        //     'client_name',
        //     'company_name',
        //     'note',
        //     'lead_status.type as statusName',
        //     'status_id',
        //     'leads.value',
        //     'leads.created_at',
        //     'lead_sources.type as source',
        //     'users.name as agent_name',
        //     'users.image',
        //     \DB::raw("(select next_follow_up_date from lead_follow_up where lead_id = leads.id and leads.next_follow_up  = 'yes' and DATE(next_follow_up_date) >= '{$currentDate}' ORDER BY next_follow_up_date asc limit 1) as next_follow_up_date")
        // )
        //     ->leftJoin('lead_status', 'lead_status.id', 'leads.status_id')
        //     ->leftJoin('lead_agents', 'lead_agents.id', 'leads.agent_id')
        //     ->leftJoin('users', 'users.id', 'lead_agents.user_id')
        //     ->leftJoin('lead_sources', 'lead_sources.id', 'leads.source_id')
        //     ->when($search, function ($q) use ($search) {
        //         $q->where('client_name', 'like', '%' . $search . '%');
        //     })
        //     ->paginate();

            $leads = Lead::select('id','updated_at','client_name','company_name')->paginate();

            return $leads;
    }


    public function getPaginatedAgentLeads($agent_id , $search = null)
    {
        $currentDate = Carbon::now()->format('Y-m-d');

        // $leads =  Lead::select(
        //     'leads.id',
        //     'leads.client_id',
        //     'leads.next_follow_up',
        //     'leads.updated_at',
        //     'client_name',
        //     'company_name',
        //     'note',
        //     'lead_status.type as statusName',
        //     'status_id',
        //     'leads.value',
        //     'leads.created_at',
        //     'lead_sources.type as source',
        //     'users.name as agent_name',
        //     'users.image',
        //     \DB::raw("(select next_follow_up_date from lead_follow_up where lead_id = leads.id and leads.next_follow_up  = 'yes' and DATE(next_follow_up_date) >= '{$currentDate}' ORDER BY next_follow_up_date asc limit 1) as next_follow_up_date")
        // )
        //     ->leftJoin('lead_status', 'lead_status.id', 'leads.status_id')
        //     ->leftJoin('lead_agents', 'lead_agents.id', 'leads.agent_id')
        //     ->leftJoin('users', 'users.id', 'lead_agents.user_id')
        //     ->leftJoin('lead_sources', 'lead_sources.id', 'leads.source_id')
        //     ->when($search, function ($q) use ($search) {
        //         $q->where('client_name', 'like', '%' . $search . '%');
        //     })
        //     ->where('leads.agent_id',$agent_id)
        //     ->paginate();

        $leads = Lead::select('id','updated_at','client_name','company_name')->where('agent_id',$agent_id)->paginate();

        return $leads;
    }
}
