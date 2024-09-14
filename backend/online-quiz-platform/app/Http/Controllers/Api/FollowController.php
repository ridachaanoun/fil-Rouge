<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class FollowController extends Controller
{
    public function follow(Request $request, $id)
    {
        $user = Auth::user();
        $userToFollow = User::findOrFail($id);

        if (!$user->following->contains($userToFollow->id)) {
            $user->following()->attach($userToFollow->id);
            return response()->json(['message' => 'Successfully followed user'], 200);
        }

        return response()->json(['message' => 'You are already following this user'], 400);
    }

    public function unfollow(Request $request, $id)
    {
        $user = Auth::user();
        $userToUnfollow = User::findOrFail($id);

        if ($user->following->contains($userToUnfollow->id)) {
            $user->following()->detach($userToUnfollow->id);
            return response()->json(['message' => 'Successfully unfollowed user'], 200);
        }

        return response()->json(['message' => 'You are not following this user'], 400);
    }

    public function followers($id)
    {
        $user = User::findOrFail($id);
        $followers = $user->followers;

        return response()->json(['followers' => $followers], 200);
    }

    public function following($id)
    {
        $user = User::findOrFail($id);
        $following = $user->following;

        return response()->json(['following' => $following], 200);
    }

    // New method to check if the authenticated user is following the specified user
    public function isFollowing($id)
    {
        $user = Auth::user();
        $userToCheck = User::findOrFail($id);

        $isFollowing = $user->following->contains($userToCheck->id);

        return response()->json(['isFollowing' => $isFollowing], 200);
    }
}
