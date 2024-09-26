-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 25, 2024 at 09:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz-platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('62RwB8ucP6EsrETG', 's:7:\"forever\";', 2040065853),
('6Q0YGZ7ewmZn2N6v', 's:7:\"forever\";', 2040066453);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `user_id`, `name`, `created_at`, `updated_at`) VALUES
(5, 1, 'reda000', '2024-08-13 11:34:57', '2024-09-02 09:43:17'),
(9, 1, 'ss', '2024-08-15 11:48:54', '2024-08-15 11:48:54'),
(10, 1, 'hi222', '2024-08-15 11:53:54', '2024-08-22 10:13:56'),
(15, 1, 'rewww', '2024-08-22 09:59:10', '2024-08-22 09:59:10'),
(17, 1, 'r200', '2024-08-22 10:19:22', '2024-08-28 08:34:45'),
(19, 1, 'ee ffedd', '2024-08-28 08:34:58', '2024-08-28 10:42:26'),
(26, 1, 'aaa', '2024-09-02 11:23:33', '2024-09-02 11:23:33'),
(28, 1, 'hi1', '2024-09-14 21:56:42', '2024-09-19 08:56:30'),
(29, 1, 'redaee', '2024-09-19 08:58:04', '2024-09-19 08:58:04'),
(30, 1, 'reda', '2024-09-24 20:48:07', '2024-09-24 20:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE `follows` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `follower_id` bigint(20) UNSIGNED NOT NULL,
  `followed_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `follows`
--

INSERT INTO `follows` (`id`, `follower_id`, `followed_id`, `created_at`, `updated_at`) VALUES
(2, 3, 1, NULL, NULL),
(3, 4, 1, NULL, NULL),
(16, 1, 4, NULL, NULL),
(17, 1, 1, NULL, NULL),
(18, 1, 3, NULL, NULL),
(19, 8, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(25, '0000_07_30_123148_create_roles_table', 1),
(26, '0001_01_01_000000_create_users_table', 1),
(27, '0001_01_01_000001_create_cache_table', 1),
(28, '0001_01_01_000002_create_jobs_table', 1),
(29, '2024_07_30_123148_create_categories_table', 1),
(30, '2024_07_30_123149_create_profiles_table', 1),
(31, '2024_07_30_123150_create_notifications_table', 1),
(32, '2024_07_30_124520_create_personal_access_tokens_table', 1),
(33, '2024_08_06_141632_create_follows_table', 1),
(34, '2024_08_30_123149_create_quizzes_table', 1),
(35, '2024_08_31_123149_create_quiz_attempts_table', 1),
(36, '2024_09_05_121110_create_questions_table', 1),
(37, '2025_08_15_114634_add_image_to_quizzes_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `data` text NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `data`, `read`, `created_at`, `updated_at`) VALUES
(1, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"1\",\"description\":\"reda\",\"user_id\":1,\"updated_at\":\"2024-08-06T15:53:03.000000Z\",\"created_at\":\"2024-08-06T15:53:03.000000Z\",\"id\":3}}', 0, '2024-08-06 14:53:03', '2024-08-06 14:53:03'),
(2, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"2\",\"description\":\"reda\",\"user_id\":1,\"updated_at\":\"2024-08-15T10:57:51.000000Z\",\"created_at\":\"2024-08-15T10:57:51.000000Z\",\"id\":4}}', 0, '2024-08-15 09:57:51', '2024-08-15 09:57:51'),
(3, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"2\",\"description\":\"reda\",\"user_id\":1,\"updated_at\":\"2024-08-15T10:57:51.000000Z\",\"created_at\":\"2024-08-15T10:57:51.000000Z\",\"id\":4}}', 0, '2024-08-15 09:57:51', '2024-08-15 09:57:51'),
(4, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"math quiz\",\"category_id\":\"2\",\"description\":\"reda 20001\",\"user_id\":1,\"updated_at\":\"2024-08-15T11:22:41.000000Z\",\"created_at\":\"2024-08-15T11:22:41.000000Z\",\"id\":5}}', 0, '2024-08-15 10:22:41', '2024-08-15 10:22:41'),
(5, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"math quiz\",\"category_id\":\"2\",\"description\":\"reda 20001\",\"user_id\":1,\"updated_at\":\"2024-08-15T11:22:41.000000Z\",\"created_at\":\"2024-08-15T11:22:41.000000Z\",\"id\":5}}', 0, '2024-08-15 10:22:41', '2024-08-15 10:22:41'),
(6, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"redaddd\",\"category_id\":3,\"description\":\"dddddddd\",\"user_id\":1,\"updated_at\":\"2024-08-15T11:31:18.000000Z\",\"created_at\":\"2024-08-15T11:31:18.000000Z\",\"id\":6}}', 0, '2024-08-15 10:31:18', '2024-08-15 10:31:18'),
(7, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"redaddd\",\"category_id\":3,\"description\":\"dddddddd\",\"user_id\":1,\"updated_at\":\"2024-08-15T11:31:18.000000Z\",\"created_at\":\"2024-08-15T11:31:18.000000Z\",\"id\":6}}', 0, '2024-08-15 10:31:18', '2024-08-15 10:31:18'),
(8, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"image\",\"category_id\":\"2\",\"description\":\"iiiiiiiiiii\",\"user_id\":1,\"updated_at\":\"2024-08-15T11:39:55.000000Z\",\"created_at\":\"2024-08-15T11:39:55.000000Z\",\"id\":7}}', 0, '2024-08-15 10:39:55', '2024-08-15 10:39:55'),
(9, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"image\",\"category_id\":\"2\",\"description\":\"iiiiiiiiiii\",\"user_id\":1,\"updated_at\":\"2024-08-15T11:39:55.000000Z\",\"created_at\":\"2024-08-15T11:39:55.000000Z\",\"id\":7}}', 0, '2024-08-15 10:39:55', '2024-08-15 10:39:55'),
(10, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"2\",\"description\":\"qqqq\",\"user_id\":1,\"image\":\"images\\/62zStJg2zbQPiNcnq1OO6wRTItfAw9JSJzbQY1oA.png\",\"updated_at\":\"2024-08-15T11:47:47.000000Z\",\"created_at\":\"2024-08-15T11:47:47.000000Z\",\"id\":8}}', 0, '2024-08-15 10:47:47', '2024-08-15 10:47:47'),
(11, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"2\",\"description\":\"qqqq\",\"user_id\":1,\"image\":\"images\\/62zStJg2zbQPiNcnq1OO6wRTItfAw9JSJzbQY1oA.png\",\"updated_at\":\"2024-08-15T11:47:47.000000Z\",\"created_at\":\"2024-08-15T11:47:47.000000Z\",\"id\":8}}', 0, '2024-08-15 10:47:47', '2024-08-15 10:47:47'),
(12, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"9\",\"description\":\"redawwww\",\"user_id\":1,\"image\":\"images\\/TXawZPTNgkMywAzxtf6v1S8yMwhkD4mn27fknXMD.png\",\"updated_at\":\"2024-08-22T11:25:10.000000Z\",\"created_at\":\"2024-08-22T11:25:10.000000Z\",\"id\":9}}', 0, '2024-08-22 10:25:10', '2024-08-22 10:25:10'),
(13, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"9\",\"description\":\"redawwww\",\"user_id\":1,\"image\":\"images\\/TXawZPTNgkMywAzxtf6v1S8yMwhkD4mn27fknXMD.png\",\"updated_at\":\"2024-08-22T11:25:10.000000Z\",\"created_at\":\"2024-08-22T11:25:10.000000Z\",\"id\":9}}', 0, '2024-08-22 10:25:10', '2024-08-22 10:25:10'),
(14, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"eeee\",\"category_id\":\"9\",\"description\":\"eeeeeee\",\"user_id\":1,\"image\":\"images\\/ADnWaCbnNMyCTUPJngyIw9TgTrNovUxvYxso15rL.png\",\"updated_at\":\"2024-08-22T11:44:35.000000Z\",\"created_at\":\"2024-08-22T11:44:35.000000Z\",\"id\":10}}', 0, '2024-08-22 10:44:35', '2024-08-22 10:44:35'),
(15, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"eeee\",\"category_id\":\"9\",\"description\":\"eeeeeee\",\"user_id\":1,\"image\":\"images\\/ADnWaCbnNMyCTUPJngyIw9TgTrNovUxvYxso15rL.png\",\"updated_at\":\"2024-08-22T11:44:35.000000Z\",\"created_at\":\"2024-08-22T11:44:35.000000Z\",\"id\":10}}', 0, '2024-08-22 10:44:35', '2024-08-22 10:44:35'),
(16, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"sqsqsq\",\"category_id\":\"9\",\"description\":\"sqsqsqs\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-22T11:51:32.000000Z\",\"created_at\":\"2024-08-22T11:51:32.000000Z\",\"id\":11}}', 0, '2024-08-22 10:51:32', '2024-08-22 10:51:32'),
(17, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"sqsqsq\",\"category_id\":\"9\",\"description\":\"sqsqsqs\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-22T11:51:32.000000Z\",\"created_at\":\"2024-08-22T11:51:32.000000Z\",\"id\":11}}', 0, '2024-08-22 10:51:32', '2024-08-22 10:51:32'),
(18, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":\"images\\/YNLqiFquLiRqueHOIOmBPWQGCNxX6TcCDgVZxIVp.png\",\"updated_at\":\"2024-08-22T13:22:53.000000Z\",\"created_at\":\"2024-08-22T13:22:53.000000Z\",\"id\":12}}', 0, '2024-08-22 12:22:53', '2024-08-22 12:22:53'),
(19, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":\"images\\/YNLqiFquLiRqueHOIOmBPWQGCNxX6TcCDgVZxIVp.png\",\"updated_at\":\"2024-08-22T13:22:53.000000Z\",\"created_at\":\"2024-08-22T13:22:53.000000Z\",\"id\":12}}', 0, '2024-08-22 12:22:53', '2024-08-22 12:22:53'),
(20, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":\"images\\/LC98Z92DJaU0CRWJu2UbyITTajN0EebI14ylwgZh.png\",\"updated_at\":\"2024-08-28T09:46:55.000000Z\",\"created_at\":\"2024-08-28T09:46:55.000000Z\",\"id\":13}}', 0, '2024-08-28 08:46:55', '2024-08-28 08:46:55'),
(21, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"new 200\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":\"images\\/LC98Z92DJaU0CRWJu2UbyITTajN0EebI14ylwgZh.png\",\"updated_at\":\"2024-08-28T09:46:55.000000Z\",\"created_at\":\"2024-08-28T09:46:55.000000Z\",\"id\":13}}', 0, '2024-08-28 08:46:55', '2024-08-28 08:46:55'),
(22, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ddd\",\"category_id\":\"5\",\"description\":\"ddd\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-28T10:11:29.000000Z\",\"created_at\":\"2024-08-28T10:11:29.000000Z\",\"id\":14}}', 0, '2024-08-28 09:11:29', '2024-08-28 09:11:29'),
(23, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ddd\",\"category_id\":\"5\",\"description\":\"ddd\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-28T10:11:29.000000Z\",\"created_at\":\"2024-08-28T10:11:29.000000Z\",\"id\":14}}', 0, '2024-08-28 09:11:29', '2024-08-28 09:11:29'),
(24, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"444\",\"category_id\":\"5\",\"description\":\"4444\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-28T10:14:21.000000Z\",\"created_at\":\"2024-08-28T10:14:21.000000Z\",\"id\":15}}', 0, '2024-08-28 09:14:21', '2024-08-28 09:14:21'),
(25, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"444\",\"category_id\":\"5\",\"description\":\"4444\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-28T10:14:21.000000Z\",\"created_at\":\"2024-08-28T10:14:21.000000Z\",\"id\":15}}', 0, '2024-08-28 09:14:21', '2024-08-28 09:14:21'),
(26, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"4444\",\"category_id\":\"5\",\"description\":\"444\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-28T10:14:37.000000Z\",\"created_at\":\"2024-08-28T10:14:37.000000Z\",\"id\":16}}', 0, '2024-08-28 09:14:37', '2024-08-28 09:14:37'),
(27, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"4444\",\"category_id\":\"5\",\"description\":\"444\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-08-28T10:14:37.000000Z\",\"created_at\":\"2024-08-28T10:14:37.000000Z\",\"id\":16}}', 0, '2024-08-28 09:14:37', '2024-08-28 09:14:37'),
(28, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"444\",\"category_id\":\"5\",\"description\":\"4444\",\"user_id\":1,\"image\":\"images\\/hxiyf1VWyAar9SlDuV8ukkMJpkMoyeJ9J16x1v2i.png\",\"updated_at\":\"2024-08-28T10:15:17.000000Z\",\"created_at\":\"2024-08-28T10:15:17.000000Z\",\"id\":17}}', 0, '2024-08-28 09:15:17', '2024-08-28 09:15:17'),
(29, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"444\",\"category_id\":\"5\",\"description\":\"4444\",\"user_id\":1,\"image\":\"images\\/hxiyf1VWyAar9SlDuV8ukkMJpkMoyeJ9J16x1v2i.png\",\"updated_at\":\"2024-08-28T10:15:17.000000Z\",\"created_at\":\"2024-08-28T10:15:17.000000Z\",\"id\":17}}', 0, '2024-08-28 09:15:17', '2024-08-28 09:15:17'),
(30, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"aaaa\",\"category_id\":\"5\",\"description\":\"aaa\",\"user_id\":1,\"image\":\"images\\/wiG3Hw88dAnr2AbsUwUCj1lq1PJs7gRkm9O8YfGN.png\",\"updated_at\":\"2024-08-28T11:37:21.000000Z\",\"created_at\":\"2024-08-28T11:37:21.000000Z\",\"id\":18}}', 0, '2024-08-28 10:37:21', '2024-08-28 10:37:21'),
(31, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"aaaa\",\"category_id\":\"5\",\"description\":\"aaa\",\"user_id\":1,\"image\":\"images\\/wiG3Hw88dAnr2AbsUwUCj1lq1PJs7gRkm9O8YfGN.png\",\"updated_at\":\"2024-08-28T11:37:21.000000Z\",\"created_at\":\"2024-08-28T11:37:21.000000Z\",\"id\":18}}', 0, '2024-08-28 10:37:21', '2024-08-28 10:37:21'),
(32, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"0000\",\"category_id\":\"5\",\"description\":\"00000\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-02T11:46:40.000000Z\",\"created_at\":\"2024-09-02T11:46:40.000000Z\",\"id\":19}}', 0, '2024-09-02 10:46:40', '2024-09-02 10:46:40'),
(33, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"0000\",\"category_id\":\"5\",\"description\":\"00000\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-02T11:46:40.000000Z\",\"created_at\":\"2024-09-02T11:46:40.000000Z\",\"id\":19}}', 0, '2024-09-02 10:46:40', '2024-09-02 10:46:40'),
(34, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"000\",\"category_id\":\"5\",\"description\":\"000\",\"user_id\":1,\"image\":\"images\\/BUh1l3Y4TqfCKhGNx29Bo84yn3jPs8BIaPhWENP9.png\",\"updated_at\":\"2024-09-02T11:47:13.000000Z\",\"created_at\":\"2024-09-02T11:47:13.000000Z\",\"id\":20}}', 0, '2024-09-02 10:47:13', '2024-09-02 10:47:13'),
(35, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"000\",\"category_id\":\"5\",\"description\":\"000\",\"user_id\":1,\"image\":\"images\\/BUh1l3Y4TqfCKhGNx29Bo84yn3jPs8BIaPhWENP9.png\",\"updated_at\":\"2024-09-02T11:47:13.000000Z\",\"created_at\":\"2024-09-02T11:47:13.000000Z\",\"id\":20}}', 0, '2024-09-02 10:47:13', '2024-09-02 10:47:13'),
(36, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"555\",\"category_id\":\"5\",\"description\":\"5555\",\"user_id\":1,\"image\":\"images\\/DnCZpfyxiITpHphIae7Lxe2hT3ZwRP9IGct2zW3K.png\",\"updated_at\":\"2024-09-02T12:27:39.000000Z\",\"created_at\":\"2024-09-02T12:27:39.000000Z\",\"id\":21}}', 0, '2024-09-02 11:27:39', '2024-09-02 11:27:39'),
(37, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"555\",\"category_id\":\"5\",\"description\":\"5555\",\"user_id\":1,\"image\":\"images\\/DnCZpfyxiITpHphIae7Lxe2hT3ZwRP9IGct2zW3K.png\",\"updated_at\":\"2024-09-02T12:27:39.000000Z\",\"created_at\":\"2024-09-02T12:27:39.000000Z\",\"id\":21}}', 0, '2024-09-02 11:27:39', '2024-09-02 11:27:39'),
(38, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"refda\",\"category_id\":\"26\",\"description\":\"qqqq\",\"user_id\":1,\"image\":\"images\\/38wkqy94fXYvrjtvbFG39UyPxsVPHw5sic0jsZ9a.png\",\"updated_at\":\"2024-09-02T15:34:45.000000Z\",\"created_at\":\"2024-09-02T15:34:45.000000Z\",\"id\":22}}', 0, '2024-09-02 14:34:45', '2024-09-02 14:34:45'),
(39, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"refda\",\"category_id\":\"26\",\"description\":\"qqqq\",\"user_id\":1,\"image\":\"images\\/38wkqy94fXYvrjtvbFG39UyPxsVPHw5sic0jsZ9a.png\",\"updated_at\":\"2024-09-02T15:34:45.000000Z\",\"created_at\":\"2024-09-02T15:34:45.000000Z\",\"id\":22}}', 0, '2024-09-02 14:34:45', '2024-09-02 14:34:45'),
(40, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"10\",\"category_id\":\"5\",\"description\":\"10\",\"user_id\":1,\"image\":\"images\\/FaLSQjnGGL77BUbOugGkAGTxr6UsnG7OtY74oZ1F.png\",\"updated_at\":\"2024-09-05T09:39:08.000000Z\",\"created_at\":\"2024-09-05T09:39:08.000000Z\",\"id\":23}}', 0, '2024-09-05 08:39:08', '2024-09-05 08:39:08'),
(41, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"10\",\"category_id\":\"5\",\"description\":\"10\",\"user_id\":1,\"image\":\"images\\/FaLSQjnGGL77BUbOugGkAGTxr6UsnG7OtY74oZ1F.png\",\"updated_at\":\"2024-09-05T09:39:08.000000Z\",\"created_at\":\"2024-09-05T09:39:08.000000Z\",\"id\":23}}', 0, '2024-09-05 08:39:08', '2024-09-05 08:39:08'),
(42, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"a\",\"category_id\":\"5\",\"description\":\"a\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:27:46.000000Z\",\"created_at\":\"2024-09-05T10:27:46.000000Z\",\"id\":24}}', 0, '2024-09-05 09:27:46', '2024-09-05 09:27:46'),
(43, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"a\",\"category_id\":\"5\",\"description\":\"a\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:27:46.000000Z\",\"created_at\":\"2024-09-05T10:27:46.000000Z\",\"id\":24}}', 0, '2024-09-05 09:27:46', '2024-09-05 09:27:46'),
(44, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"a\",\"category_id\":\"5\",\"description\":\"aa\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:01.000000Z\",\"created_at\":\"2024-09-05T10:28:01.000000Z\",\"id\":25}}', 0, '2024-09-05 09:28:01', '2024-09-05 09:28:01'),
(45, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"a\",\"category_id\":\"5\",\"description\":\"aa\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:01.000000Z\",\"created_at\":\"2024-09-05T10:28:01.000000Z\",\"id\":25}}', 0, '2024-09-05 09:28:01', '2024-09-05 09:28:01'),
(46, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"q\",\"category_id\":\"5\",\"description\":\"q\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:16.000000Z\",\"created_at\":\"2024-09-05T10:28:16.000000Z\",\"id\":26}}', 0, '2024-09-05 09:28:16', '2024-09-05 09:28:16'),
(47, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"q\",\"category_id\":\"5\",\"description\":\"q\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:16.000000Z\",\"created_at\":\"2024-09-05T10:28:16.000000Z\",\"id\":26}}', 0, '2024-09-05 09:28:16', '2024-09-05 09:28:16'),
(48, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:24.000000Z\",\"created_at\":\"2024-09-05T10:28:24.000000Z\",\"id\":27}}', 0, '2024-09-05 09:28:24', '2024-09-05 09:28:24'),
(49, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:24.000000Z\",\"created_at\":\"2024-09-05T10:28:24.000000Z\",\"id\":27}}', 0, '2024-09-05 09:28:24', '2024-09-05 09:28:24'),
(50, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:41.000000Z\",\"created_at\":\"2024-09-05T10:28:41.000000Z\",\"id\":28}}', 0, '2024-09-05 09:28:41', '2024-09-05 09:28:41'),
(51, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:41.000000Z\",\"created_at\":\"2024-09-05T10:28:41.000000Z\",\"id\":28}}', 0, '2024-09-05 09:28:41', '2024-09-05 09:28:41'),
(52, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:51.000000Z\",\"created_at\":\"2024-09-05T10:28:51.000000Z\",\"id\":29}}', 0, '2024-09-05 09:28:51', '2024-09-05 09:28:51'),
(53, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:51.000000Z\",\"created_at\":\"2024-09-05T10:28:51.000000Z\",\"id\":29}}', 0, '2024-09-05 09:28:51', '2024-09-05 09:28:51'),
(54, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:57.000000Z\",\"created_at\":\"2024-09-05T10:28:57.000000Z\",\"id\":30}}', 0, '2024-09-05 09:28:57', '2024-09-05 09:28:57'),
(55, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:28:57.000000Z\",\"created_at\":\"2024-09-05T10:28:57.000000Z\",\"id\":30}}', 0, '2024-09-05 09:28:57', '2024-09-05 09:28:57'),
(56, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:04.000000Z\",\"created_at\":\"2024-09-05T10:29:04.000000Z\",\"id\":31}}', 0, '2024-09-05 09:29:04', '2024-09-05 09:29:04'),
(57, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:04.000000Z\",\"created_at\":\"2024-09-05T10:29:04.000000Z\",\"id\":31}}', 0, '2024-09-05 09:29:04', '2024-09-05 09:29:04'),
(58, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qqqq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:11.000000Z\",\"created_at\":\"2024-09-05T10:29:11.000000Z\",\"id\":32}}', 0, '2024-09-05 09:29:11', '2024-09-05 09:29:11'),
(59, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qq\",\"category_id\":\"5\",\"description\":\"qqqq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:11.000000Z\",\"created_at\":\"2024-09-05T10:29:11.000000Z\",\"id\":32}}', 0, '2024-09-05 09:29:11', '2024-09-05 09:29:11'),
(60, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qqq\",\"category_id\":\"5\",\"description\":\"qqq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:20.000000Z\",\"created_at\":\"2024-09-05T10:29:20.000000Z\",\"id\":33}}', 0, '2024-09-05 09:29:20', '2024-09-05 09:29:20'),
(61, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qqq\",\"category_id\":\"5\",\"description\":\"qqq\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:20.000000Z\",\"created_at\":\"2024-09-05T10:29:20.000000Z\",\"id\":33}}', 0, '2024-09-05 09:29:20', '2024-09-05 09:29:20'),
(62, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ff\",\"category_id\":\"5\",\"description\":\"fff\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:31.000000Z\",\"created_at\":\"2024-09-05T10:29:31.000000Z\",\"id\":34}}', 0, '2024-09-05 09:29:31', '2024-09-05 09:29:31'),
(63, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ff\",\"category_id\":\"5\",\"description\":\"fff\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:31.000000Z\",\"created_at\":\"2024-09-05T10:29:31.000000Z\",\"id\":34}}', 0, '2024-09-05 09:29:31', '2024-09-05 09:29:31'),
(64, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ff\",\"category_id\":\"5\",\"description\":\"ffs\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:37.000000Z\",\"created_at\":\"2024-09-05T10:29:37.000000Z\",\"id\":35}}', 0, '2024-09-05 09:29:37', '2024-09-05 09:29:37'),
(65, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ff\",\"category_id\":\"5\",\"description\":\"ffs\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:37.000000Z\",\"created_at\":\"2024-09-05T10:29:37.000000Z\",\"id\":35}}', 0, '2024-09-05 09:29:37', '2024-09-05 09:29:37'),
(66, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ff\",\"category_id\":\"5\",\"description\":\"fe\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:41.000000Z\",\"created_at\":\"2024-09-05T10:29:41.000000Z\",\"id\":36}}', 0, '2024-09-05 09:29:41', '2024-09-05 09:29:41'),
(67, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"ff\",\"category_id\":\"5\",\"description\":\"fe\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-05T10:29:41.000000Z\",\"created_at\":\"2024-09-05T10:29:41.000000Z\",\"id\":36}}', 0, '2024-09-05 09:29:41', '2024-09-05 09:29:41'),
(68, 3, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qqq23\",\"category_id\":\"5\",\"description\":\"qqq23\",\"user_id\":1,\"image\":\"images\\/w1fladYbgiBmTqV56JJ27dA4kZZyujpdORGcadw1.png\",\"updated_at\":\"2024-09-19T09:57:24.000000Z\",\"created_at\":\"2024-09-19T09:57:24.000000Z\",\"id\":38}}', 0, '2024-09-19 08:57:24', '2024-09-19 08:57:24'),
(69, 4, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qqq23\",\"category_id\":\"5\",\"description\":\"qqq23\",\"user_id\":1,\"image\":\"images\\/w1fladYbgiBmTqV56JJ27dA4kZZyujpdORGcadw1.png\",\"updated_at\":\"2024-09-19T09:57:24.000000Z\",\"created_at\":\"2024-09-19T09:57:24.000000Z\",\"id\":38}}', 0, '2024-09-19 08:57:24', '2024-09-19 08:57:24'),
(70, 1, 'quiz_added', '{\"message\":\"A new quiz was added by reda\",\"quiz\":{\"title\":\"qqq23\",\"category_id\":\"5\",\"description\":\"qqq23\",\"user_id\":1,\"image\":\"images\\/w1fladYbgiBmTqV56JJ27dA4kZZyujpdORGcadw1.png\",\"updated_at\":\"2024-09-19T09:57:24.000000Z\",\"created_at\":\"2024-09-19T09:57:24.000000Z\",\"id\":38}}', 0, '2024-09-19 08:57:24', '2024-09-19 08:57:24'),
(71, 3, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"ss\",\"category_id\":\"5\",\"description\":\"ssss\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T20:32:09.000000Z\",\"created_at\":\"2024-09-24T20:32:09.000000Z\",\"id\":39}}', 0, '2024-09-24 19:32:09', '2024-09-24 19:32:09'),
(72, 4, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"ss\",\"category_id\":\"5\",\"description\":\"ssss\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T20:32:09.000000Z\",\"created_at\":\"2024-09-24T20:32:09.000000Z\",\"id\":39}}', 0, '2024-09-24 19:32:09', '2024-09-24 19:32:09'),
(73, 1, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"ss\",\"category_id\":\"5\",\"description\":\"ssss\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T20:32:09.000000Z\",\"created_at\":\"2024-09-24T20:32:09.000000Z\",\"id\":39}}', 0, '2024-09-24 19:32:09', '2024-09-24 19:32:09'),
(74, 3, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"111\",\"user_id\":1,\"image\":\"images\\/cjcRCojzxO5jZ0NSmioXrWmIXjXbOLX3P5hzC3Yk.png\",\"updated_at\":\"2024-09-24T21:06:18.000000Z\",\"created_at\":\"2024-09-24T21:06:18.000000Z\",\"id\":40}}', 0, '2024-09-24 20:06:18', '2024-09-24 20:06:18'),
(75, 4, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"111\",\"user_id\":1,\"image\":\"images\\/cjcRCojzxO5jZ0NSmioXrWmIXjXbOLX3P5hzC3Yk.png\",\"updated_at\":\"2024-09-24T21:06:18.000000Z\",\"created_at\":\"2024-09-24T21:06:18.000000Z\",\"id\":40}}', 0, '2024-09-24 20:06:18', '2024-09-24 20:06:18'),
(76, 1, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"111\",\"user_id\":1,\"image\":\"images\\/cjcRCojzxO5jZ0NSmioXrWmIXjXbOLX3P5hzC3Yk.png\",\"updated_at\":\"2024-09-24T21:06:18.000000Z\",\"created_at\":\"2024-09-24T21:06:18.000000Z\",\"id\":40}}', 0, '2024-09-24 20:06:18', '2024-09-24 20:06:18'),
(77, 3, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"28\",\"description\":\"123\",\"user_id\":1,\"image\":\"images\\/fR94cnl5lkqHXseoXXhXNaTkJCLnhp4zOSugWFgz.png\",\"updated_at\":\"2024-09-24T21:10:29.000000Z\",\"created_at\":\"2024-09-24T21:10:29.000000Z\",\"id\":41}}', 0, '2024-09-24 20:10:29', '2024-09-24 20:10:29'),
(78, 4, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"28\",\"description\":\"123\",\"user_id\":1,\"image\":\"images\\/fR94cnl5lkqHXseoXXhXNaTkJCLnhp4zOSugWFgz.png\",\"updated_at\":\"2024-09-24T21:10:29.000000Z\",\"created_at\":\"2024-09-24T21:10:29.000000Z\",\"id\":41}}', 0, '2024-09-24 20:10:29', '2024-09-24 20:10:29'),
(79, 1, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"28\",\"description\":\"123\",\"user_id\":1,\"image\":\"images\\/fR94cnl5lkqHXseoXXhXNaTkJCLnhp4zOSugWFgz.png\",\"updated_at\":\"2024-09-24T21:10:29.000000Z\",\"created_at\":\"2024-09-24T21:10:29.000000Z\",\"id\":41}}', 0, '2024-09-24 20:10:29', '2024-09-24 20:10:29'),
(80, 3, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"11\",\"category_id\":\"9\",\"description\":\"111\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T21:47:13.000000Z\",\"created_at\":\"2024-09-24T21:47:13.000000Z\",\"id\":42}}', 0, '2024-09-24 20:47:13', '2024-09-24 20:47:13'),
(81, 4, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"11\",\"category_id\":\"9\",\"description\":\"111\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T21:47:13.000000Z\",\"created_at\":\"2024-09-24T21:47:13.000000Z\",\"id\":42}}', 0, '2024-09-24 20:47:13', '2024-09-24 20:47:13'),
(82, 1, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"11\",\"category_id\":\"9\",\"description\":\"111\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T21:47:13.000000Z\",\"created_at\":\"2024-09-24T21:47:13.000000Z\",\"id\":42}}', 0, '2024-09-24 20:47:13', '2024-09-24 20:47:13'),
(83, 3, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T21:49:29.000000Z\",\"created_at\":\"2024-09-24T21:49:29.000000Z\",\"id\":43}}', 0, '2024-09-24 20:49:29', '2024-09-24 20:49:29'),
(84, 4, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T21:49:29.000000Z\",\"created_at\":\"2024-09-24T21:49:29.000000Z\",\"id\":43}}', 0, '2024-09-24 20:49:29', '2024-09-24 20:49:29'),
(85, 1, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"reda\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T21:49:29.000000Z\",\"created_at\":\"2024-09-24T21:49:29.000000Z\",\"id\":43}}', 0, '2024-09-24 20:49:29', '2024-09-24 20:49:29'),
(86, 3, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"dad\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T22:03:19.000000Z\",\"created_at\":\"2024-09-24T22:03:19.000000Z\",\"id\":44}}', 0, '2024-09-24 21:03:19', '2024-09-24 21:03:19'),
(87, 4, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"dad\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T22:03:19.000000Z\",\"created_at\":\"2024-09-24T22:03:19.000000Z\",\"id\":44}}', 0, '2024-09-24 21:03:19', '2024-09-24 21:03:19'),
(88, 1, 'quiz_added', '{\"message\":\"A new quiz was added by New Username\",\"quiz\":{\"title\":\"reda\",\"category_id\":\"5\",\"description\":\"dad\",\"user_id\":1,\"image\":null,\"updated_at\":\"2024-09-24T22:03:19.000000Z\",\"created_at\":\"2024-09-24T22:03:19.000000Z\",\"id\":44}}', 0, '2024-09-24 21:03:19', '2024-09-24 21:03:19');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Personal Access Token', 'be63ae3c06797f0fb299d111663307fb5373a409a76c5f0f83e65221ddeddfb3', '[\"*\"]', '2024-08-13 10:02:34', NULL, '2024-08-06 14:30:28', '2024-08-13 10:02:34'),
(2, 'App\\Models\\User', 2, 'Personal Access Token', 'ec1fa1b4a424d565022510724c2b4997d78c0517ce78812010d94b7c801d9acc', '[\"*\"]', '2024-08-06 14:31:06', NULL, '2024-08-06 14:30:50', '2024-08-06 14:31:06'),
(3, 'App\\Models\\User', 3, 'Personal Access Token', 'e4b020ff78a1e5b7d972b795284e36258d54bdb941761b99b22b745a9402501b', '[\"*\"]', '2024-08-06 15:01:49', NULL, '2024-08-06 14:47:00', '2024-08-06 15:01:49'),
(4, 'App\\Models\\User', 1, 'auth_token', 'a051cc12564b10d42fbddc3a39518c592ad3a30a6dd40e9adace5ad0f4da6c97', '[\"*\"]', '2024-08-15 09:57:51', NULL, '2024-08-06 14:52:27', '2024-08-15 09:57:51'),
(5, 'App\\Models\\User', 4, 'Personal Access Token', '02c3cfb3a11bf051db85075d13170c09f902863b2ae902c594929fa47c5c479e', '[\"*\"]', '2024-08-06 15:04:03', NULL, '2024-08-06 15:02:17', '2024-08-06 15:04:03'),
(6, 'App\\Models\\User', 5, 'Personal Access Token', '9c63dcb559a74baa027dc47fc01a2f4b1eb9d9afa53dd85ccad878d1489563d2', '[\"*\"]', NULL, NULL, '2024-08-12 12:04:16', '2024-08-12 12:04:16'),
(7, 'App\\Models\\User', 6, 'Personal Access Token', '691d90a8f156c384c6047ec115a5b0ff81e30b0d48042f8a4b62ecdadfeca145', '[\"*\"]', NULL, NULL, '2024-08-12 12:06:42', '2024-08-12 12:06:42'),
(8, 'App\\Models\\User', 5, 'auth_token', '2ba50327e086a52bb7b4ccf7b45a05307fdd33c767514c9a4528439312a8d0f7', '[\"*\"]', NULL, NULL, '2024-08-12 12:08:45', '2024-08-12 12:08:45'),
(9, 'App\\Models\\User', 5, 'auth_token', '88e110d491fdf774e37003f4326626ec36ede5aebed10c7d04be98a7a13958d3', '[\"*\"]', NULL, NULL, '2024-08-12 12:16:25', '2024-08-12 12:16:25'),
(10, 'App\\Models\\User', 4, 'auth_token', 'bc5a97bee7d30856d62ee415b79832cb35b898eed6fc73b7210948401f65da13', '[\"*\"]', NULL, NULL, '2024-08-12 12:18:20', '2024-08-12 12:18:20'),
(11, 'App\\Models\\User', 7, 'Personal Access Token', '8f8ebd0593793666edd7c16138fa466ad9b49b16cdab4e9809dde82ca73e653f', '[\"*\"]', NULL, NULL, '2024-08-12 12:18:33', '2024-08-12 12:18:33'),
(12, 'App\\Models\\User', 4, 'auth_token', '7f77dcd92a7429547d51df30642ef1f9bd97f390e34f37d8b57afb3d7bca3698', '[\"*\"]', NULL, NULL, '2024-08-12 12:24:06', '2024-08-12 12:24:06'),
(13, 'App\\Models\\User', 8, 'Personal Access Token', '6da908b19f491308acad2b69e22e8739307dd50fcc9cd377f5ca04acafacd638', '[\"*\"]', NULL, NULL, '2024-08-12 12:32:55', '2024-08-12 12:32:55'),
(14, 'App\\Models\\User', 8, 'auth_token', '985c884953466bfd83731718a48245bcf4dee4a66834494b17a931d7fcb33663', '[\"*\"]', NULL, NULL, '2024-08-12 12:34:34', '2024-08-12 12:34:34'),
(15, 'App\\Models\\User', 5, 'auth_token', '124da470b5425d16cdfc197844db0c3b1a66ff095115af62d7505649856a9311', '[\"*\"]', NULL, NULL, '2024-08-12 13:05:52', '2024-08-12 13:05:52'),
(16, 'App\\Models\\User', 5, 'auth_token', '8076e7e295cd8d0f1a7320dd2332cf80e402868539fd8c35f5a6eec57e6a2553', '[\"*\"]', NULL, NULL, '2024-08-12 13:45:34', '2024-08-12 13:45:34'),
(17, 'App\\Models\\User', 1, 'auth_token', 'a6520adbeb0218046ea92b8ca43b3c3d96e091c926676cb99b4bfb3d4f0e188c', '[\"*\"]', NULL, NULL, '2024-08-13 09:36:47', '2024-08-13 09:36:47'),
(18, 'App\\Models\\User', 1, 'auth_token', '1010a7d2ba0feb45b2dee1176f2d54665f68b6b67d92cc3cdf897672474af6de', '[\"*\"]', NULL, NULL, '2024-08-13 09:36:48', '2024-08-13 09:36:48'),
(19, 'App\\Models\\User', 1, 'auth_token', '55544925d8da388290ed85f0cb9837eb36eb3730309cddfed5a562f96d8515f1', '[\"*\"]', '2024-08-13 10:24:16', NULL, '2024-08-13 09:39:17', '2024-08-13 10:24:16'),
(20, 'App\\Models\\User', 5, 'auth_token', 'dc41d3f030c13dd34113f7781f5579f6f7a072a6dd249d6e3d693c035a6d78f8', '[\"*\"]', '2024-08-13 10:25:43', NULL, '2024-08-13 10:25:18', '2024-08-13 10:25:43'),
(21, 'App\\Models\\User', 4, 'auth_token', '76b3c557885e461c50418468606ba7240b3caee34e2e4e878cfa8fb52aadfd46', '[\"*\"]', '2024-08-13 11:05:30', NULL, '2024-08-13 10:36:39', '2024-08-13 11:05:30'),
(22, 'App\\Models\\User', 1, 'auth_token', '0fabfe2ba02e4dd9f1b6e60ef2d18f9a7846bc7fff86dd3b848d115b34ce745c', '[\"*\"]', NULL, NULL, '2024-08-13 11:00:00', '2024-08-13 11:00:00'),
(23, 'App\\Models\\User', 1, 'auth_token', 'a52ebc8e733d205f6be3e67a581170a5bfac188650684c95d279ec34a76a4fd4', '[\"*\"]', NULL, NULL, '2024-08-13 11:00:33', '2024-08-13 11:00:33'),
(24, 'App\\Models\\User', 5, 'auth_token', 'f6dce586c912036bf999e1385ada4ceb73c8585fac65a613b337ec4b6f78671c', '[\"*\"]', NULL, NULL, '2024-08-13 11:00:45', '2024-08-13 11:00:45'),
(25, 'App\\Models\\User', 1, 'auth_token', 'e929a03a69cd2f604855d5b6502e5ec347b7603424f964ce39204752f820b3a4', '[\"*\"]', '2024-08-13 11:39:47', NULL, '2024-08-13 11:02:23', '2024-08-13 11:39:47'),
(26, 'App\\Models\\User', 5, 'auth_token', '5be56ebac06e1006273f974be53775ac7b60961aaf3a92926376be8fb8747cc5', '[\"*\"]', '2024-08-13 11:19:38', NULL, '2024-08-13 11:19:38', '2024-08-13 11:19:38'),
(27, 'App\\Models\\User', 1, 'auth_token', 'aac4021ee41c77f5a49ff731652d83efddee8bcb2cd3061686477e2159eac3e8', '[\"*\"]', '2024-08-13 11:24:55', NULL, '2024-08-13 11:20:09', '2024-08-13 11:24:55'),
(28, 'App\\Models\\User', 1, 'auth_token', '4470ae743526347a6f21100f1b721ab0455e402cb1b597a7f870b503f99c2526', '[\"*\"]', '2024-08-13 11:26:01', NULL, '2024-08-13 11:26:01', '2024-08-13 11:26:01'),
(29, 'App\\Models\\User', 8, 'auth_token', '9840d8daf52d89b89d543e38b476243ff44fce8b1e6ae8d22f7a5fffd3a1a7ed', '[\"*\"]', '2024-08-13 11:27:20', NULL, '2024-08-13 11:27:19', '2024-08-13 11:27:20'),
(30, 'App\\Models\\User', 1, 'auth_token', 'fd5b931433e99a18cc5414352dc79de2e08c4bf0e57b8e0a77a10a0be686a20e', '[\"*\"]', '2024-08-13 11:42:47', NULL, '2024-08-13 11:27:56', '2024-08-13 11:42:47'),
(31, 'App\\Models\\User', 5, 'auth_token', '66a12445e90e2b888f1a00ddbd85f50b3b0efe28eb56430b286337cd6485b4e7', '[\"*\"]', '2024-08-13 13:51:01', NULL, '2024-08-13 13:50:56', '2024-08-13 13:51:01'),
(32, 'App\\Models\\User', 9, 'Personal Access Token', '67e1441a928f2b71b95411be778ba3081d0e5bf71f07e806c62c4b536066b926', '[\"*\"]', '2024-08-13 13:51:25', NULL, '2024-08-13 13:51:25', '2024-08-13 13:51:25'),
(33, 'App\\Models\\User', 1, 'auth_token', '3b3af8b6ccaafb71e68638fbd5b2e9de5a93c2a296d526fefbe73ff25e32eff4', '[\"*\"]', '2024-08-15 11:09:24', NULL, '2024-08-15 09:40:05', '2024-08-15 11:09:24'),
(34, 'App\\Models\\User', 1, 'auth_token', 'e9dd26e76c08398a877ab154243710c081f8e0ed33735ac9c6ffa53cc4a3ef48', '[\"*\"]', '2024-08-15 10:49:44', NULL, '2024-08-15 10:49:17', '2024-08-15 10:49:44'),
(35, 'App\\Models\\User', 5, 'auth_token', '5ccc23b3dcb4573121514aa5ee35d2a64e63391a02a32cb0c960a7db56d95eb7', '[\"*\"]', '2024-08-15 11:09:54', NULL, '2024-08-15 11:09:54', '2024-08-15 11:09:54'),
(36, 'App\\Models\\User', 1, 'auth_token', '303d087ede055d6705bcd59910c097a147eca02cfd71ef1d5a86282fd8f9b243', '[\"*\"]', '2024-08-15 12:29:08', NULL, '2024-08-15 11:10:09', '2024-08-15 12:29:08'),
(37, 'App\\Models\\User', 1, 'auth_token', '29667d75462500748c3fbccde223906b361f63dcfde4425738f2f4fd5c21586d', '[\"*\"]', '2024-08-22 12:37:28', NULL, '2024-08-22 09:42:44', '2024-08-22 12:37:28'),
(38, 'App\\Models\\User', 1, 'auth_token', '630c5851f26dc8bec06d281dc8c0f0227c8026bd4e5d029a64bbab5d77c99884', '[\"*\"]', '2024-08-22 12:24:06', NULL, '2024-08-22 10:54:41', '2024-08-22 12:24:06');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `bio` text DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `bio`, `profile_picture`, `created_at`, `updated_at`) VALUES
(1, 1, 'hi\nar \nyp ;gmbdergmpertpgerpt,glopret,mglommmmmmmmmmerrol[g,ole,trmg,erlo[g,g,ketrlo,g[,,kgole', 'profile_pictures/cuzEHJGgAPhw4eAnILQA3mflMokCTIwT90HPIteq.png', '2024-08-06 14:30:28', '2024-09-20 12:19:50'),
(3, 3, NULL, 'profile_pictures/HSo1FTtvUjl9hcE2vIcSt464xm1FXtzLIGKsHPkm.png', '2024-08-06 14:47:00', '2024-09-18 07:32:46'),
(4, 4, NULL, NULL, '2024-08-06 15:02:17', '2024-08-06 15:02:17'),
(5, 5, NULL, NULL, '2024-08-12 12:04:16', '2024-08-12 12:04:16'),
(6, 6, NULL, NULL, '2024-08-12 12:06:42', '2024-08-12 12:06:42'),
(7, 7, NULL, NULL, '2024-08-12 12:18:33', '2024-08-12 12:18:33'),
(8, 8, NULL, NULL, '2024-08-12 12:32:55', '2024-08-12 12:32:55'),
(9, 9, NULL, NULL, '2024-08-13 13:51:25', '2024-08-13 13:51:25'),
(10, 10, NULL, NULL, '2024-08-29 09:15:05', '2024-08-29 09:15:05'),
(11, 11, NULL, NULL, '2024-09-05 08:54:16', '2024-09-05 08:54:16'),
(12, 12, NULL, NULL, '2024-09-19 08:16:58', '2024-09-19 08:16:58');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `question` varchar(255) NOT NULL,
  `options` text NOT NULL,
  `correct_option` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `quiz_id`, `question`, `options`, `correct_option`, `created_at`, `updated_at`) VALUES
(1, 5, 'What is the capital of en', '{\"A\":\"Berlin\",\"B\":\"Madrid\",\"C\":\"Paris\",\"D\":\"Rome\"}', 'A', '2024-08-29 09:02:55', '2024-09-04 11:09:57'),
(2, 5, 'Updated question text', '{\"A\":\"Option A\",\"B\":\"Option B\",\"D\":\"Option D\"}', 'B', '2024-08-29 11:04:24', '2024-09-04 11:40:48'),
(3, 5, 'What is the capital of en', '{\"A\":\"Berlin\",\"C\":\"Paris\",\"D\":\"Rome\"}', 'A', '2024-08-29 11:04:51', '2024-08-29 11:04:51'),
(4, 5, 'what is my name', '{\"A\":\"reda\",\"B\":\"saad\",\"C\":\"rida\",\"D\":\"said\"}', 'C', '2024-08-29 11:05:50', '2024-08-29 11:05:50'),
(5, 5, 'what is my name', '{\"A\":\"reda\",\"B\":\"saad\",\"C\":\"rida\",\"D\":\"said\"}', 'D', '2024-08-29 11:23:30', '2024-08-29 11:23:30'),
(7, 5, '1*10', '{\"A\":\"1\",\"B\":\"0\",\"C\":\"0\",\"D\":\"0\"}', 'A', '2024-09-02 09:45:10', '2024-09-04 11:08:18'),
(8, 5, 'What is the capital of en', '{\"A\":\"Berlin\",\"C\":\"Paris\",\"D\":\"Rome\"}', 'A', '2024-09-02 11:30:54', '2024-09-02 11:30:54'),
(9, 5, '1-1', '{\"A\":\"0\",\"B\":\"1\",\"C\":\"2\",\"D\":\"3\"}', 'A', '2024-09-02 11:58:25', '2024-09-02 11:58:25'),
(11, 8, '1-1000', '{\"A\":\"0\",\"B\":\"1\",\"C\":\"000000\",\"D\":\"1\"}', 'A', '2024-09-02 12:01:44', '2024-09-04 12:22:20'),
(31, 11, '1-1', '{\"A\":\"0\",\"B\":\"1\",\"C\":\"0\",\"D\":\"1\"}', 'A', '2024-09-04 12:31:07', '2024-09-04 12:31:07'),
(35, 8, '1-1', '{\"A\":\"0\",\"B\":\"a\",\"C\":\"0\",\"D\":\"1\"}', 'A', '2024-09-14 10:55:20', '2024-09-14 10:55:20');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `title`, `description`, `category_id`, `user_id`, `created_at`, `updated_at`, `image`) VALUES
(5, 'math quiz 1', 'reda 2000100aaaaaaahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhrfffffffffffffffffffffffffffffffffffffffffffffffffffffffhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhfffffffffffffffffffffffffffffffffffffffffddddd', 10, 1, '2024-08-15 10:22:41', '2024-09-24 21:50:18', 'images/N9AQ4o7kbTEyZWdSxWRoWAjkJD10aXXJ2Rk2h6YP.png'),
(8, 'qq11qqqqqq', 'qqqq11qqqqqqqqq', 28, 12, '2024-08-15 10:47:47', '2024-09-24 21:04:55', 'images/1oxTdlvDckOtt3JagXKT178CfxKPulXm8zWSP593.png'),
(11, 'Updated Quiz', 'Updated Description', 5, 3, '2024-08-22 10:51:32', '2024-09-24 20:52:43', 'images/Fz9GJS1d4afTaGxnKcUi9qidjsgYb8Hyfx6yr3lR.png'),
(24, 'a', 'a', 5, 3, '2024-09-05 09:27:46', '2024-09-05 09:27:46', NULL),
(25, 'a', 'aa', 5, 1, '2024-09-05 09:28:01', '2024-09-05 09:28:01', NULL),
(26, 'q', 'q', 5, 1, '2024-09-05 09:28:16', '2024-09-05 09:28:16', NULL),
(27, 'qq', 'qq', 5, 1, '2024-09-05 09:28:24', '2024-09-05 09:28:24', NULL),
(28, 'qq', 'qq', 5, 1, '2024-09-05 09:28:41', '2024-09-05 09:28:41', NULL),
(29, 'qq', 'qq', 5, 1, '2024-09-05 09:28:51', '2024-09-05 09:28:51', NULL),
(30, 'qq', 'qq', 5, 1, '2024-09-05 09:28:57', '2024-09-05 09:28:57', NULL),
(31, 'qq', 'qq', 5, 1, '2024-09-05 09:29:04', '2024-09-05 09:29:04', NULL),
(32, 'qq', 'qqqq', 5, 1, '2024-09-05 09:29:11', '2024-09-05 09:29:11', NULL),
(34, 'ff', 'fff', 5, 1, '2024-09-05 09:29:31', '2024-09-05 09:29:31', NULL),
(35, 'ff', 'ffs', 5, 1, '2024-09-05 09:29:37', '2024-09-05 09:29:37', NULL),
(38, 'qqq23', 'qqq23', 5, 1, '2024-09-19 08:57:24', '2024-09-19 08:57:24', 'images/w1fladYbgiBmTqV56JJ27dA4kZZyujpdORGcadw1.png'),
(41, 'reda', '123', 28, 12, '2024-09-24 20:10:29', '2024-09-24 20:10:29', 'images/fR94cnl5lkqHXseoXXhXNaTkJCLnhp4zOSugWFgz.png'),
(42, '1111111111', '111qq', 5, 1, '2024-09-24 20:47:13', '2024-09-24 21:02:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempts`
--

CREATE TABLE `quiz_attempts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quiz_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `score` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_attempts`
--

INSERT INTO `quiz_attempts` (`id`, `quiz_id`, `user_id`, `score`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 0, '2024-09-13 14:31:23', '2024-09-13 14:31:23'),
(2, 5, 1, 60, '2024-09-13 14:33:48', '2024-09-13 14:33:48'),
(3, 5, 1, 40, '2024-09-13 14:44:52', '2024-09-13 14:44:52'),
(4, 5, 1, 40, '2024-09-13 14:45:55', '2024-09-13 14:45:55'),
(5, 5, 1, 0, '2024-09-13 14:50:39', '2024-09-13 14:50:39'),
(6, 5, 1, 50, '2024-09-13 14:51:17', '2024-09-13 14:51:17'),
(7, 5, 1, 0, '2024-09-13 14:56:34', '2024-09-13 14:56:34'),
(8, 8, 1, 100, '2024-09-13 14:56:59', '2024-09-13 14:56:59'),
(9, 8, 1, 100, '2024-09-13 14:56:59', '2024-09-13 14:56:59'),
(10, 5, 1, 50, '2024-09-13 14:58:19', '2024-09-13 14:58:19'),
(11, 5, 1, 50, '2024-09-13 14:58:19', '2024-09-13 14:58:19'),
(12, 8, 1, 100, '2024-09-13 15:00:20', '2024-09-13 15:00:20'),
(13, 8, 1, 0, '2024-09-13 15:04:35', '2024-09-13 15:04:35'),
(14, 8, 1, 100, '2024-09-13 15:37:17', '2024-09-13 15:37:17'),
(15, 5, 1, 66, '2024-09-14 09:37:14', '2024-09-14 09:37:14'),
(16, 5, 1, 66, '2024-09-14 09:37:44', '2024-09-14 09:37:44'),
(17, 8, 1, 100, '2024-09-14 09:44:29', '2024-09-14 09:44:29'),
(18, 8, 1, 100, '2024-09-14 09:48:05', '2024-09-14 09:48:05'),
(19, 5, 1, 66, '2024-09-14 09:51:07', '2024-09-14 09:51:07'),
(20, 8, 1, 0, '2024-09-14 09:58:07', '2024-09-14 09:58:07'),
(21, 8, 1, 100, '2024-09-14 09:58:24', '2024-09-14 09:58:24'),
(22, 8, 1, 100, '2024-09-14 09:58:24', '2024-09-14 09:58:24'),
(23, 8, 1, 100, '2024-09-14 09:59:16', '2024-09-14 09:59:16'),
(24, 8, 1, 100, '2024-09-14 10:03:49', '2024-09-14 10:03:49'),
(25, 8, 1, 100, '2024-09-14 10:06:36', '2024-09-14 10:06:36'),
(26, 8, 1, 100, '2024-09-14 10:08:10', '2024-09-14 10:08:10'),
(27, 8, 1, 100, '2024-09-14 10:11:16', '2024-09-14 10:11:16'),
(28, 8, 1, 100, '2024-09-14 10:21:12', '2024-09-14 10:21:12'),
(29, 8, 1, 100, '2024-09-14 10:21:12', '2024-09-14 10:21:12'),
(30, 8, 1, 100, '2024-09-14 10:25:45', '2024-09-14 10:25:45'),
(31, 8, 1, 100, '2024-09-14 10:25:58', '2024-09-14 10:25:58'),
(32, 8, 1, 100, '2024-09-14 10:29:28', '2024-09-14 10:29:28'),
(33, 8, 1, 100, '2024-09-14 10:40:07', '2024-09-14 10:40:07'),
(34, 8, 1, 100, '2024-09-14 10:45:11', '2024-09-14 10:45:11'),
(35, 8, 1, 100, '2024-09-14 10:45:35', '2024-09-14 10:45:35'),
(36, 8, 1, 100, '2024-09-14 10:45:36', '2024-09-14 10:45:36'),
(37, 8, 1, 100, '2024-09-14 10:46:13', '2024-09-14 10:46:13'),
(38, 5, 1, 66, '2024-09-14 10:46:33', '2024-09-14 10:46:33'),
(39, 5, 1, 66, '2024-09-14 10:46:33', '2024-09-14 10:46:33'),
(40, 8, 1, 100, '2024-09-14 10:54:52', '2024-09-14 10:54:52'),
(41, 8, 1, 100, '2024-09-14 10:55:56', '2024-09-14 10:55:56'),
(42, 8, 1, 50, '2024-09-14 10:59:37', '2024-09-14 10:59:37'),
(43, 8, 1, 100, '2024-09-14 11:03:33', '2024-09-14 11:03:33'),
(44, 8, 1, 0, '2024-09-14 11:07:13', '2024-09-14 11:07:13'),
(45, 5, 1, 66, '2024-09-18 13:26:58', '2024-09-18 13:26:58'),
(46, 8, 1, 100, '2024-09-19 09:23:38', '2024-09-19 09:23:38'),
(47, 8, 12, 100, '2024-09-19 09:24:38', '2024-09-19 09:24:38');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `permissions` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'all', NULL, NULL),
(2, 'user', 'basic', NULL, NULL),
(3, 'super_admin', 'all', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('AcyCMKPPzfYsmBiTq38NlrUR2K9v9w3TEF6YgHaz', NULL, '127.0.0.1', 'PostmanRuntime/7.42.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiakNwSjVseVI5RWZRMnlCbFFqSmtGV1VMSVlRNm9mN2tPYk9QRG9SYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1726773563),
('Eoa2QJv04CPgAmXY9vee6jy1ndr9l2sQZhdOhhdG', NULL, '127.0.0.1', 'PostmanRuntime/7.42.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkw4NEloRjFUZ1M1UXpPbVZqWTFtMlBxOUVqaU00V1lvRHN2S1NGeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1726776282);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'New Username', 'ridachaanoun1@gmail.com', NULL, '$2y$12$1JUd77X77NjB0RsLULRWOeQSuJs4.t68wnTR0qj6nScRJiUfB26vq', 3, NULL, '2024-08-06 14:30:28', '2024-09-20 20:15:29'),
(3, 'reda', 'ridachaanoun.u@gmail.com', NULL, '$2y$12$75Li89ryRa4HTtQRbvHUb.ZQaXluDOVJh17455Qek83WoeF5eXDjm', 1, NULL, '2024-08-06 14:47:00', '2024-09-20 08:52:04'),
(4, 'reda', 'ridachaanoun00@gmail.com', NULL, '$2y$12$sErNIt4wcSWCld9l0106l.7TwT3c2vgmPJ7f93OKNhcEhK2xSeub6', 2, NULL, '2024-08-06 15:02:17', '2024-09-24 21:43:15'),
(5, 'Rida', 'eee@gmail.com', NULL, '$2y$12$1Fiq3pU1A5oJfn1l4aycCujvLD0o0dzey3c8x01WcgJzH6womDUke', 2, NULL, '2024-08-12 12:04:16', '2024-08-12 12:04:16'),
(6, 'Rida', 'ee1e@gmail.com', NULL, '$2y$12$eQUHKNnfS8Sq8sr444eD/.OiAd0zoT7D2tc6QssihCZvBxLkmjcwi', 2, NULL, '2024-08-12 12:06:42', '2024-08-12 12:06:42'),
(7, 'reda', 'ridachaanou01@gmail.com', NULL, '$2y$12$U4KLaXlU44oOoko4EwXMluowTu4Wrk8GBeKnhclD05xr0Tgz3qmuu', 2, NULL, '2024-08-12 12:18:33', '2024-08-12 12:18:33'),
(8, 'Rida', 'user3@gmail', NULL, '$2y$12$d4vb9Kj3HLASZdf9Db2cPeUS2AC4CveKG6d5iQfO5JXTCuaX65/xG', 2, NULL, '2024-08-12 12:32:55', '2024-08-12 12:32:55'),
(9, 'user', 'test@gmail.com', NULL, '$2y$12$mJzpwpoQB6HkKLyEike9teuSv2xzb0IviwSOwqTlUaWEYjeucIRye', 2, NULL, '2024-08-13 13:51:25', '2024-08-13 13:51:25'),
(10, 'reda', 'ridachaanou001@gmail.com', NULL, '$2y$12$5bnm78CrUqZIV84xGkHBYeGMVokF0taweFs6K/kP19s2o6nQGvFOu', 2, NULL, '2024-08-29 09:15:05', '2024-08-29 09:15:05'),
(11, 'Ridauser', 'mooo@gmail.com', NULL, '$2y$12$cbM3p.NvsFAuKhZ3g5TqbeOIRiPRIrFtKv1bbg2wgXUEqI37cuYVW', 1, NULL, '2024-09-05 08:54:16', '2024-09-24 20:54:13'),
(12, 'user', 'mooou@gmail.com', NULL, '$2y$12$5quPvMihSeKQX1Czy4fwQut4.Vh3NImA3pLuyFwxV3l5Q4ppegTEK', 2, NULL, '2024-09-19 08:16:58', '2024-09-19 08:16:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follows_follower_id_foreign` (`follower_id`),
  ADD KEY `follows_followed_id_foreign` (`followed_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profiles_user_id_foreign` (`user_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questions_quiz_id_foreign` (`quiz_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quizzes_category_id_foreign` (`category_id`),
  ADD KEY `quizzes_user_id_foreign` (`user_id`);

--
-- Indexes for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_attempts_quiz_id_foreign` (`quiz_id`),
  ADD KEY `quiz_attempts_user_id_foreign` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `follows`
--
ALTER TABLE `follows`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_followed_id_foreign` FOREIGN KEY (`followed_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `follows_follower_id_foreign` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quizzes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `quiz_attempts_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quiz_attempts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
