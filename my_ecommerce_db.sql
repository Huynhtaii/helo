-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 23, 2026 lúc 03:05 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `my_ecommerce_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`cart_id`, `created_at`, `updated_at`, `user_id`) VALUES
(2001, '2025-02-24 02:02:30', '2025-02-24 02:02:30', 1),
(2002, '2025-03-07 13:09:20', '2025-03-07 13:09:20', 18),
(2003, '2025-03-07 13:22:46', '2025-03-07 13:22:46', 13),
(2004, '2025-03-08 01:56:20', '2025-03-08 01:56:20', 20),
(2005, '2025-03-09 15:03:48', '2025-03-09 15:03:48', 21),
(2006, '2025-03-10 03:36:34', '2025-03-10 03:36:34', 22),
(2007, '2025-03-10 07:49:17', '2025-03-10 07:49:17', 23);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `quantity`, `created_at`, `cart_id`, `product_id`) VALUES
(7, 3, '2025-03-06 09:09:26', 2001, 201),
(9, 1, '2025-03-06 10:08:17', 2001, 101),
(35, 1, '2025-03-08 15:29:29', 2002, 102),
(45, 1, '2025-03-10 08:06:29', 2003, 215),
(60, 3, '2026-01-14 09:18:33', 2006, 213),
(61, 1, '2026-01-14 09:18:38', 2006, 101);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`, `image`) VALUES
(1, 'Đồng hồ nam', 'Danh mục đồng hồ nam cao cấp', 'https://cdn.watchstore.vn/wp-content/uploads/2025/06/small-web-banner-xu-huong-2024_1725589299.webp'),
(2, 'Đồng hồ nữ', 'Danh mục đồng hồ nữ thời trang', 'https://cdn.watchstore.vn/wp-content/uploads/2026/01/sale-dong-ho-tet-2026-mobile.jpg'),
(3, 'Xu hướng 2025', 'Bộ sưu tập Xu hướng 2025', 'https://cdn.watchstore.vn/wp-content/uploads/2025/06/small-web-banner-quan-doi_1725598290.webp'),
(4, 'Cao cấp', 'Bộ sưu tập đồng hồ cao cấp', 'https://cdn.watchstore.vn/wp-content/uploads/2025/06/small-web-banner-tissot_1725589299.webp'),
(5, 'Nổi bật', 'Bộ sưu tập đồng hồ nổi bật', 'https://cdn.watchstore.vn/wp-content/uploads/2025/06/small-web-banner-casio-ltp_1725589299.webp'),
(6, 'Đồng hồ Treo tường', 'Bộ sưu tập đồng hồ treo tường', 'https://cdn.watchstore.vn/wp-content/uploads/2025/06/small-web-banner-giong-rolex_1725589710.webp');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories_has_products`
--

CREATE TABLE `categories_has_products` (
  `categories_category_id` int(11) NOT NULL,
  `products_product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories_has_products`
--

INSERT INTO `categories_has_products` (`categories_category_id`, `products_product_id`) VALUES
(1, 210),
(1, 212),
(1, 214),
(1, 216),
(1, 219),
(2, 102),
(3, 201),
(4, 101),
(4, 103),
(4, 202),
(4, 213),
(4, 215),
(4, 218),
(5, 203),
(6, 204),
(6, 221);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comments` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `is_resolved` tinyint(4) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `feedbacks`
--

INSERT INTO `feedbacks` (`feedback_id`, `rating`, `comments`, `created_at`, `is_resolved`, `product_id`, `user_id`, `order_id`) VALUES
(2, 4, 'Sản phẩm ổn nhưng giao chậm', '2025-02-24 02:02:30', 0, 103, 2, 1002);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `status` enum('Sent','Delivered','Seen') DEFAULT 'Sent',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `messages`
--

