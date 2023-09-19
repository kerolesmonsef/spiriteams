<?php

namespace App\Http\Resources;

use App\TaskboardColumn;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Pagination\LengthAwarePaginator;

/**
 * @mixin TaskboardColumn
 * @property LengthAwarePaginator $task_paginated
 */
class TaskBoardColumnResource extends JsonResource
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
            "id" => $this->id,
            "column_name" => $this->column_name,
            "slug" => $this->slug,
            "label_color" => $this->label_color,
            "priority" => $this->priority,
        ];

        if ($this->task_paginated ) {
            $arr['tasks'] = (TaskResource::collection($this->task_paginated));
        }

        return $arr;
    }
}
