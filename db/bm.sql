/*
 Navicat Premium Data Transfer

 Source Server         : grahalonia-admin local
 Source Server Type    : MySQL
 Source Server Version : 50638
 Source Host           : localhost:8889
 Source Schema         : building_management

 Target Server Type    : MySQL
 Target Server Version : 50638
 File Encoding         : 65001

 Date: 18/04/2018 10:45:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bm_user
-- ----------------------------
DROP TABLE IF EXISTS `bm_user`;
CREATE TABLE `bm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `building_id` int(255) DEFAULT NULL,
  `bm_user_code` varchar(255) DEFAULT NULL,
  `emei` varchar(255) DEFAULT NULL,
  `photo` blob,
  `user_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bm_user` (`building_id`),
  KEY `fk_bm_user_1` (`user_type_id`),
  CONSTRAINT `fk_bm_user` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`),
  CONSTRAINT `fk_bm_user_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building_name` varchar(255) DEFAULT NULL,
  `building_type` int(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_building` (`building_type`),
  CONSTRAINT `fk_building` FOREIGN KEY (`building_type`) REFERENCES `building_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for building_type
-- ----------------------------
DROP TABLE IF EXISTS `building_type`;
CREATE TABLE `building_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for service_item
-- ----------------------------
DROP TABLE IF EXISTS `service_item`;
CREATE TABLE `service_item` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_ppn` varchar(255) DEFAULT NULL,
  `delivery_cost` decimal(10,2) DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `fee_bm` varchar(255) DEFAULT NULL,
  `total_with_fee` varchar(255) DEFAULT NULL,
  `sp_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_service_item` (`sp_id`),
  CONSTRAINT `fk_service_item` FOREIGN KEY (`sp_id`) REFERENCES `service_provider` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for service_provider
-- ----------------------------
DROP TABLE IF EXISTS `service_provider`;
CREATE TABLE `service_provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(255) DEFAULT NULL,
  `sp_code` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `cp_name` varchar(255) DEFAULT NULL,
  `cp_id` varchar(11) DEFAULT NULL,
  `cp_mail` varchar(255) DEFAULT NULL,
  `cp_handphone` varchar(255) DEFAULT NULL,
  `registered_by` int(255) DEFAULT NULL,
  `account_no` varchar(11) DEFAULT NULL,
  `service_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_service_provider` (`service_type_id`),
  KEY `fk_service_provider_1` (`registered_by`),
  CONSTRAINT `fk_service_provider` FOREIGN KEY (`service_type_id`) REFERENCES `service_type` (`id`),
  CONSTRAINT `fk_service_provider_1` FOREIGN KEY (`registered_by`) REFERENCES `bm_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for service_type
-- ----------------------------
DROP TABLE IF EXISTS `service_type`;
CREATE TABLE `service_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sp_user
-- ----------------------------
DROP TABLE IF EXISTS `sp_user`;
CREATE TABLE `sp_user` (
  `id` int(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_type_id` int(11) DEFAULT NULL,
  `sp_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ktp` varchar(255) DEFAULT NULL,
  `handphone` varchar(255) DEFAULT NULL,
  `photo` blob,
  PRIMARY KEY (`id`),
  KEY `fk_sp_user` (`sp_id`),
  KEY `fk_sp_user_1` (`user_type_id`),
  CONSTRAINT `fk_sp_user` FOREIGN KEY (`sp_id`) REFERENCES `service_provider` (`id`),
  CONSTRAINT `fk_sp_user_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for status_code
-- ----------------------------
DROP TABLE IF EXISTS `status_code`;
CREATE TABLE `status_code` (
  `id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `transaction_code` varchar(255) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `unituser_id` int(11) DEFAULT NULL,
  `bm_id` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `status` int(255) DEFAULT NULL,
  `sp_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transaction` (`unit_id`),
  KEY `fk_transaction_1` (`unituser_id`),
  KEY `fk_transaction_2` (`bm_id`),
  KEY `fk_transaction_3` (`status`),
  KEY `fk_transaction_4` (`sp_user_id`),
  CONSTRAINT `fk_transaction` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`),
  CONSTRAINT `fk_transaction_1` FOREIGN KEY (`unituser_id`) REFERENCES `unit_user` (`id`),
  CONSTRAINT `fk_transaction_2` FOREIGN KEY (`bm_id`) REFERENCES `building` (`id`),
  CONSTRAINT `fk_transaction_3` FOREIGN KEY (`status`) REFERENCES `status_code` (`id`),
  CONSTRAINT `fk_transaction_4` FOREIGN KEY (`sp_user_id`) REFERENCES `sp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for transaction_detail
-- ----------------------------
DROP TABLE IF EXISTS `transaction_detail`;
CREATE TABLE `transaction_detail` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transaction_detail` (`item_id`),
  KEY `fk_transaction_detail_1` (`transaction_id`),
  CONSTRAINT `fk_transaction_detail` FOREIGN KEY (`item_id`) REFERENCES `service_item` (`id`),
  CONSTRAINT `fk_transaction_detail_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `id` int(11) NOT NULL,
  `unit_name` varchar(255) DEFAULT NULL,
  `building_id` int(11) DEFAULT NULL,
  `room_no` int(11) DEFAULT NULL,
  `cp_name` varchar(255) DEFAULT NULL,
  `cp_id` int(11) DEFAULT NULL,
  `cp_mail` varchar(255) DEFAULT NULL,
  `cp_handphone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unit` (`building_id`),
  CONSTRAINT `fk_unit` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unit_user
-- ----------------------------
DROP TABLE IF EXISTS `unit_user`;
CREATE TABLE `unit_user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ktp` varchar(255) DEFAULT NULL,
  `handphone` varchar(255) DEFAULT NULL,
  `user_type_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `bm_id` int(11) DEFAULT NULL,
  `photo` blob,
  PRIMARY KEY (`id`),
  KEY `fk_unit_user` (`user_type_id`),
  KEY `fk_unit_user_1` (`unit_id`),
  CONSTRAINT `fk_unit_user` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`),
  CONSTRAINT `fk_unit_user_1` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
