<?php

// app/Policies/QuizPolicy.php

namespace App\Policies;

use App\Models\Quiz;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class QuizPolicy
{
    use HandlesAuthorization;

    /**
     * Determine if the user can update the quiz.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Quiz  $quiz
     * @return bool
     */
    public function update(User $user, Quiz $quiz)
    {
        // Admins and super admins can update any quiz
        if (in_array($user->role->name, ['admin', 'super_admin'])) {
            return true;
        }

        // Users can only update their own quizzes
        return $user->id === $quiz->user_id;
    }

    /**
     * Determine if the user can delete the quiz.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Quiz  $quiz
     * @return bool
     */
    public function delete(User $user, Quiz $quiz)
    {
        // Admins and super admins can delete any quiz
        if (in_array($user->role->name, ['admin', 'super_admin'])) {
            return true;
        }

        // Users can only delete their own quizzes
        return $user->id === $quiz->user_id;
    }
}
