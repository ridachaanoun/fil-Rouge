<?php

// app/Policies/QuestionPolicy.php

namespace App\Policies;

use App\Models\Question;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class QuestionPolicy
{
    use HandlesAuthorization;

    /**
     * Determine if the user can update the question.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Question  $question
     * @return bool
     */
    public function update(User $user, Question $question)
    {
        // Admins and super admins can update any question
        if (in_array($user->role->name, ['admin', 'super_admin'])) {
            return true;
        }

        // Users can only update questions from their own quizzes
        return $user->id === $question->quiz->user_id;
    }

    /**
     * Determine if the user can delete the question.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Question  $question
     * @return bool
     */
    public function delete(User $user, Question $question)
    {
        // Admins and super admins can delete any question
        if (in_array($user->role->name, ['admin', 'super_admin'])) {
            return true;
        }

        // Users can only delete questions from their own quizzes
        return $user->id === $question->quiz->user_id;
    }
}
