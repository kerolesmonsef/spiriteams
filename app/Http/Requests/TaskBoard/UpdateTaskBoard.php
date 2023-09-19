<?php

namespace App\Http\Requests\TaskBoard;

use Froiden\LaravelInstaller\Request\CoreRequest;
use Illuminate\Foundation\Http\FormRequest;

class UpdateTaskBoard extends CoreRequest
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
        $id = $this->route()->parameter("taskboard") ?? $this->route()->parameter("taskBoard");

        return [
            'column_name' =>"required|unique:taskboard_columns,column_name,$id" ,
            'label_color' => 'required'
        ];
    }
}
