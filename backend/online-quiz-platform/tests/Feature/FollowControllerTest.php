<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class FollowControllerTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        // Seed the database with necessary data if required
        $this->artisan('db:seed');
    }

    /** @test */
    public function test_can_follow_another_user_with_jwt()
    {
        // Create the user who will follow
        $follower = User::create([
            'name' => 'Follower',
            'email' => 'follower@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        // Create the user to be followed
        $following = User::create([
            'name' => 'Following',
            'email' => 'following@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        // Log in the follower to get a JWT token
        $loginResponse = $this->postJson('/api/login', [
            'email' => $follower->email,
            'password' => 'password',
        ]);

        // Assert login was successful and extract the token
        $loginResponse->assertStatus(200);
        $token = $loginResponse->json()['token'];

        // Send a follow request as the authenticated user (follower)
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->postJson("/api/follow/{$following->id}");

        // Dump response content for debugging if needed
        // dd($response->getContent());

        // Assert the follow was successful
        $response->assertStatus(200)
                 ->assertJson(['message' => 'Successfully followed user']);
    }

    /** @test */
    public function test_cannot_follow_the_same_user_twice()
    {
        // Create two users
        $follower = User::create([
            'name' => 'Follower',
            'email' => 'follower@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        $userToFollow = User::create([
            'name' => 'UserToFollow',
            'email' => 'userfollow@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        // Log in as the follower
        $response = $this->postJson('/api/login', [
            'email' => $follower->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token'];

        // Follow the user
        $this->withHeaders(['Authorization' => 'Bearer ' . $token])
             ->postJson("/api/follow/{$userToFollow->id}");

        // Attempt to follow the same user again
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->postJson("/api/follow/{$userToFollow->id}");

        $response->assertStatus(400)
                 ->assertJson(['message' => 'You are already following this user']);
    }

    /** @test */
    public function test_can_unfollow_a_user()
    {
        // Create two users
        $follower = User::create([
            'name' => 'Follower',
            'email' => 'follower@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        $userToUnfollow = User::create([
            'name' => 'UserToUnfollow',
            'email' => 'unfollow@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        // Log in as the follower
        $loginResponse = $this->postJson('/api/login', [
            'email' => $follower->email,
            'password' => 'password',
        ]);

        $token = $loginResponse->json()['token'];

        // First, follow the user
        $this->withHeaders(['Authorization' => 'Bearer ' . $token])
             ->postJson("/api/follow/{$userToUnfollow->id}");

        // Now, unfollow the user
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->postJson("/api/unfollow/{$userToUnfollow->id}");

        $response->assertStatus(200)
                 ->assertJson(['message' => 'Successfully unfollowed user']);
    }

    /** @test */
    public function test_can_retrieve_a_list_of_followers()
    {
        // Create two users
        $follower = User::create([
            'name' => 'Follower',
            'email' => 'follower@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        $followedUser = User::create([
            'name' => 'FollowedUser',
            'email' => 'followed@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        // Log in as the followed user
        $loginResponse = $this->postJson('/api/login', [
            'email' => $followedUser->email,
            'password' => 'password',
        ]);

        $token = $loginResponse->json()['token'];

        // Attach the follower
        $followedUser->followers()->attach($follower->id);

        // Retrieve followers
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson("/api/followers/{$followedUser->id}");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'followers' => [
                         '*' => ['id', 'name', 'email', 'created_at', 'updated_at']
                     ]
                 ]);
    }

    /** @test */
    public function test_can_check_if_user_is_following_another_user()
    {
        // Create two users
        $follower = User::create([
            'name' => 'Follower',
            'email' => 'follower@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        $userToCheck = User::create([
            'name' => 'UserToCheck',
            'email' => 'check@example.com',
            'password' => Hash::make('password'),
            'role_id' => 2, // Regular user
        ]);

        // Log in as the follower
        $loginResponse = $this->postJson('/api/login', [
            'email' => $follower->email,
            'password' => 'password',
        ]);

        $token = $loginResponse->json()['token'];

        // Attach the follower
        $follower->following()->attach($userToCheck->id);

        // Check if the follower is following the user
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson("/api/is-following/{$userToCheck->id}");

        $response->assertStatus(200)
                 ->assertJson(['isFollowing' => true]);
    }
}
