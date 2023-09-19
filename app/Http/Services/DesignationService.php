<?php

namespace App\Http\Services;

use App\Designation;
use App\Helper\traits\LoggingTrait;
use App\Helper\traits\UniversalSearchTrait;
use App\Http\Requests\Designation\DesignationStoreRequest;
use App\Http\Requests\Designation\DesignationUpdateRequest;
use App\Traits\ProjectProgress;
use Froiden\RestAPI\Exceptions\RelatedResourceNotFoundException;

class DesignationService
{
    use LoggingTrait, ProjectProgress, UniversalSearchTrait;

    /**
     * @throws RelatedResourceNotFoundException
     */
    public function store(DesignationStoreRequest $request)
    {
        if ($request->has("id")) {
            $group = Designation::find(request('id')) ?? new Designation();
        } else {
            $group = new Designation();

        }

        $group->name = $request->designation_name;
        $group->save();
        if ($group->wasRecentlyCreated) {
            $this->logUserActivity(user()->id, __('messages.designationAdded'));
        } else {
            $this->logUserActivity(user()->id, __('messages.updatedSuccessfully'));
        }
        return $group;
    }

    public function update(DesignationUpdateRequest $request, $id)
    {
        $group = Designation::findOrFail($id);
        $group->name = $request->designation_name;
        $group->save();
        $this->logUserActivity($this->user->id, __('messages.updatedSuccessfully'));
        return $group;
    }
}