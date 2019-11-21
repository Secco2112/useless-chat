-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 21-Nov-2019 às 03:19
-- Versão do servidor: 5.7.26
-- versão do PHP: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `useless_chat`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `friendships`
--

DROP TABLE IF EXISTS `friendships`;
CREATE TABLE IF NOT EXISTS `friendships` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id_1` bigint(20) UNSIGNED NOT NULL,
  `user_id_2` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `friendships_user_id_1_foreign` (`user_id_1`),
  KEY `friendships_user_id_2_foreign` (`user_id_2`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `friendships`
--

INSERT INTO `friendships` (`id`, `user_id_1`, `user_id_2`, `created_at`, `updated_at`) VALUES
(39, 1, 3, '2019-11-21 08:15:51', '2019-11-21 08:15:51'),
(40, 2, 3, '2019-11-21 08:16:33', '2019-11-21 08:16:33');

-- --------------------------------------------------------

--
-- Estrutura da tabela `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE IF NOT EXISTS `friend_requests` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_request` bigint(20) UNSIGNED NOT NULL,
  `user_to_accept` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `friend_requests_user_id_1_foreign` (`user_request`),
  KEY `friend_requests_user_id_2_foreign` (`user_to_accept`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `group_chats`
--

DROP TABLE IF EXISTS `group_chats`;
CREATE TABLE IF NOT EXISTS `group_chats` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `group_chats`
--

INSERT INTO `group_chats` (`id`, `created_at`, `updated_at`) VALUES
(1, '2019-11-19 02:12:13', '2019-11-19 02:12:19'),
(2, '2019-11-19 02:22:39', '2019-11-19 02:22:39');

-- --------------------------------------------------------

--
-- Estrutura da tabela `group_chat_messages`
--

DROP TABLE IF EXISTS `group_chat_messages`;
CREATE TABLE IF NOT EXISTS `group_chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group_chat_messages_group_id_foreign` (`group_id`),
  KEY `group_chat_messages_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `group_chat_messages`
--

