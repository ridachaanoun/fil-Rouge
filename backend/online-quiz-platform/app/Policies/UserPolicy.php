<?php

namespace App\Policies;

// app/Policies/UserPolicy.php


use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class UserPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can update the role of another user.
     *
     * @param \App\Models\User $authUser
     * @param \App\Models\User $user
     * @return bool
     */
    public function updateRole(User $authUser, User $user)
    {
        // Check if the authenticated user is a super_admin
        return $authUser->role && $authUser->role->name === 'super_admin';
    }
}
