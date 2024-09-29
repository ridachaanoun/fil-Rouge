<?php

namespace Tests\Feature;

use App\Models\Role;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;
use App\Models\Profile;

class UserControllerTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        // Seed the roles table before running the tests to ensure roles are available
        $this->seed(\Database\Seeders\RolesTableSeeder::class);
    }

    /** @test */
    public function it_can_show_authenticated_user_details()
    {
        // Create a user manually with required fields and a hashed password
        $user = User::create([
            'name' => 'Test User',
            'email' => 'testuser@example.com',
            'password' => Hash::make('password'), // Ensure the password is hashed
            'role_id' => Role::where('name', 'user')->first()->id, // Set the role ID
        ]);
    
        // Create a profile for the user with additional information
        Profile::create([
            'user_id' => $user->id,
            'bio' => 'Hi, I am a test user!',
            'profile_picture' => 'profile_pictures/test.png',
        ]);
    
        // Log in the user to obtain an authentication token
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);
    
        $response->assertStatus(200); // Check if the login was successful
        $token = $response->json()['token']; // Extract the token from the response
    
        // Access the user details as an authenticated user using the token
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson('/api/user');
    
        // Assert the status and the structure of the returned JSON response
        $response->assertStatus(200)
                 ->assertJson([
                     'profile' => [
                         'user_id' => $user->id, // Check that the user ID matches
                         'bio' => 'Hi, I am a test user!', // Check the bio
                         'profile_picture' => 'profile_pictures/test.png', // Check the profile picture
                         'user' => [
                             'id' => $user->id,
                             'name' => $user->name,
                             'email' => $user->email,
                             'role_id' => $user->role_id, // Check the role ID
                         ],
                     ]
                 ]);
    }

    /** @test */
    public function it_can_update_username()
    {
        // Manually create a user with a specified role
        $user = User::create([
            'name' => 'Gerardo Hudson',
            'email' => 'gerardo.hudson@example.com',
            'password' => Hash::make('password123'),
            'role_id' => 1, // Assuming role_id 1 exists in the roles table
        ]);
    
        // Log in to obtain a token for authentication
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password123',
        ]);
    
        $response->assertStatus(200); // Assert successful login
        $token = $response->json()['token']; // Get the token from the response
    
        // Update the username through the API
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->putJson('/api/user/update-username', ['name' => 'Jane Doe']);
    
        // Assert the response indicates success
        $response->assertStatus(200)
                 ->assertJson(['message' => 'Username updated successfully.', 'name' => 'Jane Doe']);
    
        // Verify the database has the updated username
        $this->assertDatabaseHas('users', ['id' => $user->id, 'name' => 'Jane Doe']);
    }
    
    /** @test */
    public function it_can_update_email()
    {
        // Manually create a user
        $user = User::create([
            'name' => 'Gerardo Hudson',
            'email' => 'gerardo.hudson@example.com',
            'password' => Hash::make('password123'),
            'role_id' => 1, // Assuming role_id 1 exists in the roles table
        ]);
    
        // Log in to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password123',
        ]);
    
        $response->assertStatus(200); // Assert successful login
        $token = $response->json()['token']; // Extract token from response
    
        // Update the email using the API
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->putJson('/api/user/update-email', ['email' => 'jane@example.com']);

        // Assert the response indicates the email was updated successfully
        $response->assertStatus(200)
                 ->assertJson(['message' => 'Email updated successfully.', 'email' => 'jane@example.com']);

        // Verify the database reflects the updated email
        $this->assertDatabaseHas('users', ['id' => $user->id, 'email' => 'jane@example.com']);
    }
}
