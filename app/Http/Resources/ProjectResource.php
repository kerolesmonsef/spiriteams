<?php

namespace App\Http\Resources;

use App\Project;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin Project
 * @property mixed $category
 */
class ProjectResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request)
    {
        $arr = parent::toArray($request);

        $arr = array_merge($arr, [
            'id' => $this->id,
            'project_name' => $this->project_name,
            'status' => $this->status,
            'completion_percent' => $this->completion_percent,
            'start_date' => $this->start_date,
            'deadline' => $this->deadline,
            'notes' => $this->notes,
        ]);

        if ($this->relationLoaded("category")) {
            $arr['category'] = new ProjectCategoryResouce($this->category);
        }

        if ($this->relationLoaded('tasks')) {
            $arr['tasks'] = TaskResource::collection($this->tasks);
        }
        // if ($this->relationLoaded('members')) {
        //     $arr['members'] = UserResource::collection($this->members->map(fn ($member) => $member->user));
        // }
        
        if ($this->relationLoaded('members_many')) {
            $arr['members_many'] = UserResource::collection($this->members_many);
        }
        return $arr;
    }
}
