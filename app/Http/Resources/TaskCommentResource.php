<?php

namespace App\Http\Resources;

use App\TaskComment;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin TaskComment
 */
class TaskCommentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request)
    {
        $arr = [
            'comment' => $this->comment,
        ];

        if ($this->relationLoaded('user')) {
            $arr['user_name'] = $this->user->name ?? "";
        }

        return $arr;
    }
}
