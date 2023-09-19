<?php

namespace App\Http\Requests\Api;

use App\Lead;
use Illuminate\Foundation\Http\FormRequest;

class StoreLeadRequest extends FormRequest
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

        $lead = new Lead();
        $fields = $lead->getCustomFieldGroupsWithFields()->fields;

        $rules = [];
        // foreach ($fields as $field) {
        //     $rules['custom_fields_data.'.$field->name.'_'.$field->id] = $field->required  == 'yes' ? 'required' : 'nullable';
        // }
        $rules =  array_merge([
            'company_name'  => 'nullable',
            'website'       => 'nullable',
            'address'       => 'nullable',
            'mobile'        => 'nullable|numeric|unique:leads,mobile|min:10',
            'office'        => 'nullable',
            'city'          => 'nullable',
            'state'         => 'nullable',
            'country'       => 'nullable',
            'postal_code'   => 'nullable',
            'industry'      => 'nullable',
            'feedback'      => 'nullable',
            'service'       => 'nullable',
            'qol'           => 'nullable',
            'client_name'   => 'required',
            'client_email'  => 'required|email|unique:leads,client_email',
            'phone'         => 'nullable|numeric|unique:leads,phone|min:10',
            'value'         => 'nullable',
            'next_follow_up'=> 'nullable|in:yes,no',
            'note'          => 'nullable',

            'project_id'    => 'nullable',
            'source_id'     => 'nullable',
            'status_id'     => 'nullable',
            'category_id'   => 'nullable',

            
            'agent_id'      => 'nullable',
            'currency_id'   => 'nullable',
            'cell'          => 'nullable',
        ], $rules);

        return $rules;
    }

    public function validated()
    {

        $data  = [
            'lead_data'             => $this->except('custom_fields_data'),
            'custom_fields_data'    => $this->get('custom_fields_data')
        ];
        return $data;
    }


}
