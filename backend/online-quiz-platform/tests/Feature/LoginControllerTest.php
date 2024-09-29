<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class LoginControllerTest extends TestCase
{
    use RefreshDatabase; // Use the RefreshDatabase trait to reset the database after each test

    protected function setUp(): void
    {
        parent::setUp(); // Call the parent setUp method

        // Seed the roles table before running tests to ensure role data is present
        $this->seed(\Database\Seeders\RolesTableSeeder::class);

        // Manually create a user for testing
        User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'), // Ensure the password is hashed
            'role_id' => 2, // Assuming 'user' role has an ID of 2
        ]);
    }

    /** @test */
    public function it_logs_in_a_user_with_valid_credentials()
    {
        // Attempt to log in with valid credentials
        $response = $this->postJson('/api/login', [
            'email' => 'test@example.com',
            'password' => 'password',
        ]);

        // Assert that the login response is successful and contains the expected message and user data
        $response->assertStatus(200)
            ->assertJson([
                'message' => 'Logged in successfully',
                'user' => [
                    'email' => 'test@example.com',
                    // Add other user fields you want to assert
                ]
            ]);
    }

    /** @test */
    public function it_requires_email_and_password_to_login()
    {
        // Attempt to log in without any credentials
        $response = $this->postJson('/api/login', []);
        
        // Assert that the response returns validation errors for both email and password
        $response->assertStatus(422)
            ->assertJson([
                "email" => [
                    "The email field is required."
                ],
                "password" => [
                    "The password field is required."
                ]
            ]);
    }

    /** @test */
    public function it_requires_email_to_login()
    {
        // Attempt to log in without an email
        $response = $this->postJson('/api/login', [
            'password' => 'password',
        ]);

        // Assert that the response returns a validation error for the email
        $response->assertStatus(422)
            ->assertJson([
                "email" => [
                    "The email field is required."
                ],
            ]);
    }

    /** @test */
    public function it_requires_password_to_login()
    {
        // Attempt to log in without a password
        $response = $this->postJson('/api/login', [
            'email' => 'test@example.com',
        ]);

        // Assert that the response returns a validation error for the password
        $response->assertStatus(422)
            ->assertJson([
                "password" => [
                    "The password field is required."
                ]
            ]);
    }

    /** @test */
    public function it_returns_invalid_credentials_for_wrong_email_or_password()
    {
        // Attempt to log in with invalid credentials
        $response = $this->postJson('/api/login', [
            'email' => 'wrong@example.com',
            'password' => 'wrongpassword',
        ]);

        // Assert that the response indicates invalid login credentials
        $response->assertStatus(401)
            ->assertJson([
                'message' => 'Invalid login credentials'
            ]);
    }

    /** @test */
    public function it_can_logout_user()
    {
        // Create a user manually for testing logout
        $user = User::create([
            'name' => 'Test User',
            'email' => 'logout_user@example.com',
            'password' => bcrypt('password'), // Ensure the password is hashed
            'role_id' => 2, // Ensure this ID exists in your roles table
        ]);

        // Log in to obtain a JWT token
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        // Assert that the login response is successful
        $response->assertStatus(200);
        $token = $response->json()['token']; // Extract the token from the response

        // Log out the user using the token
        $logoutResponse = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                                ->postJson('/api/logout');

        // Assert the logout response indicates success
        $logoutResponse->assertStatus(200)
                       ->assertJson(['message' => 'Logged out successfully']);

        // Check that the token is invalidated by trying to access a protected route
        $protectedResponse = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                                  ->getJson('/api/user'); // Adjust to match your user endpoint

        // Assert that access is denied (401 Unauthorized) after logout
        $protectedResponse->assertStatus(401); // Expect 401 Unauthorized after logout
    }
}
