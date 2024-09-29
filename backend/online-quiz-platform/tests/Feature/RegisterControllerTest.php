<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RegisterControllerTest extends TestCase
{
    use RefreshDatabase; // Use the RefreshDatabase trait to reset the database after each test

    protected function setUp(): void
    {
        parent::setUp(); // Call the parent setUp method

        // Seed the roles table before running tests to ensure role data is present
        $this->seed(\Database\Seeders\RolesTableSeeder::class);
    }

    /** @test */
    public function it_registers_a_user_with_valid_data()
    {
        // Attempt to register a new user with valid data
        $response = $this->postJson('/api/register', [
            'name' => 'John Doe',
            'email' => 'john@example.com',
            'password' => 'password',
            'password_confirmation' => 'password', // Password confirmation should match the password
        ]);

        // Assert that the registration response is successful and contains the expected structure
        $response->assertStatus(200)
                 ->assertJsonStructure([
                    'message',
                    'user' => [
                        'id',
                        'name',
                        'email',
                    ],
                    'token', // The returned token for authentication
                    'profile' => [
                        'id',
                        'user_id',
                    ],
                 ]);

        // Assert that the user was created in the database
        $this->assertDatabaseHas('users', [
            'email' => 'john@example.com',
        ]);
    }

    /** @test */
    public function it_requires_name_email_and_password_to_register()
    {
        // Attempt to register without any data
        $response = $this->postJson('/api/register', []);

        // Assert that the response returns validation errors for name, email, and password
        $response->assertStatus(422)
        ->assertJson([
            "name"=> [
                "The name field is required."
            ],
            "email"=> [
                "The email field is required."
            ],
            "password"=> [
                "The password field is required."
            ]
        ]);
    }

    /** @test */
    public function it_requires_password_confirmation()
    {
        // Attempt to register with a password confirmation that does not match
        $response = $this->postJson('/api/register', [
            'name' => 'John Doe',
            'email' => 'john@example.com',
            'password' => 'password',
            'password_confirmation' => 'wrongpassword', // Incorrect confirmation
        ]);
        
        // Assert that the response indicates that the password confirmation does not match
        $response->assertStatus(422)
        ->assertJson([
            "password"=> [
                "The password field confirmation does not match."
                ]
            ]);
    }

    /** @test */
    public function it_requires_a_unique_email()
    {
        // Assuming there is a role with ID 1 in the roles table
        $role = \App\Models\Role::first(); // Fetch the first role from the roles table
    
        // Create a user manually with the required role_id
        User::create([
            'name' => 'Jane Doe',
            'email' => 'jane@example.com',
            'password' => bcrypt('password'), // Ensure the password is hashed
            'role_id' => 1, // Set the role_id
        ]);
    
        // Attempt to register a new user with an already taken email
        $response = $this->postJson('/api/register', [
            'name' => 'John Doe',
            'email' => 'jane@example.com', // Using the taken email
            'password' => 'password',
            'password_confirmation' => 'password',
        ]);
        
        // Assert that the response indicates that the email is already taken
        $response->assertStatus(422)
        ->assertJson([
            "email"=> [
                "The email has already been taken."
            ]
        ]);
    }
}
