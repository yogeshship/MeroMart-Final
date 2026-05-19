-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 19, 2026 at 07:55 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mero_mart_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `created_at`) VALUES
(1, 2, '2026-05-19 17:07:20');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Fruits', 'Fresh fruits and seasonal produce'),
(2, 'Vegetables', 'Fresh vegetables for daily cooking'),
(3, 'Grains', 'Rice, oats and pantry grains'),
(4, 'Dairy', 'Milk and dairy products');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `message_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`message_id`, `name`, `email`, `subject`, `message`, `submitted_at`) VALUES
(4, 'Krishna Shah', 'yogeshsah807@gmail.com', 'hello', 'nice to meet you', '2026-05-14 16:38:13'),
(5, 'yogesh sah', 'anshraut807@gmail.com', 'don', 'don dondon', '2026-05-14 17:02:53'),
(6, 'yogeshsss sah', 'yogeshsah807@gmail.com', 'hakak', 'ianao', '2026-05-14 17:26:25'),
(7, 'yogeshsss sah', 'yogeshsah807@gmail.com', 'hakak', 'ianao', '2026-05-14 17:27:00'),
(8, 'yogeshsss sah', 'yogeshsah807@gmail.com', 'hakak', 'ianao', '2026-05-14 17:27:02'),
(9, 'yogesh sah', 'yogeshsah807@gmail.com', 'hakaksss', 'asasas', '2026-05-18 12:39:19'),
(10, 'yogesh sah', 'yogeshsah807@gmail.com', 'hello', 'ssaaasa', '2026-05-18 12:39:43'),
(11, 'yogesh sah', 'yogeshsah807@gmail.com', 'hello', 'saaqq', '2026-05-19 16:21:06');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('pending','confirmed','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `delivery_address` varchar(255) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_amount`, `order_status`, `delivery_address`, `order_date`) VALUES
(1, 2, 590.00, 'pending', 'kathmandu', '2026-05-19 17:29:18'),
(2, 2, 850.00, 'pending', 'lalitpur', '2026-05-19 17:53:18');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 2, 2, 120.00),
(2, 1, 3, 1, 140.00),
(3, 1, 4, 1, 210.00),
(4, 2, 1, 1, 850.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_Id` int(11) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `unit` varchar(20) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_Id`, `product_name`, `description`, `price`, `stock_quantity`, `unit`, `image_path`, `category_id`, `created_at`) VALUES
(1, 'Organic Blueberries', 'Sweet, dense berries picked for a bright finish and clean texture.', 850.00, 24, '125g', 'assets/images/products/blueberries.jpg', 1, '2026-05-19 16:58:00'),
(2, 'Organic Tomatoes', 'Balanced acidity with a juicy center, ideal for curries, salads, and slow-cooked sauces.', 120.00, 48, '500g', 'assets/images/products/tomatoes.jpg', 2, '2026-05-19 16:58:00'),
(3, 'Organic Oranges', 'Vibrant, fragrant oranges with a refreshing sweetness.', 140.00, 39, '1kg', 'assets/images/products/oranges.jpg', 1, '2026-05-19 16:58:00'),
(4, 'Brown Rice', 'Nutty whole-grain rice with a pleasantly firm bite.', 210.00, 34, '1kg', 'assets/images/products/brown-rice.jpg', 3, '2026-05-19 16:58:00'),
(5, 'Organic Spinach', 'Tender spinach leaves with a fresh earthy flavor.', 80.00, 30, '250g', 'assets/images/products/spinach.jpg', 2, '2026-05-19 16:58:00'),
(6, 'Organic Milk', 'Smooth full-bodied milk sourced for daily freshness.', 160.00, 20, '1L', 'assets/images/products/milk.jpg', 4, '2026-05-19 16:58:00'),
(7, 'Organic Potatoes', 'Reliable all-round potatoes with a soft fluffy interior.', 60.00, 60, '1kg', 'assets/images/products/potatoes.jpg', 2, '2026-05-19 16:58:00'),
(8, 'Organic Oats', 'Hearty oats with a naturally creamy finish when cooked.', 190.00, 45, '1kg', 'assets/images/products/oats.jpg', 3, '2026-05-19 16:58:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password`, `role`, `address`, `created_at`) VALUES
(1, 'Admin User', 'admin@test.com', '9800000001', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'admin', 'Kathmandu', '2026-05-19 15:21:08'),
(2, 'ansh', 'yogeshsah807@gmail.com', '9812326418', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'customer', 'kathmandu', '2026-05-19 15:31:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `cart_user_unique` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name_unique` (`category_name`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_Id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email_unique` (`email`),
  ADD UNIQUE KEY `phone_unique` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
