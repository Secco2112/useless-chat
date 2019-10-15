-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 15-Out-2019 às 04:55
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
-- Estrutura da tabela `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_07_20_011009_create_permission_tables', 1),
(4, '2019_10_13_200652_create_private_messages_table', 2);

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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `private_messages_sender_id_foreign` (`sender_id`),
  KEY `private_messages_receiver_id_foreign` (`receiver_id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `private_messages`
--

INSERT INTO `private_messages` (`id`, `sender_id`, `receiver_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Teste', '2019-10-13 20:24:04', '2019-10-13 20:24:04'),
(2, 1, 2, 'Testqeqweqwd', '2019-10-14 01:32:04', '2019-10-14 01:32:04'),
(3, 2, 1, 'wdqwdwqdwqd', '2019-10-14 01:32:08', '2019-10-14 01:32:08'),
(4, 2, 1, 'qwdqwdqwdqwdwq', '2019-10-14 01:32:12', '2019-10-14 01:32:12'),
(5, 2, 1, 'fqwgwqgvqwrfwqd qwd12dwq d12d 12d', '2019-10-14 01:32:17', '2019-10-14 01:32:17'),
(6, 1, 2, 'wqdqwdwqdqw', '2019-10-14 01:32:21', '2019-10-14 01:32:21'),
(8, 2, 1, 'Teste 2', '2019-10-14 05:04:08', '2019-10-14 05:04:08'),
(9, 1, 2, 'Teste', '2019-10-14 08:18:00', '2019-10-14 08:18:00'),
(10, 1, 2, 'QWdqwd', '2019-10-14 08:18:08', '2019-10-14 08:18:08'),
(11, 1, 2, 'qwdqwdqwd', '2019-10-14 08:18:32', '2019-10-14 08:18:32'),
(12, 1, 2, 'Teste', '2019-10-15 06:30:16', '2019-10-15 06:30:16'),
(13, 2, 1, '21312312312', '2019-10-15 06:30:28', '2019-10-15 06:30:28'),
(14, 1, 2, 'qwdwqdq', '2019-10-15 06:33:24', '2019-10-15 06:33:24'),
(15, 1, 2, 'qwdqwdqw', '2019-10-15 06:33:25', '2019-10-15 06:33:25'),
(16, 1, 2, 'qwdqwdqdqwdqwd', '2019-10-15 06:33:26', '2019-10-15 06:33:26'),
(17, 1, 2, 'Teste', '2019-10-15 06:39:59', '2019-10-15 06:39:59'),
(18, 1, 2, 'qwdqwdqwd', '2019-10-15 06:43:58', '2019-10-15 06:43:58'),
(19, 1, 2, 'qwdqwdqwdqwdqwdqwdqwdqwd', '2019-10-15 06:44:16', '2019-10-15 06:44:16'),
(20, 2, 1, 'Teste', '2019-10-15 06:47:29', '2019-10-15 06:47:29'),
(21, 2, 1, 'dqwdwq', '2019-10-15 06:47:33', '2019-10-15 06:47:33'),
(22, 1, 2, 'Teste', '2019-10-15 06:47:57', '2019-10-15 06:47:57'),
(23, 1, 2, 'Teste', '2019-10-15 06:49:28', '2019-10-15 06:49:28'),
(24, 2, 1, 'qwdqwd', '2019-10-15 06:49:43', '2019-10-15 06:49:43'),
(25, 1, 2, 'Teste', '2019-10-15 06:56:02', '2019-10-15 06:56:02'),
(26, 1, 2, 'Teste', '2019-10-15 06:57:14', '2019-10-15 06:57:14'),
(27, 2, 1, 'Teste', '2019-10-15 06:57:56', '2019-10-15 06:57:56'),
(28, 1, 2, 'Teste', '2019-10-15 07:14:35', '2019-10-15 07:14:35'),
(29, 2, 1, 'qwdqwdqwd', '2019-10-15 07:17:27', '2019-10-15 07:17:27'),
(30, 1, 2, 'qwdqwdqwdqdqwqd', '2019-10-15 07:18:56', '2019-10-15 07:18:56'),
(31, 1, 2, 'd12e12d12d', '2019-10-15 07:18:58', '2019-10-15 07:18:58'),
(32, 1, 2, '12d12ij12hjdi12', '2019-10-15 07:18:59', '2019-10-15 07:18:59'),
(33, 1, 2, 'ejiqwjdiqwjd', '2019-10-15 07:19:20', '2019-10-15 07:19:20'),
(34, 2, 1, 'qwdjiuqwhjidqw', '2019-10-15 07:19:28', '2019-10-15 07:19:28'),
(35, 2, 1, 'qwhnidqwjdqw', '2019-10-15 07:19:28', '2019-10-15 07:19:28'),
(36, 2, 1, 'qwhndiqwjdjqwidjwqidjqw', '2019-10-15 07:19:30', '2019-10-15 07:19:30'),
(37, 2, 1, 'idwqjiodjwqijd', '2019-10-15 07:19:32', '2019-10-15 07:19:32'),
(38, 2, 1, 'Teste', '2019-10-15 07:21:31', '2019-10-15 07:21:31'),
(39, 2, 1, 'dqwdqwdq', '2019-10-15 07:21:47', '2019-10-15 07:21:47'),
(40, 2, 1, 'qwdqwdqwd', '2019-10-15 07:22:00', '2019-10-15 07:22:00'),
(41, 1, 2, 'Teste', '2019-10-15 07:27:00', '2019-10-15 07:27:00'),
(42, 2, 1, 'qwdqwdqw', '2019-10-15 07:27:20', '2019-10-15 07:27:20'),
(43, 1, 2, 'Teste', '2019-10-15 07:27:40', '2019-10-15 07:27:40'),
(44, 1, 2, 'Teste', '2019-10-15 07:28:26', '2019-10-15 07:28:26'),
(45, 1, 2, 'dqwdqwd', '2019-10-15 07:28:48', '2019-10-15 07:28:48'),
(46, 2, 1, 'dqwhudhqwhdqwhwqdih', '2019-10-15 07:28:58', '2019-10-15 07:28:58'),
(47, 1, 2, 'qwdqwdwq', '2019-10-15 07:29:35', '2019-10-15 07:29:35'),
(48, 2, 1, 'wqdqwdqwdqwd', '2019-10-15 07:29:42', '2019-10-15 07:29:42');

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
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Secco2112', 'gustavomarini9@gmail.com', NULL, '$2y$10$WC5pNNlG7IP7jiTHV8Ujf.XqSrjzhmfVox/eA7C9Qn2T/mOLdS0p6', NULL, '2019-09-29 21:11:02', '2019-09-29 21:11:02'),
(2, 'Vitor', 'vitor@teste.com', NULL, '$2y$10$cWSh9pVN81ETqDKU30aj0uQorIn8MRaNnnYWb5C/ejfhYOr1VcnkO', NULL, '2019-09-30 06:05:12', '2019-09-30 06:05:12');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
