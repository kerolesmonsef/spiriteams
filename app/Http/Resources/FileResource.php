<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class FileResource extends JsonResource
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
        return [
            'id'            => $this->id,
            'filename'      => $this->filename,
            'description'   => $this->description,
            'size'          => $this->size,
            'file_url'      => $this->file_url,
            'icon'          => $this->icon,
        ];
    }
}
