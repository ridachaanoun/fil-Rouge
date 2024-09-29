<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Notification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NotificationsControllerTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp(); // Call the parent setup method

               // Seed the database with users and other necessary data
               $this->artisan('db:seed');
}
    /** @test */
    public function test_can_fetch_user_notifications()
    {
        // Create a user with a role_id
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'), // Hash the password
            'role_id' => 2, // Ensure this ID exists in your roles table
        ]);

        // Create notifications for the user
        Notification::create([
            'user_id' => $user->id,
            'type' => 'info',
            'data' => json_encode(['message' => 'First notification']),
            'read' => false,
        ]);

        Notification::create([
            'user_id' => $user->id,
            'type' => 'info',
            'data' => json_encode(['message' => 'Second notification']),
            'read' => false,
        ]);

        // Log in as the user to get the token
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password', // assuming password is 'password'
        ]);

        $token = $response->json()['token'];

        // Fetch notifications for the logged-in user
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson('/api/notifications');

        // Assert the response contains the notifications
        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'notifications' => [
                         '*' => ['id', 'user_id', 'type', 'data', 'read', 'created_at', 'updated_at']
                     ]
                 ]);
    }

    /** @test */
    public function test_can_mark_notification_as_read()
    {
        // Create a user with a role_id
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'), // Hash the password
            'role_id' => 2, // Ensure this ID exists in your roles table
        ]);

        // Create a notification for that user
        $notification = Notification::create([
            'user_id' => $user->id,
            'type' => 'info',
            'data' => json_encode(['message' => 'Test notification']),
            'read' => false,
        ]);

        // Log in as the user to get the token
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password', // assuming password is 'password'
        ]);

        $token = $response->json()['token'];

        // Mark the notification as read
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->putJson("/api/notifications/{$notification->id}/read");

        // Assert the notification was marked as read
        $response->assertStatus(200)
                 ->assertJson(['message' => 'Notification marked as read']);

        // Verify in the database that the notification is marked as read
        $this->assertDatabaseHas('notifications', [
            'id' => $notification->id,
            'read' => true,
        ]);
    }

    /** @test */
    public function test_cannot_mark_nonexistent_notification_as_read()
    {
        // Create a user with a role_id
        $user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'), // Hash the password
            'role_id' => 2, // Ensure this ID exists in your roles table
        ]);

        // Log in as the user to get the token
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password', // assuming password is 'password'
        ]);

        $token = $response->json()['token'];

        // Attempt to mark a non-existent notification as read
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->putJson("/api/notifications/9999/read");

        // Assert the response indicates the notification was not found
        $response->assertStatus(404)
                 ->assertJson(['message' => 'Notification not found']);
    }
}
