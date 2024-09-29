<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Quiz;
use App\Models\Category;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Storage;

class QuizControllerTest extends TestCase
{
    use RefreshDatabase; // Use the RefreshDatabase trait to reset the database for each test.

    private $user; // Store the user instance for tests.

    protected function setUp(): void
    {
        parent::setUp(); // Call the parent setup method to ensure proper initialization.

        // Seed the database with initial data.
        $this->artisan('db:seed');

        // Create a user in the database with specified attributes.
        $this->user = User::create([
            'name' => 'Test User',
            'email' => 'testuser@example.com',
            'password' => bcrypt('password'), // Hash the password for storage.
            'role_id' => 2, // Assuming 2 corresponds to 'user' role.
        ]);

        // Create a category for the quizzes associated with the created user.
        Category::create([
            'name' => 'General Knowledge',
            'description' => 'A category for general knowledge quizzes.',
            'user_id' => $this->user->id
        ]);
    }

    // Helper function to log in and retrieve the authentication token.
    protected function loginAndGetToken($user)
    {
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password', // Use the defined password for login.
        ]);

        $response->assertStatus(200); // Ensure the response status is 200 (OK).
        return $response->json()['token']; // Return the token from the response.
    }

    /** @test */
    public function it_can_list_quizzes()
    {
        // Create quizzes in the database.
        Quiz::create([
            'title' => 'Sample Quiz 1',
            'description' => 'This is the first sample quiz.',
            'category_id' => 1, // Assuming category_id 1 exists.
            'user_id' => $this->user->id,
        ]);

        Quiz::create([
            'title' => 'Sample Quiz 2',
            'description' => 'This is the second sample quiz.',
            'category_id' => 1,
            'user_id' => $this->user->id,
        ]);

        $token = $this->loginAndGetToken($this->user); // Log in and get the token.

        $response = $this->getJson('/api/quizzes', [
            'Authorization' => "Bearer $token" // Pass the token in the request headers.
        ]);

        $response->assertStatus(200); // Assert that the status code is 200.
        $response->assertJsonStructure(['quizzes' => [['id', 'title', 'description', 'category_id', 'user_id']]]); // Assert the structure of the returned JSON.
        $this->assertCount(2, $response->json('quizzes')); // Ensure that 2 quizzes are returned.
    }

    /** @test */
    public function it_can_store_a_quiz()
    {
        $token = $this->loginAndGetToken($this->user); // Log in and get the token.

        $data = [
            'title' => 'New Quiz',
            'category_id' => 1, // Assuming category_id 1 exists.
            'description' => 'This is a new quiz.',
            'image' => null, // If you want to test image upload, you can add an image file here.
        ];

        $response = $this->postJson('/api/quizzes', $data, [
            'Authorization' => "Bearer $token", // Pass the token in the request headers.
        ]);

        $response->assertStatus(201); // Assert that the status code is 201 (Created).
        $this->assertDatabaseHas('quizzes', [ // Check if the quiz was successfully stored in the database.
            'title' => 'New Quiz',
            'description' => 'This is a new quiz.',
        ]);
    }

    /** @test */
    public function it_can_show_a_quiz()
    {
        // Create a quiz in the database.
        $quiz = Quiz::create([
            'title' => 'Sample Quiz',
            'description' => 'This is a sample quiz.',
            'category_id' => 1, // Assuming category_id 1 exists.
            'user_id' => $this->user->id,
        ]);
        
        $token = $this->loginAndGetToken($this->user); // Log in and get the token.

        $response = $this->getJson("/api/quizzes/{$quiz->id}", [
            'Authorization' => "Bearer $token" // Pass the token in the request headers.
        ]);

        $response->assertStatus(200); // Assert that the status code is 200.
        $response->assertJson([ // Assert that the returned JSON matches the expected quiz data.
            'quiz' => [
                'id' => $quiz->id,
                'title' => 'Sample Quiz',
                'description' => 'This is a sample quiz.',
            ],
        ]);
    }

    /** @test */
    public function it_can_update_a_quiz()
    {
        // Create a quiz in the database.
        $quiz = Quiz::create([
            'title' => 'Original Quiz',
            'description' => 'This is the original quiz.',
            'category_id' => 1,
            'user_id' => $this->user->id,
        ]);

        $token = $this->loginAndGetToken($this->user); // Log in and get the token.

        $data = [
            'title' => 'Updated Quiz',
            'description' => 'This is an updated quiz.',
        ];

        $response = $this->putJson("/api/quizzes/{$quiz->id}", $data, [
            'Authorization' => "Bearer $token", // Pass the token in the request headers.
        ]);

        $response->assertStatus(200); // Assert that the status code is 200.
        $this->assertDatabaseHas('quizzes', [ // Check if the quiz was successfully updated in the database.
            'id' => $quiz->id,
            'title' => 'Updated Quiz',
            'description' => 'This is an updated quiz.',
        ]);
    }

    /** @test */
    public function it_can_delete_a_quiz()
    {
        // Create a quiz in the database.
        $quiz = Quiz::create([
            'title' => 'Quiz to Delete',
            'description' => 'This quiz will be deleted.',
            'category_id' => 1,
            'user_id' => $this->user->id,
        ]);

        $token = $this->loginAndGetToken($this->user); // Log in and get the token.

        $response = $this->deleteJson("/api/quizzes/{$quiz->id}", [], [
            'Authorization' => "Bearer $token", // Pass the token in the request headers.
        ]);

        $response->assertStatus(200); // Assert that the status code is 200.
        $this->assertDatabaseMissing('quizzes', [ // Check if the quiz has been removed from the database.
            'id' => $quiz->id,
        ]);
    }

    /** @test */
    public function it_can_get_user_quizzes()
    {
        // Create quizzes for the user.
        Quiz::create([
            'title' => 'User Quiz 1',
            'description' => 'This is the first user quiz.',
            'category_id' => 1,
            'user_id' => $this->user->id,
        ]);

        Quiz::create([
            'title' => 'User Quiz 2',
            'description' => 'This is the second user quiz.',
            'category_id' => 1,
            'user_id' => $this->user->id,
        ]);

        $token = $this->loginAndGetToken($this->user); // Log in and get the token.

        $response = $this->getJson("/api/user-quizzes/{$this->user->id}", [
            'Authorization' => "Bearer $token" // Pass the token in the request headers.
        ]);

        $response->assertStatus(200); // Assert that the status code is 200.
        $this->assertCount(2, $response->json('quizzes')); // Ensure that the correct number of quizzes is returned.
    }
}
