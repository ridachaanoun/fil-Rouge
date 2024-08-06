<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Profile;
use Illuminate\Support\Facades\Storage;

class ProfileController extends Controller
{
    public function updateBio(Request $request)
    {
        $request->validate([
            'bio' => 'nullable|string',
        ]);

        $user = Auth::user();
        $profile = $user->profile;

        if (!$profile) {
            $profile = new Profile();
            $profile->user_id = $user->id;
        }

        $profile->bio = $request->bio;
        $profile->save();

        return response()->json(['profile' => $profile], 200);
    }

//  Update the profile picture.

    public function updateProfilePicture(Request $request)
    {
        $request->validate([
            'profile_picture' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $user = Auth::user();
        $profile = $user->profile;

        if (!$profile) {
            $profile = new Profile();
            $profile->user_id = $user->id;
        }

        if ($profile->profile_picture) {
            Storage::delete($profile->profile_picture);
        }

        $path = $request->file('profile_picture')->store('profile_pictures', 'public');

        $profile->profile_picture = $path;
        $profile->save();

        return response()->json([
            'profile' => $profile,
            'profile_picture_url' => $profile->profile_picture_url
        ], 200);
    }

    //  Get all profiles.
    public function index()
    {
        $profiles = Profile::with('user')->get();

        $profiles->each(function ($profile) {
            $profile->profile_picture_url = $profile->profile_picture_url;
        });

        return response()->json($profiles, 200);
    }

    // Get a single profile.

    public function show($id)
    {
        $profile = Profile::with('user')->find($id);

        if (!$profile) {
            return response()->json(['message' => 'Profile not found'], 404);
        }

        $profile->profile_picture_url = $profile->profile_picture_url;

        return response()->json($profile, 200);
    }
}
