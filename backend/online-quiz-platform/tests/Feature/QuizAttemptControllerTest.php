<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\Quiz;
use App\Models\User;
use App\Models\QuizAttempt;
use Illuminate\Foundation\Testing\RefreshDatabase;

class QuizAttemptControllerTest extends TestCase
{
    use RefreshDatabase;

    // Variables to hold user and quiz instances
    private $user;
    private $quiz;

    protected function setUp(): void
    {
        parent::setUp();
        // Optionally seed the database for any required initial data
        $this->artisan('db:seed');

        // Create a user for testing
        $this->user = User::create([
            'name' => 'Test User',
            'email' => 'testuser@example.com',
            'password' => bcrypt('password'), // Ensure the password is hashed
            'role_id' => 2, // Assuming 2 corresponds to 'user'
        ]);

        // Create a quiz for testing
        $this->quiz = Quiz::create([
            'title' => 'Sample Quiz',
            'description' => 'This is a sample quiz.',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    // Function to log in a user and return the authentication token
    protected function loginAndGetToken($user)
    {
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password', // Use the correct password here
        ]);

        // Assert the login was successful
        $response->assertStatus(200);
        return $response->json()['token']; // Return the token for further requests
    }

    /** @test */
    public function it_can_store_a_quiz_attempt()
    {
        // Log in the user and get the token
        $token = $this->loginAndGetToken($this->user);

        // Sample data for creating a quiz attempt
        $data = [
            'score' => 85,
        ];

        // Make the request to store the quiz attempt
        $response = $this->postJson("/api/quizzes/{$this->quiz->id}/attempts", $data, [
            'Authorization' => "Bearer $token" // Pass the token in the header
        ]);

        // Assert the response status is 201 (created)
        $response->assertStatus(201);
        // Check if the quiz attempt was stored in the database
        $this->assertDatabaseHas('quiz_attempts', [
            'quiz_id' => $this->quiz->id,
            'user_id' => $this->user->id,
            'score' => 85,
        ]);
    }

    /** @test */
    public function it_can_fetch_user_quiz_attempts()
    {
        // Log in the user and get the token
        $token = $this->loginAndGetToken($this->user);

        // Create a quiz attempt for the authenticated user
        QuizAttempt::create([
            'quiz_id' => $this->quiz->id,
            'user_id' => $this->user->id,
            'score' => 90,
        ]);

        // Make the request to fetch the user's quiz attempts
        $response = $this->getJson('/api/attempts', [
            'Authorization' => "Bearer $token" // Pass the token in the header
        ]);

        // Assert the response status is 200 (OK)
        $response->assertStatus(200);
        // Assert the structure of the returned JSON response
        $response->assertJsonStructure([
            'success',
            'attempts' => [
                '*' => ['id', 'quiz_id', 'user_id', 'score', 'created_at', 'updated_at']
            ]
        ]);
    }

    /** @test */
    public function it_can_show_a_specific_quiz_attempt()
    {
        // Log in the user and get the token
        $token = $this->loginAndGetToken($this->user);

        // Create a quiz attempt for the authenticated user
        $attempt = QuizAttempt::create([
            'quiz_id' => $this->quiz->id,
            'user_id' => $this->user->id,
            'score' => 75,
        ]);

        // Make the request to show the specific quiz attempt
        $response = $this->getJson("/api/attempts/{$attempt->id}", [
            'Authorization' => "Bearer $token" // Pass the token in the header
        ]);

        // Assert the response status is 200 (OK)
        $response->assertStatus(200);
        // Assert the response contains the specific quiz attempt data
        $response->assertJson([
            'attempt' => [
                'id' => $attempt->id,
                'quiz_id' => $attempt->quiz_id,
                'user_id' => $attempt->user_id,
                'score' => $attempt->score,
            ],
        ]);
    }
}
