<?php

namespace App\Http\Controllers\API;

use App\FollowUpNote;
use App\Http\Controllers\Controller;
use App\Http\Requests\Api\FollowUpNoteRequest;
use App\Http\Resources\FollowUpNoteResource;
use App\LeadFollowUp;
use App\Traits\StoreNoteAttachmentTrait;
use Illuminate\Http\Request;

class FollowUpNoteController extends Controller
{

    use StoreNoteAttachmentTrait;

    public function store(FollowUpNoteRequest $request)
    {



        $followup = LeadFollowUp::find($request->followup_id);

        if ($request->has('attachments')) {
            $this->storeFollowUpNotes($request, $followup);
        } else {
            FollowUpNote::create([
                'user_id'               => auth()->id(),
                'lead_follow_up_id'     => $followup->id,
                'note'                  => $request->note,
                'type'                  => 'text',
            ]);
        }
        return response()->success([
            "notes"      => FollowUpNoteResource::collection($followup->notes),
        ]);
    }

    public function update($id,Request $request)
    {
        $request->validate([
            'note'  => 'required|string',
        ]);

        $user = auth()->user();
        if (!$user->can('edit_lead')) {
            abort(403);
        }
        
        $note = FollowUpNote::findOrFail($id);
        $note->update([
            'user_id'               => auth()->id(),
            'note'                  => $request->note,
            'type'                  => 'text',
        ]);

        return response()->success();
    }


    public function destroy($id)
    {
        $user = auth()->user();
        if (!$user->can('edit_lead')) {
            abort(403);
        }
        FollowUpNote::findOrFail($id)->delete();
        $this->logUserActivity($user->id, __('messages.deleteSuccess'));
        return response()->success();
    }
}
