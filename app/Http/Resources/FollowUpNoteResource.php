<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class FollowUpNoteResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        // return parent::toArray($request)


        $attachments = null;
        foreach ($this->attachments ?? [] as $key => $attachGroup) {
            $attachments[$key] =   array_map(function ($file) {
                return  $files[] = asset_url_local_s3('followup-notes/' . $this->lead_follow_up_id . '/' . $file);
            }, $attachGroup);
        }


        return [
            'id'                  => $this->id,
            'type'                => $this->type,
            'note'                => $this->note,
            'attachments'         => $attachments,
            'created_by'            => [
                'name'      => $this->creator->name,
                'image'     => $this->creator->image_url,
            ],
            'wave_data'           => $this->wave_data,
            'local_id'            => $this->local_id,
        ];
    }
}
