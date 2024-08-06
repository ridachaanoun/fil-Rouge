<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Illuminate\Http\Request;
use App\Models\Quiz;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class QuizController extends Controller
{
    use AuthorizesRequests ;
    /**
     * Display a listing of the quizzes.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $quizzes = Quiz::with('category','questions')->get();
        // $quizzes = Quiz::with()->get();
        return response()->json(['quizzes' => $quizzes], 200);
    }

    /**
     * Store a newly created quiz.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'description' => 'required|string',
        ]);
    
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
    
        $user = Auth::user(); // Get the currently authenticated user

        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        $quiz = Quiz::create([
            'title' => $request->title,
            'category_id' => $request->category_id,
            'description' => $request->description,
            'user_id' => $user->id, // Set the user_id
        ]);

        $followers = $user->followers;

    foreach ($followers as $follower) {
        // Create notification
        Notification::create([
            'user_id' => $follower->id,
            'type' => 'quiz_added',
            'data' => json_encode([
                'message' => "A new quiz was added by " . $user->name,
                'quiz' => $quiz,
            ]),
        ]);
    }
        return response()->json(['quiz' => $quiz], 201);
    }

    /**
     * Display the specified quiz.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $quiz = Quiz::with('questions')->findOrFail($id);
        return response()->json(['quiz' => $quiz], 200);
    }

    /**
     * Update the specified quiz.
     *
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        $quiz = Quiz::findOrFail($id);
        $this->authorize('update', $quiz);
        $request->validate([
            'title' => 'nullable|string|max:255',
            'category_id' => 'nullable|exists:categories,id',
            'description' => 'nullable|string',
        ]);

        $quiz = Quiz::findOrFail($id);
        $quiz->update($request->only('title', 'category_id', 'description'));

        return response()->json(['quiz' => $quiz], 200);
    }

    /**
     * Remove the specified quiz.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        $quiz = Quiz::findOrFail($id);
        $this->authorize('delete', $quiz);
        $quiz = Quiz::findOrFail($id);
        $quiz->delete();

        return response()->json(['message' => 'Quiz deleted successfully'], 200);
    }
}
