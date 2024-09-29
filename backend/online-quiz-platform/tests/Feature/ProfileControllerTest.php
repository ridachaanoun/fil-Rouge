<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Profile;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
class ProfileControllerTest extends TestCase
{
    use RefreshDatabase;
    protected function setUp(): void
    {
        parent::setUp();
        Storage::fake('public'); // Fake the storage for testing
        $this->artisan('db:seed'); // Seed the database if necessary
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
    /** @test */
    public function test_can_update_bio()
    {
        // Create a test user
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'), // Ensure the password is hashed
            'role_id' => 2, // Ensure this ID exists in your roles table
        ]);
    
        // Log in to obtain a JWT token
        $token = $this->loginAndGetToken($user);
    
        // Make the request to update the bio using the token
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->postJson('/api/profile/bio', ['bio' => 'This is my bio.']);
    
        // Assert that the response is successful
        $response->assertStatus(200)
                 ->assertJsonStructure(['profile' => ['id', 'user_id', 'bio', 'created_at', 'updated_at']]); // Remove 'profile_picture' if not applicable
    
        // Assert the bio has been updated in the database
        $this->assertDatabaseHas('profiles', [
            'bio' => 'This is my bio.',
            'user_id' => $user->id,
        ]);
    }
    

/** @test */
public function can_update_profile_picture()
{
    $user = User::create([
        'name' => 'Test User',
        'email' => 'test@example.com',
        'password' => bcrypt('password'),
        'role_id' => 2,
    ]);
    $token = $this->loginAndGetToken($user);
    $profile = Profile::create(['user_id' => $user->id, 'bio' => 'Bio of test user']);

    // Prepare a fake image for the profile picture
    $image = \Illuminate\Http\UploadedFile::fake()->image('profile.jpg');

    // Update the profile picture
    $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                     ->postJson("/api/profile/picture", [
                         'profile_picture' => $image,
                     ]);

    // Adjust the assertion to match the actual response structure
    $response->assertStatus(200)
             ->assertJsonStructure([
                 'profile' => [
                     'id',
                     'user_id',
                     'bio',
                     'profile_picture',
                     'created_at',
                     'updated_at',
                 ],
                 'profile_picture_url'
             ]);

    // Assert the profile picture is updated in the database
    $updatedProfile = Profile::find($profile->id);
    $this->assertNotNull($updatedProfile->profile_picture);
    $this->assertStringStartsWith('profile_pictures/', $updatedProfile->profile_picture); // Check that it starts with the expected path
}


    /** @test */
    public function can_fetch_all_profiles()
    {
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
            'role_id' => 2,
        ]);
        $token = $this->loginAndGetToken($user);

        // Create a profile for the user
        Profile::create(['user_id' => $user->id, 'bio' => 'Bio of test user']);

        // Make the request with the token
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson('/api/profiles');

        $response->assertStatus(200)
                 ->assertJsonStructure([['id', 'user_id', 'bio', 'profile_picture', 'created_at', 'updated_at']]);
    }

    /** @test */
    public function can_fetch_single_profile()
    {
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
            'role_id' => 2,
        ]);
        $token = $this->loginAndGetToken($user);
        $profile = Profile::create(['user_id' => $user->id, 'bio' => 'Bio of test user']);

        // Make the request to fetch the specific profile
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson("/api/profiles/{$profile->id}");

        $response->assertStatus(200)
                 ->assertJsonStructure(['id', 'user_id', 'bio', 'profile_picture', 'created_at', 'updated_at']);
    }

    /** @test */
    public function cannot_fetch_nonexistent_profile()
    {
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
            'role_id' => 2,
        ]);
        $token = $this->loginAndGetToken($user);

        // Make the request for a nonexistent profile
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson('/api/profiles/9999');

        $response->assertStatus(404)
                 ->assertJson(['message' => 'Profile not found']);
    }

    /** @test */
 /** @test */
public function can_remove_profile_picture()
{
    $user = User::create([
        'name' => 'Test User',
        'email' => 'test@example.com',
        'password' => bcrypt('password'),
        'role_id' => 2,
    ]);
    $token = $this->loginAndGetToken($user);
    $profile = Profile::create(['user_id' => $user->id, 'bio' => 'Bio of test user', 'profile_picture' => 'profile_pictures/test.jpg']);

    // Call the endpoint to remove the profile picture
    $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                     ->postJson("/api/profile/remove-picture");

    // Adjust the assertion to match the actual response structure
    $response->assertStatus(200)
             ->assertJson([
                 'message' => 'Profile picture removed successfully',
                 'profile_picture_url' => '/storage/default-profile.png',
             ]);
}

}
