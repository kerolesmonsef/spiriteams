<?php

namespace App\Http\Resources;

use App\TaskHistory;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin TaskHistory
 * @property mixed $id
 */
class TaskHistoryResource extends JsonResource
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
            'id' => $this->id,
            'created_at' => $this->created_at,
            'comment'       => $this->comment,
        ];

        if ($this->relationLoaded("board_column")) {
            $arr['board_column'] = new TaskBoardColumnResource($this->board_column);
        }

        if ($this->relationLoaded("user")) {
            $arr['user_name'] = $this->user->name ?? "";
            $arr['user_image'] = $this->user->image_url ?? "";
        }

        return $arr;
    }
}
