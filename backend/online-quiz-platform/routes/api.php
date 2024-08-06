<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Api\CategoryController;

use App\Http\Controllers\Api\QuizController;
use App\Http\Controllers\Api\QuestionController;
use App\Http\Controllers\Api\QuizAttemptController;

Route::post('register', [RegisterController::class, 'register']);
Route::post('login', [LoginController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('logout', [LoginController::class, 'logout']);
    Route::post('/categories', [CategoryController::class, 'store']);
    Route::put('/categories/{id}', [CategoryController::class, 'update']);
    Route::delete('/categories/{id}', [CategoryController::class, 'destroy']);
    Route::get('/categories', [CategoryController::class, 'index']);
    Route::get('/categories/{id}', [CategoryController::class, 'show']);


        // Quizzes
        Route::get('quizzes', [QuizController::class, 'index']);
        Route::post('quizzes', [QuizController::class, 'store']);
        Route::get('quizzes/{quiz}', [QuizController::class, 'show']);
        Route::put('quizzes/{quiz}', [QuizController::class, 'update']);
        Route::delete('quizzes/{quiz}', [QuizController::class, 'destroy']);
    
        // Questions
        Route::post('questions', [QuestionController::class, 'store']);
        Route::get('quizzes/{quiz}/questions', [QuestionController::class, 'index']);
        Route::get('questions/{question}', [QuestionController::class, 'show']);
        Route::put('questions/{question}', [QuestionController::class, 'update']);
        Route::delete('questions/{question}', [QuestionController::class, 'destroy']);
    
        // Quiz Attempts
        Route::post('quizzes/{quiz}/attempts', [QuizAttemptController::class, 'store']);
        Route::get('attempts', [QuizAttemptController::class, 'index']);
        Route::get('attempts/{attempt}', [QuizAttemptController::class, 'show']);
});


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