INSERT INTO `messages` (`message_id`, `sender_id`, `receiver_id`, `content`, `status`, `created_at`) VALUES
(146, 11, 13, 'hi', 'Sent', '2025-03-07 13:53:23'),
(147, 13, 11, 'hello', 'Sent', '2025-03-07 13:53:38'),
(148, 13, 11, 'bạn cần mình tư vấn gì về các mẫu đồng hồ nhỉ', 'Sent', '2025-03-09 14:44:42'),
(149, 16, 13, 'xin chào admin, em có tầm 3 triệu đổ lại muốn mua một chiếc đồng hồ nam tính một xíu ạ', 'Sent', '2025-03-09 14:55:53'),
(150, 13, 16, 'Dạ không biết bên mình có Đồng hồ Citizen Eco-Drive, và Đồng hồ Casio G-Shock là có phong cách nam tính nhất ạ', 'Sent', '2025-03-09 14:57:56'),
(151, 13, 16, 'không biết anh mấy tuổi rồi ạ', 'Sent', '2025-03-09 14:58:06'),
(152, 16, 13, 'hello', 'Sent', '2025-03-09 16:01:06'),
(153, 13, 16, 'dạ anh', 'Sent', '2025-03-09 16:04:05'),
(154, 13, 16, 'ádasd', 'Sent', '2025-03-09 16:04:51'),
(155, 13, 16, 'ádasd', 'Sent', '2025-03-09 16:04:53'),
(156, 13, 16, 'ádad', 'Sent', '2025-03-09 16:04:54'),
(157, 16, 13, 'sao', 'Sent', '2025-03-09 16:07:52'),
(158, 23, 13, 'hello anh , không biết bên anh có đồng hồ nào trong tầm giá 2 triệu nam tính một xíu không ạ', 'Sent', '2025-03-10 08:01:31'),
(159, 13, 23, 'ok em', 'Sent', '2025-03-10 08:02:32'),
(160, 13, 23, 'ok', 'Sent', '2025-03-10 08:03:27'),
(161, 23, 13, 'ok', 'Sent', '2025-03-10 08:03:33'),
(162, 13, 23, 'chào em', 'Sent', '2025-03-17 15:47:17'),
(163, 13, 11, 'bạn ơi', 'Sent', '2025-03-17 15:47:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `status` enum('Pending','Shipped','Completed','Canceled') NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `user_id` int(11) NOT NULL,
  `discount_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`order_id`, `order_date`, `status`, `total_amount`, `user_id`, `discount_id`) VALUES
(1002, '2025-02-24 02:02:30', 'Pending', 250.00, 2, NULL),
(1007, '2025-03-06 02:33:17', 'Pending', 1100.00, 1, NULL),
(1010, '2025-03-08 08:57:04', 'Shipped', 1010.00, 18, NULL),
(1011, '2025-03-08 14:23:31', 'Shipped', 900857.00, 18, NULL),
(1012, '2025-03-08 14:28:15', 'Shipped', 900857.00, 18, NULL),
(1013, '2025-03-08 14:35:46', 'Shipped', 900857.00, 18, NULL),
(1016, '2025-03-08 14:44:15', 'Shipped', 730.00, 18, NULL),
(1020, '2025-03-08 14:54:01', 'Shipped', 730.00, 18, NULL),
(1021, '2025-03-08 14:55:37', 'Shipped', 730.00, 18, NULL),
(1022, '2025-03-08 14:57:29', 'Shipped', 730.00, 18, NULL),
(1023, '2025-03-08 14:58:40', 'Shipped', 730.00, 18, NULL),
(1024, '2025-03-08 14:59:10', 'Shipped', 730.00, 18, NULL),
(1025, '2025-03-08 15:00:06', 'Shipped', 730.00, 18, NULL),
(1026, '2025-03-08 15:02:32', 'Pending', 730.00, 18, NULL),
(1027, '2025-03-08 15:25:50', 'Shipped', 730.00, 18, NULL),
(1028, '2025-03-08 15:26:18', 'Shipped', 730.00, 18, NULL),
(1029, '2025-03-08 15:27:38', 'Shipped', 730.00, 18, NULL),
(1030, '2025-03-10 03:32:45', 'Shipped', 1800250.00, 21, NULL),
(1031, '2025-03-10 03:32:46', 'Shipped', 1800250.00, 21, NULL),
(1032, '2025-03-10 03:32:46', 'Shipped', 1800250.00, 21, NULL),
(1034, '2025-03-10 03:32:47', 'Shipped', 1800250.00, 21, NULL),
(1035, '2025-03-10 03:33:23', 'Shipped', 1800250.00, 21, NULL),
(1036, '2025-03-10 03:33:25', 'Shipped', 1800250.00, 21, NULL),
(1037, '2025-03-10 03:33:25', 'Shipped', 1800250.00, 21, NULL),
(1038, '2025-03-10 03:33:30', 'Shipped', 1800250.00, 21, NULL),
(1039, '2025-03-10 03:33:44', 'Shipped', 1800250.00, 21, NULL),
(1040, '2025-03-10 03:33:45', 'Shipped', 1800250.00, 21, NULL),
(1041, '2025-03-10 03:37:53', 'Shipped', 530.00, 22, NULL),
(1042, '2025-03-10 03:39:54', 'Shipped', 530.00, 22, NULL),
(1043, '2025-03-10 03:40:13', 'Shipped', 530.00, 22, NULL),
(1044, '2025-03-10 03:49:11', 'Shipped', 530.00, 22, NULL),
(1045, '2025-03-10 03:50:09', 'Shipped', 530.00, 22, NULL),
(1046, '2025-03-10 03:56:20', 'Shipped', 530.00, 22, NULL),
(1047, '2025-03-10 03:58:01', 'Shipped', 530.00, 22, NULL),
(1048, '2025-03-10 03:58:43', 'Shipped', 530.00, 22, NULL),
(1049, '2025-03-10 03:59:34', 'Shipped', 530.00, 22, NULL),
(1050, '2025-03-10 04:01:02', 'Shipped', 530.00, 22, NULL),
(1051, '2025-03-10 04:01:58', 'Shipped', 530.00, 22, NULL),
(1052, '2025-03-10 04:04:50', 'Shipped', 530.00, 22, NULL),
(1053, '2025-03-10 04:08:31', 'Shipped', 530.00, 22, NULL),
(1054, '2025-03-10 04:10:52', 'Shipped', 530.00, 22, NULL),
(1055, '2025-03-10 04:11:13', 'Shipped', 530.00, 22, NULL),
(1056, '2025-03-10 04:12:37', 'Completed', 530.00, 22, NULL),
(1057, '2025-03-10 07:53:59', 'Shipped', 1030.00, 23, NULL),
(1058, '2025-03-10 07:56:07', 'Completed', 2060.00, 23, NULL),
(1059, '2025-03-10 08:51:11', 'Shipped', 450.00, 23, NULL),
(1060, '2025-03-10 09:01:22', 'Shipped', 450.00, 23, NULL),
(1061, '2025-03-10 09:01:40', 'Shipped', 450.00, 23, NULL),
(1062, '2025-03-10 09:10:25', 'Shipped', 450.00, 23, NULL),
(1063, '2025-03-10 09:11:51', 'Shipped', 450.00, 23, NULL),
(1064, '2025-03-10 09:14:52', 'Shipped', 250.00, 23, NULL),
(1065, '2025-03-10 09:28:22', 'Shipped', 1600.00, 23, NULL),
(1066, '2025-03-10 09:28:43', 'Shipped', 250.00, 23, NULL),
(1067, '2025-03-10 09:29:17', 'Shipped', 250.00, 23, NULL),
(1068, '2025-03-10 09:30:24', 'Shipped', 250.00, 23, NULL),
(1069, '2025-03-10 09:30:53', 'Shipped', 280.00, 23, NULL),
(1070, '2025-03-10 09:30:55', 'Shipped', 280.00, 23, NULL),
(1071, '2025-03-10 09:31:22', 'Shipped', 580.00, 23, NULL),
(1072, '2025-03-10 09:32:33', 'Shipped', 450.00, 23, NULL),
(1073, '2025-03-10 09:33:02', 'Shipped', 450.00, 23, NULL),
(1074, '2025-03-10 09:34:17', 'Shipped', 250.00, 23, NULL),
(1075, '2025-03-10 09:34:19', 'Shipped', 250.00, 23, NULL),
(1076, '2025-03-10 09:34:21', 'Shipped', 250.00, 23, NULL),
(1077, '2025-03-10 09:35:48', 'Shipped', 900000.00, 23, NULL),
(1078, '2025-03-10 09:36:21', 'Shipped', 900000.00, 23, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `quantity`, `price`, `order_id`, `product_id`) VALUES
(2, 1, 250.00, 1002, 103),
(7, 1, 450.00, 1010, 102),
(8, 2, 280.00, 1010, 101),
(9, 3, 19.00, 1011, 210),
(10, 2, 0.00, 1011, 204),
(11, 1, 900000.00, 1011, 208),
(12, 3, 19.00, 1012, 210),
(13, 2, 0.00, 1012, 204),
(14, 1, 900000.00, 1012, 208),
(15, 3, 19.00, 1013, 210),
(16, 2, 0.00, 1013, 204),
(17, 1, 900000.00, 1013, 208),
(18, 1, 0.00, 1016, 102),
(19, 1, 0.00, 1016, 101),
(20, 1, 450.00, 1020, 102),
(21, 1, 280.00, 1020, 101),
(22, 1, 450.00, 1021, 102),
(23, 1, 280.00, 1021, 101),
(24, 1, 450.00, 1022, 102),
(25, 1, 280.00, 1022, 101),
(26, 1, 450.00, 1023, 102),
(27, 1, 280.00, 1023, 101),
(28, 1, 450.00, 1024, 102),
(29, 1, 280.00, 1024, 101),
(30, 1, 450.00, 1025, 102),
(31, 1, 280.00, 1025, 101),
(32, 1, 450.00, 1026, 102),
(33, 1, 280.00, 1026, 101),
(34, 1, 450.00, 1027, 102),
(35, 1, 280.00, 1027, 101),
(36, 1, 450.00, 1028, 102),
(37, 1, 280.00, 1028, 101),
(38, 1, 450.00, 1029, 102),
(39, 1, 280.00, 1029, 101),
(40, 2, 900000.00, 1030, 208),
(41, 1, 250.00, 1030, 103),
(42, 2, 900000.00, 1031, 208),
(43, 1, 250.00, 1031, 103),
(44, 2, 900000.00, 1032, 208),
(45, 1, 250.00, 1032, 103),
(48, 2, 900000.00, 1034, 208),
(49, 1, 250.00, 1034, 103),
(50, 2, 900000.00, 1035, 208),
(51, 1, 250.00, 1035, 103),
(52, 2, 900000.00, 1036, 208),
(53, 1, 250.00, 1036, 103),
(54, 2, 900000.00, 1037, 208),
(55, 1, 250.00, 1037, 103),
(56, 2, 900000.00, 1038, 208),
(57, 1, 250.00, 1038, 103),
(58, 2, 900000.00, 1039, 208),
(59, 1, 250.00, 1039, 103),
(60, 2, 900000.00, 1040, 208),
(61, 1, 250.00, 1040, 103),
(62, 1, 250.00, 1041, 103),
(63, 1, 280.00, 1041, 101),
(64, 1, 250.00, 1042, 103),
(65, 1, 280.00, 1042, 101),
(66, 1, 250.00, 1043, 103),
(67, 1, 280.00, 1043, 101),
(68, 1, 250.00, 1044, 103),
(69, 1, 280.00, 1044, 101),
(70, 1, 250.00, 1045, 103),
(71, 1, 280.00, 1045, 101),
(72, 1, 250.00, 1046, 103),
(73, 1, 280.00, 1046, 101),
(74, 1, 250.00, 1047, 103),
(75, 1, 280.00, 1047, 101),
(76, 1, 250.00, 1048, 103),
(77, 1, 280.00, 1048, 101),
(78, 1, 250.00, 1049, 103),
(79, 1, 280.00, 1049, 101),
(80, 1, 250.00, 1050, 103),
(81, 1, 280.00, 1050, 101),
(82, 1, 250.00, 1051, 103),
(83, 1, 280.00, 1051, 101),
(84, 1, 250.00, 1052, 103),
(85, 1, 280.00, 1052, 101),
(86, 1, 250.00, 1053, 103),
(87, 1, 280.00, 1053, 101),
(88, 1, 250.00, 1054, 103),
(89, 1, 280.00, 1054, 101),
(90, 1, 250.00, 1055, 103),
(91, 1, 280.00, 1055, 101),
(92, 1, 250.00, 1056, 103),
(93, 1, 280.00, 1056, 101),
(94, 1, 580.00, 1057, 201),
(95, 1, 450.00, 1057, 102),
(96, 2, 580.00, 1058, 201),
(97, 2, 450.00, 1058, 102),
(98, 1, 450.00, 1059, 102),
(99, 1, 450.00, 1060, 102),
(100, 1, 450.00, 1061, 102),
(101, 1, 450.00, 1062, 102),
(102, 1, 450.00, 1063, 102),
(103, 1, 250.00, 1064, 103),
(104, 1, 450.00, 1065, 102),
(105, 1, 1150.00, 1065, 202),
(106, 1, 250.00, 1066, 103),
(107, 1, 250.00, 1067, 103),
(108, 1, 250.00, 1068, 103),
(109, 1, 280.00, 1069, 101),
(110, 1, 280.00, 1070, 101),
(111, 1, 580.00, 1071, 201),
(112, 1, 450.00, 1072, 102),
(113, 1, 450.00, 1073, 102),
(114, 1, 250.00, 1074, 103),
(115, 1, 250.00, 1075, 103),
(116, 1, 250.00, 1076, 103),
(117, 1, 900000.00, 1077, 209),
(118, 1, 900000.00, 1078, 209);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('Credit Card','PayPal','cod','qr_code','Bank Transfer') NOT NULL,
  `status` enum('Success','Failed','Pending') NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payments`
--

INSERT INTO `payments` (`payment_id`, `payment_date`, `amount`, `payment_method`, `status`, `order_id`) VALUES
(5002, NULL, 250.00, 'Bank Transfer', 'Pending', 1002),
(5005, '2025-03-08 08:57:04', 1010.00, '', 'Success', 1010),
(5006, '2025-03-08 14:23:31', 900857.00, '', 'Success', 1011),
(5007, '2025-03-08 14:28:15', 900857.00, '', 'Success', 1012),
(5008, '2025-03-08 14:35:46', 900857.00, '', 'Success', 1013),
(5009, '2025-03-08 14:44:15', 730.00, '', 'Success', 1016),
(5010, '2025-03-08 14:54:01', 730.00, '', 'Success', 1020),
(5011, '2025-03-08 14:55:37', 730.00, '', 'Success', 1021),
(5012, '2025-03-08 14:57:29', 730.00, '', 'Success', 1022),
(5013, '2025-03-08 14:58:40', 730.00, '', 'Success', 1023),
(5014, '2025-03-08 14:59:10', 730.00, '', 'Success', 1024),
(5015, '2025-03-08 15:00:06', 730.00, '', 'Success', 1025),
(5016, '2025-03-08 15:02:32', 730.00, '', 'Success', 1026),
(5017, '2025-03-08 15:25:50', 730.00, '', 'Success', 1027),
(5018, '2025-03-08 15:26:18', 730.00, '', 'Success', 1028),
(5019, '2025-03-08 15:27:38', 730.00, '', 'Success', 1029),
(5020, '2025-03-10 03:32:45', 1800250.00, 'cod', 'Success', 1030),
(5021, '2025-03-10 03:32:46', 1800250.00, 'cod', 'Success', 1031),
(5022, '2025-03-10 03:32:47', 1800250.00, 'cod', 'Success', 1032),
(5024, '2025-03-10 03:32:47', 1800250.00, 'cod', 'Success', 1034),
(5025, '2025-03-10 03:33:23', 1800250.00, 'cod', 'Success', 1035),
(5026, '2025-03-10 03:33:25', 1800250.00, 'cod', 'Success', 1036),
(5027, '2025-03-10 03:33:25', 1800250.00, 'cod', 'Success', 1037),
(5028, '2025-03-10 03:33:30', 1800250.00, 'cod', 'Success', 1038),
(5029, '2025-03-10 03:33:44', 1800250.00, 'cod', 'Success', 1039),
(5030, '2025-03-10 03:33:46', 1800250.00, 'cod', 'Success', 1040),
(5031, '2025-03-10 03:37:53', 530.00, 'cod', 'Success', 1041),
(5032, '2025-03-10 03:39:54', 530.00, 'cod', 'Success', 1042),
(5033, '2025-03-10 03:40:13', 530.00, 'cod', 'Success', 1043),
(5034, '2025-03-10 03:49:11', 530.00, 'cod', 'Success', 1044),
(5035, '2025-03-10 03:50:10', 530.00, 'cod', 'Success', 1045),
(5036, '2025-03-10 03:56:20', 530.00, 'cod', 'Success', 1046),
(5037, '2025-03-10 03:58:01', 530.00, 'cod', 'Success', 1047),
(5038, '2025-03-10 03:58:43', 530.00, 'cod', 'Success', 1048),
(5039, '2025-03-10 03:59:34', 530.00, 'Credit Card', 'Success', 1049),
(5040, '2025-03-10 04:01:02', 530.00, 'Credit Card', 'Success', 1050),
(5041, '2025-03-10 04:01:58', 530.00, 'cod', 'Success', 1051),
(5042, '2025-03-10 04:04:50', 530.00, 'Credit Card', 'Success', 1052),
(5043, '2025-03-10 04:08:31', 530.00, 'qr_code', 'Success', 1053),
(5044, '2025-03-10 04:10:52', 530.00, 'qr_code', 'Success', 1054),
(5045, '2025-03-10 04:11:13', 530.00, 'cod', 'Success', 1055),
(5046, '2025-03-10 04:12:37', 530.00, 'cod', 'Success', 1056),
(5047, '2025-03-10 07:53:59', 1030.00, 'cod', 'Success', 1057),
(5048, '2025-03-10 07:56:07', 2060.00, 'cod', 'Success', 1058),
(5049, '2025-03-10 08:51:11', 450.00, 'cod', 'Success', 1059),
(5050, '2025-03-10 09:01:22', 450.00, 'cod', 'Success', 1060),
(5051, '2025-03-10 09:01:40', 450.00, 'cod', 'Success', 1061),
(5052, '2025-03-10 09:10:25', 450.00, 'cod', 'Success', 1062),
(5053, '2025-03-10 09:11:51', 450.00, 'cod', 'Success', 1063),
(5054, '2025-03-10 09:14:52', 250.00, 'cod', 'Success', 1064),
(5055, '2025-03-10 09:28:22', 1600.00, 'cod', 'Success', 1065),
(5056, '2025-03-10 09:28:43', 250.00, 'cod', 'Success', 1066),
(5057, '2025-03-10 09:29:17', 250.00, 'qr_code', 'Success', 1067),
(5058, '2025-03-10 09:30:24', 250.00, 'cod', 'Success', 1068),
(5059, '2025-03-10 09:30:53', 280.00, 'qr_code', 'Success', 1069),
(5060, '2025-03-10 09:30:55', 280.00, 'qr_code', 'Success', 1070),
(5061, '2025-03-10 09:31:22', 580.00, 'qr_code', 'Success', 1071),
(5062, '2025-03-10 09:32:33', 450.00, 'qr_code', 'Success', 1072),
(5063, '2025-03-10 09:33:02', 450.00, 'qr_code', 'Success', 1073),
(5064, '2025-03-10 09:34:17', 250.00, 'qr_code', 'Success', 1074),
(5065, '2025-03-10 09:34:19', 250.00, 'qr_code', 'Success', 1075),
(5066, '2025-03-10 09:34:21', 250.00, 'qr_code', 'Success', 1076),
(5067, '2025-03-10 09:35:48', 900000.00, 'qr_code', 'Success', 1077),
(5068, '2025-03-10 09:36:21', 900000.00, 'qr_code', 'Success', 1078);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount_price` decimal(10,2) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `brand_id` int(11) DEFAULT NULL,
  `sku` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `discount_price`, `rating`, `created_at`, `brand_id`, `sku`) VALUES
(101, 'Đồng hồ Casio G-Shock', 'Đồng hồ bền bỉ, phong cách thể thao', 300.00, 280.00, 5, '2025-02-24 02:02:30', 1, 'CGS-101'),
(102, 'Đồng hồ Citizen Eco-Drive', 'Đồng hồ Citizen với công nghệ Eco-Drive, không cần thay pin', 500.00, 450.00, 4, '2025-02-24 02:02:30', 2, 'CIT-102'),
(103, 'Đồng hồ Fossil', 'Đồng hồ Fossil thiết kế hiện đại, chất lượng tốt', 250.00, NULL, 4, '2025-02-24 02:02:30', 3, 'FOS-103'),
(201, 'Đồng hồ Xu hướng 2025 - A', 'Thiết kế độc đáo, bắt kịp xu hướng năm 2025', 600.00, 580.00, 5, '2025-02-24 02:02:30', 4, 'XTD-201'),
(202, 'Đồng hồ Cao cấp - B', 'Đồng hồ cao cấp với chất liệu sang trọng', 1200.00, 1150.00, 5, '2025-02-24 02:02:30', 5, 'CC-202'),
(203, 'Đồng hồ Nổi bật - C', 'Sản phẩm được khách hàng yêu thích và đánh giá cao', 800.00, 750.00, 4, '2025-02-24 02:02:30', 6, 'NB-203'),
(204, 'Đồng hồ Treo tường - D', 'Sản phẩm trang trí treo tường độc đáo', 400.00, NULL, 4, '2025-02-24 02:02:30', 7, 'TT-204'),
(208, 'Đồng hồ test', 'Mô tả sản phẩm test', 1000000.00, 900000.00, 5, '2025-02-26 15:43:21', 1, 'DH001'),
(209, 'Đồng hồ test2', 'Mô tả sản phẩm test2', 1000000.00, 900000.00, 5, '2025-02-26 15:45:13', 1, 'DH001'),
(210, 'Mẫu đồng hồ nam đẹp cá tính', 'Sản phẩm đồng hồ tốt, đẹp , có đính kim cương lịch lãm', 200.00, 19.00, 1, '2025-03-07 13:48:46', 1, 'SP9612'),
(212, 'test lỗi', 'test sản phẩm', 3000000.00, 200.00, 1, '2025-03-07 15:01:35', 1, 'SP6752'),
(213, 'Đồng hồ test1', 'testtttt', 2000000.00, 1900000.00, 1, '2025-03-09 12:05:46', 1, 'SP5209'),
(214, 'test2', 'test', 2122222.00, 99999999.99, 1, '2025-03-09 12:16:06', 1, 'SP1529'),
(215, 'tes3', 'Sản phẩm đẹp, chất lượng cao nam tính', 2000.00, 1200.00, 1, '2025-03-10 08:05:52', 1, 'SP3044'),
(216, 'têst', 'ádasdasdasd', 20000.00, 12000.00, 1, '2025-03-10 08:39:11', 1, 'SP1498'),
(218, 'transfer', '12eqwqeqwe', 12000.00, 2000.00, 1, '2025-03-10 08:49:38', 1, 'SP1069'),
(219, 'ádasd', 'ádasdas', 1200.00, 200.00, 1, '2025-03-10 09:37:27', 1, 'SP3119'),
(221, '1212', 'adsasds', 99999999.99, 1221212.00, 1, '2025-04-11 14:39:51', 1, 'SP5229');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_images`
--

CREATE TABLE `product_images` (
  `product_image_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_images`
--

INSERT INTO `product_images` (`product_image_id`, `url`, `product_id`) VALUES
(1, 'http://localhost:6969/uploads/product/product1.png', 101),
(2, 'http://localhost:6969/uploads/product/product2.png', 102),
(3, 'http://localhost:6969/uploads/product/product3.png', 103),
(4, 'https://www.watchstore.vn/images/products/2024/06/04/resized/caw211r-fc6401-1_tag-heuer_1717491547.webp', 201),
(5, 'https://www.watchstore.vn/images/products/2024/resized/424-1968262149-860594244-1712496235.webp', 201),
(6, 'https://www.watchstore.vn/images/products/2024/resized/l26285597-1-1712495070.webp', 201),
(7, 'https://cdn.watchstore.vn/wp-content/uploads/2024/06/8131g-ch-n-1_1724295646-400x400.jpg', 201),
(8, 'https://www.watchstore.vn/images/products/2024/06/04/resized/caw211r-fc6401-1_tag-heuer_1717491547.webp', 202),
(9, 'https://www.watchstore.vn/images/products/2024/resized/424-1968262149-860594244-1712496235.webp', 202),
(10, 'https://www.watchstore.vn/images/products/2024/resized/l26285597-1-1712495070.webp', 202),
(11, 'https://www.watchstore.vn/images/products/2024/05/25/resized/l2-786-5-76-3-1_longines_1716604473.webp', 202),
(12, 'https://www.watchstore.vn/images/products/2024/resized/nh8350-59l-1-1975983304-2071507878-1712483070.webp', 203),
(13, 'https://www.watchstore.vn/images/products/2024/resized/bf2011-01e-1712485173.webp', 203),
(14, 'https://www.watchstore.vn/images/products/2024/resized/bl8150-86l-1712483038.webp', 203),
(15, 'https://www.watchstore.vn/images/products/2024/resized/au1062-56e-112015096-579722830-1712485146.webp', 203),
(16, 'https://www.watchstore.vn/images/products/2024/11/07/resized/dong-ho-treo-tuong-seiko-qxm604b_1730953080.webp', 204),
(17, 'https://www.watchstore.vn/images/products/2024/resized/iq-126-5df-1712494750.webp', 204),
(18, 'https://www.watchstore.vn/images/products/2024/12/05/resized/seiko-qha007kl_1733388037.webp', 204),
(19, 'https://www.watchstore.vn/images/products/2024/09/27/resized/qxc237b-png_1727440522.webp', 204),
(22, 'http://localhost:6969/uploads/product/1740584601781-image.webp', 208),
(23, 'http://localhost:6969/uploads/product/1740584713667-image.webp', 209),
(24, 'http://localhost:6969/uploads/product/1741355326053-op990-45adgs-gl-d-1-1655171691816-1712491806.webp', 210),
(26, 'http://localhost:6969/uploads/product/1741359695116-ba2751d6-6894-4eff-a917-27cdbe4f23dc.jpg', 212),
(27, 'http://localhost:6969/uploads/product/1741521946851-op990-45adgs-gl-d-1-1655171691816-1712491806.webp', 213),
(28, 'http://localhost:6969/uploads/product/1741522566284-op990-45adgs-gl-d-1-1655171691816-1712491806.webp', 214),
(29, 'http://localhost:6969/uploads/product/1741593952499-bg5605-a2-1-1712498961.webp', 215),
(30, 'http://localhost:6969/uploads/product/1741595951371-bg5605-a2-1-1712498961.webp', 216),
(32, 'http://localhost:6969/uploads/product/1741596578694-bg5605-a2-1-1712498961.webp', 218),
(33, 'http://localhost:6969/uploads/product/1741599447853-bg5605-a2-1-1712498961.webp', 219),
(35, 'http://localhost:6969/uploads/product/1744382391033-Screenshot 2025-04-11 201836.png', 221);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`role_id`, `name`, `description`) VALUES
(1, 'Admin', 'Quản trị hệ thống'),
(2, 'Customer', 'Khách hàng mua hàng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20240803101000-create-roles.js'),
('20240803101100-create-categories.js'),
('20240803101200-create-products.js'),
('20240803101300-create-categories-has-products.js'),
('20240803101400-create-product-images.js'),
('20240803101513-create-users.js'),
('20240803101600-create-cart.js'),
('20240803101700-create-cart-items.js'),
('20240803101800-create-orders.js'),
('20240803101900-create-order-items.js'),
('20240803102000-create-payments.js'),
('20240803102100-create-feedbacks.js'),
('20250224015330-add-image-to-categories.js'),
('20250226143712-update-products-add-default-timestamp.js'),
('20250304141226-create-messages.js'),
('20250309115518-update-payments-method.js');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `phone`, `address`, `created_at`, `role_id`) VALUES
(1, 'Updated12 Name', 'updated1.email@example.com', 'hash12345', '0123456789', 'Hà Nội, Việt Nam', '2025-02-24 02:02:30', 2),
(2, 'Trần Thị Bê', 'b@email.com', 'hash54321', '0987654321', '41 Phạm Ngũ Lão, Hà Nội', '2025-02-24 02:02:30', 2),
(4, 'John Doe', 'john@example.com', '123456', NULL, NULL, '0000-00-00 00:00:00', 2),
(9, 'Nguyen Van A', 'nguyenvana@example.com', '$2a$10$smSirD8eBVCUcQx8K5k.9eHHsAiOJOOXH12jxF.w5Jesm./OLd2z2', '0987654321', '123 Đường ABC, Quận 1, TP.HCM', '0000-00-00 00:00:00', 2),
(10, 'Nguyen Van B', 'nguyenvana@example1.com', '$2a$10$smSirD8eBVCUcQx8K5k.9eHHsAiOJOOXH12jxF.w5Jesm./OLd2z2', NULL, NULL, '0000-00-00 00:00:00', 2),
(11, 'Ngo manh thong1', 'ngothongmanh.email@example.com', '$2a$10$SBDisl/uAtO8983BUTmK2OV4ss8KnVPkhx8t8Sykf4sRVM.VF7AlK', '0834162371', '47 An Dương Vương', '0000-00-00 00:00:00', 1),
(13, 'Admin', 'admin@gmail.com', '$2a$10$bI42xDQeRHxaWHXDnymjuO/4jtGKJl.BxPE.1Jzu8jTqFXJivj4qy', NULL, NULL, '2025-03-07 13:22:46', 1),
(14, 'Công Minh', 'congminh@gmail.com', '$2a$10$LQrB6JVu0BFd4HqWSsWaSebVO6f1PdRIwhwe5msAW8JOeyrQ4C/WK', NULL, NULL, '0000-00-00 00:00:00', 2),
(15, 'Nguyễn An', '1212@gmail.com', '$2a$10$5dzokYeMs/kcYOTLdLtr2uY9g.dSf/uCwmdiOjpszcHQ0x.WpBGzK', NULL, NULL, '0000-00-00 00:00:00', 2),
(16, 'Hồ Quang Trường', 'truong@gmail.com', '$2a$10$Qs9m92O04BO9WnkRnEKCg.NR/5XjDWsLzDWSQpO.5z12TvI.STU5W', NULL, NULL, '0000-00-00 00:00:00', 2),
(17, 'test', 'test@gmail.com', '$2a$10$DjW60feKYW0VNFlmDlgvy.KZkJ6SdNp4l2D7L/cAtfNLlF0ES944u', NULL, NULL, '0000-00-00 00:00:00', 2),
(18, 'Công Minh', 'congminhchannel2@gmail.com', '$2a$10$bI42xDQeRHxaWHXDnymjuO/4jtGKJl.BxPE.1Jzu8jTqFXJivj4qy', '01213123123', 'Chưa có thông tin', '2025-03-07 13:09:20', 2),
(20, 'test2', 'test2@gmail.com', '$2a$10$765icFHBqGo6PfJsbQ/fl.J0Tid8MGtXFOnBP17m6.owzAWz/60vG', NULL, NULL, '2025-03-08 01:56:20', 2),
(21, 'Nguyễn Tài', 'test3@gmail.com', '$2a$10$LgIwLE33b0OhsLpUSyU8duXRXXLwqsMujCA6ffWGIBUaahrxx8wsW', '08211213', '41 duong hieu tuoc', '2025-03-09 15:03:48', 2),
(22, 'Nguyễn An', 'annguyenmxh@gmail.com', '$2y$10$EhwG4wCFt/nQQidTSywtvOQT2i0EYKLidkS.mOFVrhkB//h7VnCOq', '0123123123', '41 đống đa hà nội', '2025-03-10 03:36:34', 1),
(23, 'Vĩnh Phước', 'lep94003@gmail.com', '$2a$10$8A4.Su7CurHFiC9iZtMSpOvewHxYICBmRAUAjILtiL839.w9RU8Fe', '012398172', '47 Đống Đa Hà Nội', '2025-03-10 07:49:17', 2);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `categories_has_products`
--
ALTER TABLE `categories_has_products`
  ADD PRIMARY KEY (`categories_category_id`,`products_product_id`),
  ADD KEY `products_product_id` (`products_product_id`);

--
-- Chỉ mục cho bảng `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Chỉ mục cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`product_image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Chỉ mục cho bảng `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2008;

--
-- AUTO_INCREMENT cho bảng `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1079;

--
-- AUTO_INCREMENT cho bảng `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5069;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT cho bảng `product_images`
--
ALTER TABLE `product_images`
  MODIFY `product_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `categories_has_products`
--
ALTER TABLE `categories_has_products`
  ADD CONSTRAINT `categories_has_products_ibfk_1` FOREIGN KEY (`categories_category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `categories_has_products_ibfk_2` FOREIGN KEY (`products_product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feedbacks_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feedbacks_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
