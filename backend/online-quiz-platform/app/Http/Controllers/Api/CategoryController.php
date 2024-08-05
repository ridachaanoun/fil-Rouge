<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Category;
use Illuminate\Support\Facades\Validator;
class CategoryController extends Controller
{
    use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;
// Display a listing of the categories.

    public function index()
    {
        $categories = Category::all();
        return response()->json(['categories' => $categories], 200);
    }

//  Display the specified category.

    public function show($id)
    {
        $category = Category::findOrFail($id);
        return response()->json(['category' => $category], 200);
    }

//  Create a new category.

    public function store(Request $request)
    {
        $user = Auth::user();

        // Authorize the action
        $this->authorize('create', Category::class);

        $validateCategory = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:categories',
            
        ]);
        if ($validateCategory->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validation error',
                'errors' => $validateCategory->errors()
            ], 401);
        }

        $category = Category::create([
            'name' => $request->name,
            'user_id' => $user->id,
        ]);

        return response()->json(['category' => $category], 201);
    }

//  Update the specified category.

    public function update(Request $request, $id)
    {
        $user = Auth::user();

        $category = Category::findOrFail($id);

        // Authorize the action
        $this->authorize('update', $category);
        $validateCategory = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:categories,name,' . $category->id,
            
        ]);
        if ($validateCategory->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validation error',
                'errors' => $validateCategory->errors()
            ], 401);
        }

        $category->update([
            'name' => $request->name,
        ]);

        return response()->json(['category' => $category], 200);
    }


      //Remove the specified category from storage.
 
    public function destroy($id)
    {
        $user = Auth::user();

        $category = Category::findOrFail($id);

        // Authorize the action
        $this->authorize('delete', $category);

        $category->delete();

        return response()->json(['message' => 'Category deleted successfully'], 200);
    }
}
