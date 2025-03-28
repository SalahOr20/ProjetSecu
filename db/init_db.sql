-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour sportify
CREATE DATABASE IF NOT EXISTS `sportify` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sportify`;

-- Listage de la structure de table sportify. auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.auth_group : ~0 rows (environ)

-- Listage de la structure de table sportify. auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.auth_group_permissions : ~0 rows (environ)

-- Listage de la structure de table sportify. auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.auth_permission : ~28 rows (environ)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add custom user', 7, 'add_customuser'),
	(26, 'Can change custom user', 7, 'change_customuser'),
	(27, 'Can delete custom user', 7, 'delete_customuser'),
	(28, 'Can view custom user', 7, 'view_customuser'),
	(29, 'Can add product', 8, 'add_product'),
	(30, 'Can change product', 8, 'change_product'),
	(31, 'Can delete product', 8, 'delete_product'),
	(32, 'Can view product', 8, 'view_product'),
	(33, 'Can add order', 9, 'add_order'),
	(34, 'Can change order', 9, 'change_order'),
	(35, 'Can delete order', 9, 'delete_order'),
	(36, 'Can view order', 9, 'view_order'),
	(37, 'Can add order item', 10, 'add_orderitem'),
	(38, 'Can change order item', 10, 'change_orderitem'),
	(39, 'Can delete order item', 10, 'delete_orderitem'),
	(40, 'Can view order item', 10, 'view_orderitem'),
	(41, 'Can add order', 11, 'add_order'),
	(42, 'Can change order', 11, 'change_order'),
	(43, 'Can delete order', 11, 'delete_order'),
	(44, 'Can view order', 11, 'view_order'),
	(45, 'Can add order item', 12, 'add_orderitem'),
	(46, 'Can change order item', 12, 'change_orderitem'),
	(47, 'Can delete order item', 12, 'delete_orderitem'),
	(48, 'Can view order item', 12, 'view_orderitem');

-- Listage de la structure de table sportify. auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.auth_user : ~0 rows (environ)

-- Listage de la structure de table sportify. auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.auth_user_groups : ~0 rows (environ)

-- Listage de la structure de table sportify. auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.auth_user_user_permissions : ~0 rows (environ)

-- Listage de la structure de table sportify. django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.django_admin_log : ~0 rows (environ)

-- Listage de la structure de table sportify. django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.django_content_type : ~7 rows (environ)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(9, 'Orders', 'order'),
	(10, 'Orders', 'orderitem'),
	(11, 'Product', 'order'),
	(12, 'Product', 'orderitem'),
	(8, 'Product', 'product'),
	(6, 'sessions', 'session'),
	(7, 'Users', 'customuser');

-- Listage de la structure de table sportify. django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.django_migrations : ~19 rows (environ)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-03-28 17:06:16.185093'),
	(2, 'contenttypes', '0002_remove_content_type_name', '2025-03-28 17:06:16.271540'),
	(3, 'auth', '0001_initial', '2025-03-28 17:06:17.016485'),
	(4, 'auth', '0002_alter_permission_name_max_length', '2025-03-28 17:06:17.113951'),
	(5, 'auth', '0003_alter_user_email_max_length', '2025-03-28 17:06:17.150603'),
	(6, 'auth', '0004_alter_user_username_opts', '2025-03-28 17:06:17.162293'),
	(7, 'auth', '0005_alter_user_last_login_null', '2025-03-28 17:06:17.254763'),
	(8, 'auth', '0006_require_contenttypes_0002', '2025-03-28 17:06:17.257155'),
	(9, 'auth', '0007_alter_validators_add_error_messages', '2025-03-28 17:06:17.268640'),
	(10, 'auth', '0008_alter_user_username_max_length', '2025-03-28 17:06:17.348315'),
	(11, 'auth', '0009_alter_user_last_name_max_length', '2025-03-28 17:06:17.462620'),
	(12, 'auth', '0010_alter_group_name_max_length', '2025-03-28 17:06:17.499437'),
	(13, 'auth', '0011_update_proxy_permissions', '2025-03-28 17:06:17.510472'),
	(14, 'auth', '0012_alter_user_first_name_max_length', '2025-03-28 17:06:17.614244'),
	(15, 'Users', '0001_initial', '2025-03-28 17:06:18.011961'),
	(16, 'admin', '0001_initial', '2025-03-28 17:06:18.215424'),
	(17, 'admin', '0002_logentry_remove_auto_add', '2025-03-28 17:06:18.225594'),
	(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-28 17:06:18.230396'),
	(19, 'sessions', '0001_initial', '2025-03-28 17:06:18.276467'),
	(20, 'Product', '0001_initial', '2025-03-28 17:17:06.638378'),
	(21, 'Orders', '0001_initial', '2025-03-28 17:26:26.820099'),
	(22, 'Product', '0002_product_stock', '2025-03-28 17:31:57.515386'),
	(23, 'Product', '0003_remove_product_is_available', '2025-03-28 17:32:47.555280'),
	(24, 'Product', '0004_alter_product_created_at_alter_product_updated_at', '2025-03-28 17:33:33.892459'),
	(25, 'Product', '0005_alter_product_created_at_alter_product_stock_and_more', '2025-03-28 18:40:17.126846');

-- Listage de la structure de table sportify. django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.django_session : ~0 rows (environ)

-- Listage de la structure de table sportify. orders_order
CREATE TABLE IF NOT EXISTS `orders_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Orders_order_user_id_ee9579da_fk_Users_customuser_id` (`user_id`),
  CONSTRAINT `Orders_order_user_id_ee9579da_fk_Users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.orders_order : ~1 rows (environ)
