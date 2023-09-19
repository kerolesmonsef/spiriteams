<?php

namespace App\Http\Requests\Api;

use App\Lead;
use App\Rules\CheckDateFormat;
use App\Rules\CheckEqualAfterDate;
use Illuminate\Foundation\Http\FormRequest;

class FollowUpRequest extends FormRequest
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
        $lead = Lead::findOrFail($this->lead);

        return [
            'remark'                        => 'required|string',
            'attachments'                   => 'array',

            'attachments.images'            => 'array',
            'attachments.images.*'          => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',

            'attachments.files'             => 'array',
            'attachments.files.*'           => 'required|mimes:png,jpg,csv,txt,xlx,xls,pdf|max:2048',

            'attachments.voice'             => 'array',
            'attachments.voice.*'           => 'required|file',

            'local_id'                      => 'nullable',
            'wave_data'                     => 'nullable',
            
            'next_follow_up_date' => [new CheckDateFormat(null, 'd/m/Y H:i'),new CheckEqualAfterDate('','d/m/Y H:i', $lead->created_at->format('d/m/Y H:i'))],
        ];
    }
}
