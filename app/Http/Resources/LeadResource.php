<?php

namespace App\Http\Resources;


use Illuminate\Http\Resources\Json\JsonResource;

class LeadResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return
            [
                'id'            => $this->id,
                'company_name'  => $this->company_name,
                'client_name'   => $this->client_email,
                'client_email'  => $this->client_email,
                'follow'        =>  FollowUpResource::collection($this->follow),
                'lead_information'  => [
                    'cart_num'      => '#'.$this->id,
                    'feedback'      => $this->feedback,
                    'industry'      => $this->industry,
                    'city'          => $this->city,
                ],
                'marketing_data'  => [
                    'project'   =>  $this->project->project_name,
                    'service'   =>  $this->service,
                    'qol'       =>  $this->qol ?  trans('modules.lead.qol_values.'. $this->qol) : null,
                    'status'    =>  $this->lead_status->type ?? null,
                ],
                'contact_dat'  => [
                    'phone'             => $this->phone,
                    'mobile'            => $this->mobile,
                    'client_email'      => $this->client_email,

                ],

            ];
    }
}
