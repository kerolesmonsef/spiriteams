<?php

namespace App\Traits;

use App\FollowUpNote;
use App\Helper\Files;
use Illuminate\Http\Request;

trait StoreNoteAttachmentTrait
{


    
    private function storeFollowUpNotes(Request $request, $followup)
    {
        
        foreach ($request->attachments as $type => $attachments) {
            $attachments_urls = [];

            $attachments_urls[$type]  = array_map(function ($attach) use ($followup) {
                return $filename[] = Files::uploadLocalOrS3($attach, 'followup-notes/' . $followup->id);
            }, $attachments);

            FollowUpNote::create([
                'user_id'               => auth()->id(),
                'lead_follow_up_id'     => $followup->id,
                // 'note'                  => $request->note,
                'attachments'           => $attachments_urls,
                'type'                  => $type,
                'local_id'              => $request->local_id,
                'wave_data'             => $request->wave_data,

            ]);

        }
    }

}
