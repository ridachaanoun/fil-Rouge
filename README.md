<p align="center"> <a href="https://laravel.com" target="_blank"> <img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"> </a> </p> <p align="center"> <a href="https://github.com/laravel/framework/actions"> <img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"> </a> <a href="https://packagist.org/packages/laravel/framework"> <img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"> </a> <a href="https://packagist.org/packages/laravel/framework"> <img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"> </a> <a href="https://packagist.org/packages/laravel/framework"> <img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"> </a> </p> <h1 align="center">Online Quiz Platform</h1> <h3 align="center">Backend powered by Laravel, with a Vue.js frontend available <a href="https://github.com/ridachaanoun/quiz_frontend">here</a>.</h3>

### 🚀 About The Project:
- The Online Quiz Platform is a robust application where users can participate in quizzes, view their results, and administrators can manage quizzes and users.
- This repository contains the backend implementation built with Laravel.
- To get the frontend built with Vue.js, visit quiz_frontend.
  
### 🛠 Technologies Used:
<p align="center"> <img src="https://skillicons.dev/icons?i=laravel,postman,mysql,php,git" alt="Technologies" /> </p>

📄 Installation Instructions:

## Prerequisites
### Ensure the following tools are installed on your system:

- PHP (>= 8.1)
- Composer
- Node.js and npm
- MySQL
- Git

### Step 1: Clone the Repository
  ```bash
  git clone https://github.com/your-username/online-quiz-platform.git
  cd fil-Rouge
  cd backend
  cd online-quiz-platform
  ```
2. Install PHP and Node.js dependencies:

    ```bash
    composer install
    npm install
3. Build the frontend assets:
    ```bash
    npm run dev
    
#### Step 2: Set Up Environment Variables
1. Copy the .env.example file to .env:
    ```bash
    cp .env.example .env
2. Configure the database and other environment settings in the .env file.
.Update the database settings to match your local or remote database configuration:
    ```bash
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=your_database_name
    DB_USERNAME=your_database_username
    DB_PASSWORD=your_database_password

3. Generate the application key:
     ```bash
    php artisan key:generate
     
#### Step 3: Migrate the Database
1. Run migrations to set up your database tables:
   ```bash
   php artisan migrate
2. Seed the database :
   ```bash
   php artisan db:seed
   
#### 3.Import the quiz-platform.sql file:
     After running the migrations, import the quiz-platform.sql file into your database.
    
#### Step 4: Serve the Application
1. Start the Laravel development server:    
    ```bash
    php artisan storage:link
    php artisan serve
- By default, the application will be available at http://localhost:8000.
Getting Started

---

### 🌐 API Endpoints

#### Authentication
| Endpoint           | Method | Description           |
|--------------------|--------|-----------------------|
| `/api/register`    | POST   | Register a new user   |
| `/api/login`       | POST   | User login            |
| `/api/logout`      | POST   | User logout (protected) |

---

#### Categories
| Endpoint                  | Method | Description                          |
|---------------------------|--------|--------------------------------------|
| `/api/categories`         | POST   | Create a new category (protected)    |
| `/api/categories/{id}`    | PUT    | Update an existing category (protected) |
| `/api/categories/{id}`    | DELETE | Delete a category (protected)        |
| `/api/categories`         | GET    | Get all categories                   |
| `/api/categories/{id}`    | GET    | Get category details by ID           |

---

#### Quizzes
| Endpoint                     | Method | Description                              |
|------------------------------|--------|------------------------------------------|
| `/api/quizzes`               | GET    | Get all quizzes                          |
| `/api/quizzes`               | POST   | Create a new quiz (protected)            |
| `/api/quizzes/{quiz}`        | GET    | Get quiz details by ID                   |
| `/api/quizzes/{quiz}`        | PUT    | Update an existing quiz (protected)      |
| `/api/quizzes/{quiz}`        | DELETE | Delete a quiz (protected)                |
| `/api/user-quizzes/{id}`     | GET    | Get quizzes created by a specific user   |

---

#### Questions
| Endpoint                           | Method | Description                              |
|------------------------------------|--------|------------------------------------------|
| `/api/questions`                   | POST   | Add a question to a quiz (protected)     |
| `/api/quizzes/{quiz}/questions`    | GET    | Get all questions for a specific quiz    |
| `/api/questions/{question}`        | GET    | Get details of a specific question       |
| `/api/questions/{question}`        | PUT    | Update a specific question (protected)   |
| `/api/questions/{question}`        | DELETE | Delete a question (protected)            |

---

#### Quiz Attempts
| Endpoint                         | Method | Description                              |
|----------------------------------|--------|------------------------------------------|
| `/api/quizzes/{quiz}/attempts`   | POST   | Submit a quiz attempt                    |
| `/api/attempts`                  | GET    | Get all quiz attempts (protected)        |
| `/api/attempts/{attempt}`        | GET    | Get details of a specific quiz attempt   |

---

#### Profiles
| Endpoint                           | Method | Description                                  |
|------------------------------------|--------|----------------------------------------------|
| `/api/profile/bio`                 | POST   | Update user bio                              |
| `/api/profile/picture`             | POST   | Update user profile picture                  |
| `/api/profile/remove-picture`      | POST   | Remove user profile picture                  |
| `/api/profiles`                    | GET    | Get all user profiles                        |
| `/api/profiles/{id}`               | GET    | Get a specific user's profile by ID          |
| `/api/user`                        | GET    | Get currently logged-in user's profile       |

---

#### Notifications
| Endpoint                           | Method | Description                              |
|------------------------------------|--------|------------------------------------------|
| `/api/notifications`               | GET    | Get all notifications for the user       |
| `/api/notifications/{id}/read`     | PUT    | Mark a notification as read              |

---

#### Follows
| Endpoint                           | Method | Description                              |
|------------------------------------|--------|------------------------------------------|
| `/api/follow/{id}`                 | POST   | Follow a user                            |
| `/api/unfollow/{id}`               | POST   | Unfollow a user                          |
| `/api/followers/{id}`              | GET    | Get all followers for a user             |
| `/api/following/{id}`              | GET    | Get all users that a user is following   |
| `/api/is-following/{id}`           | GET    | Check if the logged-in user follows a specific user |

---

#### User Management
| Endpoint                           | Method | Description                              |
|------------------------------------|--------|------------------------------------------|
| `/api/users/{user}/role`           | PUT    | Change the role of a user (admin only)   |
| `/api/user/update-username`        | PUT    | Update the username of the logged-in user|
| `/api/user/update-email`           | PUT    | Update the email of the logged-in user   |
| `/api/user/update-password`        | PUT    | Update the password of the logged-in user|

---
📧 Contact:
For questions or support, contact ridachaanoun.ff.2@gmail.com.
