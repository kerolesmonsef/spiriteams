<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class LeadFollowUp extends BaseModel
{
    protected $table = 'lead_follow_up';
    protected $dates = ['next_follow_up_date', 'created_at'];
    
    public function lead(){
        return $this->belongsTo(Lead::class);
    }
    
    public function creator(){
        return $this->belongsTo(User::class,'created_by')->withDefault();
    }
    
    public function users(){
        return $this->belongsToMany(User::class,'folowups_mentions')->withTimestamps();
    }

    public function followup_mentions(){
        return $this->hasMany(FolowupsMention::class, 'lead_follow_up_id');
    }
    
    public function notes(){
        return $this->hasMany(FollowUpNote::class, 'lead_follow_up_id');
    }
}
