<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Quiz;
use App\Models\QuizAttempt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
class QuizAttemptController extends Controller
{
    /**
     * Store a new quiz attempt.
     *
     * @param Request $request
     * @param int $quizId
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request, $quizId)
    {
        $validator = Validator::make($request->all(), [
            // 'answers' => 'required|array',
            'score' => 'required|integer',
        ]);
    
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
        $quiz = Quiz::findOrFail($quizId);
        $user = Auth::user();

        $attempt = QuizAttempt::create([
            'quiz_id' => $quiz->id,
            'user_id' => $user->id,
            // 'answers' => $request->answers,
            'score' => $request->score,
        ]);

        return response()->json(['attempt' => $attempt], 201);
    }

    /**
     * Display a user's quiz attempts.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    // Return all quiz attempts for the authenticated user
    public function index()
    {
        try {
            // Get the authenticated user
            $user = Auth::user();

            // Fetch the quiz attempts for the user
            $quizAttempts = QuizAttempt::with('quiz')
                ->where('user_id', $user->id)
                ->get();

            // Return the quiz attempts in a JSON response
            return response()->json([
                'success' => true,
                'attempts' => $quizAttempts,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve quiz attempts',
            ], 500);
        }
    }

    /**
     * Display a specific quiz attempt.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $attempt = QuizAttempt::with('quiz')->findOrFail($id);

        return response()->json(['attempt' => $attempt], 200);
    }
}