INSERT INTO `orders_order` (`id`, `total_price`, `created_at`, `updated_at`, `is_paid`, `user_id`) VALUES
	(12, 899.97, '2025-03-28 19:42:42.000000', '2025-03-28 19:42:42.000000', 1, 1);

-- Listage de la structure de table sportify. orders_orderitem
CREATE TABLE IF NOT EXISTS `orders_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Orders_orderitem_order_id_3570cd78_fk_Orders_order_id` (`order_id`),
  KEY `Orders_orderitem_product_id_948be4ea_fk_Product_product_id` (`product_id`),
  CONSTRAINT `Orders_orderitem_order_id_3570cd78_fk_Orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `Orders_orderitem_product_id_948be4ea_fk_Product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`id`),
  CONSTRAINT `orders_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.orders_orderitem : ~1 rows (environ)
INSERT INTO `orders_orderitem` (`id`, `quantity`, `total_price`, `order_id`, `product_id`) VALUES
	(1, 2, 332.00, 12, 56);

-- Listage de la structure de table sportify. product_order
CREATE TABLE IF NOT EXISTS `product_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Product_order_user_id_22517dec_fk_Users_customuser_id` (`user_id`),
  CONSTRAINT `Product_order_user_id_22517dec_fk_Users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.product_order : ~0 rows (environ)

-- Listage de la structure de table sportify. product_orderitem
CREATE TABLE IF NOT EXISTS `product_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Product_orderitem_order_id_780e11df_fk_Product_order_id` (`order_id`),
  KEY `Product_orderitem_product_id_a5fa6209_fk_Product_product_id` (`product_id`),
  CONSTRAINT `Product_orderitem_order_id_780e11df_fk_Product_order_id` FOREIGN KEY (`order_id`) REFERENCES `product_order` (`id`),
  CONSTRAINT `Product_orderitem_product_id_a5fa6209_fk_Product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`id`),
  CONSTRAINT `product_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.product_orderitem : ~0 rows (environ)

