-- MeroMart updated database export
-- Generated on: 2026-05-02 19:58:56

CREATE DATABASE IF NOT EXISTS `mero_mart_db`;
USE `mero_mart_db`;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `order_items`;
DROP TABLE IF EXISTS `cart`;
DROP TABLE IF EXISTS `cart_items`;
DROP TABLE IF EXISTS `contact_messages`;

-- Table structure for `categories`
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `users`
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `products`
CREATE TABLE `products` (
  `product_Id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `unit` varchar(20) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`product_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `orders`
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('pending','confirmed','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `delivery_address` varchar(255) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `order_items`
CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `cart`
CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `cart_user_unique` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `cart_items`
CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`cart_item_id`),
  KEY `cart_id` (`cart_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Table structure for `contact_messages`
CREATE TABLE `contact_messages` (
  `message_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Data for `categories`
INSERT INTO `categories` VALUES (1, 'Fruits', 'Fresh seasonal fruits and berries');
INSERT INTO `categories` VALUES (2, 'Vegetables', 'Fresh organic vegetables and greens');
INSERT INTO `categories` VALUES (3, 'Dairy', 'Milk, cheese, yogurt, and dairy items');
INSERT INTO `categories` VALUES (4, 'Grains', 'Rice, oats, bread, and grain products');

-- Data for `users`
INSERT INTO `users` VALUES (2, 'Garima Rana', 'ranaagarimaa@gmail.com', '9748209462', '9aaea75bad811aead1530043939e03fb61bfeb9eb6b3dbcde7c9d46d9b1b7b06', 'admin', '', '2026-05-02 19:52:25.0');

-- Data for `products`
INSERT INTO `products` VALUES (1, 'Brown Rice', 'Healthy whole grain brown rice.', 210.00, 18, '1kg', 'brown-rice.png', 4, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (2, 'Organic Blueberries', 'Fresh organic blueberries packed with natural sweetness.', 850.00, 48, '125g', 'blueberries.png', 1, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (3, 'Organic Milk', 'Fresh dairy milk for daily use.', 160.00, 40, '1L', 'milk.png', 3, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (4, 'Organic Oats', 'Healthy oats for breakfast and baking.', 190.00, 22, '1kg', 'oats.png', 4, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (5, 'Organic Oranges', 'Juicy oranges rich in vitamin C.', 140.00, 25, '1kg', 'oranges.png', 1, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (6, 'Organic Potatoes', 'Naturally grown potatoes.', 60.00, 30, '1kg', 'potatoes.png', 2, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (7, 'Organic Spinach', 'Fresh leafy greens from local farms.', 80.00, 55, '250g', 'spinach.png', 2, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (8, 'Organic Tomatoes', 'Fresh farm tomatoes for everyday cooking.', 120.00, 32, '500g', 'tomatoes.png', 2, 'Active', '2026-05-01 16:29:49.0');
INSERT INTO `products` VALUES (9, 'Blueberries', '', 200.00, 30, 'packet', 'assets/images/products/blueberries.jpg', 1, 'Active', '2026-05-02 16:42:10.0');

-- No data for `orders`

-- No data for `order_items`

-- No data for `cart`

-- No data for `cart_items`

-- Data for `contact_messages`
INSERT INTO `contact_messages` VALUES (1, 'Yogesh', 'yogesh@test.com', 'Test Message', 'Hello this is a test from backend', '2026-04-19 19:54:59.0');
INSERT INTO `contact_messages` VALUES (2, 'ansh', 'ansh@gmail.com', 'ansh', 'ansh', '2026-04-19 20:48:48.0');
INSERT INTO `contact_messages` VALUES (3, 'ansh', 'ansh@gmail.com', 'ansh', 'ansh', '2026-04-19 20:54:33.0');

SET FOREIGN_KEY_CHECKS=1;
