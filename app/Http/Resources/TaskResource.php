<?php

namespace App\Http\Resources;

use App\Task;
use App\User;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Resources\Json\ResourceCollection;

/**
 * @mixin Task
 */
class TaskResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array
     */
    public function toArray($request)
    {
        //        $arr = [
        //            'id' => $this->id,
        //            'heading' => $this->heading,
        //            'description' => $this->description,
        //            'start_date' => $this->start_date,
        //            'due_date' => $this->due_date,
        //            'created_at' => $this->created_at,
        //        ];
        $arr = parent::toArray($request);

        $arr['updated_at'] = $this->updated_at;
        $arr['created_at'] = $this->created_at;
        $arr['created_by'] = [
            // 'id'         => $this->create_by->id ?? null,
            'name'       => $this->create_by->name ?? '',
            'image_url'  => $this->create_by->image_url,
        ];

        if ($this->relationLoaded("board_column")) {
            $arr['board_column'] = new TaskBoardColumnResource($this->board_column);
        }

        if ($this->relationLoaded("create_by") and $this->create_by) {
            $arr['create_by_name'] = $this->create_by->name;
        }

        if ($this->relationLoaded('users')) {
            $arr['users_names'] = $this->users->map(fn (User $user) => $user->name);
            $arr['users'] = UserResource::collection($this->users);
        }

        if ($this->relationLoaded('files')) {
            $arr['files'] =  FileResource::collection($this->files);
        }

        if ($this->project){
            $arr['project_members'] = UserResource::collection($this->project->members_many );
        }else{
            $arr['project_members'] = [];
        }

        return $arr;
    }
}