-- Listage de la structure de table sportify. product_product
CREATE TABLE IF NOT EXISTS `product_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `stock` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Product_product_stock_8dd560c1_check` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.product_product : ~0 rows (environ)
INSERT INTO `product_product` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`, `stock`) VALUES
	(40, 'Surfboard 1', 'High-quality surfboard for beginners', 299.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 10),
	(41, 'Surfboard 2', 'Surfboard for intermediate surfers', 499.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 5),
	(42, 'Wetsuit 1', 'Wetsuit for cold water surfing', 119.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 20),
	(43, 'Wetsuit 2', 'Lightweight wetsuit for warm waters', 89.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 15),
	(44, 'Surfboard 3', 'Advanced surfboard for experienced surfers', 799.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 3),
	(45, 'Surfboard 4', 'Surfboard for short waves', 399.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 7),
	(46, 'Surfboard 5', 'All-round surfboard for different conditions', 299.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 12),
	(47, 'Surfboard 6', 'Special board for long waves', 599.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 6),
	(48, 'Rash Guard 1', 'Rash guard to protect against sun and rashes', 29.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 25),
	(49, 'Rash Guard 2', 'Quick-dry rash guard for water sports', 24.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 30),
	(50, 'Kite 1', 'Kite for beginners', 350.00, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 8),
	(51, 'Kite 2', 'Professional kite for advanced users', 700.00, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 5),
	(52, 'Surfboard 7', 'Compact surfboard for small waves', 250.00, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 10),
	(53, 'Leash 1', 'Leash for surfboards', 19.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 50),
	(54, 'Leash 2', 'Heavy-duty leash for larger surfboards', 24.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 40),
	(55, 'Fins 1', 'Set of fins for surfboard', 49.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 15),
	(56, 'Fins 2', 'Advanced set of fins for speed', 69.99, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 12),
	(57, 'Paddle 1', 'Paddle for stand-up paddleboarding', 150.00, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 10),
	(58, 'Paddle 2', 'Carbon fiber paddle for SUP', 250.00, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 8),
	(59, 'Dry Bag 1', 'Waterproof dry bag for keeping belongings safe', 30.00, '2025-03-28 19:42:00.000000', '2025-03-28 19:42:00.000000', 40),
	(60, 'Surfboard 3000', 'Une planche de surf idéale pour les débutants.', 350.00, '2025-03-28 18:50:08.227442', '2025-03-28 18:50:08.227442', 0);

-- Listage de la structure de table sportify. users_customuser
CREATE TABLE IF NOT EXISTS `users_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.users_customuser : ~1 rows (environ)
INSERT INTO `users_customuser` (`id`, `last_login`, `email`, `username`, `password`, `is_staff`, `is_superuser`) VALUES
	(1, NULL, 'testuser@example.com', 'testuser', 'pbkdf2_sha256$870000$hE7DhqEd1TQ3vkAOXzYIdt$r4SilbjcFw2ywl7YC+WRquCHmA5HWkSHQiCa7WrcJEs=', 0, 0);

-- Listage de la structure de table sportify. users_customuser_groups
CREATE TABLE IF NOT EXISTS `users_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Users_customuser_groups_customuser_id_group_id_5ac5fb62_uniq` (`customuser_id`,`group_id`),
  KEY `Users_customuser_groups_group_id_c15c8f40_fk_auth_group_id` (`group_id`),
  CONSTRAINT `Users_customuser_gro_customuser_id_2cb9ebc6_fk_Users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `Users_customuser_groups_group_id_c15c8f40_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.users_customuser_groups : ~0 rows (environ)

-- Listage de la structure de table sportify. users_customuser_user_permissions
CREATE TABLE IF NOT EXISTS `users_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Users_customuser_user_pe_customuser_id_permission_12209533_uniq` (`customuser_id`,`permission_id`),
  KEY `Users_customuser_use_permission_id_ff591115_fk_auth_perm` (`permission_id`),
  CONSTRAINT `Users_customuser_use_customuser_id_f80eaa53_fk_Users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `Users_customuser_use_permission_id_ff591115_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sportify.users_customuser_user_permissions : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
