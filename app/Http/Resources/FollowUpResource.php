<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class FollowUpResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        // return parent::toArray($request);
        $loadNoyes = $this->resource->relationLoaded('notes');

        return [
            'id'                    => $this->id,
            'lead_id'               => $this->lead_id,
            'remark'                => $this->remark,
            'records'               => $this->notes->where('type','voice')->count(),
            'notes'                 => FollowUpNoteResource::collection($this->when($loadNoyes,$this->notes)),
            'created_by'            => [
                'name'      => $this->creator->name,
                'image'     => $this->creator->image_url,
            ],
            'next_follow_up_date'   => $this->next_follow_up_date,
            'created_at'            => $this->created_at,
        ];
    }
}
