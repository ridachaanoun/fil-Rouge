<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
class Profile extends Model
{
    use HasFactory;
    protected $fillable = [
        'bio',
        'user_id',
        'profile_picture'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
        // Accessor for profile_picture URL
    public function getProfilePictureUrlAttribute()
    {
        return $this->profile_picture ? Storage::url($this->profile_picture) : null;
    }
}
