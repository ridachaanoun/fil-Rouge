<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use App\Models\User;
use App\Models\Role;
use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;
class UserController extends Controller
{
    use AuthorizesRequests ;
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
        $this->authorize('updateRole', $user);

        $request->validate([
            'role_id' => 'required|exists:roles,id',
        ]);

        $role = Role::findOrFail($request->input('role_id'));
        $user->role()->associate($role);
        $user->save();

        return response()->json(['message' => 'User role updated successfully.'], 200);
    }

    // Update username
    public function updateUsername(Request $request)
    {
        /** @var \App\Models\User $user **/
        $user = Auth::user();

        // Validate the request
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Update the user's name
        
        $user->name = $request->input('name');
        $user->save();

        return response()->json(['message' => 'Username updated successfully.', 'name' => $user->name], 200);
    }

    // Update email
    public function updateEmail(Request $request)
    {
        /** @var \App\Models\User $user **/
        $user = Auth::user();

        // Validate the request
        $request->validate([
            'email' => ['required', 'string', 'email', 'max:255', Rule::unique('users')->ignore($user->id)],
        ]);

        // Update the user's email
        $user->email = $request->input('email');
        $user->save();

        return response()->json(['message' => 'Email updated successfully.', 'email' => $user->email], 200);
    }

    // Update password
    public function updatePassword(Request $request)
    {
        /** @var \App\Models\User $user **/
        $user = Auth::user();

        // Validate the request
        $request->validate([
            'current_password' => 'required',
            'password' => 'required|string|min:8|confirmed',
        ]);

        // Check if the current password is correct
        if (!Hash::check($request->input('current_password'), $user->password)) {
            return response()->json(['message' => 'Current password is incorrect.'], 400);
        }

        // Update the user's password
        $user->password = Hash::make($request->input('password'));
        $user->save();

        return response()->json(['message' => 'Password updated successfully.'], 200);
    }
}
