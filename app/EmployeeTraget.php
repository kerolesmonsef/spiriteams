<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Holiday
 * @package App\Models
 */
class EmployeeTraget extends BaseModel
{
    protected $table =  'target';
    protected $fillable = ['employe_id', 'call_m', 'calls_w', 'visits_w', 'visits_m', 'money'];
    protected $guarded = ['id'];
    public function user()
    {
        return $this->belongsTo(User::class,'user_id');
    }
}
