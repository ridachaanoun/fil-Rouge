<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use App\Models\User;
use App\Models\Role;
class UserController extends Controller
{
    use AuthorizesRequests;
    public function show()
    {
        $user = Auth::user();
        return response()->json([
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'role' => $user->role->name, // Add role name to the response
            'created_at' => $user->created_at,
            'updated_at' => $user->updated_at,
        ]);
    }
    public function updateRole(Request $request, User $user)
    {
        // Use the policy to check authorization
        $this->authorize('updateRole', $user);

        // Validate the request
        $request->validate([
            'role_id' => 'required|exists:roles,id',
        ]);

        // Fetch the role
        $role = Role::findOrFail($request->input('role_id'));

        // Update the user's role
        $user->role()->associate($role);
        $user->save();

        return response()->json(['message' => 'User role updated successfully.'], 200);
    }
}