INSERT INTO `group_chat_messages` (`id`, `group_id`, `user_id`, `content`, `deleted`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Teste', 1, '2019-11-06 03:54:34', '2019-11-20 05:53:25'),
(2, 1, 2, 'Teste 2', 0, '2019-11-19 03:54:42', '2019-11-19 03:54:42'),
(3, 1, 3, 'Teste 3', 0, '2019-11-19 03:54:50', '2019-11-19 03:54:50'),
(4, 1, 3, 'Teste', 0, '2019-11-19 03:57:49', '2019-11-19 03:57:49'),
(5, 1, 1, 'teste', 0, '2019-11-20 03:21:25', '2019-11-20 03:21:25'),
(6, 1, 1, 'dwqdqjw', 0, '2019-11-20 03:21:31', '2019-11-20 03:21:31'),
(7, 1, 1, 'qwidjiqwjd', 0, '2019-11-20 03:21:32', '2019-11-20 03:21:32'),
(8, 1, 1, 'qowjdioqjwd', 0, '2019-11-20 03:21:32', '2019-11-20 03:21:32'),
(9, 1, 3, 'aqui', 0, '2019-11-20 03:21:34', '2019-11-20 03:21:34'),
(10, 1, 3, 'qowkdowqkd', 0, '2019-11-20 03:21:36', '2019-11-20 03:21:36'),
(11, 1, 3, 'qwojkdoqwkodqwk', 0, '2019-11-20 03:21:36', '2019-11-20 03:21:36'),
(12, 1, 3, 'okqwodkqw', 0, '2019-11-20 03:21:37', '2019-11-20 03:21:37'),
(13, 1, 1, 'qwjdiqjwd', 0, '2019-11-20 03:21:40', '2019-11-20 03:21:40'),
(14, 1, 1, 'qiwjdiqwjd', 0, '2019-11-20 03:21:41', '2019-11-20 03:21:41'),
(15, 1, 1, '', 0, '2019-11-20 03:21:41', '2019-11-20 03:21:41'),
(16, 1, 1, 'qwjodqwoj', 0, '2019-11-20 03:21:42', '2019-11-20 03:21:42'),
(17, 1, 1, 'teste', 0, '2019-11-20 03:21:43', '2019-11-20 03:21:43'),
(18, 1, 1, 'sim', 0, '2019-11-20 03:21:44', '2019-11-20 03:21:44'),
(19, 1, 2, 'teste', 0, '2019-11-20 03:22:08', '2019-11-20 03:22:08');

-- --------------------------------------------------------

--
-- Estrutura da tabela `group_chat_users`
--

DROP TABLE IF EXISTS `group_chat_users`;
CREATE TABLE IF NOT EXISTS `group_chat_users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group_chat_users_group_id_foreign` (`group_id`),
  KEY `group_chat_users_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `group_chat_users`
--

INSERT INTO `group_chat_users` (`id`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2019-11-19 02:13:36', '2019-11-19 02:13:36'),
(2, 1, 2, '2019-11-19 02:13:39', '2019-11-19 02:13:39'),
(3, 1, 3, '2019-11-19 02:22:45', '2019-11-19 02:22:45');

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_07_20_011009_create_permission_tables', 1),
(4, '2019_10_13_200652_create_private_messages_table', 2),
(5, '2019_11_18_054050_create_profile_avatars_table', 3),
(6, '2019_11_19_015749_create_group_chats_table', 4),
(7, '2019_11_19_015848_create_group_chat_users_table', 5),
(8, '2019_11_19_035251_create_group_chat_messages_table', 6),
(9, '2019_11_20_042827_create_friendships_table', 7),
(10, '2019_11_20_230458_create_friend_requests_table', 8);

-- --------------------------------------------------------

--
-- Estrutura da tabela `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `private_messages`
--

DROP TABLE IF EXISTS `private_messages`;
CREATE TABLE IF NOT EXISTS `private_messages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `private_messages_sender_id_foreign` (`sender_id`),
  KEY `private_messages_receiver_id_foreign` (`receiver_id`)
) ENGINE=MyISAM AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `private_messages`
--

INSERT INTO `private_messages` (`id`, `sender_id`, `receiver_id`, `content`, `deleted`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Teste', 1, '2019-10-13 20:24:04', '2019-11-20 05:52:01'),
(2, 1, 2, 'Testqeqweqwd', 1, '2019-10-14 01:32:04', '2019-11-20 05:52:01'),
(3, 2, 1, 'wdqwdwqdwqd', 0, '2019-10-14 01:32:08', '2019-11-20 05:49:44'),
(4, 2, 1, 'qwdqwdqwdqwdwq', 0, '2019-10-14 01:32:12', '2019-11-20 05:49:44'),
(5, 2, 1, 'fqwgwqgvqwrfwqd qwd12dwq d12d 12d', 0, '2019-10-14 01:32:17', '2019-11-20 05:49:44'),
(6, 1, 2, 'wqdqwdwqdqw', 1, '2019-10-14 01:32:21', '2019-11-20 05:52:01'),
(8, 2, 1, 'Teste 2', 0, '2019-10-14 05:04:08', '2019-11-20 05:49:44'),
(9, 1, 2, 'Teste', 1, '2019-10-14 08:18:00', '2019-11-20 05:52:01'),
(10, 1, 2, 'QWdqwd', 1, '2019-10-14 08:18:08', '2019-11-20 05:52:01'),
(11, 1, 2, 'qwdqwdqwd', 1, '2019-10-14 08:18:32', '2019-11-20 05:52:01'),
(12, 1, 2, 'Teste', 1, '2019-10-15 06:30:16', '2019-11-20 05:52:01'),
(13, 2, 1, '21312312312', 0, '2019-10-15 06:30:28', '2019-11-20 05:49:44'),
(14, 1, 2, 'qwdwqdq', 1, '2019-10-15 06:33:24', '2019-11-20 05:52:01'),
(15, 1, 2, 'qwdqwdqw', 1, '2019-10-15 06:33:25', '2019-11-20 05:52:01'),
(16, 1, 2, 'qwdqwdqdqwdqwd', 1, '2019-10-15 06:33:26', '2019-11-20 05:52:01'),
(17, 1, 2, 'Teste', 1, '2019-10-15 06:39:59', '2019-11-20 05:52:01'),
(18, 1, 2, 'qwdqwdqwd', 1, '2019-10-15 06:43:58', '2019-11-20 05:52:01'),
(19, 1, 2, 'qwdqwdqwdqwdqwdqwdqwdqwd', 1, '2019-10-15 06:44:16', '2019-11-20 05:52:01'),
(20, 2, 1, 'Teste', 0, '2019-10-15 06:47:29', '2019-11-20 05:49:44'),
(21, 2, 1, 'dqwdwq', 0, '2019-10-15 06:47:33', '2019-11-20 05:49:44'),
(22, 1, 2, 'Teste', 1, '2019-10-15 06:47:57', '2019-11-20 05:52:01'),
(23, 1, 2, 'Teste', 1, '2019-10-15 06:49:28', '2019-11-20 05:52:01'),
(24, 2, 1, 'qwdqwd', 0, '2019-10-15 06:49:43', '2019-11-20 05:49:44'),
(25, 1, 2, 'Teste', 1, '2019-10-15 06:56:02', '2019-11-20 05:52:01'),
(26, 1, 2, 'Teste', 1, '2019-10-15 06:57:14', '2019-11-20 05:52:01'),
(27, 2, 1, 'Teste', 0, '2019-10-15 06:57:56', '2019-11-20 05:49:44'),
(28, 1, 2, 'Teste', 1, '2019-10-15 07:14:35', '2019-11-20 05:52:01'),
(29, 2, 1, 'qwdqwdqwd', 0, '2019-10-15 07:17:27', '2019-11-20 05:49:44'),
(30, 1, 2, 'qwdqwdqwdqdqwqd', 1, '2019-10-15 07:18:56', '2019-11-20 05:52:01'),
(31, 1, 2, 'd12e12d12d', 1, '2019-10-15 07:18:58', '2019-11-20 05:52:01'),
(32, 1, 2, '12d12ij12hjdi12', 1, '2019-10-15 07:18:59', '2019-11-20 05:52:01'),
(33, 1, 2, 'ejiqwjdiqwjd', 1, '2019-10-15 07:19:20', '2019-11-20 05:52:01'),
(34, 2, 1, 'qwdjiuqwhjidqw', 0, '2019-10-15 07:19:28', '2019-11-20 05:49:44'),
(35, 2, 1, 'qwhnidqwjdqw', 0, '2019-10-15 07:19:28', '2019-11-20 05:49:44'),
(36, 2, 1, 'qwhndiqwjdjqwidjwqidjqw', 0, '2019-10-15 07:19:30', '2019-11-20 05:49:44'),
(37, 2, 1, 'idwqjiodjwqijd', 0, '2019-10-15 07:19:32', '2019-11-20 05:49:44'),
(38, 2, 1, 'Teste', 0, '2019-10-15 07:21:31', '2019-11-20 05:49:44'),
(39, 2, 1, 'dqwdqwdq', 0, '2019-10-15 07:21:47', '2019-11-20 05:49:44'),
(40, 2, 1, 'qwdqwdqwd', 0, '2019-10-15 07:22:00', '2019-11-20 05:49:44'),
(41, 1, 2, 'Teste', 1, '2019-10-15 07:27:00', '2019-11-20 05:52:01'),
(42, 2, 1, 'qwdqwdqw', 0, '2019-10-15 07:27:20', '2019-11-20 05:49:44'),
(43, 1, 2, 'Teste', 1, '2019-10-15 07:27:40', '2019-11-20 05:52:01'),
(44, 1, 2, 'Teste', 1, '2019-10-15 07:28:26', '2019-11-20 05:52:01'),
(45, 1, 2, 'dqwdqwd', 1, '2019-10-15 07:28:48', '2019-11-20 05:52:01'),
(46, 2, 1, 'dqwhudhqwhdqwhwqdih', 0, '2019-10-15 07:28:58', '2019-11-20 05:49:44'),
(47, 1, 2, 'qwdqwdwq', 1, '2019-10-15 07:29:35', '2019-11-20 05:52:01'),
(48, 2, 1, 'wqdqwdqwdqwd', 0, '2019-10-15 07:29:42', '2019-11-20 05:49:44'),
(49, 1, 2, 'Teste', 1, '2019-10-20 20:43:32', '2019-11-20 05:52:01'),
(50, 1, 2, 'Teste', 1, '2019-10-21 06:38:43', '2019-11-20 05:52:01'),
(51, 1, 2, 'dijqwidjqwjdq', 1, '2019-10-21 06:40:09', '2019-11-20 05:52:01'),
(52, 2, 1, 'e2112e21e12', 0, '2019-10-21 06:40:31', '2019-11-20 05:49:44'),
(53, 1, 2, 'Teste', 1, '2019-10-21 06:43:59', '2019-11-20 05:52:01'),
(54, 1, 2, 'idjqwijdqwd', 1, '2019-10-21 06:44:05', '2019-11-20 05:52:01'),
(55, 2, 1, 'dqwdwqdqwdwq', 0, '2019-10-21 06:44:11', '2019-11-20 05:49:44'),
(56, 2, 1, 'qwdqwdwqdqwdwq', 0, '2019-10-21 06:44:23', '2019-11-20 05:49:44'),
(57, 1, 2, 'dqwdwqwqdqwd', 1, '2019-10-21 06:44:32', '2019-11-20 05:52:01'),
(58, 1, 2, 'Teste', 1, '2019-10-21 06:48:24', '2019-11-20 05:52:01'),
(59, 2, 1, 'Teste', 0, '2019-10-21 06:48:30', '2019-11-20 05:49:44'),
(60, 1, 2, 'diqwjidjqw', 1, '2019-10-21 06:48:36', '2019-11-20 05:52:01'),
(61, 1, 2, 'jidjqwijdqwj', 1, '2019-10-21 06:48:45', '2019-11-20 05:52:01'),
(62, 1, 2, 'Teste', 1, '2019-10-21 06:49:52', '2019-11-20 05:52:01'),
(63, 2, 1, 'jdiwqjdiqwjwqd', 0, '2019-10-21 06:50:08', '2019-11-20 05:49:44'),
(64, 1, 2, 'Teste', 1, '2019-10-21 06:50:58', '2019-11-20 05:52:01'),
(65, 1, 2, 'qwdqwdqwd', 1, '2019-10-21 06:54:26', '2019-11-20 05:52:01'),
(66, 1, 2, 'qwdqwdqwdqwqwdqw', 1, '2019-10-21 06:54:50', '2019-11-20 05:52:01'),
(67, 1, 2, 'Teste', 1, '2019-10-21 06:55:48', '2019-11-20 05:52:01'),
(68, 1, 2, 'Teste', 1, '2019-10-21 06:58:30', '2019-11-20 05:52:01'),
(69, 1, 2, 'qdwqdqwdqwd', 1, '2019-10-21 06:58:36', '2019-11-20 05:52:01'),
(70, 1, 2, 'Teste', 1, '2019-10-21 07:18:14', '2019-11-20 05:52:01'),
(71, 1, 2, 'wqdqwdqw', 1, '2019-10-21 07:23:17', '2019-11-20 05:52:01'),
(72, 1, 2, 'oqwkdoqwkd', 1, '2019-10-21 07:23:19', '2019-11-20 05:52:01'),
(73, 2, 1, 'wqhdiuqjwjdwqij', 0, '2019-10-21 07:23:22', '2019-11-20 05:49:44'),
(74, 2, 1, 'qdwqj9djqwidjwq', 0, '2019-10-21 07:23:25', '2019-11-20 05:49:44'),
(75, 1, 2, 'Teste', 1, '2019-10-21 07:24:09', '2019-11-20 05:52:01'),
(76, 2, 1, 'Teste', 0, '2019-10-21 07:24:12', '2019-11-20 05:49:44'),
(77, 1, 2, 'Teste', 1, '2019-10-21 07:24:33', '2019-11-20 05:52:01'),
(78, 2, 1, 'Teste', 0, '2019-10-21 07:24:35', '2019-11-20 05:49:44'),
(79, 1, 2, 'Teste', 1, '2019-10-21 07:24:43', '2019-11-20 05:52:01'),
(80, 2, 1, 'Teste', 0, '2019-10-21 07:24:45', '2019-11-20 05:49:44'),
(81, 1, 2, 'Teste', 1, '2019-10-21 07:31:03', '2019-11-20 05:52:01'),
(82, 2, 1, 'Teste', 0, '2019-10-21 07:31:07', '2019-11-20 05:49:44'),
(83, 2, 1, 'jijdiqwjjdwq', 0, '2019-10-21 07:31:10', '2019-11-20 05:49:44'),
(84, 1, 2, 'wqodkwoqkdoqwkwdq', 1, '2019-10-21 07:31:16', '2019-11-20 05:52:01'),
(85, 1, 2, 'Teste', 1, '2019-10-21 07:31:37', '2019-11-20 05:52:01'),
(86, 2, 1, 'Teste', 0, '2019-10-21 07:31:40', '2019-11-20 05:49:44'),
(87, 2, 1, 'Teste', 0, '2019-10-21 07:32:54', '2019-11-20 05:49:44'),
(88, 2, 1, 'Teste', 0, '2019-10-21 07:33:32', '2019-11-20 05:49:44'),
(89, 1, 2, 'Teste', 1, '2019-10-21 07:33:35', '2019-11-20 05:52:01'),
(90, 1, 2, 'Olar', 1, '2019-10-21 07:33:39', '2019-11-20 05:52:01'),
(91, 1, 2, 'Teste', 1, '2019-10-21 07:33:43', '2019-11-20 05:52:01'),
(92, 1, 2, '2', 1, '2019-10-21 07:33:43', '2019-11-20 05:52:01'),
(93, 1, 2, 'qwjd', 1, '2019-10-21 07:33:44', '2019-11-20 05:52:01'),
(94, 1, 2, 'qwidjq', 1, '2019-10-21 07:33:44', '2019-11-20 05:52:01'),
(95, 1, 2, 'qwdijqwi', 1, '2019-10-21 07:33:45', '2019-11-20 05:52:01'),
(96, 2, 1, 'Claro', 0, '2019-10-21 07:33:53', '2019-11-20 05:49:44'),
(97, 1, 2, 'Teste', 1, '2019-10-21 07:35:07', '2019-11-20 05:52:01'),
(98, 1, 2, 'Olar', 1, '2019-10-21 07:35:28', '2019-11-20 05:52:01'),
(99, 2, 1, 'Teste', 0, '2019-10-21 07:35:31', '2019-11-20 05:49:44'),
(100, 2, 1, 'olar', 0, '2019-10-21 07:36:07', '2019-11-20 05:49:44'),
(101, 1, 2, 'olar', 1, '2019-10-21 07:36:10', '2019-11-20 05:52:01'),
(102, 2, 1, 'oi', 0, '2019-10-21 07:36:14', '2019-11-20 05:49:44'),
(103, 1, 2, 'teste', 1, '2019-10-21 07:37:21', '2019-11-20 05:52:01'),
(104, 2, 1, 'teste', 0, '2019-10-21 07:37:24', '2019-11-20 05:49:44'),
(105, 1, 2, 'Teste', 1, '2019-10-21 07:38:18', '2019-11-20 05:52:01'),
(106, 1, 2, 'Teste', 1, '2019-10-21 07:38:32', '2019-11-20 05:52:01'),
(107, 2, 1, 'aqui', 0, '2019-10-21 07:38:35', '2019-11-20 05:49:44'),
(108, 1, 2, 'qwdqwdwqdq', 1, '2019-10-21 07:38:38', '2019-11-20 05:52:01'),
(109, 2, 1, 'teste', 0, '2019-11-18 00:29:31', '2019-11-18 00:29:31'),
(110, 1, 2, 'teste', 0, '2019-11-18 00:29:33', '2019-11-18 00:29:33'),
(111, 2, 1, 'wdqdwq', 0, '2019-11-18 00:29:51', '2019-11-18 00:29:51'),
(112, 1, 2, 'qwdqwd', 0, '2019-11-18 00:29:53', '2019-11-18 00:29:53'),
(113, 2, 1, 'qdwqd', 0, '2019-11-18 00:29:57', '2019-11-18 00:29:57'),
(114, 1, 2, 'teste', 0, '2019-11-18 00:29:59', '2019-11-18 00:29:59'),
(115, 1, 2, 'teste', 0, '2019-11-18 00:32:30', '2019-11-18 00:32:30'),
(116, 2, 1, 'ar', 0, '2019-11-18 00:32:38', '2019-11-18 00:32:38'),
(117, 1, 2, 'ar', 0, '2019-11-18 00:33:09', '2019-11-18 00:33:09'),
(118, 2, 1, 'ar', 0, '2019-11-18 00:33:18', '2019-11-18 00:33:18'),
(119, 1, 2, 'teste', 0, '2019-11-18 00:35:27', '2019-11-18 00:35:27'),
(120, 2, 1, 'teste', 0, '2019-11-18 00:35:46', '2019-11-18 00:35:46'),
(121, 1, 2, 'teste', 0, '2019-11-18 00:37:06', '2019-11-18 00:37:06'),
(122, 2, 1, 'teste', 0, '2019-11-18 00:37:09', '2019-11-18 00:37:09'),
(123, 1, 2, 'teste', 0, '2019-11-18 00:38:54', '2019-11-18 00:38:54'),
(124, 2, 1, 'teste', 0, '2019-11-18 00:38:58', '2019-11-18 00:38:58'),
(125, 1, 2, 'teste', 0, '2019-11-18 00:51:14', '2019-11-18 00:51:14'),
(126, 2, 1, 'teste', 0, '2019-11-18 00:51:53', '2019-11-18 00:51:53'),
(127, 1, 2, 'teste', 0, '2019-11-18 00:52:59', '2019-11-18 00:52:59'),
(128, 2, 1, 'teste', 0, '2019-11-18 00:53:02', '2019-11-18 00:53:02'),
(129, 1, 2, 'teste', 0, '2019-11-18 00:54:55', '2019-11-18 00:54:55'),
(130, 2, 1, 'teste', 0, '2019-11-18 00:54:58', '2019-11-18 00:54:58'),
(131, 1, 2, 'teste', 0, '2019-11-18 00:55:48', '2019-11-18 00:55:48'),
(132, 2, 1, 'teste', 0, '2019-11-18 00:55:50', '2019-11-18 00:55:50'),
(133, 1, 2, 'teste', 0, '2019-11-18 00:55:55', '2019-11-18 00:55:55'),
(134, 1, 2, 'qwdwq', 0, '2019-11-18 00:56:05', '2019-11-18 00:56:05'),
(135, 1, 2, 'wqkdwqk', 0, '2019-11-18 00:57:37', '2019-11-18 00:57:37'),
(136, 1, 2, 'qwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdwqwdqwdwqdw', 0, '2019-11-18 00:57:46', '2019-11-18 00:57:46'),
(137, 1, 2, 'teste', 0, '2019-11-18 01:01:14', '2019-11-18 01:01:14'),
(138, 2, 1, 'teste', 0, '2019-11-18 01:01:16', '2019-11-18 01:01:16'),
(139, 1, 2, 'teste', 0, '2019-11-18 01:01:22', '2019-11-18 01:01:22'),
(140, 1, 2, 'teste', 0, '2019-11-18 01:03:04', '2019-11-18 01:03:04'),
(141, 2, 1, 'teste', 0, '2019-11-18 01:03:06', '2019-11-18 01:03:06'),
(142, 1, 2, 'teste', 0, '2019-11-18 01:03:19', '2019-11-18 01:03:19'),
(143, 2, 1, 'teste', 0, '2019-11-18 01:03:21', '2019-11-18 01:03:21'),
(144, 2, 1, 'wqdwqdiwqjidjqwjdq', 0, '2019-11-18 01:03:28', '2019-11-18 01:03:28'),
(145, 2, 1, 'wqdijqwidjwiqjwiqjdiwqwj', 0, '2019-11-18 01:03:32', '2019-11-18 01:03:32'),
(146, 1, 2, 'wqdjoiwqkjodwqkdkqwd', 0, '2019-11-18 01:03:37', '2019-11-18 01:03:37'),
(147, 1, 2, 'teste', 0, '2019-11-18 01:06:29', '2019-11-18 01:06:29'),
(148, 1, 2, 'dwqdwq', 0, '2019-11-18 01:06:34', '2019-11-18 01:06:34'),
(149, 1, 2, 'qwdqwd', 0, '2019-11-18 01:06:36', '2019-11-18 01:06:36'),
(150, 1, 2, 'qwdqwd', 0, '2019-11-18 01:06:36', '2019-11-18 01:06:36'),
(151, 1, 2, 'qwdqwd', 0, '2019-11-18 01:06:40', '2019-11-18 01:06:40'),
(152, 1, 2, 'qwdqw', 0, '2019-11-18 01:06:40', '2019-11-18 01:06:40'),
(153, 1, 3, 'Teste', 0, '2019-11-18 04:05:38', '2019-11-18 04:05:38'),
(154, 1, 3, 'teste', 0, '2019-11-19 06:34:58', '2019-11-19 06:34:58'),
(155, 3, 1, 'teste', 0, '2019-11-19 06:35:40', '2019-11-19 06:35:40'),
(156, 3, 1, 'wqdqw', 0, '2019-11-19 06:35:58', '2019-11-19 06:35:58'),
(157, 3, 1, 'qwdqwdwq', 0, '2019-11-19 06:36:02', '2019-11-19 06:36:02'),
(158, 1, 3, 'teste', 0, '2019-11-19 06:36:03', '2019-11-19 06:36:03'),
(159, 3, 1, 'teste', 0, '2019-11-19 06:36:12', '2019-11-19 06:36:12'),
(160, 1, 3, 'teste', 0, '2019-11-19 06:36:14', '2019-11-19 06:36:14'),
(161, 1, 3, 'teste', 0, '2019-11-19 06:38:03', '2019-11-19 06:38:03'),
(162, 3, 1, 'twqdqw', 0, '2019-11-19 06:38:06', '2019-11-19 06:38:06'),
(163, 1, 3, 'teste', 0, '2019-11-19 06:39:52', '2019-11-19 06:39:52'),
(164, 1, 3, 'teste', 0, '2019-11-19 06:40:00', '2019-11-19 06:40:00'),
(165, 3, 1, 'teste', 0, '2019-11-19 06:40:02', '2019-11-19 06:40:02'),
(166, 1, 3, 'dqwdwqdwq', 0, '2019-11-19 06:40:08', '2019-11-19 06:40:08'),
(167, 3, 1, 'dwqdqwhwuqdqwd', 0, '2019-11-19 06:40:15', '2019-11-19 06:40:15'),
(168, 1, 3, 'aquii', 0, '2019-11-19 06:40:18', '2019-11-19 06:40:18'),
(169, 1, 3, 'teste', 0, '2019-11-19 06:40:19', '2019-11-19 06:40:19'),
(170, 1, 3, 'borqdqwdqwjidjwqijwqi', 0, '2019-11-19 06:40:23', '2019-11-19 06:40:23'),
(171, 3, 1, 'teste', 0, '2019-11-19 06:46:57', '2019-11-19 06:46:57'),
(172, 1, 3, 'aqui', 0, '2019-11-19 06:47:00', '2019-11-19 06:47:00'),
(173, 3, 1, 'Teste', 0, '2019-11-19 06:47:05', '2019-11-19 06:47:05'),
(174, 3, 1, 'Laboratório', 0, '2019-11-19 06:47:09', '2019-11-19 06:47:09'),
(175, 1, 3, 'qwdqwdqw', 0, '2019-11-19 06:49:33', '2019-11-19 06:49:33'),
(176, 1, 3, 'teste', 0, '2019-11-19 07:11:01', '2019-11-19 07:11:01'),
(177, 3, 1, 'teste', 0, '2019-11-19 07:11:05', '2019-11-19 07:11:05'),
(178, 1, 3, 'dwqqwdqwd', 0, '2019-11-19 07:11:07', '2019-11-19 07:11:07'),
(183, 3, 1, 'teste', 0, '2019-11-21 02:27:45', '2019-11-21 02:27:45'),
(182, 3, 1, 'qwdqwd', 0, '2019-11-21 02:25:56', '2019-11-21 02:25:56'),
(181, 1, 3, 'teste', 0, '2019-11-21 02:25:55', '2019-11-21 02:25:55'),
(180, 1, 2, 'asc', 0, '2019-11-20 07:45:30', '2019-11-20 07:45:30'),
(179, 1, 3, 'teste', 0, '2019-11-20 07:45:15', '2019-11-20 07:45:15'),
(184, 1, 3, 'wqdqw', 0, '2019-11-21 02:27:47', '2019-11-21 02:27:47'),
(185, 1, 3, 'dqwdqwdq', 0, '2019-11-21 02:28:01', '2019-11-21 02:28:01'),
(186, 1, 3, 'teste', 0, '2019-11-21 02:28:01', '2019-11-21 02:28:01'),
(187, 1, 3, 'teste', 0, '2019-11-21 03:27:01', '2019-11-21 03:27:01'),
(188, 1, 3, '561651561', 0, '2019-11-21 03:28:06', '2019-11-21 03:28:06'),
(189, 3, 1, '0', 0, '2019-11-21 03:28:09', '2019-11-21 03:28:09'),
(190, 1, 3, '1', 0, '2019-11-21 03:28:13', '2019-11-21 03:28:13'),
(191, 2, 3, 'Teste', 0, '2019-11-21 08:16:42', '2019-11-21 08:16:42'),
(192, 2, 3, 'dqwdwq', 0, '2019-11-21 08:16:51', '2019-11-21 08:16:51'),
(193, 2, 3, 'qwdwqd', 0, '2019-11-21 08:16:52', '2019-11-21 08:16:52'),
(194, 2, 3, 'wqdqwdq', 0, '2019-11-21 08:16:53', '2019-11-21 08:16:53');

-- --------------------------------------------------------

--
-- Estrutura da tabela `profile_avatars`
--

DROP TABLE IF EXISTS `profile_avatars`;
CREATE TABLE IF NOT EXISTS `profile_avatars` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_avatars_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accept_delete` tinyint(1) NOT NULL DEFAULT '0',
  `delete_time` int(11) DEFAULT NULL,
  `delete_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `accept_delete`, `delete_time`, `delete_type`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Secco2112', 'gustavomarini9@gmail.com', NULL, '$2y$10$WC5pNNlG7IP7jiTHV8Ujf.XqSrjzhmfVox/eA7C9Qn2T/mOLdS0p6', 1, 7, 'days', NULL, '2019-09-29 21:11:02', '2019-11-20 05:00:02'),
(2, 'Vitor', 'vitor@teste.com', NULL, '$2y$10$cWSh9pVN81ETqDKU30aj0uQorIn8MRaNnnYWb5C/ejfhYOr1VcnkO', 0, NULL, NULL, NULL, '2019-09-30 06:05:12', '2019-09-30 06:05:12'),
(3, 'Teste', 'teste@teste.com', NULL, '$2y$10$hKbFKvPrkSs81UkG0F/M3.QF1eqk1WadHYoxtUiUaXShLJbUE/3vW', 0, NULL, NULL, NULL, '2019-11-19 06:34:12', '2019-11-19 06:34:12');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
