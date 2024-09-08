<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Question;
use App\Models\Quiz;
use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;
class QuestionController extends Controller
{
    use AuthorizesRequests;
    //  Store a newly created question.

    public function store(Request $request,)
    {
        $quiz = Quiz::findOrFail($request->quiz_id);
        $this->authorize('update', $quiz);
        $request->validate([
            'quiz_id' => 'required|exists:quizzes,id',
            'question' => 'required|string',
            'options' => 'required|array',
            'correct_option' => 'required|string',
        ]);

        $question = Question::create($request->all());

        return response()->json(['question' => $question], 201);
    }

    /**
     * Display a listing of the questions for a specific quiz.
     *
     * @param int $quizId
     * @return \Illuminate\Http\JsonResponse
     */
    public function index($quizId)
    {
        $questions = Question::where('quiz_id', $quizId)->get();
        return response()->json(['questions' => $questions], 200);
    }

    /**
     * Display the specified question.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $question = Question::findOrFail($id);
        return response()->json(['question' => $question], 200);
    }

    /**
     * Update the specified question.
     *
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
public function update(Request $request, $id)
{
    // Find the question by its ID
    $question = Question::findOrFail($id);

    // Authorize the user based on the question's quiz
    $this->authorize('update', $question);

    // Validate the incoming request
    $request->validate([
        'question' => 'nullable|string',
        'options' => 'nullable|array',
        'correct_option' => 'nullable|string',
    ]);

    // Update the question with the validated data
    $question->update($request->only('question', 'options', 'correct_option'));

    // Return a successful response with the updated question
    return response()->json(['question' => $question], 200);
}

    /**
     * Remove the specified question.
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        $question = Question::findOrFail($id);
    // if (!$question) {
    //     return response()->json(['message' => "the question doesn't exist"], 404);
    // }
        // Authorize the deletion of the question
        $this->authorize('delete', $question);
        
        $question->delete();
    
        return response()->json(['message' => 'Question deleted successfully'], 200);
    }
}
    