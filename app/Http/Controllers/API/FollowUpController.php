<?php

namespace App\Http\Controllers\API;

use App\FollowUpNote;
use App\Helper\Files;
use App\Http\Controllers\Controller;
use App\Http\Requests\Api\FollowUpRequest;
use App\Http\Resources\FollowUpResource;
use App\Lead;
use App\LeadFollowUp;
use App\Rules\CheckDateFormat;
use App\Rules\CheckEqualAfterDate;
use App\Traits\StoreNoteAttachmentTrait;
use Carbon\Carbon;
use Illuminate\Http\Request;

class FollowUpController extends Controller
{
    use StoreNoteAttachmentTrait;

    public function index($lead)
    {
        $user = auth()->user();
        $lead = Lead::find($lead);

        if (!$user->can('edit_lead') && $lead->lead_agent->user_id != $user->id) {
            abort(403);
        }
        $lead_follows = $lead->follow;
        return response()->success([
            "follow-ups" => FollowUpResource::collection($lead_follows),
        ]);
    }


    public function store($lead, FollowUpRequest $request)
    {
        $user = auth()->user();
        if (!$user->can('edit_lead') && $lead->lead_agent->user_id != $user->id) {
            abort(403);
        }

        $lead = Lead::findOrFail($lead);

        $followup  = $lead->follow()->create([
            'remark'                 => $request->remark,
            'created_by'             => $user->id,
            'next_follow_up_date'    => Carbon::createFromFormat('d/m/Y H:i', $request->next_follow_up_date)->format('Y-m-d H:i:s'),
        ]);


        if ($request->has('attachments')) {
            $this->storeFollowUpNotes($request, $followup);
        }

        return response()->success([
            "follow-up" => new FollowUpResource($followup),
        ]);
    }


    public function show($lead, $id)
    {
        $user = auth()->user();
        if (!$user->can('edit_lead') && $lead->lead_agent->user_id != $user->id) {
            abort(403);
        }
        $followup = LeadFollowUp::with('notes')->findOrFail($id);
        return response()->success([
            "follow-up" => new FollowUpResource($followup),
        ]);
    }


    public function destroy($lead, $id)
    {
        $user = auth()->user();
        if (!$user->can('edit_lead') && $lead->lead_agent->user_id != $user->id) {
            abort(403);
        }
        LeadFollowUp::findOrFail($id)->delete();
        $this->logUserActivity($user->id, __('messages.deleteSuccess'));
        return response()->success();
    }
}
