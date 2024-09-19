<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Illuminate\Http\Request;
use App\Models\Quiz;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Storage;

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
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:4000',
        ]);
    
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
    
        $user = Auth::user(); // Get the currently authenticated user
    
        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }
    
        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('images', 'public');
        }
    
        $quiz = Quiz::create([
            'title' => $request->title,
            'category_id' => $request->category_id,
            'description' => $request->description,
            'user_id' => $user->id, // Set the user_id
            'image' => $imagePath // Save the image path
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
        $quiz = Quiz::with('questions','category')->findOrFail($id);
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
        // Find the quiz or fail with a 404
        $quiz = Quiz::find($id);

        if (!$quiz) {
            return response()->json(['message' => 'Quiz not found'], 404);
        }

        // Authorize the user to update the quiz
        $this->authorize('update', $quiz);

        // Validate the request
        $validator = Validator::make($request->all(), [
            'title' => 'nullable|string|max:255',
            'category_id' => 'nullable|exists:categories,id',
            'description' => 'nullable|string',
            'image' => 'nullable|file|mimes:jpeg,png,jpg|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Update the quiz with validated data
        $validatedData = $validator->validated();
        $quiz->fill($validatedData);

        // Handle file upload if provided
        if ($request->hasFile('image')) {
            // Delete the old image if it exists
            if ($quiz->image && Storage::disk('public')->exists($quiz->image)) {
                Storage::disk('public')->delete($quiz->image);
            }

            // Store the image and set the path to be stored in the database
            $path = $request->file('image')->store('images', 'public');
            $quiz->image = $path; // Store the full path relative to the storage directory
        }

        // Save the updated quiz
        $quiz->save();

        // Return the updated quiz as a JSON response
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
    public function getUserQuizzes($id)
    {
        // // Get the authenticated user
        // $user = Auth::user();

        // // Check if user is authenticated
        // if (!$user) {
        //     return response()->json(['message' => 'Unauthorized'], 401);
        // }

        // Fetch quizzes created by the authenticated user
        $quizzes = Quiz::where('user_id', $id)
                        ->with('category', 'questions')
                        ->get();

        return response()->json(['quizzes' => $quizzes], 200);
    }
}
