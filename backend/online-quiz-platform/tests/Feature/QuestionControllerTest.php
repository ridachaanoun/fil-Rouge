<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;
use App\Models\Quiz;
use App\Models\Question;

class QuestionControllerTest extends TestCase
{
    use RefreshDatabase;

    protected $user;
    protected $quiz;

    protected function setUp(): void
    {
        parent::setUp();
        // Seed the database with roles
        $this->artisan('db:seed');

        // Create a user and a quiz for testing
        $this->user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
            'role_id' => 2, // Assuming 2 corresponds to 'user'
        ]);

        $this->quiz = Quiz::create([
            'title' => 'Sample Quiz',
            'description' => 'This is a sample quiz for testing.',
            'user_id' => $this->user->id,
        ]);
    }

    protected function loginAndGetToken($user)
    {
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password', // Adjust this if your password is different
        ]);

        $response->assertStatus(200);
        return $response->json()['token'];
    }

    /** @test */
    public function testItCanStoreAQuestion()
    {
        // First, log in and get the token
        $token = $this->loginAndGetToken($this->user);

        // Prepare the question data
        $data = [
            'quiz_id' => $this->quiz->id,
            'question' => 'Sample Question?',
            'options' => ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
            'correct_option' => 'Option 1',
        ];

        // Make the request to store the question
        $response = $this->postJson('/api/questions', $data, [
            'Authorization' => "Bearer $token"
        ]);

        // Assert that the response is as expected
        $response->assertStatus(201);
        $this->assertDatabaseHas('questions', [
            'question' => 'Sample Question?',
            'quiz_id' => $this->quiz->id,
        ]);
    }

    /** @test */
    public function it_can_list_questions_for_a_quiz()
    {
        $token = $this->loginAndGetToken($this->user); // Log in and get token
        $question = Question::create([
            'quiz_id' => $this->quiz->id,
            'question' => 'What is the capital of Germany?',
            'options' => json_encode(['Berlin', 'Madrid', 'Rome']),
            'correct_option' => 'Berlin',
        ]);

        $response = $this->getJson("/api/quizzes/{$this->quiz->id}/questions", [
            'Authorization' => "Bearer $token" // Include the token
        ]);

        $response->assertStatus(200);
        $response->assertJsonFragment(['question' => $question->question]);
    }

    /** @test */
    public function it_can_show_a_specific_question()
    {
        $token = $this->loginAndGetToken($this->user); // Log in and get token
        $question = Question::create([
            'quiz_id' => $this->quiz->id,
            'question' => 'What is the largest ocean?',
            'options' => json_encode(['Pacific', 'Atlantic', 'Indian']),
            'correct_option' => 'Pacific',
        ]);

        $response = $this->getJson("/api/questions/{$question->id}", [
            'Authorization' => "Bearer $token" // Include the token
        ]);

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'question'
        ]);
    }

    /** @test */
    public function it_can_update_a_question()
    {
        $token = $this->loginAndGetToken($this->user); // Log in and get token
        $question = Question::create([
            'quiz_id' => $this->quiz->id,
            'question' => 'What is the capital of Italy?',
            'options' => json_encode(['Rome', 'Venice', 'Milan']),
            'correct_option' => 'Rome',
        ]);

        $data = [
            'question' => 'Updated question?',
            'options' => json_encode(['Option 1', 'Option 2', 'Option 3']),
            'correct_option' => 'Option ',
            'options' => ['Pacific', 'Atlantic', 'Indian'], 
        ];

        $response = $this->putJson("/api/questions/{$question->id}", $data, [
            'Authorization' => "Bearer $token" // Include the token
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('questions', ['id' => $question->id, 'question' => 'Updated question?']);
    }

    /** @test */
    public function it_can_delete_a_question()
    {
        $token = $this->loginAndGetToken($this->user); // Log in and get token
        $question = Question::create([
            'quiz_id' => $this->quiz->id,
            'question' => 'What is the smallest planet?',
            'options' => json_encode(['Mercury', 'Venus', 'Earth']),
            'correct_option' => 'Mercury',
        ]);

        $response = $this->deleteJson("/api/questions/{$question->id}", [], [
            'Authorization' => "Bearer $token" // Include the token
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseMissing('questions', ['id' => $question->id]);
    }
}
