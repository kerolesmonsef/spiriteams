<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

class FollowUpNoteRequest extends FormRequest
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
        return [
            'note'                          => 'nullable|required_without:attachments|string',
            'followup_id'                   => 'required|numeric|exists:lead_follow_up,id',

            'attachments'                   => 'array',

            'attachments.images'            => 'array',
            'attachments.images.*'          => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',

            'attachments.files'             => 'array',
            'attachments.files.*'           => 'required|mimes:png,jpg,csv,txt,xlx,xls,pdf|max:2048',

            'attachments.voice'             => 'array',
            'attachments.voice.*'           => 'required|file',

            'local_id'                      => 'nullable',
            'wave_data'                     => 'nullable',
        ];
    }
}
