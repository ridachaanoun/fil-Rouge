<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class CategoryControllerTest extends TestCase
{
    // Use the RefreshDatabase trait to reset the database for each test
    use RefreshDatabase;

    private $adminUser; // Variable to hold the admin user instance
    private $regularUser; // Variable to hold the regular user instance

    protected function setUp(): void
    {
        parent::setUp(); // Call the parent setup method

               // Seed the database with users and other necessary data
               $this->artisan('db:seed');

        // Manually create an admin user
        $this->adminUser = User::create([
            'name' => 'Admin User',
            'email' => 'admin@example.com',
            'password' => Hash::make('password'), // Hash the password for security
            'role_id' => 1, // Assuming role_id = 1 is admin
        ]);

        // Manually create a regular user
        $this->regularUser = User::create([
            'name' => 'Regular User',
            'email' => 'user@example.com',
            'password' => Hash::make('password'), // Hash the password for security
            'role_id' => 2, // Assuming role_id = 2 is a regular user
        ]);
    }

    /** @test */
    public function it_can_list_all_categories()
    {
        // Manually create categories for testing
        Category::create(['name' => 'Category 1', 'user_id' => $this->adminUser->id]);
        Category::create(['name' => 'Category 2', 'user_id' => $this->regularUser->id]);

        // Log in as admin user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->adminUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response

        // Use the token to access the categories
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson('/api/categories');

        // Assert the response status and structure
        $response->assertStatus(200)
                 ->assertJsonCount(2, 'categories') // Check if 2 categories are returned
                 ->assertJsonStructure([ // Assert the structure of the returned JSON
                     'categories' => [
                         '*' => ['id', 'name', 'user_id', 'created_at', 'updated_at']
                     ]
                 ]);
    }

    /** @test */
    public function it_can_show_a_single_category()
    {
        // Manually create a category for testing
        $category = Category::create(['name' => 'Category 1', 'user_id' => $this->adminUser->id]);

        // Log in as admin user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->adminUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response

        // Use the token to access the specific category
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->getJson("/api/categories/{$category->id}");

        // Assert the response status and check if the correct category is returned
        $response->assertStatus(200)
                 ->assertJson(['category' => ['id' => $category->id, 'name' => 'Category 1']]);
    }

    /** @test */
    public function it_can_create_a_category_as_admin()
    {
        // Log in as admin user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->adminUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response

        // Use the token to create a new category
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->postJson('/api/categories', [
                             'name' => 'New Category', // Name of the new category
                         ]);

        // Assert the response status and check if the category was created
        $response->assertStatus(201) // Check for HTTP 201 Created status
                 ->assertJson(['category' => ['name' => 'New Category']]); // Check returned JSON

        // Verify that the category exists in the database
        $this->assertDatabaseHas('categories', ['name' => 'New Category']);
    }

    /** @test */
    public function it_cannot_create_category_as_regular_user()
    {
        // Log in as regular user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->regularUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response

        // Attempt to create a new category as a regular user
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->postJson('/api/categories', [
                             'name' => 'Category Attempt', // Name of the category attempt
                         ]);

        // Assert the response status (403 Forbidden)
        $response->assertStatus(403); // Forbidden

        // Verify that the category was not created in the database
        $this->assertDatabaseMissing('categories', ['name' => 'Category Attempt']);
    }

    /** @test */
    public function it_can_update_a_category_as_admin()
    {
        // Log in as admin user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->adminUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response
        
        // Manually create a category for testing
        $category = Category::create(['name' => 'Old Category', 'user_id' => $this->adminUser->id]);

        // Use the token to update the category
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->putJson("/api/categories/{$category->id}", [
                             'name' => 'Updated Category', // New name for the category
                         ]);

        // Assert the response status and check if the category was updated
        $response->assertStatus(200)
                 ->assertJson(['category' => ['name' => 'Updated Category']]);

        // Verify that the category is updated in the database
        $this->assertDatabaseHas('categories', ['id' => $category->id, 'name' => 'Updated Category']);
    }

    /** @test */
    public function it_cannot_update_a_category_as_regular_user()
    {
        // Log in as regular user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->regularUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response
        
        // Manually create a category for testing
        $category = Category::create(['name' => 'Old Category', 'user_id' => $this->adminUser->id]);

        // Attempt to update the category as a regular user
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->putJson("/api/categories/{$category->id}", [
                             'name' => 'Updated Category', // New name for the category
                         ]);

        // Assert the response status (403 Forbidden)
        $response->assertStatus(403); // Forbidden

        // Verify that the category has not changed in the database
        $this->assertDatabaseHas('categories', ['id' => $category->id, 'name' => 'Old Category']);
    }

    /** @test */
    public function it_can_delete_a_category_as_admin()
    {
        // Log in as admin user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->adminUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response
        
        // Manually create a category for testing
        $category = Category::create(['name' => 'Category to Delete', 'user_id' => $this->adminUser->id]);

        // Use the token to delete the category
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->deleteJson("/api/categories/{$category->id}");

        // Assert the response status and check the delete message
        $response->assertStatus(200)
                 ->assertJson(['message' => 'Category deleted successfully']);

        // Verify that the category is no longer in the database
        $this->assertDatabaseMissing('categories', ['id' => $category->id]);
    }

    /** @test */
    public function it_cannot_delete_a_category_as_regular_user()
    {
        // Log in as regular user to obtain a token
        $response = $this->postJson('/api/login', [
            'email' => $this->regularUser->email,
            'password' => 'password',
        ]);

        $token = $response->json()['token']; // Get the token from the response
        
        // Manually create a category for testing
        $category = Category::create(['name' => 'Category to Delete', 'user_id' => $this->adminUser->id]);

        // Attempt to delete the category as a regular user
        $response = $this->withHeaders(['Authorization' => 'Bearer ' . $token])
                         ->deleteJson("/api/categories/{$category->id}");

        // Assert the response status (403 Forbidden)
        $response->assertStatus(403); // Forbidden

        // Verify that the category is still in the database
        $this->assertDatabaseHas('categories', ['id' => $category->id]);
    }
}
