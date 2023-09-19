<?php

namespace App\Http\Requests\Lead;

use App\Http\Requests\CoreRequest;

class StoreRequest extends CoreRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $rules = [
            'company_name' => 'nullable',
            'website' =>'nullable',
            'address' => 'nullable',
            'mobile' => 'nullable|numeric|unique:leads,mobile|min:10',
            'office' => 'nullable',
            'city' => 'nullable',
            'state' => 'nullable',
            'country' => 'nullable',
            'postal_code' => 'nullable',
            'industry' =>'nullable',
            'feedback' =>'nullable',
            'service' =>'nullable',
            'qol' =>'nullable',
            'client_name' => 'required',
            'client_email' => 'required|email|unique:leads,client_email',
            'phone' => 'nullable|numeric|unique:leads,phone|min:10',
            'value' => 'nullable',
            'next_follow_up' => 'nullable|in:yes,no',
            'note' =>'nullable',

            'project_id' =>'nullable',
            'source_id' => 'nullable',
            'status_id' => 'nullable',
            'category_id' => 'nullable',

            
            'agent_id' => 'nullable',
            'currency_id' => 'nullable',
            'cell' =>'nullable',
            // 'salutation' => 'nullable',
            // 'name' => 'required',
            // 'email' =>'nullable',
            //'custom_fields_data' => 'required',
        ];
        return $rules;
    }
}
