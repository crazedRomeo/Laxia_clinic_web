/*
 Navicat Premium Data Transfer

 Source Server         : Ares
 Source Server Type    : MySQL
 Source Server Version : 100418
 Source Host           : localhost:3306
 Source Schema         : clinic_doctor_dev

 Target Server Type    : MySQL
 Target Server Version : 100418
 File Encoding         : 65001

 Date: 11/07/2022 22:45:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer_images
-- ----------------------------
DROP TABLE IF EXISTS `answer_images`;
CREATE TABLE `answer_images`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `answer_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_patient_id_foreign`(`answer_id`) USING BTREE,
  CONSTRAINT `answer_images_ibfk_1` FOREIGN KEY (`answer_id`) REFERENCES `answers` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answer_images
-- ----------------------------
INSERT INTO `answer_images` VALUES (2, 37, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/answers/thumbs/QGkaQp1803.jpg', '2021-08-12 11:35:35', '2021-08-12 11:35:35');
INSERT INTO `answer_images` VALUES (3, 37, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/answers/thumbs/MmJjmF8984.jpg', '2021-08-12 11:36:06', '2021-08-12 11:36:06');
INSERT INTO `answer_images` VALUES (4, 45, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/answers/thumbs/CttQlr3519.jpg', '2022-07-07 10:57:15', '2022-07-07 10:57:15');

-- ----------------------------
-- Table structure for answers
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `question_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_patient_id_foreign`(`doctor_id`) USING BTREE,
  INDEX `comments_parent_id_foreign`(`question_id`) USING BTREE,
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answers
-- ----------------------------
INSERT INTO `answers` VALUES (36, 57, 4, 'aaaaaっっっっs', '2021-08-10 05:24:38', '2021-08-10 06:16:25');
INSERT INTO `answers` VALUES (37, 57, 4, '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが', '2021-08-12 11:35:35', '2021-08-12 11:35:35');
INSERT INTO `answers` VALUES (38, 57, 5, 'gttttttttttt', '2021-08-18 01:41:46', '2021-08-18 01:41:51');
INSERT INTO `answers` VALUES (39, 57, 11, 'っっっっっf', '2021-08-18 02:00:18', '2021-08-18 02:00:18');
INSERT INTO `answers` VALUES (40, 57, 5, 'あああああ', '2021-08-18 02:21:50', '2021-08-18 02:21:50');
INSERT INTO `answers` VALUES (41, 57, 6, 'っs', '2021-08-26 07:32:37', '2021-08-26 07:32:37');
INSERT INTO `answers` VALUES (42, 57, 3, 'ggggg', '2022-03-14 07:12:07', '2022-03-14 07:12:07');
INSERT INTO `answers` VALUES (43, 57, 5, 'what is problem', '2022-06-28 22:29:12', '2022-06-28 22:29:12');
INSERT INTO `answers` VALUES (44, 57, 5, 'ffsdfsdaf', '2022-07-07 10:54:16', '2022-07-07 10:54:16');
INSERT INTO `answers` VALUES (45, 57, 8, 'sdfs', '2022-07-07 10:57:15', '2022-07-07 10:57:15');

-- ----------------------------
-- Table structure for attachments
-- ----------------------------
DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `attachable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `attachable_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ファイルパース',
  `img_type` tinyint(3) NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `attachments_attachable_type_attachable_id_index`(`attachable_type`, `attachable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 382 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attachments
-- ----------------------------
INSERT INTO `attachments` VALUES (159, 'App\\Models\\TreatCase', 31, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/before/thumbs/vBdZTT2495.jfif', 0, '2022-06-01 18:46:18', '2022-06-01 18:46:18');
INSERT INTO `attachments` VALUES (160, 'App\\Models\\TreatCase', 31, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/after/thumbs/NtbezG3997.jfif', 1, '2022-06-01 18:46:18', '2022-06-01 18:46:18');
INSERT INTO `attachments` VALUES (163, 'App\\Models\\TreatCase', 32, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/before/thumbs/URZzEK6154.jfif', 0, '2022-06-01 19:02:02', '2022-06-01 19:02:02');
INSERT INTO `attachments` VALUES (164, 'App\\Models\\TreatCase', 32, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/after/thumbs/KFzxeM6217.jfif', 1, '2022-06-01 19:02:02', '2022-06-01 19:02:02');
INSERT INTO `attachments` VALUES (169, 'App\\Models\\TreatCase', 30, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/before/thumbs/NtEKes7292.jpg', 0, '2022-06-22 01:27:42', '2022-06-22 01:27:42');
INSERT INTO `attachments` VALUES (170, 'App\\Models\\TreatCase', 30, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/before/thumbs/OgYAlo7701.jpg', 0, '2022-06-22 01:27:42', '2022-06-22 01:27:42');
INSERT INTO `attachments` VALUES (171, 'App\\Models\\TreatCase', 30, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/cases/after/thumbs/ALCDqi4896.jpg', 1, '2022-06-22 01:27:42', '2022-06-22 01:27:42');
INSERT INTO `attachments` VALUES (188, 'App\\Models\\Menu', 35, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/menus/thumbs/DdrYHr2261.jpg', 0, '2022-07-04 17:38:04', '2022-07-04 17:38:04');
INSERT INTO `attachments` VALUES (189, 'App\\Models\\Menu', 35, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/menus/thumbs/rqvPAc1236.jpg', 0, '2022-07-04 17:38:04', '2022-07-04 17:38:04');
INSERT INTO `attachments` VALUES (379, 'App\\Models\\Clinic', 1, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/menus/thumbs/ziEtgH1426.png', 0, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `attachments` VALUES (380, 'App\\Models\\Clinic', 1, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/menus/thumbs/fxloyz0891.png', 0, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `attachments` VALUES (381, 'App\\Models\\Clinic', 1, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/menus/thumbs/FGaxFT0379.jpg', 0, '2022-07-06 00:10:14', '2022-07-06 00:10:14');

-- ----------------------------
-- Table structure for case_categories
-- ----------------------------
DROP TABLE IF EXISTS `case_categories`;
CREATE TABLE `case_categories`  (
  `case_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL,
  INDEX `case_categories_case_id_foreign`(`case_id`) USING BTREE,
  INDEX `case_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `case_categories_case_id_foreign` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `case_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of case_categories
-- ----------------------------
INSERT INTO `case_categories` VALUES (31, 28);
INSERT INTO `case_categories` VALUES (31, 32);
INSERT INTO `case_categories` VALUES (32, 28);
INSERT INTO `case_categories` VALUES (30, 27);

-- ----------------------------
-- Table structure for case_menus
-- ----------------------------
DROP TABLE IF EXISTS `case_menus`;
CREATE TABLE `case_menus`  (
  `case_id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  INDEX `FK_case_menus_cases`(`case_id`) USING BTREE,
  INDEX `FK_case_menus_menus`(`menu_id`) USING BTREE,
  CONSTRAINT `FK_case_menus_cases` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_case_menus_menus` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of case_menus
-- ----------------------------
INSERT INTO `case_menus` VALUES (32, 11);
INSERT INTO `case_menus` VALUES (2, 34);
INSERT INTO `case_menus` VALUES (3, 9);
INSERT INTO `case_menus` VALUES (4, 35);

-- ----------------------------
-- Table structure for cases
-- ----------------------------
DROP TABLE IF EXISTS `cases`;
CREATE TABLE `cases`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '担当医師',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `patient_age` tinyint(4) NULL DEFAULT NULL COMMENT '施術者の年齢',
  `patient_gender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '施術者の性別',
  `case_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '症例の解説',
  `treat_risk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '副作用・リスク',
  `doctor_opinion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '担当ドクターからのコメント',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cases_clinic_id_foreign`(`clinic_id`) USING BTREE,
  CONSTRAINT `cases_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cases
-- ----------------------------
INSERT INTO `cases` VALUES (1, 1, 73, '二重術1dayナチュラルプレミアム法', 10, 'female', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-23 16:55:56');
INSERT INTO `cases` VALUES (2, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-22 10:26:29');
INSERT INTO `cases` VALUES (3, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-15 12:03:11');
INSERT INTO `cases` VALUES (4, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', 'ああああ', '2021-04-18 14:31:48', '2021-06-16 07:00:39');
INSERT INTO `cases` VALUES (5, 1, NULL, '二重術1dayナチュラルプレミアム法　', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-15 12:28:27');
INSERT INTO `cases` VALUES (6, 1, 73, '二重術1dayナチュラルプレミアム法　', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-15 12:28:34');
INSERT INTO `cases` VALUES (7, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-15 12:28:40');
INSERT INTO `cases` VALUES (8, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-06-15 12:28:47');
INSERT INTO `cases` VALUES (9, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (10, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (11, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (12, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (13, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (14, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (15, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (16, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (17, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (18, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (19, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (20, 1, NULL, '二重術1dayナチュラルプレミアム法', 11, 'male', 'あああ', 'あああ', NULL, '2021-04-18 14:31:48', '2021-04-18 14:31:48');
INSERT INTO `cases` VALUES (29, 1, NULL, 'うい', 30, 'female', 'あああ', 'あああ', 'ああああ', '2021-06-23 17:13:07', '2021-07-20 00:49:40');
INSERT INTO `cases` VALUES (30, 1, NULL, '奥二重切開', 10, 'male', 'っっっっっっっっっs', 'っっっっっっっsっっっっっs\nっっっっっs\n\ns\n\n\n\n\nっっっっっっっっっっs', 'っっっっっs', '2021-07-20 00:48:43', '2022-06-22 01:27:42');
INSERT INTO `cases` VALUES (31, 5, NULL, 'こらあ', 20, 'male', 'ｆｓｆｓｄｆｓｄ', 'ｓｄｆｓｄｆｓｄｆ', 'ｓｄｆｓｄｆｓｄ', '2022-06-01 18:37:53', '2022-06-01 18:37:53');
INSERT INTO `cases` VALUES (32, 6, NULL, 'あああ', 20, 'male', 'ｆｄｓｆｄｓｆ', 'あｆｄｓｆ', 'あｄｆｓだｓふぁ', '2022-06-01 18:59:25', '2022-06-01 18:59:25');

-- ----------------------------
-- Table structure for clinic_day_infos
-- ----------------------------
DROP TABLE IF EXISTS `clinic_day_infos`;
CREATE TABLE `clinic_day_infos`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NOT NULL,
  `day_info_id` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: 営業日, 1: 定休日',
  `start_time` int(11) NULL DEFAULT NULL,
  `end_time` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clinic_day_infos
-- ----------------------------
INSERT INTO `clinic_day_infos` VALUES (161, 1, 1, 0, 2, 0, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (162, 1, 2, 0, 1, 3, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (163, 1, 3, 1, 2, 3, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (164, 1, 4, 0, 0, 3, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (165, 1, 5, 0, 0, 3, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (166, 1, 6, 0, 0, 3, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (167, 1, 7, 0, NULL, NULL, '2022-07-06 00:10:14', '2022-07-06 00:10:14');
INSERT INTO `clinic_day_infos` VALUES (168, 1, 8, 0, 0, 7, '2022-07-06 00:10:14', '2022-07-06 00:10:14');

-- ----------------------------
-- Table structure for clinic_doctors_relation
-- ----------------------------
DROP TABLE IF EXISTS `clinic_doctors_relation`;
CREATE TABLE `clinic_doctors_relation`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clinic_patient_info_memos_clinic_id_foreign`(`clinic_id`) USING BTREE,
  INDEX `clinic_patient_info_memos_patient_info_id_foreign`(`doctor_id`) USING BTREE,
  CONSTRAINT `clinic_doctors_relation_ibfk_1` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `clinic_doctors_relation_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clinic_doctors_relation
-- ----------------------------
INSERT INTO `clinic_doctors_relation` VALUES (3, 71, 57, '2021-08-24 05:34:48', '2021-08-24 05:34:48');
INSERT INTO `clinic_doctors_relation` VALUES (6, 1, 57, '2021-08-25 22:28:48', '2021-08-25 22:28:48');

-- ----------------------------
-- Table structure for clinic_patient_info_memos
-- ----------------------------
DROP TABLE IF EXISTS `clinic_patient_info_memos`;
CREATE TABLE `clinic_patient_info_memos`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NOT NULL,
  `patient_info_id` bigint(20) UNSIGNED NOT NULL,
  `memo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clinic_patient_info_memos_clinic_id_foreign`(`clinic_id`) USING BTREE,
  INDEX `clinic_patient_info_memos_patient_info_id_foreign`(`patient_info_id`) USING BTREE,
  CONSTRAINT `clinic_patient_info_memos_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `clinic_patient_info_memos_patient_info_id_foreign` FOREIGN KEY (`patient_info_id`) REFERENCES `patient_infos` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for clinics
-- ----------------------------
DROP TABLE IF EXISTS `clinics`;
CREATE TABLE `clinics`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'クリニック名',
  `pref_id` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '都道府県',
  `city_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `town_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `addr02` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '住所02',
  `nearest_station` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最寄駅',
  `site` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公式サイト',
  `access` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'アクセス',
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '電話番号',
  `credit_card` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'クレジットカード',
  `parking` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '駐車場',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '写真',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clinics_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `clinics_pref_id_foreign`(`pref_id`) USING BTREE,
  CONSTRAINT `clinics_pref_id_foreign` FOREIGN KEY (`pref_id`) REFERENCES `mtb_prefs` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `clinics_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clinics
-- ----------------------------
INSERT INTO `clinics` VALUES (1, 1, 'クリニック2', NULL, 22, NULL, 'sdsdfadsf', 'asf', 'dfadsf', 'asdfds', '236234234', 'Visa', 'sdfsdafsf', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/TSVOQS4996.jpg', '2021-02-11 01:50:01', '2022-07-04 19:06:56');
INSERT INTO `clinics` VALUES (3, 68, 'クリニック3', NULL, 23, NULL, 'sdsdfadsf', 'asf', 'dfadsf', 'asdfds', '236234234', 'Visa', 'sdfsdafsf', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/TSVOQS4996.jpg', '2021-07-19 05:12:46', '2021-07-19 05:12:46');
INSERT INTO `clinics` VALUES (4, 71, 'クリニック4', NULL, 12, NULL, 'sdsdfadsf', 'asf', 'dfadsf', 'asdfds', '236234234', 'Visa', 'sdfsdafsf', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/TSVOQS4996.jpg', '2021-08-17 17:42:24', '2021-08-17 17:42:24');
INSERT INTO `clinics` VALUES (5, 93, 'クリニック5', NULL, 3, NULL, 'sdsdfadsf', 'asf', 'dfadsf', 'asdfds', '236234234', 'Visa', 'sdfsdafsf', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/TSVOQS4996.jpg', '2022-06-01 18:24:47', '2022-06-01 18:24:47');
INSERT INTO `clinics` VALUES (6, 94, 'クリニック6', NULL, 23, NULL, 'sdsdfadsf', 'asf', 'dfadsf', 'asdfds', '236234234', 'Visa', 'sdfsdafsf', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/TSVOQS4996.jpg', '2022-06-01 18:58:58', '2022-06-01 18:58:58');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `commentable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_commentable_type_commentable_id_index`(`commentable_type`, `commentable_id`) USING BTREE,
  INDEX `comments_patient_id_foreign`(`patient_id`) USING BTREE,
  INDEX `comments_parent_id_foreign`(`parent_id`) USING BTREE,
  CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `comments_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, NULL, 'App\\Models\\TreatProgress', 1, NULL, 'コメント', '2022-04-01 11:26:16', '2022-04-01 11:26:16');
INSERT INTO `comments` VALUES (2, NULL, 'App\\Models\\CounselingReport', 1, NULL, 'コメントdwwd', '2022-04-01 11:35:46', '2022-04-01 11:35:46');
INSERT INTO `comments` VALUES (3, NULL, 'App\\Models\\Question', 9, NULL, 'コメント', '2022-04-01 11:37:18', '2022-04-01 11:37:18');
INSERT INTO `comments` VALUES (4, NULL, 'App\\Models\\TreatProgress', 1, NULL, 'コメント', '2022-05-05 08:21:30', '2022-05-05 08:21:30');
INSERT INTO `comments` VALUES (5, NULL, 'App\\Models\\TreatProgress', 1, NULL, 'コメント', '2022-05-05 08:21:42', '2022-05-05 08:21:42');
INSERT INTO `comments` VALUES (6, NULL, 'App\\Models\\TreatProgress', 1, NULL, 'コメント', '2022-05-05 08:21:51', '2022-05-05 08:21:51');
INSERT INTO `comments` VALUES (7, NULL, 'App\\Models\\CounselingReport', 1, NULL, 'コメントdwwd', '2022-05-05 08:30:17', '2022-05-05 08:30:17');
INSERT INTO `comments` VALUES (8, NULL, 'App\\Models\\Question', 9, NULL, 'コメント', '2022-05-05 19:57:07', '2022-05-05 19:57:07');
INSERT INTO `comments` VALUES (9, NULL, 'App\\Models\\Question', 9, 3, 'コメント', '2022-05-05 19:59:09', '2022-05-05 19:59:09');
INSERT INTO `comments` VALUES (10, NULL, 'App\\Models\\Question', 9, NULL, 'コメント', '2022-05-06 07:56:14', '2022-05-06 07:56:14');
INSERT INTO `comments` VALUES (11, NULL, 'App\\Models\\Question', 9, NULL, 'コメント', '2022-05-06 07:56:27', '2022-05-06 07:56:27');
INSERT INTO `comments` VALUES (12, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:57:25', '2022-05-06 07:57:25');
INSERT INTO `comments` VALUES (13, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:26', '2022-05-06 07:58:26');
INSERT INTO `comments` VALUES (14, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:28', '2022-05-06 07:58:28');
INSERT INTO `comments` VALUES (15, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:29', '2022-05-06 07:58:29');
INSERT INTO `comments` VALUES (16, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:31', '2022-05-06 07:58:31');
INSERT INTO `comments` VALUES (17, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:32', '2022-05-06 07:58:32');
INSERT INTO `comments` VALUES (18, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:33', '2022-05-06 07:58:33');
INSERT INTO `comments` VALUES (19, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:35', '2022-05-06 07:58:35');
INSERT INTO `comments` VALUES (20, NULL, 'App\\Models\\Question', 9, 9, 'コメント', '2022-05-06 07:58:36', '2022-05-06 07:58:36');
INSERT INTO `comments` VALUES (21, NULL, 'App\\Models\\Question', 10, NULL, 'コメント', '2022-05-06 08:02:31', '2022-05-06 08:02:31');
INSERT INTO `comments` VALUES (22, NULL, 'App\\Models\\Question', 10, 1, 'コメント', '2022-05-06 08:02:55', '2022-05-06 08:02:55');
INSERT INTO `comments` VALUES (23, NULL, 'App\\Models\\Question', 10, 1, 'コメント', '2022-05-06 08:02:56', '2022-05-06 08:02:56');
INSERT INTO `comments` VALUES (24, NULL, 'App\\Models\\Question', 10, 1, 'コメント', '2022-05-06 08:03:26', '2022-05-06 08:03:26');
INSERT INTO `comments` VALUES (25, NULL, 'App\\Models\\Question', 10, 1, 'コメント', '2022-05-06 08:03:28', '2022-05-06 08:03:28');
INSERT INTO `comments` VALUES (26, NULL, 'App\\Models\\Question', 10, NULL, 'コメント', '2022-05-06 08:05:00', '2022-05-06 08:05:00');
INSERT INTO `comments` VALUES (27, NULL, 'App\\Models\\Question', 10, NULL, 'コメント', '2022-05-06 08:05:01', '2022-05-06 08:05:01');
INSERT INTO `comments` VALUES (28, NULL, 'App\\Models\\Question', 10, 1, 'コメント', '2022-05-06 08:09:16', '2022-05-06 08:09:16');
INSERT INTO `comments` VALUES (29, NULL, 'App\\Models\\Question', 10, 2, 'コメント', '2022-05-06 08:09:34', '2022-05-06 08:09:34');
INSERT INTO `comments` VALUES (30, NULL, 'App\\Models\\Question', 10, NULL, 'コメント', '2022-05-06 08:12:47', '2022-05-06 08:12:47');
INSERT INTO `comments` VALUES (31, NULL, 'App\\Models\\Question', 10, NULL, 'コメント', '2022-05-06 08:23:34', '2022-05-06 08:23:34');
INSERT INTO `comments` VALUES (32, NULL, 'App\\Models\\Question', 13, NULL, '1232312', '2022-05-06 08:33:10', '2022-05-06 08:33:10');
INSERT INTO `comments` VALUES (33, NULL, 'App\\Models\\Question', 13, NULL, 'fasdfasdfsad', '2022-05-06 08:33:18', '2022-05-06 08:33:18');
INSERT INTO `comments` VALUES (34, NULL, 'App\\Models\\Question', 13, NULL, 'dsdasdasda', '2022-05-06 08:33:26', '2022-05-06 08:33:26');
INSERT INTO `comments` VALUES (35, NULL, 'App\\Models\\Question', 15, NULL, 'sdfsdfd', '2022-05-06 08:37:11', '2022-05-06 08:37:11');
INSERT INTO `comments` VALUES (36, NULL, 'App\\Models\\Question', 13, NULL, 'dfdsf', '2022-05-06 08:46:24', '2022-05-06 08:46:24');
INSERT INTO `comments` VALUES (37, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:26', '2022-05-06 12:54:26');
INSERT INTO `comments` VALUES (38, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:34', '2022-05-06 12:54:34');
INSERT INTO `comments` VALUES (39, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:35', '2022-05-06 12:54:35');
INSERT INTO `comments` VALUES (40, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:35', '2022-05-06 12:54:35');
INSERT INTO `comments` VALUES (41, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:35', '2022-05-06 12:54:35');
INSERT INTO `comments` VALUES (42, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:35', '2022-05-06 12:54:35');
INSERT INTO `comments` VALUES (43, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:35', '2022-05-06 12:54:35');
INSERT INTO `comments` VALUES (44, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:36', '2022-05-06 12:54:36');
INSERT INTO `comments` VALUES (45, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:36', '2022-05-06 12:54:36');
INSERT INTO `comments` VALUES (46, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'dcfcasd', '2022-05-06 12:54:36', '2022-05-06 12:54:36');
INSERT INTO `comments` VALUES (47, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'xcxc', '2022-05-06 12:55:02', '2022-05-06 12:55:02');
INSERT INTO `comments` VALUES (48, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'aaaaaaa', '2022-05-06 12:55:17', '2022-05-06 12:55:17');
INSERT INTO `comments` VALUES (49, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'aaaaaaa', '2022-05-06 12:55:19', '2022-05-06 12:55:19');
INSERT INTO `comments` VALUES (50, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'aaaaaaa', '2022-05-06 12:55:20', '2022-05-06 12:55:20');
INSERT INTO `comments` VALUES (51, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'asds', '2022-05-06 12:55:33', '2022-05-06 12:55:33');
INSERT INTO `comments` VALUES (52, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'aaaaa', '2022-05-06 12:55:41', '2022-05-06 12:55:41');
INSERT INTO `comments` VALUES (53, NULL, 'App\\Models\\CounselingReport', 4, NULL, 'dfdsf', '2022-05-06 12:57:03', '2022-05-06 12:57:03');
INSERT INTO `comments` VALUES (54, NULL, 'App\\Models\\CounselingReport', 4, NULL, 'sdfdf', '2022-05-06 12:57:11', '2022-05-06 12:57:11');
INSERT INTO `comments` VALUES (55, NULL, 'App\\Models\\CounselingReport', 4, NULL, 'sdfdf', '2022-05-06 12:57:12', '2022-05-06 12:57:12');
INSERT INTO `comments` VALUES (56, NULL, 'App\\Models\\CounselingReport', 4, NULL, 'sdfdf', '2022-05-06 12:57:12', '2022-05-06 12:57:12');
INSERT INTO `comments` VALUES (57, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'fff', '2022-05-06 13:00:16', '2022-05-06 13:00:16');
INSERT INTO `comments` VALUES (58, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'asdsdasda', '2022-05-06 13:00:41', '2022-05-06 13:00:41');
INSERT INTO `comments` VALUES (59, NULL, 'App\\Models\\CounselingReport', 3, NULL, 'asdsdasda', '2022-05-06 13:01:32', '2022-05-06 13:01:32');
INSERT INTO `comments` VALUES (60, NULL, 'App\\Models\\CounselingReport', 1, NULL, 'コメントdwwd', '2022-05-06 13:02:30', '2022-05-06 13:02:30');
INSERT INTO `comments` VALUES (61, 70, 'App\\Models\\Question', 12, NULL, 'dfddfssdfdf', '2022-05-23 18:53:01', '2022-05-23 18:53:01');
INSERT INTO `comments` VALUES (62, 70, 'App\\Models\\Question', 12, NULL, 'sdfs', '2022-05-24 09:12:27', '2022-05-24 09:12:27');
INSERT INTO `comments` VALUES (63, 70, 'App\\Models\\Question', 13, NULL, 'asdsd', '2022-05-27 14:21:44', '2022-05-27 14:21:44');
INSERT INTO `comments` VALUES (64, 70, 'App\\Models\\Question', 13, NULL, 'asfasfsaf', '2022-05-27 14:21:49', '2022-05-27 14:21:49');
INSERT INTO `comments` VALUES (65, 70, 'App\\Models\\Question', 13, NULL, 'asfsafsafaf', '2022-05-27 14:21:51', '2022-05-27 14:21:51');
INSERT INTO `comments` VALUES (66, 70, 'App\\Models\\Question', 13, NULL, 'asfasfassaf', '2022-05-27 14:21:57', '2022-05-27 14:21:57');

-- ----------------------------
-- Table structure for counseling_categories
-- ----------------------------
DROP TABLE IF EXISTS `counseling_categories`;
CREATE TABLE `counseling_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `counseling_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `counseling_categories_counseling_id_foreign`(`counseling_id`) USING BTREE,
  INDEX `counseling_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `counseling_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `counseling_categories_counseling_id_foreign` FOREIGN KEY (`counseling_id`) REFERENCES `counseling_reports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of counseling_categories
-- ----------------------------
INSERT INTO `counseling_categories` VALUES (1, 1, 20, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (2, 1, 26, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (3, 2, 20, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (4, 2, 26, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (5, 3, 20, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (6, 3, 26, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (7, 4, 20, NULL, NULL);
INSERT INTO `counseling_categories` VALUES (8, 4, 26, NULL, NULL);

-- ----------------------------
-- Table structure for counseling_questions
-- ----------------------------
DROP TABLE IF EXISTS `counseling_questions`;
CREATE TABLE `counseling_questions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `counseling_report_id` bigint(20) UNSIGNED NOT NULL,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `counseling_questions_counseling_report_id_foreign`(`counseling_report_id`) USING BTREE,
  CONSTRAINT `counseling_questions_counseling_report_id_foreign` FOREIGN KEY (`counseling_report_id`) REFERENCES `counseling_reports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of counseling_questions
-- ----------------------------
INSERT INTO `counseling_questions` VALUES (1, 1, '質問１', '回答１', '2022-04-01 11:30:26', '2022-04-01 11:30:26');
INSERT INTO `counseling_questions` VALUES (2, 1, '質問２', '回答２', '2022-04-01 11:30:26', '2022-04-01 11:30:26');
INSERT INTO `counseling_questions` VALUES (3, 2, '質問１', '回答１', '2022-04-01 11:31:46', '2022-04-01 11:31:46');
INSERT INTO `counseling_questions` VALUES (4, 2, '質問２', '回答２', '2022-04-01 11:31:46', '2022-04-01 11:31:46');
INSERT INTO `counseling_questions` VALUES (5, 3, '質問１', '回答１', '2022-04-01 11:35:29', '2022-04-01 11:35:29');
INSERT INTO `counseling_questions` VALUES (6, 3, '質問２', '回答２', '2022-04-01 11:35:29', '2022-04-01 11:35:29');
INSERT INTO `counseling_questions` VALUES (7, 4, '質問１', '回答１', '2022-04-29 01:36:28', '2022-04-29 01:36:28');
INSERT INTO `counseling_questions` VALUES (8, 4, '質問２', '回答２', '2022-04-29 01:36:28', '2022-04-29 01:36:28');

-- ----------------------------
-- Table structure for counseling_reports
-- ----------------------------
DROP TABLE IF EXISTS `counseling_reports`;
CREATE TABLE `counseling_reports`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '患者ID',
  `clinic_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT 'クリニックID',
  `doctor_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '医師ID',
  `counseling_date` date NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `before_counseling` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `after_ccounseling` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `rate` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `counseling_reports_patient_id_foreign`(`patient_id`) USING BTREE,
  INDEX `counseling_reports_clinic_id_foreign`(`clinic_id`) USING BTREE,
  CONSTRAINT `counseling_reports_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `counseling_reports_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of counseling_reports
-- ----------------------------
INSERT INTO `counseling_reports` VALUES (1, 13, 1, 76, '2020-10-10', 'TBD-ここに例を入れる（どんなことに悩んでいますか？）', 'TBD-ここに例を入れる（このクリニックを選んだ理由は？）', 'カウンセリングの様子はどうでしたか？', 'カウンセリング後の感想', 4, '2022-04-01 11:30:26', '2022-04-01 11:30:26', '湘南美容クリニック銀座院で二重埋没についてカウンセリング');
INSERT INTO `counseling_reports` VALUES (2, 12, 1, 74, '2020-10-10', 'TBD-ここに例を入れる（どんなことに悩んでいますか？）', 'TBD-ここに例を入れる（このクリニックを選んだ理由は？）', 'カウンセリングの様子はどうでしたか？', 'カウンセリング後の感想', 4, '2022-04-01 11:31:46', '2022-04-01 11:31:46', '湘南美容クリニック銀座院で二重埋没についてカウンセリング');
INSERT INTO `counseling_reports` VALUES (3, 11, 1, 74, '2020-10-10', 'TBD-ここに例を入れる（どんなことに悩んでいますか？）', 'TBD-ここに例を入れる（このクリニックを選んだ理由は？）', 'カウンセリングの様子はどうでしたか？', 'カウンセリング後の感想', 4, '2022-04-01 11:35:29', '2022-04-01 11:35:29', '湘南美容クリニック銀座院で二重埋没についてカウンセリング');
INSERT INTO `counseling_reports` VALUES (4, 8, 1, 74, '2020-10-10', 'TBD-ここに例を入れる（どんなことに悩んでいますか？）', 'TBD-ここに例を入れる（このクリニックを選んだ理由は？）', 'カウンセリングの様子はどうでしたか？', 'カウンセリング後の感想', 4, '2022-04-29 01:36:28', '2022-04-29 01:36:28', '湘南美容クリニック銀座院で二重埋没についてカウンセリング');

-- ----------------------------
-- Table structure for day_infos
-- ----------------------------
DROP TABLE IF EXISTS `day_infos`;
CREATE TABLE `day_infos`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` tinyint(4) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of day_infos
-- ----------------------------
INSERT INTO `day_infos` VALUES (1, '月曜日', 1, NULL, NULL);
INSERT INTO `day_infos` VALUES (2, '火曜日', 2, NULL, NULL);
INSERT INTO `day_infos` VALUES (3, '水曜日', 3, NULL, NULL);
INSERT INTO `day_infos` VALUES (4, '木曜日', 4, NULL, NULL);
INSERT INTO `day_infos` VALUES (5, '金曜日', 5, NULL, NULL);
INSERT INTO `day_infos` VALUES (6, '土曜日', 6, NULL, NULL);
INSERT INTO `day_infos` VALUES (7, '日曜日', 7, NULL, NULL);
INSERT INTO `day_infos` VALUES (8, '祝日', 8, NULL, NULL);

-- ----------------------------
-- Table structure for diaries
-- ----------------------------
DROP TABLE IF EXISTS `diaries`;
CREATE TABLE `diaries`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL COMMENT '患者ID',
  `clinic_id` bigint(20) UNSIGNED NOT NULL COMMENT 'クリニックID',
  `treat_date` date NULL DEFAULT NULL COMMENT '施術を受けた日',
  `doctor_id` bigint(20) UNSIGNED NOT NULL COMMENT '担当ドクターID',
  `price` int(11) NULL DEFAULT NULL COMMENT '施術費用',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `rate_01` tinyint(4) NULL DEFAULT NULL,
  `rate_02` tinyint(4) NULL DEFAULT NULL,
  `rate_03` tinyint(4) NULL DEFAULT NULL,
  `rate_04` tinyint(4) NULL DEFAULT NULL,
  `rate_05` tinyint(4) NULL DEFAULT NULL,
  `rate_06` tinyint(4) NULL DEFAULT NULL,
  `rate_07` tinyint(4) NULL DEFAULT NULL,
  `rate_08` tinyint(4) NULL DEFAULT NULL,
  `rate_09` tinyint(4) NULL DEFAULT NULL,
  `ave_rate` double(2, 1) NULL DEFAULT NULL,
  `cost_anesthetic` int(11) NULL DEFAULT NULL COMMENT '麻酔費用',
  `cost_drug` int(11) NULL DEFAULT NULL COMMENT '処方薬の費用',
  `cost_other` int(11) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT 'その他の費用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diaries_patient_id_foreign`(`patient_id`) USING BTREE,
  INDEX `diaries_clinic_id_foreign`(`clinic_id`) USING BTREE,
  INDEX `diaries_doctor_id_foreign`(`doctor_id`) USING BTREE,
  CONSTRAINT `diaries_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `diaries_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diaries
-- ----------------------------
INSERT INTO `diaries` VALUES (10, 8, 3, '2022-06-14', 73, 3000, '2022-07-09 05:49:32', '2022-07-09 05:49:39', 3, 3, 3, 3, 3, 3, 3, 3, 5, 5.0, 200, 200, 00000000200);
INSERT INTO `diaries` VALUES (11, 8, 3, '2022-06-15', 73, 2000, '2022-07-09 05:49:37', '2022-07-09 05:49:42', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4.0, 400, 40, 00000000400);

-- ----------------------------
-- Table structure for diary_categories
-- ----------------------------
DROP TABLE IF EXISTS `diary_categories`;
CREATE TABLE `diary_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `diary_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diary_categories_diary_id_foreign`(`diary_id`) USING BTREE,
  INDEX `diary_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `diary_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `diary_categories_diary_id_foreign` FOREIGN KEY (`diary_id`) REFERENCES `diaries` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diary_categories
-- ----------------------------
INSERT INTO `diary_categories` VALUES (25, 10, 127, NULL, NULL);
INSERT INTO `diary_categories` VALUES (26, 11, 11, NULL, NULL);

-- ----------------------------
-- Table structure for diary_menu
-- ----------------------------
DROP TABLE IF EXISTS `diary_menu`;
CREATE TABLE `diary_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `diary_id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `cost` int(11) NULL DEFAULT NULL COMMENT '施術費用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diary_menu_diary_id_foreign`(`diary_id`) USING BTREE,
  INDEX `diary_menu_menu_id_foreign`(`menu_id`) USING BTREE,
  CONSTRAINT `diary_menu_diary_id_foreign` FOREIGN KEY (`diary_id`) REFERENCES `diaries` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `diary_menu_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diary_menu
-- ----------------------------
INSERT INTO `diary_menu` VALUES (15, 10, 35, NULL, NULL, 2000);
INSERT INTO `diary_menu` VALUES (16, 11, 35, NULL, NULL, 2000);

-- ----------------------------
-- Table structure for diary_rate_questions
-- ----------------------------
DROP TABLE IF EXISTS `diary_rate_questions`;
CREATE TABLE `diary_rate_questions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `diary_id` bigint(20) UNSIGNED NOT NULL,
  `rate` double(8, 2) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diary_rate_questions_question_id_foreign`(`question_id`) USING BTREE,
  INDEX `diary_rate_questions_diary_id_foreign`(`diary_id`) USING BTREE,
  CONSTRAINT `diary_rate_questions_diary_id_foreign` FOREIGN KEY (`diary_id`) REFERENCES `diaries` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `diary_rate_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `mtb_diary_rate_questions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for diary_text_questions
-- ----------------------------
DROP TABLE IF EXISTS `diary_text_questions`;
CREATE TABLE `diary_text_questions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `diary_id` bigint(20) UNSIGNED NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diary_text_questions_question_id_foreign`(`question_id`) USING BTREE,
  INDEX `diary_text_questions_diary_id_foreign`(`diary_id`) USING BTREE,
  CONSTRAINT `diary_text_questions_diary_id_foreign` FOREIGN KEY (`diary_id`) REFERENCES `diaries` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `diary_text_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `mtb_diary_text_questions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for doctor_case_category_relation
-- ----------------------------
DROP TABLE IF EXISTS `doctor_case_category_relation`;
CREATE TABLE `doctor_case_category_relation`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `case_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_patient_id_foreign`(`case_id`) USING BTREE,
  CONSTRAINT `doctor_case` FOREIGN KEY (`case_id`) REFERENCES `doctor_cases` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_case_category_relation
-- ----------------------------
INSERT INTO `doctor_case_category_relation` VALUES (1, 54, 29, '2021-08-20 02:36:10', '2021-08-20 02:36:10');
INSERT INTO `doctor_case_category_relation` VALUES (2, 51, 27, '2022-03-14 11:55:49', '2022-03-14 11:55:49');

-- ----------------------------
-- Table structure for doctor_case_images
-- ----------------------------
DROP TABLE IF EXISTS `doctor_case_images`;
CREATE TABLE `doctor_case_images`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `case_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `type` enum('before','after') CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_patient_id_foreign`(`case_id`) USING BTREE,
  CONSTRAINT `doctor_cases_images_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `doctor_cases` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_case_images
-- ----------------------------
INSERT INTO `doctor_case_images` VALUES (178, 51, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/gXzuxB1652.jpg', '2021-08-09 03:06:09', '2021-08-09 03:06:09');
INSERT INTO `doctor_case_images` VALUES (179, 51, 'after', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/after/thumbs/OunmlI0065.jpg', '2021-08-09 03:06:09', '2021-08-09 03:06:09');
INSERT INTO `doctor_case_images` VALUES (181, 53, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/KMcYnI3320.jpeg', '2021-08-10 05:19:30', '2021-08-10 05:19:30');
INSERT INTO `doctor_case_images` VALUES (182, 53, 'after', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/after/thumbs/dpQfes4997.png', '2021-08-10 05:19:30', '2021-08-10 05:19:30');
INSERT INTO `doctor_case_images` VALUES (183, 54, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/rrSMwq5095.jpg', '2021-08-20 02:36:10', '2021-08-20 02:36:10');
INSERT INTO `doctor_case_images` VALUES (184, 54, 'after', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/after/thumbs/QytjpM3354.jpg', '2021-08-20 02:36:10', '2021-08-20 02:36:10');
INSERT INTO `doctor_case_images` VALUES (186, 53, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/oTdToi6805.jpeg', '2022-06-18 21:00:35', '2022-06-18 21:00:35');
INSERT INTO `doctor_case_images` VALUES (188, 51, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/ssLCcP2359.jpeg', '2022-06-19 16:29:52', '2022-06-19 16:29:52');
INSERT INTO `doctor_case_images` VALUES (189, 51, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/erXhST4528.jpeg', '2022-06-19 16:29:53', '2022-06-19 16:29:53');
INSERT INTO `doctor_case_images` VALUES (190, 51, 'before', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/ZWMVHx6871.jpeg', '2022-06-19 16:29:53', '2022-06-19 16:29:53');

-- ----------------------------
-- Table structure for doctor_case_menus
-- ----------------------------
DROP TABLE IF EXISTS `doctor_case_menus`;
CREATE TABLE `doctor_case_menus`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `case_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `menu_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cost` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `doctor_case_images_imb_1`(`case_id`) USING BTREE,
  INDEX `doctor_case_menus_menu_id_foreign`(`menu_id`) USING BTREE,
  CONSTRAINT `doctor_case_images_imb_1` FOREIGN KEY (`case_id`) REFERENCES `doctor_cases` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `doctor_case_menus_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_case_menus
-- ----------------------------
INSERT INTO `doctor_case_menus` VALUES (2, 54, 3, NULL, NULL, '2021-08-20 02:53:31', '2021-08-20 02:53:31');
INSERT INTO `doctor_case_menus` VALUES (3, 54, 35, NULL, NULL, '2021-08-23 08:34:01', '2021-08-23 08:34:01');

-- ----------------------------
-- Table structure for doctor_cases
-- ----------------------------
DROP TABLE IF EXISTS `doctor_cases`;
CREATE TABLE `doctor_cases`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `age` tinyint(4) UNSIGNED NULL DEFAULT NULL,
  `gender` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `operation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `operationRisk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `majordoctorComment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cases_clinic_id_foreign`(`doctor_id`) USING BTREE,
  INDEX `cases_menu_id_foreign`(`title`) USING BTREE,
  INDEX `cases_speciality_id_foreign`(`gender`) USING BTREE,
  INDEX `cases_stuff_id_foreign`(`age`) USING BTREE,
  CONSTRAINT `doctor_cases_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_cases
-- ----------------------------
INSERT INTO `doctor_cases` VALUES (47, 57, '225代女性の湘南美容二重切開', 20, 'female', '他院様による二重術後の左右差・三重解消、ライン修正を行いました。', '①瞼の腫れ、突っ張り感、ゴロゴロした感じ、目やにが増えたり、血液の混ざった涙が出るなど目の違和感を感じられる場合がございますが、異常ではございませんのでご安心下さい。', 'このかたは二重幅が狭かったので、くっきりなるような二重にしました。', '2021-05-04 20:27:58', '2021-07-26 05:21:39');
INSERT INTO `doctor_cases` VALUES (48, 57, '224代女性の湘南美容二重切開', 30, 'female', '他院様による二重術後の左右差・三重解消、ライン修正を行いました。', '①瞼の腫れ、突っ張り感、ゴロゴロした感じ、目やにが増えたり、血液の混ざった涙が出るなど目の違和感を感じられる場合がございますが、異常ではございませんのでご安心下さい。', 'このかたは二重幅が狭かったので、くっきりなるような二重にしました。', '2021-05-04 20:29:31', '2021-07-26 05:21:12');
INSERT INTO `doctor_cases` VALUES (49, 57, '223代女性の湘南美容二重切開', 20, 'female', '他院様による二重術後の左右差・三重解消、ライン修正を行いました。', '①瞼の腫れ、突っ張り感、ゴロゴロした感じ、目やにが増えたり、血液の混ざった涙が出るなど目の違和感を感じられる場合がございますが、異常ではございませんのでご安心下さい。', 'このかたは二重幅が狭かったので、くっきりなるような二重にしました。', '2021-05-04 20:36:36', '2021-07-26 05:20:42');
INSERT INTO `doctor_cases` VALUES (51, 57, '221代女性の湘南美容二重切開', 20, 'female', '他院様による二重術後の左右差・三重解消、ライン修正を行いました。', '①瞼の腫れ、突っ張り感、ゴロゴロした感じ、目やにが増えたり、血液の混ざった涙が出るなど目の違和感を感じられる場合がございますが、異常ではございませんのでご安心下さい。', 'このかたは二重幅が狭かったので、くっきりなるような二重にしました。', '2021-05-09 13:30:31', '2022-03-14 11:55:49');
INSERT INTO `doctor_cases` VALUES (52, 57, '222代女性の湘南美容二重切開', 30, 'male', '他院様による二重術後の左右差・三重解消、ライン修正を行いました。', '①瞼の腫れ、突っ張り感、ゴロゴロした感じ、目やにが増えたり、血液の混ざった涙が出るなど目の違和感を感じられる場合がございますが、異常ではございませんのでご安心下さい。', 'このかたは二重幅が狭かったので、くっきりなるような二重にしました。', '2021-05-09 13:30:31', '2021-07-26 05:20:03');
INSERT INTO `doctor_cases` VALUES (53, 57, '22222', 20, 'female', '222', '222', '2222', '2021-08-10 05:19:30', '2021-08-10 05:19:30');
INSERT INTO `doctor_cases` VALUES (54, 57, 'タイトル1', 30, 'male', '施術の解説', '副作用・リスク', '担当ドクターからのコメント(任意)', '2021-08-20 02:36:10', '2021-08-20 02:36:10');

-- ----------------------------
-- Table structure for doctor_categories
-- ----------------------------
DROP TABLE IF EXISTS `doctor_categories`;
CREATE TABLE `doctor_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diary_categories_diary_id_foreign`(`doctor_id`) USING BTREE,
  INDEX `diary_categories_category_id_foreign`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_categories
-- ----------------------------
INSERT INTO `doctor_categories` VALUES (25, 74, 127, NULL, NULL);
INSERT INTO `doctor_categories` VALUES (26, 75, 11, NULL, NULL);

-- ----------------------------
-- Table structure for doctor_clinics
-- ----------------------------
DROP TABLE IF EXISTS `doctor_clinics`;
CREATE TABLE `doctor_clinics`  (
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `clinic_id` bigint(20) UNSIGNED NOT NULL,
  INDEX `doctor_clinics_doctor_id_foreign`(`doctor_id`) USING BTREE,
  INDEX `doctor_clinics_clinic_id_foreign`(`clinic_id`) USING BTREE,
  CONSTRAINT `doctor_clinics_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `doctor_clinics_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for doctor_images
-- ----------------------------
DROP TABLE IF EXISTS `doctor_images`;
CREATE TABLE `doctor_images`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_patient_id_foreign`(`doctor_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_images
-- ----------------------------
INSERT INTO `doctor_images` VALUES (178, 70, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/gXzuxB1652.jpg', '2021-08-09 03:06:09', '2021-08-09 03:06:09');
INSERT INTO `doctor_images` VALUES (179, 70, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/after/thumbs/OunmlI0065.jpg', '2021-08-09 03:06:09', '2021-08-09 03:06:09');
INSERT INTO `doctor_images` VALUES (180, 57, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/BwNkDJ1959.jpeg', '2021-08-10 05:18:41', '2021-08-10 05:18:41');
INSERT INTO `doctor_images` VALUES (182, 57, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/after/thumbs/dpQfes4997.png', '2021-08-10 05:19:30', '2021-08-10 05:19:30');
INSERT INTO `doctor_images` VALUES (183, 57, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/before/thumbs/rrSMwq5095.jpg', '2021-08-20 02:36:10', '2021-08-20 02:36:10');
INSERT INTO `doctor_images` VALUES (184, 57, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/cases/after/thumbs/QytjpM3354.jpg', '2021-08-20 02:36:10', '2021-08-20 02:36:10');
INSERT INTO `doctor_images` VALUES (185, 57, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/profile/thumbs/MnfoLt5486.jpeg', '2022-06-19 23:32:03', '2022-06-19 23:32:03');

-- ----------------------------
-- Table structure for doctors
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `clinic_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `kata_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '氏名（漢字）',
  `hira_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '氏名（カタカナ）',
  `gender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性別',
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '電話番号',
  `birthday` date NULL DEFAULT NULL COMMENT '生年月日',
  `area_id` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '施術を考えているエリア',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `job_id` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '役職',
  `experience_year` tinyint(3) NULL DEFAULT NULL COMMENT '経歴',
  `spec0` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '得意分野①',
  `spec1` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '得意分野②',
  `spec2` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '得意分野③',
  `profile` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '経歴',
  `career` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '資格・実績',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `patients_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `patients_area_id_foreign`(`area_id`) USING BTREE,
  INDEX `doctors_ibfk_3`(`job_id`) USING BTREE,
  INDEX `doctors_ibfk_5`(`spec1`) USING BTREE,
  INDEX `doctors_ibfk_4`(`spec0`) USING BTREE,
  INDEX `doctors_ibfk_6`(`spec2`) USING BTREE,
  INDEX `doctors_clinic_id_foreign`(`clinic_id`) USING BTREE,
  CONSTRAINT `doctors_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `mtb_prefs` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `mtb_jobs` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_4` FOREIGN KEY (`spec0`) REFERENCES `mtb_specialities` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_5` FOREIGN KEY (`spec1`) REFERENCES `mtb_specialities` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_6` FOREIGN KEY (`spec2`) REFERENCES `mtb_specialities` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctors
-- ----------------------------
INSERT INTO `doctors` VALUES (70, 57, 3, 'タナカジン', '田中 仁', NULL, NULL, NULL, NULL, '2021-04-23 23:30:56', '2022-06-30 13:14:06', 3, 20, 10, 19, 1, 'ふぁsdふぁsdf\nあsdふぁsdfあsdf', 'ああああ\nあsdふぁsdf\nあsdふぁsdf', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (71, 58, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 11:41:17', '2021-05-07 11:41:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (72, 59, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 11:43:40', '2021-05-07 11:43:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (73, 60, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 11:49:58', '2022-06-22 13:31:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (74, 61, 3, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 11:57:58', '2021-05-07 12:15:25', 1, 2, NULL, NULL, NULL, '1997年ラシア大学医学部卒業 <br>', '美容外科専門医(JSAS)<br>', '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (75, 62, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 11:59:29', '2021-05-07 11:59:29', 2, NULL, NULL, NULL, NULL, NULL, NULL, '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (76, 63, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 12:00:12', '2021-05-07 12:00:12', 1, NULL, NULL, NULL, NULL, NULL, NULL, '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (77, 64, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 12:01:40', '2021-05-07 12:01:40', 1, NULL, NULL, NULL, NULL, NULL, NULL, '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (78, 65, 1, '田中 仁', '田中 仁', NULL, NULL, NULL, NULL, '2021-05-07 12:03:07', '2021-05-07 12:03:07', 1, NULL, NULL, NULL, NULL, NULL, NULL, '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (79, 69, 3, '田中 仁1', '田中 仁1', NULL, NULL, NULL, NULL, '2021-04-23 23:30:56', '2021-07-12 17:00:08', 1, 20, NULL, NULL, NULL, 'ふぁsdふぁsdf\nあsdふぁsdf\nあsdf', 'ああああ\nあsdふぁsdf\nあsdふぁsdf', '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');
INSERT INTO `doctors` VALUES (80, 70, 3, 'タナカアオイ', '田中葵', NULL, NULL, NULL, NULL, '2021-08-18 02:20:34', '2021-08-18 02:24:54', 1, 1, NULL, NULL, NULL, 'ああああ', 'ああああ', '1.amazonaws.com/doctor/profile/thumbs/auGwpq1798.jpeg');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT current_timestamp(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `favoriable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `favoriable_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `favorites_favoriable_type_favoriable_id_index`(`favoriable_type`, `favoriable_id`) USING BTREE,
  INDEX `favorites_patient_id_foreign`(`patient_id`) USING BTREE,
  CONSTRAINT `favorites_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorites
-- ----------------------------
INSERT INTO `favorites` VALUES (3, NULL, 'App\\Models\\CounselingReport', 1, NULL, NULL);
INSERT INTO `favorites` VALUES (11, NULL, 'App\\Models\\Menu', 3, NULL, NULL);
INSERT INTO `favorites` VALUES (19, NULL, 'App\\Models\\Doctor', 74, NULL, NULL);
INSERT INTO `favorites` VALUES (29, NULL, 'App\\Models\\Diary', 1, NULL, NULL);
INSERT INTO `favorites` VALUES (122, 70, 'App\\Models\\Diary', 10, NULL, NULL);

-- ----------------------------
-- Table structure for follows
-- ----------------------------
DROP TABLE IF EXISTS `follows`;
CREATE TABLE `follows`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `follow_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `follows_patient_id_foreign`(`patient_id`) USING BTREE,
  INDEX `follows_follow_id_foreign`(`follow_id`) USING BTREE,
  CONSTRAINT `follows_follow_id_foreign` FOREIGN KEY (`follow_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `follows_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for likeables
-- ----------------------------
DROP TABLE IF EXISTS `likeables`;
CREATE TABLE `likeables`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `likeable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `likeable_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `likeables_likeable_type_likeable_id_index`(`likeable_type`, `likeable_id`) USING BTREE,
  INDEX `likeables_patient_id_foreign`(`patient_id`) USING BTREE,
  CONSTRAINT `likeables_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of likeables
-- ----------------------------
INSERT INTO `likeables` VALUES (25, 70, 'App\\Models\\Question', 12, NULL, NULL);

-- ----------------------------
-- Table structure for mailbox_users
-- ----------------------------
DROP TABLE IF EXISTS `mailbox_users`;
CREATE TABLE `mailbox_users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mailbox_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `last_message_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mailbox_users_mailbox_id_foreign`(`mailbox_id`) USING BTREE,
  INDEX `mailbox_users_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `mailbox_users_last_message_id_foreign`(`last_message_id`) USING BTREE,
  CONSTRAINT `mailbox_users_last_message_id_foreign` FOREIGN KEY (`last_message_id`) REFERENCES `messages` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `mailbox_users_mailbox_id_foreign` FOREIGN KEY (`mailbox_id`) REFERENCES `mailboxes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mailbox_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 251 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mailbox_users
-- ----------------------------
INSERT INTO `mailbox_users` VALUES (1, 1, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (2, 1, 2, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (5, 3, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (6, 3, 4, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (7, 4, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (8, 4, 5, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (9, 5, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (10, 5, 6, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (11, 6, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (12, 6, 7, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (13, 7, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (14, 7, 8, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (15, 8, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (16, 8, 9, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (17, 9, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (18, 9, 10, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (19, 10, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (20, 10, 11, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (21, 11, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (22, 11, 12, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (23, 12, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (24, 12, 13, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (25, 13, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (26, 13, 14, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (27, 14, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (28, 14, 15, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (29, 15, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (30, 15, 16, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (31, 16, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (32, 16, 17, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (33, 17, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (34, 17, 18, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (35, 18, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (36, 18, 19, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (37, 19, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (38, 19, 20, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (39, 20, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (40, 20, 21, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (41, 21, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (42, 21, 22, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (43, 22, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (44, 22, 23, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (45, 23, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (46, 23, 24, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (47, 24, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (48, 24, 25, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (49, 25, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (50, 25, 26, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (51, 26, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (52, 26, 27, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (53, 27, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (54, 27, 28, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (55, 28, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (56, 28, 29, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (57, 29, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (58, 29, 30, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (59, 30, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (60, 30, 31, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (61, 31, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (62, 31, 32, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (63, 32, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (64, 32, 33, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (65, 33, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (66, 33, 34, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (67, 34, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (68, 34, 35, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (69, 35, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (70, 35, 36, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (71, 36, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (72, 36, 37, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (77, 39, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (78, 39, 40, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (79, 40, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (80, 40, 41, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (81, 41, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (82, 41, 42, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (83, 42, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (84, 42, 43, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (87, 44, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (88, 44, 45, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (89, 45, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (90, 45, 46, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (103, 52, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (104, 52, 2, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (107, 54, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (108, 54, 4, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (109, 55, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (110, 55, 5, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (111, 56, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (112, 56, 6, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (113, 57, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (114, 57, 7, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (115, 58, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (116, 58, 8, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (117, 59, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (118, 59, 9, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (119, 60, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (120, 60, 10, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (121, 61, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (122, 61, 11, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (123, 62, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (124, 62, 12, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (125, 63, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (126, 63, 13, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (127, 64, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (128, 64, 14, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (129, 65, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (130, 65, 15, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (131, 66, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (132, 66, 16, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (133, 67, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (134, 67, 17, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (135, 68, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (136, 68, 18, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (137, 69, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (138, 69, 19, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (139, 70, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (140, 70, 20, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (141, 71, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (142, 71, 21, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (143, 72, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (144, 72, 22, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (145, 73, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (146, 73, 23, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (147, 74, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (148, 74, 24, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (149, 75, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (150, 75, 25, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (151, 76, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (152, 76, 26, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (153, 77, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (154, 77, 27, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (155, 78, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (156, 78, 28, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (157, 79, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (158, 79, 29, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (159, 80, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (160, 80, 30, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (161, 81, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (162, 81, 31, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (163, 82, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (164, 82, 32, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (165, 83, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (166, 83, 33, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (167, 84, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (168, 84, 34, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (169, 85, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (170, 85, 35, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (171, 86, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (172, 86, 36, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (173, 87, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (174, 87, 37, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (179, 90, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (180, 90, 40, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (181, 91, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (182, 91, 41, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (183, 92, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (184, 92, 42, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (185, 93, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (186, 93, 43, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (189, 95, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (190, 95, 45, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (191, 96, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (192, 96, 46, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (205, 103, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (206, 103, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (207, 104, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (208, 104, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (209, 105, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (210, 105, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (211, 106, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (212, 106, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (213, 107, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (214, 107, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (215, 108, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (216, 108, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (217, 109, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (218, 109, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (219, 110, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (220, 110, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (221, 111, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (222, 111, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (223, 112, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (224, 112, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (225, 113, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (226, 113, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (227, 114, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (228, 114, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (229, 115, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (230, 115, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (231, 116, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (232, 116, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (233, 117, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (234, 117, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (235, 118, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (236, 118, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (237, 119, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (238, 119, NULL, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (239, 120, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (240, 120, 90, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (241, 121, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (242, 121, 90, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (243, 122, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (244, 122, 90, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (245, 123, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (246, 123, 90, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (247, 124, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (248, 124, 90, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (249, 125, 1, NULL, NULL, NULL);
INSERT INTO `mailbox_users` VALUES (250, 125, 90, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mailboxes
-- ----------------------------
DROP TABLE IF EXISTS `mailboxes`;
CREATE TABLE `mailboxes`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mailboxes_reservation_id_foreign`(`reservation_id`) USING BTREE,
  CONSTRAINT `mailboxes_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mailboxes
-- ----------------------------
INSERT INTO `mailboxes` VALUES (1, 1, '2021-02-11 01:50:01', '2021-02-11 01:50:01');
INSERT INTO `mailboxes` VALUES (3, 3, '2021-02-11 01:50:03', '2021-02-11 01:50:03');
INSERT INTO `mailboxes` VALUES (4, 4, '2021-02-11 01:50:04', '2021-02-11 01:50:04');
INSERT INTO `mailboxes` VALUES (5, 5, '2021-02-11 01:50:05', '2021-02-11 01:50:05');
INSERT INTO `mailboxes` VALUES (6, 6, '2021-02-11 01:50:05', '2021-02-11 01:50:05');
INSERT INTO `mailboxes` VALUES (7, 7, '2021-02-11 01:50:06', '2021-02-11 01:50:06');
INSERT INTO `mailboxes` VALUES (8, 8, '2021-02-11 01:50:06', '2021-02-11 01:50:06');
INSERT INTO `mailboxes` VALUES (9, 9, '2021-02-11 01:50:07', '2021-02-11 01:50:07');
INSERT INTO `mailboxes` VALUES (10, 10, '2021-02-11 01:50:08', '2021-02-11 01:50:08');
INSERT INTO `mailboxes` VALUES (11, 11, '2021-02-11 01:50:08', '2021-02-11 01:50:08');
INSERT INTO `mailboxes` VALUES (12, 12, '2021-02-11 01:50:09', '2021-02-11 01:50:09');
INSERT INTO `mailboxes` VALUES (13, 13, '2021-02-11 01:50:10', '2021-02-11 01:50:10');
INSERT INTO `mailboxes` VALUES (14, 14, '2021-02-11 01:50:10', '2021-02-11 01:50:10');
INSERT INTO `mailboxes` VALUES (15, 15, '2021-02-11 01:50:11', '2021-02-11 01:50:11');
INSERT INTO `mailboxes` VALUES (16, 16, '2021-02-11 01:50:11', '2021-02-11 01:50:11');
INSERT INTO `mailboxes` VALUES (17, 17, '2021-02-11 01:50:12', '2021-02-11 01:50:12');
INSERT INTO `mailboxes` VALUES (18, 18, '2021-02-11 01:50:12', '2021-02-11 01:50:12');
INSERT INTO `mailboxes` VALUES (19, 19, '2021-02-11 01:50:13', '2021-02-11 01:50:13');
INSERT INTO `mailboxes` VALUES (20, 20, '2021-02-11 01:50:14', '2021-02-11 01:50:14');
INSERT INTO `mailboxes` VALUES (21, 21, '2021-02-11 01:50:14', '2021-02-11 01:50:14');
INSERT INTO `mailboxes` VALUES (22, 22, '2021-02-11 01:50:15', '2021-02-11 01:50:15');
INSERT INTO `mailboxes` VALUES (23, 23, '2021-02-11 01:50:15', '2021-02-11 01:50:15');
INSERT INTO `mailboxes` VALUES (24, 24, '2021-02-11 01:50:16', '2021-02-11 01:50:16');
INSERT INTO `mailboxes` VALUES (25, 25, '2021-02-11 01:50:16', '2021-02-11 01:50:16');
INSERT INTO `mailboxes` VALUES (26, 26, '2021-02-11 01:50:17', '2021-02-11 01:50:17');
INSERT INTO `mailboxes` VALUES (27, 27, '2021-02-11 01:50:17', '2021-02-11 01:50:17');
INSERT INTO `mailboxes` VALUES (28, 28, '2021-02-11 01:50:18', '2021-02-11 01:50:18');
INSERT INTO `mailboxes` VALUES (29, 29, '2021-02-11 01:50:19', '2021-02-11 01:50:19');
INSERT INTO `mailboxes` VALUES (30, 30, '2021-02-11 01:50:20', '2021-02-11 01:50:20');
INSERT INTO `mailboxes` VALUES (31, 31, '2021-02-11 01:50:20', '2021-02-11 01:50:20');
INSERT INTO `mailboxes` VALUES (32, 32, '2021-02-11 01:50:21', '2021-02-11 01:50:21');
INSERT INTO `mailboxes` VALUES (33, 33, '2021-02-11 01:50:22', '2021-02-11 01:50:22');
INSERT INTO `mailboxes` VALUES (34, 34, '2021-02-11 01:50:22', '2021-02-11 01:50:22');
INSERT INTO `mailboxes` VALUES (35, 35, '2021-02-11 01:50:23', '2021-02-11 01:50:23');
INSERT INTO `mailboxes` VALUES (36, 36, '2021-02-11 01:50:24', '2021-02-11 01:50:24');
INSERT INTO `mailboxes` VALUES (39, 39, '2021-02-11 01:50:25', '2021-02-11 01:50:25');
INSERT INTO `mailboxes` VALUES (40, 40, '2021-02-11 01:50:26', '2021-02-11 01:50:26');
INSERT INTO `mailboxes` VALUES (41, 41, '2021-02-11 01:50:27', '2021-02-11 01:50:27');
INSERT INTO `mailboxes` VALUES (42, 42, '2021-02-11 01:50:27', '2021-02-11 01:50:27');
INSERT INTO `mailboxes` VALUES (44, 44, '2021-02-11 01:50:29', '2021-02-11 01:50:29');
INSERT INTO `mailboxes` VALUES (45, 45, '2021-02-11 01:50:29', '2021-02-11 01:50:29');
INSERT INTO `mailboxes` VALUES (52, 1, '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `mailboxes` VALUES (54, 3, '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `mailboxes` VALUES (55, 4, '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `mailboxes` VALUES (56, 5, '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `mailboxes` VALUES (57, 6, '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `mailboxes` VALUES (58, 7, '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `mailboxes` VALUES (59, 8, '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `mailboxes` VALUES (60, 9, '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `mailboxes` VALUES (61, 10, '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `mailboxes` VALUES (62, 11, '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `mailboxes` VALUES (63, 12, '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `mailboxes` VALUES (64, 13, '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `mailboxes` VALUES (65, 14, '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `mailboxes` VALUES (66, 15, '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `mailboxes` VALUES (67, 16, '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `mailboxes` VALUES (68, 17, '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `mailboxes` VALUES (69, 18, '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `mailboxes` VALUES (70, 19, '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `mailboxes` VALUES (71, 20, '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `mailboxes` VALUES (72, 21, '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `mailboxes` VALUES (73, 22, '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `mailboxes` VALUES (74, 23, '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `mailboxes` VALUES (75, 24, '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `mailboxes` VALUES (76, 25, '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `mailboxes` VALUES (77, 26, '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `mailboxes` VALUES (78, 27, '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `mailboxes` VALUES (79, 28, '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `mailboxes` VALUES (80, 29, '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `mailboxes` VALUES (81, 30, '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `mailboxes` VALUES (82, 31, '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `mailboxes` VALUES (83, 32, '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `mailboxes` VALUES (84, 33, '2021-02-11 05:50:03', '2021-02-11 05:50:03');
INSERT INTO `mailboxes` VALUES (85, 34, '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `mailboxes` VALUES (86, 35, '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `mailboxes` VALUES (87, 36, '2021-02-11 05:50:06', '2021-02-11 05:50:06');
INSERT INTO `mailboxes` VALUES (90, 39, '2021-02-11 05:50:07', '2021-02-11 05:50:07');
INSERT INTO `mailboxes` VALUES (91, 40, '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `mailboxes` VALUES (92, 41, '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `mailboxes` VALUES (93, 42, '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `mailboxes` VALUES (95, 44, '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `mailboxes` VALUES (96, 45, '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `mailboxes` VALUES (103, 52, '2022-04-01 11:38:45', '2022-04-01 11:38:45');
INSERT INTO `mailboxes` VALUES (104, 53, '2022-04-19 15:11:39', '2022-04-19 15:11:39');
INSERT INTO `mailboxes` VALUES (105, 54, '2022-04-20 20:13:03', '2022-04-20 20:13:03');
INSERT INTO `mailboxes` VALUES (106, 55, '2022-04-21 06:57:08', '2022-04-21 06:57:08');
INSERT INTO `mailboxes` VALUES (107, 56, '2022-04-21 08:16:16', '2022-04-21 08:16:16');
INSERT INTO `mailboxes` VALUES (108, 57, '2022-04-21 09:13:51', '2022-04-21 09:13:51');
INSERT INTO `mailboxes` VALUES (109, 58, '2022-04-21 12:54:56', '2022-04-21 12:54:56');
INSERT INTO `mailboxes` VALUES (110, 59, '2022-04-21 15:24:49', '2022-04-21 15:24:49');
INSERT INTO `mailboxes` VALUES (111, 60, '2022-04-21 15:24:58', '2022-04-21 15:24:58');
INSERT INTO `mailboxes` VALUES (112, 61, '2022-04-23 07:21:32', '2022-04-23 07:21:32');
INSERT INTO `mailboxes` VALUES (113, 62, '2022-04-23 09:37:32', '2022-04-23 09:37:32');
INSERT INTO `mailboxes` VALUES (114, 63, '2022-04-23 09:39:25', '2022-04-23 09:39:25');
INSERT INTO `mailboxes` VALUES (115, 64, '2022-04-23 09:43:47', '2022-04-23 09:43:47');
INSERT INTO `mailboxes` VALUES (116, 65, '2022-04-25 03:54:50', '2022-04-25 03:54:50');
INSERT INTO `mailboxes` VALUES (117, 66, '2022-04-25 04:53:41', '2022-04-25 04:53:41');
INSERT INTO `mailboxes` VALUES (118, 67, '2022-04-25 04:56:35', '2022-04-25 04:56:35');
INSERT INTO `mailboxes` VALUES (119, 68, '2022-05-16 09:46:06', '2022-05-16 09:46:06');
INSERT INTO `mailboxes` VALUES (120, 69, '2022-05-24 08:18:02', '2022-05-24 08:18:02');
INSERT INTO `mailboxes` VALUES (121, 70, '2022-05-24 08:18:02', '2022-05-24 08:18:02');
INSERT INTO `mailboxes` VALUES (122, 71, '2022-05-24 08:19:49', '2022-05-24 08:19:49');
INSERT INTO `mailboxes` VALUES (123, 72, '2022-05-28 06:26:06', '2022-05-28 06:26:06');
INSERT INTO `mailboxes` VALUES (124, 73, '2022-06-30 09:40:48', '2022-06-30 09:40:48');
INSERT INTO `mailboxes` VALUES (125, 74, '2022-06-30 12:11:46', '2022-06-30 12:11:46');

-- ----------------------------
-- Table structure for medias
-- ----------------------------
DROP TABLE IF EXISTS `medias`;
CREATE TABLE `medias`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mediable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mediable_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '画像か動画か',
  `category` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `thumb_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `medias_mediable_type_mediable_id_index`(`mediable_type`, `mediable_id`) USING BTREE,
  INDEX `medias_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `medias_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medias
-- ----------------------------
INSERT INTO `medias` VALUES (1, 'App\\Models\\Diary', 10, 1, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/WtFkqE9146.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/WtFkqE9146.png', NULL, '2022-04-29 00:49:04', '2022-05-09 01:17:45');
INSERT INTO `medias` VALUES (2, 'App\\Models\\Diary', 10, 1, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/ycFlOT9148.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/ycFlOT9148.png', NULL, '2022-04-29 00:49:16', '2022-04-29 00:51:01');
INSERT INTO `medias` VALUES (3, 'App\\Models\\TreatProgress', 1, 1, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/nGYLON6968.png', NULL, '2022-04-29 00:49:28', '2022-04-29 00:51:01');
INSERT INTO `medias` VALUES (4, 'App\\Models\\CounselingReport', 3, 1, 'self', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/venCER5464.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/venCER5464.png', NULL, '2022-04-29 01:34:39', '2022-04-29 01:36:28');
INSERT INTO `medias` VALUES (5, 'App\\Models\\CounselingReport', 3, 1, 'self', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/jsdKuq1513.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/jsdKuq1513.png', NULL, '2022-04-29 01:34:56', '2022-04-29 01:39:54');
INSERT INTO `medias` VALUES (6, 'App\\Models\\CounselingReport', 3, 1, 'like', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nZgdNm5560.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/nZgdNm5560.png', NULL, '2022-04-29 01:35:12', '2022-04-29 01:36:28');
INSERT INTO `medias` VALUES (7, 'App\\Models\\CounselingReport', 3, 1, 'like', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/NFPHWW6779.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/NFPHWW6779.png', NULL, '2022-04-29 01:35:32', '2022-04-29 01:36:28');
INSERT INTO `medias` VALUES (8, 'App\\Models\\CounselingReport', 3, 1, 'dislike', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/pLPZfd2415.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/pLPZfd2415.png', NULL, '2022-04-29 01:35:49', '2022-04-29 01:36:28');
INSERT INTO `medias` VALUES (9, NULL, NULL, 1, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/VFThHV9378.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/VFThHV9378.png', NULL, '2022-04-29 01:43:05', '2022-04-29 01:43:05');
INSERT INTO `medias` VALUES (10, 'App\\Models\\Question', 9, 1, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/nGYLON6968.png', NULL, '2022-04-29 00:49:28', '2022-04-29 00:51:01');
INSERT INTO `medias` VALUES (11, NULL, NULL, 1, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/uIYDhH2739.png', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/thumbs/uIYDhH2739.png', NULL, '2022-05-09 00:07:01', '2022-05-09 00:07:01');

-- ----------------------------
-- Table structure for menu_categories
-- ----------------------------
DROP TABLE IF EXISTS `menu_categories`;
CREATE TABLE `menu_categories`  (
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(6) UNSIGNED NOT NULL,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  CONSTRAINT `FK_menu_categories_menus` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_menu_categories_mtb_part_categories` FOREIGN KEY (`category_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_categories
-- ----------------------------
INSERT INTO `menu_categories` VALUES (3, 160);
INSERT INTO `menu_categories` VALUES (3, 161);
INSERT INTO `menu_categories` VALUES (18, 162);
INSERT INTO `menu_categories` VALUES (35, 163);
INSERT INTO `menu_categories` VALUES (35, 27);
INSERT INTO `menu_categories` VALUES (35, 31);
INSERT INTO `menu_categories` VALUES (37, 33);
INSERT INTO `menu_categories` VALUES (37, 29);
INSERT INTO `menu_categories` VALUES (37, 36);
INSERT INTO `menu_categories` VALUES (38, 28);
INSERT INTO `menu_categories` VALUES (39, 29);

-- ----------------------------
-- Table structure for menu_photos
-- ----------------------------
DROP TABLE IF EXISTS `menu_photos`;
CREATE TABLE `menu_photos`  (
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  CONSTRAINT `FK_menu_photos_menus` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu_process
-- ----------------------------
DROP TABLE IF EXISTS `menu_process`;
CREATE TABLE `menu_process`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `period` int(20) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_process_menu_id_foreign`(`menu_id`) USING BTREE,
  CONSTRAINT `menu_process_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_process
-- ----------------------------
INSERT INTO `menu_process` VALUES (17, 35, 'cvddfds', 15, '2022-07-04 17:38:03', '2022-07-04 17:38:03');
INSERT INTO `menu_process` VALUES (18, 35, 'dgfdsg', 10, '2022-07-04 17:38:04', '2022-07-04 17:38:04');
INSERT INTO `menu_process` VALUES (19, 35, 'dsfdf', 15, '2022-07-04 17:38:04', '2022-07-04 17:38:04');
INSERT INTO `menu_process` VALUES (20, 35, 'sdfadsf', 25, '2022-07-04 17:38:04', '2022-07-04 17:38:04');
INSERT INTO `menu_process` VALUES (25, 39, 'sasdf', 15, '2022-07-04 17:50:45', '2022-07-04 17:50:45');
INSERT INTO `menu_process` VALUES (26, 39, 'asdfsdf', 15, '2022-07-04 17:50:45', '2022-07-04 17:50:45');
INSERT INTO `menu_process` VALUES (27, 38, 'qwewe', 15, '2022-07-05 01:51:17', '2022-07-05 01:51:17');
INSERT INTO `menu_process` VALUES (28, 38, 'qwewqe', 15, '2022-07-05 01:51:17', '2022-07-05 01:51:17');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'メニュー名',
  `price` int(11) NULL DEFAULT NULL COMMENT '料金',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'メニューの説明',
  `risk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '副作用・リスク',
  `guarantee` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '施術の保証',
  `treat_time` tinyint(4) NULL DEFAULT NULL COMMENT '施術の時間',
  `basshi` tinyint(4) NULL DEFAULT NULL COMMENT '抜糸',
  `hospital_visit` tinyint(4) NULL DEFAULT NULL COMMENT '施術後の通院',
  `hare` tinyint(4) NULL DEFAULT NULL COMMENT '腫れ',
  `pain` tinyint(4) NULL DEFAULT NULL COMMENT '痛み',
  `bleeding` tinyint(4) NULL DEFAULT NULL COMMENT '内出血',
  `hospital_need` tinyint(4) NULL DEFAULT NULL COMMENT '入院の必要性',
  `masui` tinyint(4) NULL DEFAULT NULL COMMENT '麻酔',
  `makeup` tinyint(4) NULL DEFAULT NULL COMMENT 'メイク/洗顔',
  `shower` tinyint(4) NULL DEFAULT NULL COMMENT 'シャワー/洗髪/入浴',
  `massage` tinyint(4) NULL DEFAULT NULL COMMENT '施術部のマッサージ',
  `sport_impossible` tinyint(4) NULL DEFAULT NULL COMMENT '激しいスポーツ',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '画像',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '掲載ステータ',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menus_clinic_id_foreign`(`clinic_id`) USING BTREE,
  CONSTRAINT `menus_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (3, 1, '両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 10, 10, 10, 10, 10, 10, 10, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 0, '2021-04-18 10:11:38', '2021-06-23 17:49:17');
INSERT INTO `menus` VALUES (9, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 500, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (11, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (12, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 200, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (16, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (17, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (18, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 300, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-07-20 17:27:38');
INSERT INTO `menus` VALUES (19, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (20, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 20, 20, 20, 20, 20, 20, 20, 20, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (21, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (22, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (23, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (24, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (25, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (26, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (27, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (28, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (29, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (30, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (31, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (32, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 300, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (33, 1, '埋没法ダブル（５年保証付き）両目埋没法ダブル（５年保証付き）両目', 248900, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (34, 1, '両目埋没法ダブル（５年保証付き）両目', 200, 'ああああ', 'ああああ', 'ああああ', 5, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-04-18 10:11:38', '2021-04-18 10:11:38');
INSERT INTO `menus` VALUES (35, 1, 'ええええ', 22222, '222222', '22222222\n22222\n22222\n2222222', '2222222222222', 15, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-07-20 00:46:27', '2022-07-04 17:38:03');
INSERT INTO `menus` VALUES (36, 1, '両目埋没法ダブル（５年保証付き）両目', 200, 'ああああ', 'ああああ', 'ああああ', 15, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2021-07-20 00:46:27', '2021-08-20 02:36:55');
INSERT INTO `menus` VALUES (37, 1, 'sadadasdsa', 324234, 'adfadsfads', 'adsfasd', 'dasfdasfadsfsdafds', 15, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2022-07-04 17:24:59', '2022-07-04 17:39:31');
INSERT INTO `menus` VALUES (38, 1, 'dasfad', 3423, 'adsf', 'adf', 'adesf', 15, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 1, '2022-07-04 17:46:12', '2022-07-05 01:51:17');
INSERT INTO `menus` VALUES (39, 1, 'asdf', 23524, 'adfdsf', 'dfas', 'ffasdfsad', 15, 5, 10, 15, 5, 5, 5, 5, 5, 5, 5, 5, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/user/medias/nGYLON6968.png', 0, '2022-07-04 17:49:31', '2022-07-04 17:50:45');

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mailbox_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'メッセージ',
  `is_file` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'メッセージタイプ',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `messages_mailbox_id_foreign`(`mailbox_id`) USING BTREE,
  INDEX `messages_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `messages_mailbox_id_foreign` FOREIGN KEY (`mailbox_id`) REFERENCES `mailboxes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (7, 36, 1, '畏まりました。そうしましたらご希望のイメージに合う写真を何枚か用意しておいてもらえますか？', 0, '2022-03-13 21:40:43', '2022-03-13 21:40:43');
INSERT INTO `messages` VALUES (11, 3, 15, '畏まりました。そうしましたらご希望のイメージに合う写真を何枚か用意しておいてもらえますか？', 0, '2022-03-15 14:04:28', '2022-03-15 14:04:32');
INSERT INTO `messages` VALUES (13, 36, 15, '畏まりました。そうしましたらご希望のイメージに合う写真を何枚か用意しておいてもらえますか？', 0, '2022-03-15 14:07:37', '2022-03-16 14:07:41');
INSERT INTO `messages` VALUES (35, 45, 1, 'dddd', 0, '2022-03-19 01:57:06', '2022-03-19 01:57:06');
INSERT INTO `messages` VALUES (36, 45, 1, 'dddddd', 0, '2022-03-19 01:57:08', '2022-03-19 01:57:08');
INSERT INTO `messages` VALUES (37, 45, 1, 'dddddd', 0, '2022-03-19 01:57:11', '2022-03-19 01:57:11');
INSERT INTO `messages` VALUES (38, 45, 1, 'ddddddddd', 0, '2022-03-19 01:57:12', '2022-03-19 01:57:12');
INSERT INTO `messages` VALUES (43, 40, 1, 'だsっっっっっっっふぁsdf', 0, '2022-03-24 21:07:33', '2022-03-24 21:07:33');
INSERT INTO `messages` VALUES (44, 44, 1, 'sdfdふぁsd', 0, '2022-03-24 21:08:02', '2022-03-24 21:08:02');
INSERT INTO `messages` VALUES (45, 44, 1, 'あsdふぁsd', 0, '2022-03-24 21:08:17', '2022-03-24 21:08:17');
INSERT INTO `messages` VALUES (46, 44, 1, 'あsdふぁsd', 0, '2022-03-24 21:08:18', '2022-03-24 21:08:18');
INSERT INTO `messages` VALUES (47, 44, 1, 'あsdふぁsd', 0, '2022-03-24 21:08:20', '2022-03-24 21:08:20');
INSERT INTO `messages` VALUES (48, 44, 1, 'あsdふぁsd', 0, '2022-03-25 21:37:18', '2022-03-25 21:37:18');
INSERT INTO `messages` VALUES (49, 44, 1, 'あsdふぁsd', 0, '2022-03-25 21:37:21', '2022-03-25 21:37:21');
INSERT INTO `messages` VALUES (50, 44, 1, 'あsdふぁsd', 0, '2022-03-27 04:00:20', '2022-03-27 04:00:20');
INSERT INTO `messages` VALUES (51, 44, 1, 'あsdふぁsd', 0, '2022-03-27 04:00:23', '2022-03-27 04:00:23');
INSERT INTO `messages` VALUES (52, 44, 1, 'dddddddd', 0, '2022-03-27 21:45:23', '2022-03-27 21:45:23');
INSERT INTO `messages` VALUES (53, 44, 1, 'dddddddddd', 0, '2022-03-27 21:45:26', '2022-03-27 21:45:26');
INSERT INTO `messages` VALUES (58, 45, 1, 'っっっっっっっd', 0, '2022-03-27 21:49:42', '2022-03-27 21:49:42');
INSERT INTO `messages` VALUES (59, 45, 1, 'っっっっっd', 0, '2022-03-27 21:49:45', '2022-03-27 21:49:45');
INSERT INTO `messages` VALUES (62, 45, 1, 'dddddddd', 0, '2022-03-30 03:02:44', '2022-03-30 03:02:44');
INSERT INTO `messages` VALUES (63, 45, 1, 'dddddddddd', 0, '2022-03-30 03:02:46', '2022-03-30 03:02:46');
INSERT INTO `messages` VALUES (64, 45, 1, 'dddddddd', 0, '2022-03-30 03:02:48', '2022-03-30 03:02:48');
INSERT INTO `messages` VALUES (65, 41, 1, 'dddddddddddddd', 0, '2022-03-30 03:50:27', '2022-03-30 03:50:27');
INSERT INTO `messages` VALUES (66, 41, 1, 'ddddddddd', 0, '2022-03-30 03:50:28', '2022-03-30 03:50:28');
INSERT INTO `messages` VALUES (67, 41, 1, 'dddddddddd', 0, '2022-03-30 03:50:30', '2022-03-30 03:50:30');
INSERT INTO `messages` VALUES (74, 44, 1, 'gvbcvb', 0, '2022-06-28 14:15:17', '2022-06-28 14:15:17');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2017_12_07_122845_create_oauth_providers_table', 1);
INSERT INTO `migrations` VALUES (4, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (5, '2020_08_03_075706_create_mtb_rsv_contents_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_08_03_190031_create_mtb_part_categories_table', 1);
INSERT INTO `migrations` VALUES (7, '2020_08_03_191035_create_mtb_jobs_table', 1);
INSERT INTO `migrations` VALUES (8, '2020_08_03_201210_create_mtb_specialities_table', 1);
INSERT INTO `migrations` VALUES (9, '2020_08_03_201220_create_mtb_prefs_table', 1);
INSERT INTO `migrations` VALUES (10, '2020_08_03_201230_create_mtb_interest_categories_table', 1);
INSERT INTO `migrations` VALUES (11, '2020_08_04_154414_create_patients_table', 1);
INSERT INTO `migrations` VALUES (12, '2020_08_04_155009_create_patient_infos_table', 1);
INSERT INTO `migrations` VALUES (13, '2020_08_04_160426_create_clinics_table', 1);
INSERT INTO `migrations` VALUES (14, '2020_08_04_175716_create_attachments_table', 1);
INSERT INTO `migrations` VALUES (15, '2020_08_04_175944_create_clinic_patient_info_memos_table', 1);
INSERT INTO `migrations` VALUES (16, '2020_08_04_178724_create_menus_table', 1);
INSERT INTO `migrations` VALUES (17, '2020_08_04_180130_create_stuffs_table', 1);
INSERT INTO `migrations` VALUES (18, '2020_08_04_180459_create_reservations_table', 1);
INSERT INTO `migrations` VALUES (19, '2020_08_04_180518_create_rsv_categories_table', 1);
INSERT INTO `migrations` VALUES (20, '2020_08_04_180530_create_payments_table', 1);
INSERT INTO `migrations` VALUES (21, '2020_08_04_184830_create_withdraws_table', 1);
INSERT INTO `migrations` VALUES (22, '2020_08_04_185450_create_mailboxes_table', 1);
INSERT INTO `migrations` VALUES (23, '2020_08_04_185457_create_messages_table', 1);
INSERT INTO `migrations` VALUES (24, '2020_08_04_185506_create_mailbox_users_table', 1);
INSERT INTO `migrations` VALUES (25, '2020_08_04_190156_create_medias_table', 1);
INSERT INTO `migrations` VALUES (26, '2020_08_04_190324_create_diaries_table', 1);
INSERT INTO `migrations` VALUES (27, '2020_08_04_192834_create_diary_categories_table', 1);
INSERT INTO `migrations` VALUES (28, '2020_08_04_194046_create_mtb_diary_rate_questions', 1);
INSERT INTO `migrations` VALUES (29, '2020_08_04_194200_create_mtb_diary_text_questions', 1);
INSERT INTO `migrations` VALUES (30, '2020_08_04_194438_create_diary_rate_questions_table', 1);
INSERT INTO `migrations` VALUES (31, '2020_08_04_194455_create_diary_text_questions_table', 1);
INSERT INTO `migrations` VALUES (32, '2020_08_04_200212_create_mtb_treat_indicators_table', 1);
INSERT INTO `migrations` VALUES (33, '2020_08_04_200556_create_treat_progresses_table', 1);
INSERT INTO `migrations` VALUES (34, '2020_08_04_200702_create_counseling_reports_table', 1);
INSERT INTO `migrations` VALUES (35, '2020_08_04_200719_create_counseling_questions_table', 1);
INSERT INTO `migrations` VALUES (36, '2020_08_04_202131_create_questions_table', 1);
INSERT INTO `migrations` VALUES (37, '2020_08_04_202330_create_question_categories_table', 1);
INSERT INTO `migrations` VALUES (38, '2020_08_04_202336_create_favorites_table', 1);
INSERT INTO `migrations` VALUES (39, '2020_08_04_202347_create_comments_table', 1);
INSERT INTO `migrations` VALUES (40, '2020_08_04_202633_create_viewables_table', 1);
INSERT INTO `migrations` VALUES (41, '2020_08_05_071607_create_stuff_specialities_table', 1);
INSERT INTO `migrations` VALUES (42, '2020_08_12_055543_create_cases_table', 1);
INSERT INTO `migrations` VALUES (43, '2020_08_20_064229_create_rsv_hope_times_table', 1);
INSERT INTO `migrations` VALUES (44, '2020_08_27_182627_add_filrebase_key_to_users_table', 1);
INSERT INTO `migrations` VALUES (45, '2020_09_16_013417_add_confirmation_code_column_to_users_table', 1);
INSERT INTO `migrations` VALUES (46, '2020_09_16_070233_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (47, '2020_09_16_093136_add_columns_to_patients_table', 1);
INSERT INTO `migrations` VALUES (48, '2020_09_16_101445_create_patient_interest_categories_table', 1);
INSERT INTO `migrations` VALUES (49, '2020_09_17_030750_add_social_login_columns_to_users_table', 1);
INSERT INTO `migrations` VALUES (50, '2020_09_20_015519_create_treat_status_table', 1);
INSERT INTO `migrations` VALUES (51, '2020_09_20_151324_create_counseling_categories_table', 1);
INSERT INTO `migrations` VALUES (52, '2020_09_21_015326_create_follows_table', 1);
INSERT INTO `migrations` VALUES (53, '2020_10_20_154622_alter_address_column_to_clinics_table', 1);
INSERT INTO `migrations` VALUES (54, '2020_10_20_162158_create_mtb_cities_table', 1);
INSERT INTO `migrations` VALUES (55, '2020_10_20_162213_create_mtb_towns_table', 1);
INSERT INTO `migrations` VALUES (56, '2020_10_27_082318_create_likeables_table', 1);
INSERT INTO `migrations` VALUES (57, '2020_10_29_083310_create_diary_menu_table', 1);
INSERT INTO `migrations` VALUES (58, '2020_10_29_160302_add_stuff_id_column_to_counseling_reports_table', 1);
INSERT INTO `migrations` VALUES (59, '2020_10_31_042255_create_case_categories_table', 1);
INSERT INTO `migrations` VALUES (60, '2020_11_04_081856_create_reservation_categories_table', 1);
INSERT INTO `migrations` VALUES (61, '2020_11_04_084640_add_use_point_column_to_reservations_table', 1);
INSERT INTO `migrations` VALUES (62, '2020_11_07_004436_add_point_column_to_patients_table', 1);
INSERT INTO `migrations` VALUES (63, '2020_11_07_004722_create_point_histories_table', 1);
INSERT INTO `migrations` VALUES (64, '2020_11_07_015839_add_department_column_to_clinics_table', 1);
INSERT INTO `migrations` VALUES (65, '2020_11_07_123938_add_rate_columns_to_diaries_table', 1);
INSERT INTO `migrations` VALUES (66, '2020_11_07_125424_change_area_column_to_patients_table', 1);
INSERT INTO `migrations` VALUES (67, '2020_11_07_153126_add_ave_diaries_rate_column_to_clinics_table', 1);
INSERT INTO `migrations` VALUES (68, '2020_11_07_154900_add_ave_diaries_rate_column_to_stuffs_table', 1);
INSERT INTO `migrations` VALUES (69, '2020_11_11_033358_create_mtb_concern_categories_table', 1);
INSERT INTO `migrations` VALUES (70, '2020_11_11_152456_create_patient_categories_table', 1);
INSERT INTO `migrations` VALUES (71, '2020_11_11_153406_change_category_id_column_to_counseling_categories', 1);
INSERT INTO `migrations` VALUES (72, '2020_11_13_031227_alter_columns_to_diaries_table', 1);
INSERT INTO `migrations` VALUES (73, '2020_11_13_050242_add_cost_column_to_diary_menu_table', 1);
INSERT INTO `migrations` VALUES (74, '2020_11_13_063306_add_type_columns_to_point_histories_table', 1);
INSERT INTO `migrations` VALUES (75, '2021_06_22_003130_create_case_menus_table', 2);
INSERT INTO `migrations` VALUES (76, '2021_06_22_003547_create_menu_categories_table', 2);
INSERT INTO `migrations` VALUES (77, '2021_06_22_003943_create_menu_photos_table', 2);
INSERT INTO `migrations` VALUES (78, '2021_07_18_044128_alter_duty_column_to_stuffs_table', 3);
INSERT INTO `migrations` VALUES (79, '2021_07_18_061737_alter_experience_year_column_to_stuffs_table', 3);
INSERT INTO `migrations` VALUES (80, '2021_07_22_025716_add_clinic_column_to_doctors_table', 4);
INSERT INTO `migrations` VALUES (81, '2021_08_18_225002_add_parent_id_to_mtb_specialities_table', 5);
INSERT INTO `migrations` VALUES (82, '2021_08_19_110135_add_menu_id_to_doctor_case_menus_table', 6);
INSERT INTO `migrations` VALUES (83, '2021_08_24_162511_create_doctor_clinics_table', 7);
INSERT INTO `migrations` VALUES (84, '2022_03_15_081834_drop_patient_infos_table', 8);
INSERT INTO `migrations` VALUES (85, '2022_03_15_082924_update_all_columns_to_reservations_table', 8);
INSERT INTO `migrations` VALUES (86, '2022_03_15_084925_drop_is_visited_column_to_reservations_table', 8);
INSERT INTO `migrations` VALUES (87, '2022_03_15_090356_change_status_column_to_reservations_table', 8);
INSERT INTO `migrations` VALUES (88, '2022_03_15_115455_add_type_column_to_reservations_table', 8);
INSERT INTO `migrations` VALUES (89, '2022_03_15_133237_change_doctor_id_column_to_doctors_table', 8);
INSERT INTO `migrations` VALUES (90, '2022_03_18_054553_drop_menu_id_column_to_cases_table', 9);
INSERT INTO `migrations` VALUES (91, '2022_03_18_055631_drop_category_id_column_to_menus_table', 9);
INSERT INTO `migrations` VALUES (92, '2022_03_18_065029_drop_photo_column_to_cases_table', 9);
INSERT INTO `migrations` VALUES (93, '2022_03_19_074513_update_all_columns_to_clinics_table', 10);
INSERT INTO `migrations` VALUES (94, '2022_03_19_082437_create_day_infos_table', 10);
INSERT INTO `migrations` VALUES (95, '2022_03_19_084248_create_clinic_day_infos_table', 10);
INSERT INTO `migrations` VALUES (96, '2022_03_22_011632_drop_doctor_id_fk_to_diaries_table', 11);
INSERT INTO `migrations` VALUES (97, '2022_03_25_084609_drop_stuff_id_fk_to_counseling_reports_table', 12);
INSERT INTO `migrations` VALUES (98, '2022_03_25_084749_update_stuff_id_to_counseling_reports_table', 12);
INSERT INTO `migrations` VALUES (99, '2022_03_25_123847_add_doctor_id_to_cases_table', 13);
INSERT INTO `migrations` VALUES (100, '2022_06_27_062554_create_menu_process_table', 14);

-- ----------------------------
-- Table structure for mtb_cities
-- ----------------------------
DROP TABLE IF EXISTS `mtb_cities`;
CREATE TABLE `mtb_cities`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pref_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mtb_cities_pref_id_foreign`(`pref_id`) USING BTREE,
  CONSTRAINT `mtb_cities_pref_id_foreign` FOREIGN KEY (`pref_id`) REFERENCES `mtb_prefs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_cities
-- ----------------------------
INSERT INTO `mtb_cities` VALUES (1, 1, '札幌市中央区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (2, 1, '札幌市北区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (3, 1, '札幌市東区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (4, 1, '札幌市白石区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (5, 1, '札幌市豊平区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (6, 1, '札幌市南区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (7, 1, '札幌市西区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (8, 1, '札幌市厚別区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (9, 1, '札幌市手稲区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (10, 1, '札幌市清田区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (11, 1, '函館市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (12, 1, '小樽市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (13, 1, '旭川市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (14, 1, '室蘭市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (15, 1, '釧路市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (16, 1, '帯広市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (17, 1, '北見市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (18, 1, '夕張市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (19, 1, '岩見沢市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (20, 1, '網走市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (21, 1, '留萌市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (22, 1, '苫小牧市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (23, 1, '稚内市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (24, 1, '美唄市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (25, 1, '芦別市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (26, 2, '青森市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (27, 2, '弘前市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (28, 2, '八戸市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (29, 2, '黒石市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (30, 2, '五所川原市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (31, 3, '盛岡市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (32, 3, '宮古市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (33, 3, '大船渡市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (34, 3, '花巻市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (35, 3, '北上市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (36, 4, '仙台市青葉区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (37, 4, '仙台市宮城野区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (38, 4, '仙台市若林区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (39, 4, '仙台市太白区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (40, 4, '仙台市泉区', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (41, 5, '秋田市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (42, 5, '能代市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (43, 5, '横手市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (44, 5, '大館市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (45, 5, '男鹿市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (46, 6, '山形市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (47, 6, '米沢市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (48, 6, '鶴岡市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (49, 6, '酒田市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (50, 6, '新庄市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (51, 7, '福島市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (52, 7, '会津若松市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (53, 7, '郡山市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (54, 7, 'いわき市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (55, 7, '白河市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (56, 8, '水戸市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (57, 8, '日立市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (58, 8, '土浦市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (59, 8, '古河市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (60, 8, '石岡市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (61, 9, '宇都宮市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (62, 9, '足利市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (63, 9, '栃木市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (64, 9, '佐野市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (65, 9, '鹿沼市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (66, 10, '前橋市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (67, 10, '高崎市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (68, 10, '桐生市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (69, 10, '伊勢崎市', NULL, NULL);
INSERT INTO `mtb_cities` VALUES (70, 10, '太田市', NULL, NULL);

-- ----------------------------
-- Table structure for mtb_concern_categories
-- ----------------------------
DROP TABLE IF EXISTS `mtb_concern_categories`;
CREATE TABLE `mtb_concern_categories`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'カテゴリー名',
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` smallint(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_concern_categories
-- ----------------------------
INSERT INTO `mtb_concern_categories` VALUES (1, NULL, '目元', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (2, NULL, '鼻', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (3, NULL, '肌', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (4, NULL, '顔・輪郭', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (5, NULL, 'ボディ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (6, NULL, '胸', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (7, NULL, '口元・唇', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (8, NULL, '審美歯科・歯科矯正', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (9, NULL, 'その他', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (10, 1, '一重', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (11, 1, '奥二重', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (12, 1, '二重の左右左', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (13, 1, '二重幅が狭い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (14, 1, '目が小さい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (15, 1, 'まぶたが暑い・重い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (16, 1, '離れ目', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (17, 1, '蒙古襞が張っている', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (18, 1, 'つり目・きつい目つき', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (19, 1, '二重幅が広い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (20, 1, '眠そうな目・目の開きが悪い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (21, 1, '目の下のくま', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (22, 1, '下まぶたのたるみ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (23, 2, '鼻が低い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (24, 2, '鼻が短い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (25, 2, '鼻先が丸い・団子鼻', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (26, 2, '鼻先が低い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (27, 2, '鼻の下が長い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (28, 2, '鼻が大きい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (29, 2, '鼻筋が太い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (30, 2, '鷹鼻', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (31, 2, '鼻が上を向いている', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (32, 3, 'あごがない', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (33, 3, 'くま', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (34, 3, 'しわ・たるみ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (35, 3, 'エイジングケア', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (36, 3, '肌のハリ・ツヤ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (37, 3, 'ホクロ取りたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (38, 3, 'ニキビ・ニキビ跡', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (39, 3, '肌荒れ・肌の不調', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (40, 3, '毛穴', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (41, 3, 'シミ・くすみ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (42, 3, '赤ら顔', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (43, 3, '美白になりたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (44, 3, '肝斑(かんぱん)', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (45, 3, 'リフトアップ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (46, 4, 'あごがない', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (47, 4, '顔を小さくしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (48, 4, '口元の形を変えたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (49, 4, 'エラが張っている', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (50, 4, '頬骨が出ている', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (51, 4, '輪郭の脂肪', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (52, 4, 'リフトアップ', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (53, 4, '輪郭を整えたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (54, 4, '立体的なフェイスラインにしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (55, 4, '額を丸くしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (56, 4, '面長', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (57, 4, '歯茎が見える', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (58, 5, '二の腕の脂肪', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (59, 5, '太ももの脂肪', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (60, 5, 'お腹の脂肪', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (61, 5, 'お尻の垂れている', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (62, 5, 'ふくらはぎの脂肪', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (63, 6, '胸を大きくしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (64, 6, '胸の形を治したい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (65, 6, '乳房を小さくしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (66, 7, '唇が薄い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (67, 7, '鼻の下が長い', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (68, 7, '口角をあげたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (69, 7, '唇の形を変えたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (70, 7, '歯茎が見える', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (71, 7, '口元が出ている・受け口', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (72, 8, '歯並びを良くしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (73, 8, '歯を白くしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (74, 8, '口元が出ている・受け口', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (75, 8, '虫歯を治したい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (76, 8, 'インプラントにしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (77, 9, 'ムダ毛', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (78, 9, '脇汗を止めたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (79, 9, 'タトゥーを消したい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (80, 9, '傷跡を綺麗にしたい', 1, NULL);
INSERT INTO `mtb_concern_categories` VALUES (81, 9, 'ピアスを開けたい', 1, NULL);

-- ----------------------------
-- Table structure for mtb_diary_rate_questions
-- ----------------------------
DROP TABLE IF EXISTS `mtb_diary_rate_questions`;
CREATE TABLE `mtb_diary_rate_questions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('TREAT','CLINIC','DOCTOR') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_diary_rate_questions
-- ----------------------------
INSERT INTO `mtb_diary_rate_questions` VALUES (1, '施術前の説明は十分でしたか？', 'TREAT', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (2, '施術の仕上がりに満足していますか？', 'TREAT', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (3, '施術の料金は妥当でしたか？', 'TREAT', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (4, '院内の雰囲気、設備、清潔感はいかがでしたか？', 'CLINIC', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (5, 'スタッフの対応はいかがでしたか？', 'CLINIC', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (6, 'プライバシーへの配慮はいかがでしたか？', 'CLINIC', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (7, '治療前の説明は十分でしたか？', 'DOCTOR', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (8, 'ご自分の要望・意見を考慮してもらえましたか？', 'DOCTOR', 1, NULL, NULL, NULL);
INSERT INTO `mtb_diary_rate_questions` VALUES (9, '術前、術中、術後の対応はいかがでしたか？', 'DOCTOR', 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_diary_text_questions
-- ----------------------------
DROP TABLE IF EXISTS `mtb_diary_text_questions`;
CREATE TABLE `mtb_diary_text_questions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_diary_text_questions
-- ----------------------------
INSERT INTO `mtb_diary_text_questions` VALUES (1, 'どんなことで悩んでいましたか？', 1, 0, NULL, NULL);
INSERT INTO `mtb_diary_text_questions` VALUES (2, 'クリニック、ドクターを選択した理由は？', 1, 1, NULL, NULL);
INSERT INTO `mtb_diary_text_questions` VALUES (3, 'このメニューを選んだ理由は？', 1, 2, NULL, NULL);
INSERT INTO `mtb_diary_text_questions` VALUES (4, '施術の流れや施術中の痛みは？', 1, 3, NULL, NULL);
INSERT INTO `mtb_diary_text_questions` VALUES (5, 'ドクターやスタッフの対応はどうでしたか？', 1, 4, NULL, NULL);
INSERT INTO `mtb_diary_text_questions` VALUES (6, 'この施術をしたいと思ってる人へアドバイスを', 1, 5, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_interest_categories
-- ----------------------------
DROP TABLE IF EXISTS `mtb_interest_categories`;
CREATE TABLE `mtb_interest_categories`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'カテゴリー名',
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` smallint(6) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 350 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_interest_categories
-- ----------------------------
INSERT INTO `mtb_interest_categories` VALUES (1, NULL, '二重', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (2, NULL, '目元・クマ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (3, NULL, '鼻', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (4, NULL, '顎・輪郭・小顔', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (5, NULL, '耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (6, NULL, '口元', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (7, NULL, '歯科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (8, NULL, 'しわ・ほうれい線', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (9, NULL, 'たるみ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (10, NULL, 'しみ・そばかす・肝斑', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (11, NULL, '毛穴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (12, NULL, 'ほくろ・イボ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (13, NULL, 'くすみ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (14, NULL, 'にきび・にきび跡', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (15, NULL, '赤ら顔', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (16, NULL, 'あざ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (17, NULL, '豊胸・バスト・乳首', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (18, NULL, '痩身・脂肪吸引・部分やせ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (19, NULL, '脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (20, NULL, 'タトゥー・刺青除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (21, NULL, 'わきが・多汗症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (22, NULL, 'アートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (23, NULL, '泌尿器科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (24, NULL, '薄毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (25, NULL, '婦人科・女性器', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (26, NULL, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (27, 1, '二重埋没法', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (28, 1, '二重切開法', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (29, 1, '目頭切開', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (30, 1, '目尻切開', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (31, 1, 'グラマラスライン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (32, 1, '目尻靭帯移動', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (33, 1, '眼瞼下垂', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (34, 1, '眉下切開', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (35, 1, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (36, 1, 'タレ目ボトックス注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (37, 1, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (38, 2, '涙袋形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (39, 2, '上眼瞼リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (40, 2, '目の下の脂肪取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (41, 2, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (42, 2, '蒙古ひだ形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (43, 2, 'グラマラスライン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (44, 2, 'くま治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (45, 2, '上まぶたたるみ取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (46, 2, '下まぶたたるみ取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (47, 2, '上まぶたの脂肪取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (48, 2, '下まぶたの脂肪取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (49, 2, 'まぶたの脂肪溶解注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (50, 2, 'ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (51, 2, 'まつ毛・眉毛の植毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (52, 2, '逆さまつげ修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (53, 2, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (54, 2, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (55, 2, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (56, 3, '隆鼻術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (57, 3, '鼻尖形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (58, 3, '鼻中隔延長', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (59, 3, '小鼻縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (60, 3, '鼻ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (61, 3, 'レディエッセ注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (62, 3, '軟骨移植', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (63, 3, '骨切幅寄せ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (64, 3, 'ハンプ切除', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (65, 3, '斜鼻修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (66, 3, '鼻翼挙上手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (67, 3, 'プロテーゼ除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (68, 3, 'ハイコ・ミスコ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (69, 3, '鼻孔縁挙上', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (70, 3, '鼻翼基部プロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (71, 3, '眉間プロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (72, 3, '鼻尖縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (73, 3, '真皮移植', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (74, 3, '鼻孔縁下降', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (75, 3, '鼻修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (76, 3, '系リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (77, 3, 'わし鼻・段鼻修正・ハンプ切除', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (78, 3, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (79, 3, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (80, 4, 'あごヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (81, 4, '額ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (82, 4, '頬ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (83, 4, 'あごレディエッセ注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (84, 4, 'あごボトックス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (85, 4, 'エラ・小顔ボトックス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (86, 4, 'あごプロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (87, 4, '額プロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (88, 4, 'あご骨切り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (89, 4, 'エラ骨削り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (90, 4, '頬骨削り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (91, 4, '眉骨削り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (92, 4, '脂肪吸引', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (93, 4, '脂肪溶解注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (94, 4, 'バッカルファット除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (95, 4, 'メーラーファット除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (96, 4, 'リフトアップ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (97, 4, '脂肪注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (98, 4, '額脂肪注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (99, 4, '額を丸く', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (100, 4, 'こめかみ形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (101, 4, '輪郭修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (102, 4, '脂肪冷却', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (103, 4, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (104, 4, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (105, 5, '立ち耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (106, 5, '柔道耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (107, 5, '耳たぶピアス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (108, 5, '耳軟骨ピアス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (109, 5, '耳鼻科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (110, 5, 'ボディピアス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (111, 5, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (112, 6, '唇ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (113, 6, '口角ボトックス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (114, 6, '口唇縮小術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (115, 6, '口角挙上', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (116, 6, '人中短縮術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (117, 6, 'ガミースマイル手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (118, 6, 'セットバック', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (119, 6, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (120, 7, 'インプラント', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (121, 7, '歯科矯正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (122, 7, 'インビザライン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (123, 7, 'セラミック', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (124, 7, 'ホワイトニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (125, 7, '義歯・入れ歯', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (126, 7, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (127, 7, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (128, 8, 'ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (129, 8, 'アグネス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (130, 8, 'ベビーコラーゲン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (131, 8, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (132, 8, 'ボトックス注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (133, 8, 'ボツリヌストキシン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (134, 8, 'フェイスリフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (135, 8, 'glow（グロー）注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (136, 8, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (137, 8, 'ポラリス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (138, 8, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (139, 8, 'ジェネシス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (140, 8, 'HIFU', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (141, 8, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (142, 8, '糸リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (143, 8, 'イントラジェン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (144, 8, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (145, 8, 'フォトフェイシャル', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (146, 8, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (147, 8, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (148, 8, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (149, 8, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (150, 9, 'フェイスリフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (151, 9, 'HIFU', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (152, 9, 'ポラリス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (153, 9, 'RF治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (154, 9, '糸リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (155, 9, 'ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (156, 9, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (157, 9, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (158, 9, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (159, 9, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (160, 9, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (161, 9, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (162, 10, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (163, 10, 'シミ取りレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (164, 10, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (165, 10, 'レーザートーニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (166, 10, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (167, 10, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (168, 10, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (169, 10, '白玉注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (170, 10, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (171, 10, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (172, 10, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (173, 10, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (174, 11, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (175, 11, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (176, 11, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (177, 11, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (178, 11, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (179, 11, '美容内服薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (180, 11, 'ポラリス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (181, 11, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (182, 11, '水光注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (183, 11, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (184, 11, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (185, 11, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (186, 11, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (187, 11, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (188, 12, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (189, 12, '切除縫縮手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (190, 12, '皮膚切除術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (191, 12, 'YAGレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (192, 12, '電気メス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (193, 12, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (194, 12, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (195, 12, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (196, 12, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (197, 13, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (198, 13, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (199, 13, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (200, 13, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (201, 13, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (202, 13, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (203, 13, 'レーザートーニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (204, 13, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (205, 13, 'プラセンタ注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (206, 13, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (207, 13, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (208, 13, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (209, 13, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (210, 14, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (211, 14, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (212, 14, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (213, 14, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (214, 14, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (215, 14, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (216, 14, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (217, 14, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (218, 14, 'レーザートーニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (219, 14, 'ジェネシス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (220, 14, 'プラセンタ注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (221, 14, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (222, 14, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (223, 14, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (224, 14, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (225, 15, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (226, 15, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (227, 15, 'ジェネシス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (228, 15, 'フォトフェイシャル', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (229, 15, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (230, 15, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (231, 15, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (232, 15, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (233, 15, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (234, 15, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (235, 16, ' ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (236, 16, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (237, 16, 'YAGレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (238, 16, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (239, 16, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (240, 16, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (241, 16, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (242, 17, '豊胸(脂肪注入)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (243, 17, '豊胸(シリコンパック)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (244, 17, '豊胸(ヒアルロン酸)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (245, 17, 'エイジングブレスト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (246, 17, 'ハイブリッド', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (247, 17, '陥没乳首(乳頭)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (248, 17, '乳首縮小(乳頭)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (249, 17, '乳輪縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (250, 17, '乳房縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (251, 17, '乳房吊上', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (252, 17, '垂れ乳修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (253, 17, '吸収性ジェル', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (254, 17, 'ヒアルロニダーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (255, 17, '人工乳腺(バッグ)除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (256, 17, '乳がん検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (257, 17, '乳房再建', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (258, 17, '予防手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (259, 17, '乳輪・乳頭の美白', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (260, 17, '乳輪のぶつぶつ除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (261, 17, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (262, 17, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (263, 18, 'GLP-1ダイエット', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (264, 18, 'エムスカルプト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (265, 18, 'インディバ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (266, 18, '脂肪吸引（二の腕）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (267, 18, '脂肪吸引（太もも）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (268, 18, '脂肪吸引（お腹）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (269, 18, '脂肪吸引（ヒップ）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (270, 18, '脂肪溶解注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (271, 18, '脂肪溶解注射(二の腕)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (272, 18, '脂肪溶解注射(太もも)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (273, 18, '脂肪溶解注射(お腹)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (274, 18, '脂肪溶解注射(ヒップ)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (275, 18, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (276, 18, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (277, 19, '医療レーザー脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (278, 19, 'ニードル脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (279, 19, '光脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (280, 19, 'ワキ脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (281, 19, 'VIO脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (282, 19, '顔、うなじの脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (283, 19, '腕の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (284, 19, '足の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (285, 19, '背中・お腹の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (286, 19, '髭脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (287, 19, '顔脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (288, 19, '全身脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (289, 19, 'その他の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (290, 20, 'YAGレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (291, 20, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (292, 20, '刺青除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (293, 20, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (294, 21, 'ボトックス注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (295, 21, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (296, 21, 'ミラドライ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (297, 21, '手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (298, 21, '注射治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (299, 21, '外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (300, 21, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (301, 22, '眉のアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (302, 22, 'アイラインのアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (303, 22, 'リップアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (304, 22, 'ほくろのアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (305, 22, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (306, 23, '性病', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (307, 23, 'ED治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (308, 23, '前立腺', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (309, 23, '結石', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (310, 23, '腫瘍', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (311, 23, 'HIVエイズ検査', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (312, 23, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (313, 24, '男性型脱毛症(AGA)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (314, 24, '女性男性型脱毛症(FAGA)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (315, 24, 'びまん性脱毛症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (316, 24, '分娩後脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (317, 24, '円形脱毛症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (318, 24, '脂漏性脱毛症(粃糠性)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (319, 24, '抜毛症(トリコチロマニア)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (320, 24, 'プロペシア', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (321, 24, 'HARG療法', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (322, 24, '育毛メソセラピー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (323, 24, '内服・外用薬治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (324, 24, '植毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (325, 24, '人工毛植毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (326, 25, '小陰唇縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (327, 25, '処女膜再生', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (328, 25, '膣縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (329, 25, '妊娠線', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (330, 25, 'すそワキガ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (331, 25, 'クリトリス包茎', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (332, 25, '性病', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (333, 25, 'HIVエイズ検査', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (334, 25, '不妊治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (335, 25, '産婦人科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (336, 25, '婦人科検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (337, 25, '乳がん検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (338, 25, '子宮がん検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (339, 25, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (340, 26, '再生医療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (341, 26, '下肢静脈瘤', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (342, 26, 'レーシック・ICL', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (343, 26, 'ホルモン治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (344, 26, 'いびき治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (345, 26, '粉瘤(アテローム)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (346, 26, '肩こり・腰痛注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (347, 26, 'でべそ修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (348, 26, '唇修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_interest_categories` VALUES (349, 26, '豊尻・ヒップアップ', 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_jobs
-- ----------------------------
DROP TABLE IF EXISTS `mtb_jobs`;
CREATE TABLE `mtb_jobs`  (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_jobs
-- ----------------------------
INSERT INTO `mtb_jobs` VALUES (1, '院長', 1, 0, NULL, NULL);
INSERT INTO `mtb_jobs` VALUES (2, '副院長', 1, 1, NULL, NULL);
INSERT INTO `mtb_jobs` VALUES (3, '部長', 1, 1, NULL, NULL);
INSERT INTO `mtb_jobs` VALUES (4, '医師', 1, 1, NULL, NULL);
INSERT INTO `mtb_jobs` VALUES (5, '主任', 1, 1, NULL, NULL);
INSERT INTO `mtb_jobs` VALUES (6, '主任部長', 1, 1, NULL, NULL);
INSERT INTO `mtb_jobs` VALUES (7, 'スタッフ', 1, 1, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_part_categories
-- ----------------------------
DROP TABLE IF EXISTS `mtb_part_categories`;
CREATE TABLE `mtb_part_categories`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'カテゴリー名',
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` smallint(6) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 350 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_part_categories
-- ----------------------------
INSERT INTO `mtb_part_categories` VALUES (1, NULL, '二重', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (2, NULL, '目元・クマ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (3, NULL, '鼻', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (4, NULL, '顎・輪郭・小顔', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (5, NULL, '耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (6, NULL, '口元', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (7, NULL, '歯科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (8, NULL, 'しわ・ほうれい線', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (9, NULL, 'たるみ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (10, NULL, 'しみ・そばかす・肝斑', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (11, NULL, '毛穴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (12, NULL, 'ほくろ・イボ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (13, NULL, 'くすみ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (14, NULL, 'にきび・にきび跡', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (15, NULL, '赤ら顔', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (16, NULL, 'あざ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (17, NULL, '豊胸・バスト・乳首', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (18, NULL, '痩身・脂肪吸引・部分やせ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (19, NULL, '脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (20, NULL, 'タトゥー・刺青除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (21, NULL, 'わきが・多汗症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (22, NULL, 'アートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (23, NULL, '泌尿器科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (24, NULL, '薄毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (25, NULL, '婦人科・女性器', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (26, NULL, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (27, 1, '二重埋没法', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (28, 1, '二重切開法', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (29, 1, '目頭切開', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (30, 1, '目尻切開', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (31, 1, 'グラマラスライン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (32, 1, '目尻靭帯移動', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (33, 1, '眼瞼下垂', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (34, 1, '眉下切開', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (35, 1, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (36, 1, 'タレ目ボトックス注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (37, 1, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (38, 2, '涙袋形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (39, 2, '上眼瞼リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (40, 2, '目の下の脂肪取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (41, 2, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (42, 2, '蒙古ひだ形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (43, 2, 'グラマラスライン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (44, 2, 'くま治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (45, 2, '上まぶたたるみ取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (46, 2, '下まぶたたるみ取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (47, 2, '上まぶたの脂肪取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (48, 2, '下まぶたの脂肪取り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (49, 2, 'まぶたの脂肪溶解注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (50, 2, 'ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (51, 2, 'まつ毛・眉毛の植毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (52, 2, '逆さまつげ修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (53, 2, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (54, 2, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (55, 2, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (56, 3, '隆鼻術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (57, 3, '鼻尖形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (58, 3, '鼻中隔延長', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (59, 3, '小鼻縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (60, 3, '鼻ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (61, 3, 'レディエッセ注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (62, 3, '軟骨移植', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (63, 3, '骨切幅寄せ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (64, 3, 'ハンプ切除', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (65, 3, '斜鼻修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (66, 3, '鼻翼挙上手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (67, 3, 'プロテーゼ除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (68, 3, 'ハイコ・ミスコ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (69, 3, '鼻孔縁挙上', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (70, 3, '鼻翼基部プロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (71, 3, '眉間プロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (72, 3, '鼻尖縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (73, 3, '真皮移植', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (74, 3, '鼻孔縁下降', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (75, 3, '鼻修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (76, 3, '系リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (77, 3, 'わし鼻・段鼻修正・ハンプ切除', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (78, 3, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (79, 3, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (80, 4, 'あごヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (81, 4, '額ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (82, 4, '頬ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (83, 4, 'あごレディエッセ注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (84, 4, 'あごボトックス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (85, 4, 'エラ・小顔ボトックス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (86, 4, 'あごプロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (87, 4, '額プロテーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (88, 4, 'あご骨切り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (89, 4, 'エラ骨削り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (90, 4, '頬骨削り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (91, 4, '眉骨削り', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (92, 4, '脂肪吸引', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (93, 4, '脂肪溶解注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (94, 4, 'バッカルファット除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (95, 4, 'メーラーファット除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (96, 4, 'リフトアップ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (97, 4, '脂肪注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (98, 4, '額脂肪注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (99, 4, '額を丸く', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (100, 4, 'こめかみ形成', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (101, 4, '輪郭修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (102, 4, '脂肪冷却', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (103, 4, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (104, 4, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (105, 5, '立ち耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (106, 5, '柔道耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (107, 5, '耳たぶピアス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (108, 5, '耳軟骨ピアス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (109, 5, '耳鼻科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (110, 5, 'ボディピアス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (111, 5, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (112, 6, '唇ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (113, 6, '口角ボトックス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (114, 6, '口唇縮小術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (115, 6, '口角挙上', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (116, 6, '人中短縮術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (117, 6, 'ガミースマイル手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (118, 6, 'セットバック', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (119, 6, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (120, 7, 'インプラント', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (121, 7, '歯科矯正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (122, 7, 'インビザライン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (123, 7, 'セラミック', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (124, 7, 'ホワイトニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (125, 7, '義歯・入れ歯', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (126, 7, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (127, 7, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (128, 8, 'ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (129, 8, 'アグネス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (130, 8, 'ベビーコラーゲン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (131, 8, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (132, 8, 'ボトックス注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (133, 8, 'ボツリヌストキシン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (134, 8, 'フェイスリフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (135, 8, 'glow（グロー）注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (136, 8, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (137, 8, 'ポラリス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (138, 8, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (139, 8, 'ジェネシス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (140, 8, 'HIFU', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (141, 8, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (142, 8, '糸リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (143, 8, 'イントラジェン', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (144, 8, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (145, 8, 'フォトフェイシャル', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (146, 8, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (147, 8, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (148, 8, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (149, 8, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (150, 9, 'フェイスリフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (151, 9, 'HIFU', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (152, 9, 'ポラリス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (153, 9, 'RF治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (154, 9, '糸リフト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (155, 9, 'ヒアルロン酸注入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (156, 9, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (157, 9, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (158, 9, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (159, 9, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (160, 9, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (161, 9, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (162, 10, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (163, 10, 'シミ取りレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (164, 10, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (165, 10, 'レーザートーニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (166, 10, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (167, 10, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (168, 10, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (169, 10, '白玉注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (170, 10, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (171, 10, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (172, 10, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (173, 10, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (174, 11, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (175, 11, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (176, 11, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (177, 11, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (178, 11, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (179, 11, '美容内服薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (180, 11, 'ポラリス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (181, 11, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (182, 11, '水光注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (183, 11, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (184, 11, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (185, 11, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (186, 11, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (187, 11, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (188, 12, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (189, 12, '切除縫縮手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (190, 12, '皮膚切除術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (191, 12, 'YAGレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (192, 12, '電気メス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (193, 12, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (194, 12, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (195, 12, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (196, 12, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (197, 13, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (198, 13, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (199, 13, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (200, 13, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (201, 13, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (202, 13, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (203, 13, 'レーザートーニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (204, 13, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (205, 13, 'プラセンタ注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (206, 13, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (207, 13, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (208, 13, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (209, 13, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (210, 14, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (211, 14, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (212, 14, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (213, 14, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (214, 14, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (215, 14, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (216, 14, '美容点滴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (217, 14, 'ピーリング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (218, 14, 'レーザートーニング', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (219, 14, 'ジェネシス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (220, 14, 'プラセンタ注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (221, 14, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (222, 14, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (223, 14, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (224, 14, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (225, 15, 'CO2レーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (226, 15, 'フォトRF', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (227, 15, 'ジェネシス', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (228, 15, 'フォトフェイシャル', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (229, 15, 'ダーマペン4', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (230, 15, 'イオン導入', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (231, 15, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (232, 15, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (233, 15, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (234, 15, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (235, 16, ' ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (236, 16, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (237, 16, 'YAGレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (238, 16, '内服・外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (239, 16, '光治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (240, 16, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (241, 16, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (242, 17, '豊胸(脂肪注入)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (243, 17, '豊胸(シリコンパック)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (244, 17, '豊胸(ヒアルロン酸)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (245, 17, 'エイジングブレスト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (246, 17, 'ハイブリッド', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (247, 17, '陥没乳首(乳頭)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (248, 17, '乳首縮小(乳頭)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (249, 17, '乳輪縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (250, 17, '乳房縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (251, 17, '乳房吊上', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (252, 17, '垂れ乳修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (253, 17, '吸収性ジェル', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (254, 17, 'ヒアルロニダーゼ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (255, 17, '人工乳腺(バッグ)除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (256, 17, '乳がん検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (257, 17, '乳房再建', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (258, 17, '予防手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (259, 17, '乳輪・乳頭の美白', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (260, 17, '乳輪のぶつぶつ除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (261, 17, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (262, 17, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (263, 18, 'GLP-1ダイエット', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (264, 18, 'エムスカルプト', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (265, 18, 'インディバ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (266, 18, '脂肪吸引（二の腕）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (267, 18, '脂肪吸引（太もも）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (268, 18, '脂肪吸引（お腹）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (269, 18, '脂肪吸引（ヒップ）', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (270, 18, '脂肪溶解注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (271, 18, '脂肪溶解注射(二の腕)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (272, 18, '脂肪溶解注射(太もも)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (273, 18, '脂肪溶解注射(お腹)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (274, 18, '脂肪溶解注射(ヒップ)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (275, 18, '他院で受けた修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (276, 18, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (277, 19, '医療レーザー脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (278, 19, 'ニードル脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (279, 19, '光脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (280, 19, 'ワキ脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (281, 19, 'VIO脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (282, 19, '顔、うなじの脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (283, 19, '腕の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (284, 19, '足の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (285, 19, '背中・お腹の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (286, 19, '髭脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (287, 19, '顔脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (288, 19, '全身脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (289, 19, 'その他の脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (290, 20, 'YAGレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (291, 20, 'ピコレーザー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (292, 20, '刺青除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (293, 20, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (294, 21, 'ボトックス注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (295, 21, 'レーザー治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (296, 21, 'ミラドライ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (297, 21, '手術', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (298, 21, '注射治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (299, 21, '外用薬', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (300, 21, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (301, 22, '眉のアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (302, 22, 'アイラインのアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (303, 22, 'リップアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (304, 22, 'ほくろのアートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (305, 22, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (306, 23, '性病', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (307, 23, 'ED治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (308, 23, '前立腺', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (309, 23, '結石', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (310, 23, '腫瘍', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (311, 23, 'HIVエイズ検査', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (312, 23, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (313, 24, '男性型脱毛症(AGA)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (314, 24, '女性男性型脱毛症(FAGA)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (315, 24, 'びまん性脱毛症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (316, 24, '分娩後脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (317, 24, '円形脱毛症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (318, 24, '脂漏性脱毛症(粃糠性)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (319, 24, '抜毛症(トリコチロマニア)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (320, 24, 'プロペシア', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (321, 24, 'HARG療法', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (322, 24, '育毛メソセラピー', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (323, 24, '内服・外用薬治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (324, 24, '植毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (325, 24, '人工毛植毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (326, 25, '小陰唇縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (327, 25, '処女膜再生', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (328, 25, '膣縮小', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (329, 25, '妊娠線', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (330, 25, 'すそワキガ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (331, 25, 'クリトリス包茎', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (332, 25, '性病', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (333, 25, 'HIVエイズ検査', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (334, 25, '不妊治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (335, 25, '産婦人科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (336, 25, '婦人科検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (337, 25, '乳がん検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (338, 25, '子宮がん検診', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (339, 25, 'その他', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (340, 26, '再生医療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (341, 26, '下肢静脈瘤', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (342, 26, 'レーシック・ICL', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (343, 26, 'ホルモン治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (344, 26, 'いびき治療', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (345, 26, '粉瘤(アテローム)', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (346, 26, '肩こり・腰痛注射', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (347, 26, 'でべそ修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (348, 26, '唇修正', 1, NULL, NULL, NULL);
INSERT INTO `mtb_part_categories` VALUES (349, 26, '豊尻・ヒップアップ', 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_prefs
-- ----------------------------
DROP TABLE IF EXISTS `mtb_prefs`;
CREATE TABLE `mtb_prefs`  (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_prefs
-- ----------------------------
INSERT INTO `mtb_prefs` VALUES (1, '北海道', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (2, '青森県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (3, '岩手県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (4, '宮城県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (5, '秋田県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (6, '山形県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (7, '福島県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (8, '茨城県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (9, '栃木県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (10, '群馬県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (11, '埼玉県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (12, '千葉県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (13, '東京都', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (14, '神奈川県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (15, '新潟県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (16, '富山県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (17, '石川県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (18, '福井県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (19, '山梨県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (20, '長野県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (21, '岐阜県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (22, '静岡県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (23, '愛知県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (24, '三重県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (25, '滋賀県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (26, '京都府', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (27, '大阪府', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (28, '兵庫県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (29, '奈良県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (30, '和歌山県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (31, '鳥取県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (32, '島根県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (33, '岡山県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (34, '広島県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (35, '山口県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (36, '徳島県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (37, '香川県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (38, '愛媛県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (39, '高知県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (40, '福岡県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (41, '佐賀県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (42, '長崎県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (43, '熊本県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (44, '大分県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (45, '宮崎県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (46, '鹿児島県', 1, NULL, NULL, NULL);
INSERT INTO `mtb_prefs` VALUES (47, '沖縄県', 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_rsv_contents
-- ----------------------------
DROP TABLE IF EXISTS `mtb_rsv_contents`;
CREATE TABLE `mtb_rsv_contents`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '予約内容名',
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_rsv_contents
-- ----------------------------
INSERT INTO `mtb_rsv_contents` VALUES (1, 'カウンセリング', 1, 0, NULL, NULL);
INSERT INTO `mtb_rsv_contents` VALUES (2, '施術', 1, 1, NULL, NULL);
INSERT INTO `mtb_rsv_contents` VALUES (3, '術後検査', 1, 2, NULL, NULL);
INSERT INTO `mtb_rsv_contents` VALUES (4, '施術・カウンセリング', 1, 3, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_specialities
-- ----------------------------
DROP TABLE IF EXISTS `mtb_specialities`;
CREATE TABLE `mtb_specialities`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `sort_no` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_specialities
-- ----------------------------
INSERT INTO `mtb_specialities` VALUES (1, NULL, '二重', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (2, NULL, '目元・クマ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (3, NULL, '鼻', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (4, NULL, '顎・輪郭・小顔', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (5, NULL, '耳', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (6, NULL, '口元', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (7, NULL, '歯科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (8, NULL, 'しわ・ほうれい線', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (9, NULL, 'たるみ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (10, NULL, 'しみ・そばかす・肝斑', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (11, NULL, '毛穴', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (12, NULL, 'ほくろ・イボ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (13, NULL, 'くすみ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (14, NULL, 'にきび・にきび跡', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (15, NULL, '赤ら顔', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (16, NULL, 'あざ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (17, NULL, '豊胸・バスト・乳首', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (18, NULL, '痩身・脂肪吸引・部分やせ', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (19, NULL, '脱毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (20, NULL, 'タトゥー・刺青除去', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (21, NULL, 'わきが・多汗症', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (22, NULL, 'アートメイク', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (23, NULL, '泌尿器科', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (24, NULL, '薄毛', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (25, NULL, '婦人科・女性器', 1, NULL, NULL, NULL);
INSERT INTO `mtb_specialities` VALUES (26, NULL, 'その他', 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mtb_towns
-- ----------------------------
DROP TABLE IF EXISTS `mtb_towns`;
CREATE TABLE `mtb_towns`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `city_id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mtb_towns_city_id_foreign`(`city_id`) USING BTREE,
  CONSTRAINT `mtb_towns_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `mtb_cities` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_towns
-- ----------------------------
INSERT INTO `mtb_towns` VALUES (1, 1, '旭ケ丘', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (2, 1, '大通東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (3, 1, '大通西', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (4, 2, 'あいの里一条', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (5, 2, 'あいの里二条', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (6, 2, 'あいの里三条', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (7, 3, '丘珠町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (8, 3, '北四条東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (9, 3, '北五条東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (10, 4, '川北', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (11, 4, '川北一条', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (12, 4, '川北二条', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (13, 5, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (14, 5, '水車町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (15, 5, '月寒中央通', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (16, 26, '青葉', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (17, 26, '青柳', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (18, 26, '浅虫', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (19, 27, '青山', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (20, 27, '悪戸', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (21, 27, '石川', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (22, 28, '青葉', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (23, 28, '石堂', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (24, 28, '一番町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (25, 29, 'あけぼの町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (26, 29, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (27, 29, '一番町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (28, 30, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (29, 30, '稲実', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (30, 30, '岩木町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (31, 31, '青山', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (32, 31, '浅岸', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (33, 31, '愛宕町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (34, 32, '大通', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (35, 32, '小山田', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (36, 32, '栄町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (37, 33, '猪川町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (38, 33, '大船渡町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (39, 34, '東町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (40, 34, '石鳥谷町好地', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (41, 34, '太田', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (42, 35, '飯豊', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (43, 35, '上野町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (44, 35, '大堤北', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (45, 36, '旭ケ丘', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (46, 36, '愛子中央', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (47, 36, '愛子東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (48, 37, '銀杏町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (49, 37, '出花', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (50, 37, '岩切', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (51, 38, '荒井', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (52, 38, '荒井東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (53, 38, '荒町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (54, 39, '秋保町長袋', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (55, 39, 'あすと長町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (56, 39, '泉崎', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (57, 40, '明石南', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (58, 40, '旭丘堤', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (59, 40, '泉ケ丘', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (60, 41, '旭川南町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (61, 41, '新屋扇町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (62, 41, '新屋沖田町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (63, 42, '万町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (64, 42, '追分町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (65, 42, '大瀬儘下', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (66, 43, '赤坂', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (67, 43, '旭川', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (68, 43, '駅前町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (69, 44, '赤館町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (70, 44, '有浦', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (71, 44, '御成町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (72, 45, '船川港船川', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (73, 45, '船越', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (74, 46, '青柳', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (75, 46, 'あかねケ丘', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (76, 46, 'あこや町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (77, 47, '相生町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (78, 47, '大町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (79, 47, '春日', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (80, 48, '泉町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (81, 48, '板井川', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (82, 48, '上畑町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (83, 49, 'あきほ町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (84, 49, '駅東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (85, 49, '大宮', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (86, 50, '泉田', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (87, 50, '五日町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (88, 50, '大手町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (89, 51, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (90, 51, '荒井北', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (91, 51, '飯坂町平野', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (92, 52, '一箕町亀賀', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (93, 52, '一箕町鶴賀', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (94, 52, '一箕町松長', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (95, 53, '安積', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (96, 53, '安積荒井', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (97, 53, '安積荒井本町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (98, 54, '東田町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (99, 54, '泉ケ丘', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (100, 54, '泉玉露', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (101, 55, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (102, 55, '泉田', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (103, 55, '一番町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (104, 56, '青柳町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (105, 56, '赤塚', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (106, 56, '石川町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (107, 57, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (108, 57, '鮎川町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (109, 57, '会瀬町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (110, 58, '天川', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (111, 58, '荒川沖西', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (112, 58, '荒川沖東', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (113, 59, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (114, 59, '尾崎', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (115, 59, '女沼', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (116, 60, '旭台', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (117, 60, '石岡', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (118, 60, '大砂', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (119, 61, '相野沢町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (120, 61, '旭', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (121, 61, '飯田町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (122, 62, '相生町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (123, 62, '朝倉町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (124, 62, '伊勢町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (125, 63, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (126, 63, '泉町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (127, 63, '今泉町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (128, 64, '赤坂町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (129, 64, '浅沼町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (130, 64, '石塚町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (131, 65, '石橋町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (132, 65, '磯町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (133, 65, '今宮町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (134, 66, '青柳町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (135, 66, '朝倉町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (136, 66, '朝日町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (137, 67, '相生町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (138, 67, '旭町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (139, 67, '東町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (140, 68, '相生町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (141, 68, '稲荷町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (142, 68, '織姫町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (143, 69, '東町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (144, 69, '安堀町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (145, 69, '今泉町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (146, 70, '新井町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (147, 70, '飯田町', NULL, NULL);
INSERT INTO `mtb_towns` VALUES (148, 70, '飯塚町', NULL, NULL);

-- ----------------------------
-- Table structure for mtb_treat_indicators
-- ----------------------------
DROP TABLE IF EXISTS `mtb_treat_indicators`;
CREATE TABLE `mtb_treat_indicators`  (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mtb_treat_indicators
-- ----------------------------
INSERT INTO `mtb_treat_indicators` VALUES (1, '痛み', 0, NULL, NULL);
INSERT INTO `mtb_treat_indicators` VALUES (2, '腫れ', 1, NULL, NULL);
INSERT INTO `mtb_treat_indicators` VALUES (3, '傷あと', 2, NULL, NULL);

-- ----------------------------
-- Table structure for oauth_providers
-- ----------------------------
DROP TABLE IF EXISTS `oauth_providers`;
CREATE TABLE `oauth_providers`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_user_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `refresh_token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_providers_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `oauth_providers_provider_user_id_index`(`provider_user_id`) USING BTREE,
  CONSTRAINT `oauth_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
INSERT INTO `password_resets` VALUES ('patient_0@test.com', '$2y$10$zhBAjFjWFYqaX7jfCijuZe3l1RS.CtWNUNYRMhkqEsxc6.TUMTYAq', '2022-04-28 11:20:22');
INSERT INTO `password_resets` VALUES ('senior.webdev92@gmail.com', '$2y$10$zhBAjFjWFYqaX7jfCijuZe3l1RS.CtWNUNYRMhkqEsxc6.TUMTYAq', '2022-04-28 11:49:24');
INSERT INTO `password_resets` VALUES ('doctor@gmail.com', '$2y$10$zhBAjFjWFYqaX7jfCijuZe3l1RS.CtWNUNYRMhkqEsxc6.TUMTYAq', '2021-08-30 16:48:47');

-- ----------------------------
-- Table structure for patient_categories
-- ----------------------------
DROP TABLE IF EXISTS `patient_categories`;
CREATE TABLE `patient_categories`  (
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL,
  INDEX `patient_categories_patient_id_foreign`(`patient_id`) USING BTREE,
  INDEX `patient_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `patient_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `patient_categories_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patient_interest_categories
-- ----------------------------
DROP TABLE IF EXISTS `patient_interest_categories`;
CREATE TABLE `patient_interest_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `interest_category_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `patient_interest_categories_patient_id_foreign`(`patient_id`) USING BTREE,
  INDEX `patient_interest_categories_interest_category_id_foreign`(`interest_category_id`) USING BTREE,
  CONSTRAINT `patient_interest_categories_interest_category_id_foreign` FOREIGN KEY (`interest_category_id`) REFERENCES `mtb_interest_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `patient_interest_categories_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '氏名（漢字）',
  `kana` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '氏名（カタカナ）',
  `gender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性別',
  `phone_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '電話番号',
  `birthday` date NULL DEFAULT NULL COMMENT '生年月日',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `unique_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ニックネーム',
  `nickname` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ニックネーム',
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '自己紹介',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `point` int(11) NOT NULL DEFAULT 0,
  `area_id` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '施術を考えているエリア',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `patients_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `patients_area_id_foreign`(`area_id`) USING BTREE,
  CONSTRAINT `patients_area_id_foreign` FOREIGN KEY (`area_id`) REFERENCES `mtb_prefs` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `patients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patients
-- ----------------------------
INSERT INTO `patients` VALUES (1, 2, '患者_0', 'カンジャ_0', 'female', '+3962773747025', '1986-12-02', '2021-02-11 05:49:41', '2021-02-11 05:49:41', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (3, 4, '患者_2', 'カンジャ_2', 'male', '+5813293633462', '1979-02-23', '2021-02-11 05:49:42', '2021-02-11 05:49:42', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (4, 5, '患者_3', 'カンジャ_3', 'female', '+4931819507815', '2015-03-10', '2021-02-11 05:49:43', '2021-02-11 05:49:43', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (5, 6, '患者_4', 'カンジャ_4', 'female', '+5071608738270', '2014-05-15', '2021-02-11 05:49:44', '2021-02-11 05:49:44', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (6, 7, '患者_5', 'カンジャ_5', 'male', '+4821510780254', '2005-08-03', '2021-02-11 05:49:44', '2022-03-13 21:50:43', NULL, NULL, NULL, 'storage/patient/profile/1535282.jpg', 13088, NULL);
INSERT INTO `patients` VALUES (7, 8, '患者_6', 'カンジャ_6', 'male', '+5981674360267', '2008-10-31', '2021-02-11 05:49:45', '2021-02-11 05:49:45', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (8, 9, '患者_7', 'カンジャ_7', 'female', '+6519555666517', '2015-03-10', '2021-02-11 05:49:46', '2021-02-11 05:49:46', NULL, NULL, NULL, 'storage/patient/profile/1535282.jpg', 2000, NULL);
INSERT INTO `patients` VALUES (9, 10, '患者_8', 'カンジャ_8', 'male', '+3195663705895', '2006-06-12', '2021-02-11 05:49:47', '2021-02-11 05:49:47', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (10, 11, '患者_9', 'カンジャ_9', 'female', '+3533483234022', '2015-10-05', '2021-02-11 05:49:47', '2021-02-11 05:49:47', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (11, 12, '患者_10', 'カンジャ_10', 'male', '+5636711728957', '1985-06-19', '2021-02-11 05:49:48', '2021-02-11 05:49:48', NULL, NULL, NULL, 'storage/patient/profile/1535282.jpg', 2000, NULL);
INSERT INTO `patients` VALUES (12, 13, '患者_11', 'カンジャ_11', 'male', '+1970093483342', '1990-01-20', '2021-02-11 05:49:48', '2021-02-11 05:49:49', NULL, NULL, NULL, 'storage/patient/profile/1535282.jpg', 2000, NULL);
INSERT INTO `patients` VALUES (13, 14, '患者_12', 'カンジャ_12', 'female', '+8581498710762', '2014-02-27', '2021-02-11 05:49:49', '2021-02-11 05:49:49', NULL, NULL, NULL, 'storage/patient/profile/1535282.jpg', 2000, NULL);
INSERT INTO `patients` VALUES (14, 15, '患者_13', 'カンジャ_13', 'male', '+9902033628582', '1971-06-05', '2021-02-11 05:49:50', '2021-02-11 05:49:50', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (15, 16, '患者_14', 'カンジャ_14', 'female', '+5164067893192', '2018-09-27', '2021-02-11 05:49:50', '2021-02-11 05:49:50', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (16, 17, '患者_15', 'カンジャ_15', 'female', '+2211637818914', '2014-09-23', '2021-02-11 05:49:51', '2021-02-11 05:49:51', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (17, 18, '患者_16', 'カンジャ_16', 'male', '+9005110699925', '1990-07-26', '2021-02-11 05:49:52', '2021-02-11 05:49:52', NULL, NULL, NULL, 'storage/patient/profile/1535282.jpg', 2000, NULL);
INSERT INTO `patients` VALUES (18, 19, '患者_17', 'カンジャ_17', 'male', '+7955533342523', '2003-03-29', '2021-02-11 05:49:52', '2021-02-11 05:49:52', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (19, 20, '患者_18', 'カンジャ_18', 'male', '+8495165132280', '1988-08-23', '2021-02-11 05:49:53', '2021-02-11 05:49:53', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (20, 21, '患者_19', 'カンジャ_19', 'male', '+7632799053287', '2001-06-30', '2021-02-11 05:49:54', '2021-02-11 05:49:54', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (21, 22, '患者_20', 'カンジャ_20', 'male', '+5048457056520', '1972-05-05', '2021-02-11 05:49:55', '2021-02-11 05:49:55', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (22, 23, '患者_21', 'カンジャ_21', 'female', '+7897526239009', '1983-12-13', '2021-02-11 05:49:55', '2021-02-11 05:49:55', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (23, 24, '患者_22', 'カンジャ_22', 'male', '+9961910381968', '2002-06-05', '2021-02-11 05:49:56', '2021-02-11 05:49:56', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (24, 25, '患者_23', 'カンジャ_23', 'female', '+2591693952062', '1978-10-25', '2021-02-11 05:49:56', '2021-02-11 05:49:57', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (25, 26, '患者_24', 'カンジャ_24', 'male', '+8303021584565', '2011-06-26', '2021-02-11 05:49:58', '2021-02-11 05:49:58', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (26, 27, '患者_25', 'カンジャ_25', 'female', '+8433186705487', '2008-05-29', '2021-02-11 05:49:58', '2021-02-11 05:49:58', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (27, 28, '患者_26', 'カンジャ_26', 'female', '+4546379492988', '2016-03-20', '2021-02-11 05:49:59', '2021-02-11 05:49:59', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (28, 29, '患者_27', 'カンジャ_27', 'female', '+3496100968269', '2007-09-25', '2021-02-11 05:49:59', '2021-02-11 05:50:00', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (29, 30, '患者_28', 'カンジャ_28', 'female', '+7745014970831', '1994-08-11', '2021-02-11 05:50:00', '2021-02-11 05:50:00', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (30, 31, '患者_29', 'カンジャ_29', 'male', '+1256322464027', '1993-05-13', '2021-02-11 05:50:01', '2021-02-11 05:50:01', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (31, 32, '患者_30', 'カンジャ_30', 'female', '+6984623337010', '1990-10-04', '2021-02-11 05:50:01', '2021-02-11 05:50:02', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (32, 33, '患者_31', 'カンジャ_31', 'male', '+9873455104032', '1971-07-22', '2021-02-11 05:50:02', '2021-02-11 05:50:02', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (33, 34, '患者_32', 'カンジャ_32', 'male', '+2436711794667', '1983-10-19', '2021-02-11 05:50:03', '2021-02-11 05:50:03', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (34, 35, '患者_33', 'カンジャ_33', 'female', '+7411614628822', '1984-08-26', '2021-02-11 05:50:04', '2021-02-11 05:50:04', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (35, 36, '患者_34', 'カンジャ_34', 'male', '+9384066277201', '2008-02-25', '2021-02-11 05:50:05', '2021-02-11 05:50:05', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (36, 37, '患者_35', 'カンジャ_35', 'female', '+7834386582093', '2006-10-05', '2021-02-11 05:50:05', '2022-06-30 07:56:19', NULL, NULL, NULL, NULL, 2990, NULL);
INSERT INTO `patients` VALUES (37, 38, '患者_36', 'カンジャ_36', 'male', '+5021374456033', '1990-03-19', '2021-02-11 05:50:06', '2021-02-11 05:50:06', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (38, 39, '患者_37', 'カンジャ_37', 'female', '+1491464521800', '1995-02-05', '2021-02-11 05:50:07', '2021-02-11 05:50:07', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (39, 40, '患者_38', 'カンジャ_38', 'male', '+5502740207698', '2003-06-20', '2021-02-11 05:50:07', '2021-02-11 05:50:07', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (40, 41, '患者_39', 'カンジャ_39', 'female', '+6223945261858', '1989-07-01', '2021-02-11 05:50:08', '2021-02-11 05:50:08', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (41, 42, '患者_40', 'カンジャ_40', 'male', '+9992952785099', '2018-04-01', '2021-02-11 05:50:08', '2021-02-11 05:50:08', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (42, 43, '患者_41', 'カンジャ_41', 'male', '+6338114263011', '1979-10-19', '2021-02-11 05:50:09', '2021-02-11 05:50:09', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (43, 44, '患者_42', 'カンジャ_42', 'female', '+6638275445073', '1974-03-24', '2021-02-11 05:50:10', '2021-02-11 05:50:10', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (44, 45, '患者_43', 'カンジャ_43', 'female', '+4140504008938', '1973-06-24', '2021-02-11 05:50:10', '2022-07-04 11:17:44', NULL, NULL, NULL, NULL, 2050, NULL);
INSERT INTO `patients` VALUES (45, 46, '患者_44', 'カンジャ_44', 'female', '+4893280289848', '1977-01-28', '2021-02-11 05:50:11', '2022-07-04 11:17:26', NULL, NULL, NULL, NULL, 2050, NULL);
INSERT INTO `patients` VALUES (46, 47, '患者_45', 'カンジャ_45', 'female', '+3725088535064', '1989-08-29', '2021-02-11 05:50:12', '2021-02-11 05:50:12', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (47, 48, '患者_46', 'カンジャ_46', 'male', '+8102444007260', '2009-04-02', '2021-02-11 05:50:12', '2021-02-11 05:50:12', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (48, 49, '患者_47', 'カンジャ_47', 'female', '+9360183811143', '2012-01-22', '2021-02-11 05:50:13', '2021-02-11 05:50:13', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (49, 50, '患者_48', 'カンジャ_48', 'female', '+3253509910373', '1992-10-25', '2021-02-11 05:50:13', '2022-03-16 19:35:55', NULL, NULL, NULL, NULL, 2653, NULL);
INSERT INTO `patients` VALUES (50, 51, '患者_49', 'カンジャ_49', 'female', '+9587482719643', '2011-03-07', '2021-02-11 05:50:14', '2022-03-16 06:43:11', NULL, NULL, NULL, NULL, 2095, NULL);
INSERT INTO `patients` VALUES (51, 52, '患者_50', 'カンジャ_50', 'male', '+9082993412257', '1974-02-18', '2021-02-11 05:50:15', '2021-02-11 05:50:15', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (52, 72, NULL, NULL, NULL, NULL, NULL, '2022-03-20 18:18:52', '2022-03-20 18:18:52', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (53, 73, NULL, NULL, NULL, NULL, NULL, '2022-04-05 07:50:47', '2022-04-05 07:50:47', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (54, 74, NULL, NULL, NULL, NULL, NULL, '2022-04-18 13:21:08', '2022-04-18 13:21:08', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (55, 75, NULL, NULL, NULL, NULL, NULL, '2022-04-18 13:21:21', '2022-04-18 13:21:21', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (56, 76, NULL, NULL, NULL, NULL, NULL, '2022-04-22 03:28:48', '2022-04-22 03:28:48', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (57, 77, NULL, NULL, NULL, NULL, NULL, '2022-04-25 07:42:55', '2022-04-25 07:42:55', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (58, 78, NULL, NULL, NULL, NULL, NULL, '2022-04-25 12:07:06', '2022-04-25 12:07:06', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (59, 79, NULL, NULL, NULL, NULL, NULL, '2022-04-25 13:07:13', '2022-04-25 13:07:13', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (60, 80, NULL, NULL, NULL, NULL, NULL, '2022-04-27 07:40:45', '2022-04-27 07:40:45', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (61, 81, NULL, NULL, NULL, NULL, NULL, '2022-04-27 07:47:12', '2022-04-27 07:47:12', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (62, 82, NULL, NULL, NULL, NULL, NULL, '2022-04-30 14:51:01', '2022-04-30 14:51:01', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (63, 83, NULL, NULL, NULL, NULL, NULL, '2022-04-30 14:54:49', '2022-04-30 14:54:49', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (64, 84, NULL, NULL, NULL, NULL, NULL, '2022-05-02 08:18:33', '2022-05-02 08:18:33', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (65, 85, NULL, NULL, NULL, NULL, NULL, '2022-05-02 08:24:29', '2022-05-02 08:24:29', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (66, 86, NULL, NULL, NULL, NULL, NULL, '2022-05-17 13:28:59', '2022-05-17 13:28:59', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (67, 87, NULL, NULL, NULL, NULL, NULL, '2022-05-18 02:25:14', '2022-05-18 02:25:14', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (68, 88, NULL, NULL, NULL, NULL, NULL, '2022-05-20 05:48:01', '2022-05-20 05:48:01', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (69, 89, NULL, NULL, NULL, NULL, NULL, '2022-05-20 05:56:28', '2022-05-20 05:56:28', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (70, 90, NULL, 'k1k2', 'male', '123456890', '1994-11-14', '2022-05-20 14:03:17', '2022-07-04 13:14:10', NULL, NULL, NULL, NULL, 4807, NULL);
INSERT INTO `patients` VALUES (71, 91, NULL, NULL, NULL, NULL, NULL, '2022-05-24 08:30:22', '2022-05-24 08:30:22', NULL, NULL, NULL, NULL, 2000, NULL);
INSERT INTO `patients` VALUES (72, 92, NULL, NULL, NULL, NULL, NULL, '2022-05-28 09:09:56', '2022-05-28 09:09:56', NULL, NULL, NULL, NULL, 2000, NULL);

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `total_price` int(11) NULL DEFAULT NULL,
  `except_price` int(11) NULL DEFAULT NULL,
  `except_item` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `treat_price` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `payments_reservation_id_foreign`(`reservation_id`) USING BTREE,
  CONSTRAINT `payments_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payments
-- ----------------------------
INSERT INTO `payments` VALUES (1, 1, 10000, 1000, NULL, 9000, '2022-03-12 12:26:00', '2022-03-12 12:26:05');
INSERT INTO `payments` VALUES (2, 7, 10000, 1000, NULL, 9000, '2022-03-11 12:26:08', '2022-03-11 12:26:17');
INSERT INTO `payments` VALUES (3, 4, 10000, 1000, NULL, 9000, '2022-03-10 12:26:22', '2022-03-10 12:26:26');
INSERT INTO `payments` VALUES (4, 1, 10000, 1000, NULL, 9000, '2022-03-09 12:26:29', '2022-03-09 12:26:33');
INSERT INTO `payments` VALUES (5, 3, 10000, 1000, NULL, 9000, '2022-03-08 12:26:37', '2022-03-08 12:26:42');
INSERT INTO `payments` VALUES (6, 5, 10000, 1000, NULL, 9000, '2022-03-13 13:26:45', '2022-03-13 13:26:50');
INSERT INTO `payments` VALUES (7, 6, 111111, 222, NULL, 110889, '2022-03-13 21:50:43', '2022-03-13 21:50:43');
INSERT INTO `payments` VALUES (8, 36, 90000, 200, NULL, 89700, '2022-06-30 07:56:19', '2022-06-30 12:08:56');
INSERT INTO `payments` VALUES (9, 45, 1000, 500, NULL, 500, '2022-07-04 11:17:26', '2022-07-04 11:17:26');
INSERT INTO `payments` VALUES (10, 44, 1000, 500, NULL, 500, '2022-07-04 11:17:44', '2022-07-04 11:17:44');
INSERT INTO `payments` VALUES (11, 74, 1000, 12, NULL, 888, '2022-07-04 13:10:57', '2022-07-04 13:10:57');
INSERT INTO `payments` VALUES (12, 73, 45235, 2342, NULL, 42793, '2022-07-04 13:14:10', '2022-07-04 13:14:10');

-- ----------------------------
-- Table structure for point_histories
-- ----------------------------
DROP TABLE IF EXISTS `point_histories`;
CREATE TABLE `point_histories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `use_point` int(11) NOT NULL DEFAULT 0,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `point_histories_patient_id_foreign`(`patient_id`) USING BTREE,
  CONSTRAINT `point_histories_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 259 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of point_histories
-- ----------------------------
INSERT INTO `point_histories` VALUES (1, 1, 2000, NULL, '2021-02-11 01:50:01', '2021-02-11 01:50:01', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (2, 1, 0, NULL, '2021-02-11 01:50:01', '2021-02-11 01:50:01', 'reservation_requested', 1);
INSERT INTO `point_histories` VALUES (5, 3, 2000, NULL, '2021-02-11 01:50:03', '2021-02-11 01:50:03', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (6, 3, 0, NULL, '2021-02-11 01:50:03', '2021-02-11 01:50:03', 'reservation_requested', 3);
INSERT INTO `point_histories` VALUES (7, 4, 2000, NULL, '2021-02-11 01:50:03', '2021-02-11 01:50:03', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (8, 4, 0, NULL, '2021-02-11 01:50:04', '2021-02-11 01:50:04', 'reservation_requested', 4);
INSERT INTO `point_histories` VALUES (9, 5, 2000, NULL, '2021-02-11 01:50:04', '2021-02-11 01:50:04', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (10, 5, 0, NULL, '2021-02-11 01:50:05', '2021-02-11 01:50:05', 'reservation_requested', 5);
INSERT INTO `point_histories` VALUES (11, 6, 2000, NULL, '2021-02-11 01:50:05', '2021-02-11 01:50:05', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (12, 6, 0, NULL, '2021-02-11 01:50:05', '2021-02-11 01:50:05', 'reservation_requested', 6);
INSERT INTO `point_histories` VALUES (13, 7, 2000, NULL, '2021-02-11 01:50:05', '2021-02-11 01:50:05', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (14, 7, 0, NULL, '2021-02-11 01:50:06', '2021-02-11 01:50:06', 'reservation_requested', 7);
INSERT INTO `point_histories` VALUES (15, 8, 2000, NULL, '2021-02-11 01:50:06', '2021-02-11 01:50:06', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (16, 8, 0, NULL, '2021-02-11 01:50:06', '2021-02-11 01:50:06', 'reservation_requested', 8);
INSERT INTO `point_histories` VALUES (17, 9, 2000, NULL, '2021-02-11 01:50:07', '2021-02-11 01:50:07', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (18, 9, 0, NULL, '2021-02-11 01:50:07', '2021-02-11 01:50:07', 'reservation_requested', 9);
INSERT INTO `point_histories` VALUES (19, 10, 2000, NULL, '2021-02-11 01:50:07', '2021-02-11 01:50:07', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (20, 10, 0, NULL, '2021-02-11 01:50:08', '2021-02-11 01:50:08', 'reservation_requested', 10);
INSERT INTO `point_histories` VALUES (21, 11, 2000, NULL, '2021-02-11 01:50:08', '2021-02-11 01:50:08', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (22, 11, 0, NULL, '2021-02-11 01:50:08', '2021-02-11 01:50:08', 'reservation_requested', 11);
INSERT INTO `point_histories` VALUES (23, 12, 2000, NULL, '2021-02-11 01:50:09', '2021-02-11 01:50:09', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (24, 12, 0, NULL, '2021-02-11 01:50:09', '2021-02-11 01:50:09', 'reservation_requested', 12);
INSERT INTO `point_histories` VALUES (25, 13, 2000, NULL, '2021-02-11 01:50:10', '2021-02-11 01:50:10', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (26, 13, 0, NULL, '2021-02-11 01:50:10', '2021-02-11 01:50:10', 'reservation_requested', 13);
INSERT INTO `point_histories` VALUES (27, 14, 2000, NULL, '2021-02-11 01:50:10', '2021-02-11 01:50:10', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (28, 14, 0, NULL, '2021-02-11 01:50:10', '2021-02-11 01:50:10', 'reservation_requested', 14);
INSERT INTO `point_histories` VALUES (29, 15, 2000, NULL, '2021-02-11 01:50:11', '2021-02-11 01:50:11', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (30, 15, 0, NULL, '2021-02-11 01:50:11', '2021-02-11 01:50:11', 'reservation_requested', 15);
INSERT INTO `point_histories` VALUES (31, 16, 2000, NULL, '2021-02-11 01:50:11', '2021-02-11 01:50:11', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (32, 16, 0, NULL, '2021-02-11 01:50:11', '2021-02-11 01:50:11', 'reservation_requested', 16);
INSERT INTO `point_histories` VALUES (33, 17, 2000, NULL, '2021-02-11 01:50:11', '2021-02-11 01:50:11', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (34, 17, 0, NULL, '2021-02-11 01:50:12', '2021-02-11 01:50:12', 'reservation_requested', 17);
INSERT INTO `point_histories` VALUES (35, 18, 2000, NULL, '2021-02-11 01:50:12', '2021-02-11 01:50:12', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (36, 18, 0, NULL, '2021-02-11 01:50:12', '2021-02-11 01:50:12', 'reservation_requested', 18);
INSERT INTO `point_histories` VALUES (37, 19, 2000, NULL, '2021-02-11 01:50:13', '2021-02-11 01:50:13', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (38, 19, 0, NULL, '2021-02-11 01:50:13', '2021-02-11 01:50:13', 'reservation_requested', 19);
INSERT INTO `point_histories` VALUES (39, 20, 2000, NULL, '2021-02-11 01:50:13', '2021-02-11 01:50:13', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (40, 20, 0, NULL, '2021-02-11 01:50:14', '2021-02-11 01:50:14', 'reservation_requested', 20);
INSERT INTO `point_histories` VALUES (41, 21, 2000, NULL, '2021-02-11 01:50:14', '2021-02-11 01:50:14', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (42, 21, 0, NULL, '2021-02-11 01:50:14', '2021-02-11 01:50:14', 'reservation_requested', 21);
INSERT INTO `point_histories` VALUES (43, 22, 2000, NULL, '2021-02-11 01:50:14', '2021-02-11 01:50:14', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (44, 22, 0, NULL, '2021-02-11 01:50:15', '2021-02-11 01:50:15', 'reservation_requested', 22);
INSERT INTO `point_histories` VALUES (45, 23, 2000, NULL, '2021-02-11 01:50:15', '2021-02-11 01:50:15', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (46, 23, 0, NULL, '2021-02-11 01:50:15', '2021-02-11 01:50:15', 'reservation_requested', 23);
INSERT INTO `point_histories` VALUES (47, 24, 2000, NULL, '2021-02-11 01:50:16', '2021-02-11 01:50:16', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (48, 24, 0, NULL, '2021-02-11 01:50:16', '2021-02-11 01:50:16', 'reservation_requested', 24);
INSERT INTO `point_histories` VALUES (49, 25, 2000, NULL, '2021-02-11 01:50:16', '2021-02-11 01:50:16', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (50, 25, 0, NULL, '2021-02-11 01:50:16', '2021-02-11 01:50:16', 'reservation_requested', 25);
INSERT INTO `point_histories` VALUES (51, 26, 2000, NULL, '2021-02-11 01:50:17', '2021-02-11 01:50:17', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (52, 26, 0, NULL, '2021-02-11 01:50:17', '2021-02-11 01:50:17', 'reservation_requested', 26);
INSERT INTO `point_histories` VALUES (53, 27, 2000, NULL, '2021-02-11 01:50:17', '2021-02-11 01:50:17', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (54, 27, 0, NULL, '2021-02-11 01:50:17', '2021-02-11 01:50:17', 'reservation_requested', 27);
INSERT INTO `point_histories` VALUES (55, 28, 2000, NULL, '2021-02-11 01:50:18', '2021-02-11 01:50:18', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (56, 28, 0, NULL, '2021-02-11 01:50:18', '2021-02-11 01:50:18', 'reservation_requested', 28);
INSERT INTO `point_histories` VALUES (57, 29, 2000, NULL, '2021-02-11 01:50:19', '2021-02-11 01:50:19', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (58, 29, 0, NULL, '2021-02-11 01:50:19', '2021-02-11 01:50:19', 'reservation_requested', 29);
INSERT INTO `point_histories` VALUES (59, 30, 2000, NULL, '2021-02-11 01:50:19', '2021-02-11 01:50:19', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (60, 30, 0, NULL, '2021-02-11 01:50:20', '2021-02-11 01:50:20', 'reservation_requested', 30);
INSERT INTO `point_histories` VALUES (61, 31, 2000, NULL, '2021-02-11 01:50:20', '2021-02-11 01:50:20', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (62, 31, 0, NULL, '2021-02-11 01:50:20', '2021-02-11 01:50:20', 'reservation_requested', 31);
INSERT INTO `point_histories` VALUES (63, 32, 2000, NULL, '2021-02-11 01:50:21', '2021-02-11 01:50:21', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (64, 32, 0, NULL, '2021-02-11 01:50:21', '2021-02-11 01:50:21', 'reservation_requested', 32);
INSERT INTO `point_histories` VALUES (65, 33, 2000, NULL, '2021-02-11 01:50:21', '2021-02-11 01:50:21', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (66, 33, 0, NULL, '2021-02-11 01:50:22', '2021-02-11 01:50:22', 'reservation_requested', 33);
INSERT INTO `point_histories` VALUES (67, 34, 2000, NULL, '2021-02-11 01:50:22', '2021-02-11 01:50:22', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (68, 34, 0, NULL, '2021-02-11 01:50:22', '2021-02-11 01:50:22', 'reservation_requested', 34);
INSERT INTO `point_histories` VALUES (69, 35, 2000, NULL, '2021-02-11 01:50:23', '2021-02-11 01:50:23', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (70, 35, 0, NULL, '2021-02-11 01:50:23', '2021-02-11 01:50:23', 'reservation_requested', 35);
INSERT INTO `point_histories` VALUES (71, 36, 2000, NULL, '2021-02-11 01:50:23', '2021-02-11 01:50:23', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (72, 36, 0, NULL, '2021-02-11 01:50:24', '2021-02-11 01:50:24', 'reservation_requested', 36);
INSERT INTO `point_histories` VALUES (73, 37, 2000, NULL, '2021-02-11 01:50:24', '2021-02-11 01:50:24', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (74, 37, 0, NULL, '2021-02-11 01:50:24', '2021-02-11 01:50:24', 'reservation_requested', 37);
INSERT INTO `point_histories` VALUES (75, 38, 2000, NULL, '2021-02-11 01:50:25', '2021-02-11 01:50:25', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (76, 38, 0, NULL, '2021-02-11 01:50:25', '2021-02-11 01:50:25', 'reservation_requested', 38);
INSERT INTO `point_histories` VALUES (77, 39, 2000, NULL, '2021-02-11 01:50:25', '2021-02-11 01:50:25', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (78, 39, 0, NULL, '2021-02-11 01:50:25', '2021-02-11 01:50:25', 'reservation_requested', 39);
INSERT INTO `point_histories` VALUES (79, 40, 2000, NULL, '2021-02-11 01:50:26', '2021-02-11 01:50:26', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (80, 40, 0, NULL, '2021-02-11 01:50:26', '2021-02-11 01:50:26', 'reservation_requested', 40);
INSERT INTO `point_histories` VALUES (81, 41, 2000, NULL, '2021-02-11 01:50:27', '2021-02-11 01:50:27', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (82, 41, 0, NULL, '2021-02-11 01:50:27', '2021-02-11 01:50:27', 'reservation_requested', 41);
INSERT INTO `point_histories` VALUES (83, 42, 2000, NULL, '2021-02-11 01:50:27', '2021-02-11 01:50:27', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (84, 42, 0, NULL, '2021-02-11 01:50:27', '2021-02-11 01:50:27', 'reservation_requested', 42);
INSERT INTO `point_histories` VALUES (85, 43, 2000, NULL, '2021-02-11 01:50:28', '2021-02-11 01:50:28', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (86, 43, 0, NULL, '2021-02-11 01:50:28', '2021-02-11 01:50:28', 'reservation_requested', 43);
INSERT INTO `point_histories` VALUES (87, 44, 2000, NULL, '2021-02-11 01:50:28', '2021-02-11 01:50:28', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (88, 44, 0, NULL, '2021-02-11 01:50:29', '2021-02-11 01:50:29', 'reservation_requested', 44);
INSERT INTO `point_histories` VALUES (89, 45, 2000, NULL, '2021-02-11 01:50:29', '2021-02-11 01:50:29', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (90, 45, 0, NULL, '2021-02-11 01:50:29', '2021-02-11 01:50:29', 'reservation_requested', 45);
INSERT INTO `point_histories` VALUES (91, 46, 2000, NULL, '2021-02-11 01:50:29', '2021-02-11 01:50:29', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (92, 46, 0, NULL, '2021-02-11 01:50:30', '2021-02-11 01:50:30', 'reservation_requested', 46);
INSERT INTO `point_histories` VALUES (93, 47, 2000, NULL, '2021-02-11 01:50:30', '2021-02-11 01:50:30', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (94, 47, 0, NULL, '2021-02-11 01:50:30', '2021-02-11 01:50:30', 'reservation_requested', 47);
INSERT INTO `point_histories` VALUES (95, 48, 2000, NULL, '2021-02-11 01:50:31', '2021-02-11 01:50:31', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (96, 48, 0, NULL, '2021-02-11 01:50:31', '2021-02-11 01:50:31', 'reservation_requested', 48);
INSERT INTO `point_histories` VALUES (97, 49, 2000, NULL, '2021-02-11 01:50:31', '2021-02-11 01:50:31', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (98, 49, 0, NULL, '2021-02-11 01:50:31', '2021-02-11 01:50:31', 'reservation_requested', 49);
INSERT INTO `point_histories` VALUES (99, 50, 2000, NULL, '2021-02-11 01:50:32', '2021-02-11 01:50:32', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (100, 50, 0, NULL, '2021-02-11 01:50:32', '2021-02-11 01:50:32', 'reservation_requested', 50);
INSERT INTO `point_histories` VALUES (101, 51, 2000, NULL, '2021-02-11 01:50:33', '2021-02-11 01:50:33', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (102, 51, 0, NULL, '2021-02-11 01:50:33', '2021-02-11 01:50:33', 'reservation_requested', 51);
INSERT INTO `point_histories` VALUES (103, 1, 2000, NULL, '2021-02-11 05:49:41', '2021-02-11 05:49:41', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (104, 1, 0, NULL, '2021-02-11 05:49:41', '2021-02-11 05:49:41', 'reservation_requested', 1);
INSERT INTO `point_histories` VALUES (107, 3, 2000, NULL, '2021-02-11 05:49:42', '2021-02-11 05:49:42', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (108, 3, 0, NULL, '2021-02-11 05:49:43', '2021-02-11 05:49:43', 'reservation_requested', 3);
INSERT INTO `point_histories` VALUES (109, 4, 2000, NULL, '2021-02-11 05:49:43', '2021-02-11 05:49:43', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (110, 4, 0, NULL, '2021-02-11 05:49:43', '2021-02-11 05:49:43', 'reservation_requested', 4);
INSERT INTO `point_histories` VALUES (111, 5, 2000, NULL, '2021-02-11 05:49:44', '2021-02-11 05:49:44', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (112, 5, 0, NULL, '2021-02-11 05:49:44', '2021-02-11 05:49:44', 'reservation_requested', 5);
INSERT INTO `point_histories` VALUES (113, 6, 2000, NULL, '2021-02-11 05:49:45', '2021-02-11 05:49:45', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (114, 6, 0, NULL, '2021-02-11 05:49:45', '2021-02-11 05:49:45', 'reservation_requested', 6);
INSERT INTO `point_histories` VALUES (115, 7, 2000, NULL, '2021-02-11 05:49:45', '2021-02-11 05:49:45', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (116, 7, 0, NULL, '2021-02-11 05:49:46', '2021-02-11 05:49:46', 'reservation_requested', 7);
INSERT INTO `point_histories` VALUES (117, 8, 2000, NULL, '2021-02-11 05:49:46', '2021-02-11 05:49:46', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (118, 8, 0, NULL, '2021-02-11 05:49:47', '2021-02-11 05:49:47', 'reservation_requested', 8);
INSERT INTO `point_histories` VALUES (119, 9, 2000, NULL, '2021-02-11 05:49:47', '2021-02-11 05:49:47', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (120, 9, 0, NULL, '2021-02-11 05:49:47', '2021-02-11 05:49:47', 'reservation_requested', 9);
INSERT INTO `point_histories` VALUES (121, 10, 2000, NULL, '2021-02-11 05:49:47', '2021-02-11 05:49:47', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (122, 10, 0, NULL, '2021-02-11 05:49:48', '2021-02-11 05:49:48', 'reservation_requested', 10);
INSERT INTO `point_histories` VALUES (123, 11, 2000, NULL, '2021-02-11 05:49:48', '2021-02-11 05:49:48', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (124, 11, 0, NULL, '2021-02-11 05:49:48', '2021-02-11 05:49:48', 'reservation_requested', 11);
INSERT INTO `point_histories` VALUES (125, 12, 2000, NULL, '2021-02-11 05:49:49', '2021-02-11 05:49:49', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (126, 12, 0, NULL, '2021-02-11 05:49:49', '2021-02-11 05:49:49', 'reservation_requested', 12);
INSERT INTO `point_histories` VALUES (127, 13, 2000, NULL, '2021-02-11 05:49:49', '2021-02-11 05:49:49', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (128, 13, 0, NULL, '2021-02-11 05:49:50', '2021-02-11 05:49:50', 'reservation_requested', 13);
INSERT INTO `point_histories` VALUES (129, 14, 2000, NULL, '2021-02-11 05:49:50', '2021-02-11 05:49:50', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (130, 14, 0, NULL, '2021-02-11 05:49:50', '2021-02-11 05:49:50', 'reservation_requested', 14);
INSERT INTO `point_histories` VALUES (131, 15, 2000, NULL, '2021-02-11 05:49:50', '2021-02-11 05:49:50', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (132, 15, 0, NULL, '2021-02-11 05:49:51', '2021-02-11 05:49:51', 'reservation_requested', 15);
INSERT INTO `point_histories` VALUES (133, 16, 2000, NULL, '2021-02-11 05:49:51', '2021-02-11 05:49:51', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (134, 16, 0, NULL, '2021-02-11 05:49:51', '2021-02-11 05:49:51', 'reservation_requested', 16);
INSERT INTO `point_histories` VALUES (135, 17, 2000, NULL, '2021-02-11 05:49:52', '2021-02-11 05:49:52', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (136, 17, 0, NULL, '2021-02-11 05:49:52', '2021-02-11 05:49:52', 'reservation_requested', 17);
INSERT INTO `point_histories` VALUES (137, 18, 2000, NULL, '2021-02-11 05:49:52', '2021-02-11 05:49:52', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (138, 18, 0, NULL, '2021-02-11 05:49:53', '2021-02-11 05:49:53', 'reservation_requested', 18);
INSERT INTO `point_histories` VALUES (139, 19, 2000, NULL, '2021-02-11 05:49:53', '2021-02-11 05:49:53', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (140, 19, 0, NULL, '2021-02-11 05:49:54', '2021-02-11 05:49:54', 'reservation_requested', 19);
INSERT INTO `point_histories` VALUES (141, 20, 2000, NULL, '2021-02-11 05:49:54', '2021-02-11 05:49:54', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (142, 20, 0, NULL, '2021-02-11 05:49:54', '2021-02-11 05:49:54', 'reservation_requested', 20);
INSERT INTO `point_histories` VALUES (143, 21, 2000, NULL, '2021-02-11 05:49:55', '2021-02-11 05:49:55', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (144, 21, 0, NULL, '2021-02-11 05:49:55', '2021-02-11 05:49:55', 'reservation_requested', 21);
INSERT INTO `point_histories` VALUES (145, 22, 2000, NULL, '2021-02-11 05:49:55', '2021-02-11 05:49:55', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (146, 22, 0, NULL, '2021-02-11 05:49:56', '2021-02-11 05:49:56', 'reservation_requested', 22);
INSERT INTO `point_histories` VALUES (147, 23, 2000, NULL, '2021-02-11 05:49:56', '2021-02-11 05:49:56', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (148, 23, 0, NULL, '2021-02-11 05:49:56', '2021-02-11 05:49:56', 'reservation_requested', 23);
INSERT INTO `point_histories` VALUES (149, 24, 2000, NULL, '2021-02-11 05:49:57', '2021-02-11 05:49:57', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (150, 24, 0, NULL, '2021-02-11 05:49:57', '2021-02-11 05:49:57', 'reservation_requested', 24);
INSERT INTO `point_histories` VALUES (151, 25, 2000, NULL, '2021-02-11 05:49:58', '2021-02-11 05:49:58', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (152, 25, 0, NULL, '2021-02-11 05:49:58', '2021-02-11 05:49:58', 'reservation_requested', 25);
INSERT INTO `point_histories` VALUES (153, 26, 2000, NULL, '2021-02-11 05:49:58', '2021-02-11 05:49:58', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (154, 26, 0, NULL, '2021-02-11 05:49:58', '2021-02-11 05:49:58', 'reservation_requested', 26);
INSERT INTO `point_histories` VALUES (155, 27, 2000, NULL, '2021-02-11 05:49:59', '2021-02-11 05:49:59', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (156, 27, 0, NULL, '2021-02-11 05:49:59', '2021-02-11 05:49:59', 'reservation_requested', 27);
INSERT INTO `point_histories` VALUES (157, 28, 2000, NULL, '2021-02-11 05:49:59', '2021-02-11 05:49:59', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (158, 28, 0, NULL, '2021-02-11 05:50:00', '2021-02-11 05:50:00', 'reservation_requested', 28);
INSERT INTO `point_histories` VALUES (159, 29, 2000, NULL, '2021-02-11 05:50:00', '2021-02-11 05:50:00', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (160, 29, 0, NULL, '2021-02-11 05:50:00', '2021-02-11 05:50:00', 'reservation_requested', 29);
INSERT INTO `point_histories` VALUES (161, 30, 2000, NULL, '2021-02-11 05:50:01', '2021-02-11 05:50:01', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (162, 30, 0, NULL, '2021-02-11 05:50:01', '2021-02-11 05:50:01', 'reservation_requested', 30);
INSERT INTO `point_histories` VALUES (163, 31, 2000, NULL, '2021-02-11 05:50:01', '2021-02-11 05:50:01', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (164, 31, 0, NULL, '2021-02-11 05:50:02', '2021-02-11 05:50:02', 'reservation_requested', 31);
INSERT INTO `point_histories` VALUES (165, 32, 2000, NULL, '2021-02-11 05:50:02', '2021-02-11 05:50:02', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (166, 32, 0, NULL, '2021-02-11 05:50:02', '2021-02-11 05:50:02', 'reservation_requested', 32);
INSERT INTO `point_histories` VALUES (167, 33, 2000, NULL, '2021-02-11 05:50:03', '2021-02-11 05:50:03', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (168, 33, 0, NULL, '2021-02-11 05:50:03', '2021-02-11 05:50:03', 'reservation_requested', 33);
INSERT INTO `point_histories` VALUES (169, 34, 2000, NULL, '2021-02-11 05:50:04', '2021-02-11 05:50:04', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (170, 34, 0, NULL, '2021-02-11 05:50:04', '2021-02-11 05:50:04', 'reservation_requested', 34);
INSERT INTO `point_histories` VALUES (171, 35, 2000, NULL, '2021-02-11 05:50:05', '2021-02-11 05:50:05', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (172, 35, 0, NULL, '2021-02-11 05:50:05', '2021-02-11 05:50:05', 'reservation_requested', 35);
INSERT INTO `point_histories` VALUES (173, 36, 2000, NULL, '2021-02-11 05:50:05', '2021-02-11 05:50:05', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (174, 36, 0, NULL, '2021-02-11 05:50:06', '2021-02-11 05:50:06', 'reservation_requested', 36);
INSERT INTO `point_histories` VALUES (175, 37, 2000, NULL, '2021-02-11 05:50:06', '2021-02-11 05:50:06', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (176, 37, 0, NULL, '2021-02-11 05:50:06', '2021-02-11 05:50:06', 'reservation_requested', 37);
INSERT INTO `point_histories` VALUES (177, 38, 2000, NULL, '2021-02-11 05:50:07', '2021-02-11 05:50:07', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (178, 38, 0, NULL, '2021-02-11 05:50:07', '2021-02-11 05:50:07', 'reservation_requested', 38);
INSERT INTO `point_histories` VALUES (179, 39, 2000, NULL, '2021-02-11 05:50:07', '2021-02-11 05:50:07', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (180, 39, 0, NULL, '2021-02-11 05:50:07', '2021-02-11 05:50:07', 'reservation_requested', 39);
INSERT INTO `point_histories` VALUES (181, 40, 2000, NULL, '2021-02-11 05:50:08', '2021-02-11 05:50:08', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (182, 40, 0, NULL, '2021-02-11 05:50:08', '2021-02-11 05:50:08', 'reservation_requested', 40);
INSERT INTO `point_histories` VALUES (183, 41, 2000, NULL, '2021-02-11 05:50:08', '2021-02-11 05:50:08', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (184, 41, 0, NULL, '2021-02-11 05:50:09', '2021-02-11 05:50:09', 'reservation_requested', 41);
INSERT INTO `point_histories` VALUES (185, 42, 2000, NULL, '2021-02-11 05:50:09', '2021-02-11 05:50:09', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (186, 42, 0, NULL, '2021-02-11 05:50:09', '2021-02-11 05:50:09', 'reservation_requested', 42);
INSERT INTO `point_histories` VALUES (187, 43, 2000, NULL, '2021-02-11 05:50:10', '2021-02-11 05:50:10', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (188, 43, 0, NULL, '2021-02-11 05:50:10', '2021-02-11 05:50:10', 'reservation_requested', 43);
INSERT INTO `point_histories` VALUES (189, 44, 2000, NULL, '2021-02-11 05:50:10', '2021-02-11 05:50:10', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (190, 44, 0, NULL, '2021-02-11 05:50:11', '2021-02-11 05:50:11', 'reservation_requested', 44);
INSERT INTO `point_histories` VALUES (191, 45, 2000, NULL, '2021-02-11 05:50:11', '2021-02-11 05:50:11', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (192, 45, 0, NULL, '2021-02-11 05:50:11', '2021-02-11 05:50:11', 'reservation_requested', 45);
INSERT INTO `point_histories` VALUES (193, 46, 2000, NULL, '2021-02-11 05:50:12', '2021-02-11 05:50:12', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (194, 46, 0, NULL, '2021-02-11 05:50:12', '2021-02-11 05:50:12', 'reservation_requested', 46);
INSERT INTO `point_histories` VALUES (195, 47, 2000, NULL, '2021-02-11 05:50:12', '2021-02-11 05:50:12', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (196, 47, 0, NULL, '2021-02-11 05:50:13', '2021-02-11 05:50:13', 'reservation_requested', 47);
INSERT INTO `point_histories` VALUES (197, 48, 2000, NULL, '2021-02-11 05:50:13', '2021-02-11 05:50:13', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (198, 48, 0, NULL, '2021-02-11 05:50:13', '2021-02-11 05:50:13', 'reservation_requested', 48);
INSERT INTO `point_histories` VALUES (199, 49, 2000, NULL, '2021-02-11 05:50:13', '2021-02-11 05:50:13', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (200, 49, 0, NULL, '2021-02-11 05:50:14', '2021-02-11 05:50:14', 'reservation_requested', 49);
INSERT INTO `point_histories` VALUES (201, 50, 2000, NULL, '2021-02-11 05:50:14', '2021-02-11 05:50:14', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (202, 50, 0, NULL, '2021-02-11 05:50:15', '2021-02-11 05:50:15', 'reservation_requested', 50);
INSERT INTO `point_histories` VALUES (203, 51, 2000, NULL, '2021-02-11 05:50:15', '2021-02-11 05:50:15', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (204, 51, 0, NULL, '2021-02-11 05:50:15', '2021-02-11 05:50:15', 'reservation_requested', 51);
INSERT INTO `point_histories` VALUES (205, 6, 11088, NULL, '2022-03-13 21:50:43', '2022-03-13 21:50:43', 'reservation_finished', 6);
INSERT INTO `point_histories` VALUES (206, 50, 95, NULL, '2022-03-16 06:43:11', '2022-03-16 06:43:11', 'reservation_finished', 50);
INSERT INTO `point_histories` VALUES (207, 49, 653, NULL, '2022-03-16 19:35:55', '2022-03-16 19:35:55', 'reservation_finished', 49);
INSERT INTO `point_histories` VALUES (208, 52, 2000, NULL, '2022-03-20 18:18:52', '2022-03-20 18:18:52', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (210, 53, 2000, NULL, '2022-04-05 07:50:47', '2022-04-05 07:50:47', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (212, 54, 2000, NULL, '2022-04-18 13:21:08', '2022-04-18 13:21:08', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (213, 55, 2000, NULL, '2022-04-18 13:21:21', '2022-04-18 13:21:21', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (222, 56, 2000, NULL, '2022-04-22 03:28:48', '2022-04-22 03:28:48', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (230, 57, 2000, NULL, '2022-04-25 07:42:55', '2022-04-25 07:42:55', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (231, 58, 2000, NULL, '2022-04-25 12:07:06', '2022-04-25 12:07:06', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (232, 59, 2000, NULL, '2022-04-25 13:07:13', '2022-04-25 13:07:13', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (233, 60, 2000, NULL, '2022-04-27 07:40:45', '2022-04-27 07:40:45', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (234, 61, 2000, NULL, '2022-04-27 07:47:12', '2022-04-27 07:47:12', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (236, 62, 2000, NULL, '2022-04-30 14:51:01', '2022-04-30 14:51:01', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (237, 63, 2000, NULL, '2022-04-30 14:54:49', '2022-04-30 14:54:49', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (238, 64, 2000, NULL, '2022-05-02 08:18:33', '2022-05-02 08:18:33', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (239, 65, 2000, NULL, '2022-05-02 08:24:29', '2022-05-02 08:24:29', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (241, 66, 2000, NULL, '2022-05-17 13:28:59', '2022-05-17 13:28:59', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (242, 67, 2000, NULL, '2022-05-18 02:25:14', '2022-05-18 02:25:14', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (243, 68, 2000, NULL, '2022-05-20 05:48:01', '2022-05-20 05:48:01', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (244, 69, 2000, NULL, '2022-05-20 05:56:28', '2022-05-20 05:56:28', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (245, 70, 2000, NULL, '2022-05-20 14:03:17', '2022-05-20 14:03:17', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (246, 70, -120, NULL, '2022-05-24 08:18:02', '2022-05-24 08:18:02', 'reservation_requested', 69);
INSERT INTO `point_histories` VALUES (247, 70, -120, NULL, '2022-05-24 08:18:02', '2022-05-24 08:18:02', 'reservation_requested', 70);
INSERT INTO `point_histories` VALUES (248, 70, -120, NULL, '2022-05-24 08:19:49', '2022-05-24 08:19:49', 'reservation_requested', 71);
INSERT INTO `point_histories` VALUES (249, 71, 2000, NULL, '2022-05-24 08:30:22', '2022-05-24 08:30:22', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (250, 70, -1000, NULL, '2022-05-28 06:26:06', '2022-05-28 06:26:06', 'reservation_requested', 72);
INSERT INTO `point_histories` VALUES (251, 72, 2000, NULL, '2022-05-28 09:09:56', '2022-05-28 09:09:56', 'user_new_registered', NULL);
INSERT INTO `point_histories` VALUES (252, 36, 990, NULL, '2022-06-30 07:56:19', '2022-06-30 07:56:19', 'reservation_finished', 36);
INSERT INTO `point_histories` VALUES (253, 70, -100, NULL, '2022-06-30 09:40:49', '2022-06-30 09:40:49', 'reservation_requested', 73);
INSERT INTO `point_histories` VALUES (254, 70, -100, NULL, '2022-06-30 12:11:46', '2022-06-30 12:11:46', 'reservation_requested', 74);
INSERT INTO `point_histories` VALUES (255, 45, 50, NULL, '2022-07-04 11:17:26', '2022-07-04 11:17:26', 'reservation_finished', 45);
INSERT INTO `point_histories` VALUES (256, 44, 50, NULL, '2022-07-04 11:17:44', '2022-07-04 11:17:44', 'reservation_finished', 44);
INSERT INTO `point_histories` VALUES (257, 70, 88, NULL, '2022-07-04 13:10:57', '2022-07-04 13:10:57', 'reservation_finished', 74);
INSERT INTO `point_histories` VALUES (258, 70, 4279, NULL, '2022-07-04 13:14:10', '2022-07-04 13:14:10', 'reservation_finished', 73);

-- ----------------------------
-- Table structure for question_categories
-- ----------------------------
DROP TABLE IF EXISTS `question_categories`;
CREATE TABLE `question_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `category_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `question_categories_question_id_foreign`(`question_id`) USING BTREE,
  INDEX `question_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `question_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `question_categories_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question_categories
-- ----------------------------
INSERT INTO `question_categories` VALUES (1, 9, 37, '2021-07-29 07:36:09', '2021-07-29 07:36:09');

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL COMMENT '患者ID',
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `questions_patient_id_foreign`(`patient_id`) USING BTREE,
  CONSTRAINT `questions_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES (1, 17, '2この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:55:26', '2021-08-12 02:55:26');
INSERT INTO `questions` VALUES (2, 17, '2この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:55:43', '2021-08-12 02:55:43');
INSERT INTO `questions` VALUES (3, 17, '3この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:55:52', '2021-08-12 02:55:52');
INSERT INTO `questions` VALUES (4, 17, '4この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:56:05', '2021-08-12 02:56:05');
INSERT INTO `questions` VALUES (5, 17, '5この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:56:16', '2021-08-12 02:56:16');
INSERT INTO `questions` VALUES (6, 17, '6この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:56:30', '2021-08-12 02:56:30');
INSERT INTO `questions` VALUES (7, 17, '7この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:56:38', '2021-08-12 02:56:38');
INSERT INTO `questions` VALUES (8, 17, '8この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:56:45', '2021-08-12 02:56:45');
INSERT INTO `questions` VALUES (9, 17, '9この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:56:54', '2021-08-12 02:56:54');
INSERT INTO `questions` VALUES (10, 17, '10この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:57:05', '2021-08-12 02:57:05');
INSERT INTO `questions` VALUES (11, 17, '11この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:57:14', '2021-08-12 02:57:14');
INSERT INTO `questions` VALUES (12, 17, '12この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？この鼻はどのような整形がベストですか？', '4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでどうなんでしょうか。...', '2021-08-12 02:57:24', '2021-08-12 02:57:24');

-- ----------------------------
-- Table structure for recent_search
-- ----------------------------
DROP TABLE IF EXISTS `recent_search`;
CREATE TABLE `recent_search`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `search_id` bigint(20) NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `follows_patient_id_foreign`(`search_id`) USING BTREE,
  INDEX `follows_follow_id_foreign`(`patient_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recent_search
-- ----------------------------
INSERT INTO `recent_search` VALUES (3, 1, 70, '2022-06-22 18:38:19', '2022-06-22 18:38:23');
INSERT INTO `recent_search` VALUES (4, 1, 70, '2022-06-22 18:57:06', '2022-06-22 18:57:12');
INSERT INTO `recent_search` VALUES (5, 7, 70, '2022-06-23 03:34:32', '2022-06-23 05:32:55');

-- ----------------------------
-- Table structure for reservation_categories
-- ----------------------------
DROP TABLE IF EXISTS `reservation_categories`;
CREATE TABLE `reservation_categories`  (
  `reservation_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL,
  INDEX `reservation_categories_reservation_id_foreign`(`reservation_id`) USING BTREE,
  INDEX `reservation_categories_category_id_foreign`(`category_id`) USING BTREE,
  CONSTRAINT `reservation_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `mtb_interest_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reservation_categories_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reservations
-- ----------------------------
DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_date` date NULL DEFAULT NULL COMMENT '来院日時',
  `start_time` time(0) NULL DEFAULT NULL COMMENT '診察時間',
  `end_time` time(0) NULL DEFAULT NULL COMMENT '診察時間',
  `clinic_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `patient_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `doctor_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT 5 COMMENT '予約方法',
  `status` smallint(6) NULL DEFAULT NULL COMMENT 'ステータス',
  `hope_treat` smallint(6) NULL DEFAULT NULL COMMENT '当日は施術を希望されますか？',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '希望・相談',
  `use_point` int(11) NOT NULL DEFAULT 0 COMMENT '使用ポイント',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reservations_clinic_id_foreign`(`clinic_id`) USING BTREE,
  INDEX `reservations_patient_info_id_foreign`(`patient_id`) USING BTREE,
  INDEX `reservations_stuff_id_foreign`(`doctor_id`) USING BTREE,
  CONSTRAINT `reservations_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservations
-- ----------------------------
INSERT INTO `reservations` VALUES (1, '2022-03-08', '21:28:27', '23:28:41', 1, 1, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `reservations` VALUES (3, '2022-03-09', '19:29:31', '23:29:37', 1, 3, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `reservations` VALUES (4, '2022-03-10', '08:30:19', '15:30:29', 1, 4, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `reservations` VALUES (5, '2022-03-11', '07:30:35', '21:30:45', 1, 5, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `reservations` VALUES (6, '2022-03-11', '11:30:50', '21:30:56', 1, 6, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `reservations` VALUES (7, '2022-03-11', '09:31:02', '23:31:09', 1, 7, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `reservations` VALUES (8, NULL, NULL, NULL, 1, 8, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `reservations` VALUES (9, NULL, NULL, NULL, 1, 9, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `reservations` VALUES (10, NULL, NULL, NULL, 1, 10, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `reservations` VALUES (11, NULL, NULL, NULL, 1, 11, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `reservations` VALUES (12, NULL, NULL, NULL, 1, 12, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `reservations` VALUES (13, NULL, NULL, NULL, 1, 13, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `reservations` VALUES (14, NULL, NULL, NULL, 1, 14, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `reservations` VALUES (15, NULL, NULL, NULL, 1, 15, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `reservations` VALUES (16, NULL, NULL, NULL, 1, 16, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `reservations` VALUES (17, NULL, NULL, NULL, 1, 17, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `reservations` VALUES (18, NULL, NULL, NULL, 1, 18, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `reservations` VALUES (19, NULL, NULL, NULL, 1, 19, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `reservations` VALUES (20, NULL, NULL, NULL, 1, 20, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `reservations` VALUES (21, NULL, NULL, NULL, 1, 21, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `reservations` VALUES (22, NULL, NULL, NULL, 1, 22, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `reservations` VALUES (23, NULL, NULL, NULL, 1, 23, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `reservations` VALUES (24, NULL, NULL, NULL, 1, 24, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `reservations` VALUES (25, NULL, NULL, NULL, 1, 25, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `reservations` VALUES (26, NULL, NULL, NULL, 1, 26, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `reservations` VALUES (27, NULL, NULL, NULL, 1, 27, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `reservations` VALUES (28, NULL, NULL, NULL, 1, 28, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `reservations` VALUES (29, NULL, NULL, NULL, 1, 29, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `reservations` VALUES (30, NULL, NULL, NULL, 1, 30, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `reservations` VALUES (31, NULL, NULL, NULL, 1, 31, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `reservations` VALUES (32, NULL, NULL, NULL, 1, 32, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `reservations` VALUES (33, NULL, NULL, NULL, 1, 33, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:03', '2021-02-11 05:50:03');
INSERT INTO `reservations` VALUES (34, NULL, NULL, NULL, 1, 34, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `reservations` VALUES (35, NULL, NULL, NULL, 1, 35, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `reservations` VALUES (36, '2022-03-21', '11:30:00', NULL, 1, 36, 70, 5, 15, 10, '質問が入ります。', 100, '2021-02-11 05:50:06', '2022-03-15 23:40:57');
INSERT INTO `reservations` VALUES (39, NULL, NULL, NULL, 1, 39, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:07', '2021-02-11 05:50:07');
INSERT INTO `reservations` VALUES (40, NULL, NULL, NULL, 1, 40, NULL, 5, 5, 10, '質問が入ります。', 0, '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `reservations` VALUES (41, NULL, NULL, NULL, 1, 41, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `reservations` VALUES (42, NULL, NULL, NULL, 1, 42, NULL, 5, 5, 5, '質問が入ります。', 0, '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `reservations` VALUES (44, '2022-03-29', '13:15:00', NULL, 1, 44, 70, 5, 15, 5, '質問が入ります。', 0, '2021-02-11 05:50:11', '2022-03-24 21:07:49');
INSERT INTO `reservations` VALUES (45, '2022-03-22', '12:45:00', NULL, 1, 45, 70, 5, 15, 5, '質問が入ります。', 0, '2021-02-11 05:50:11', '2022-03-27 21:46:48');
INSERT INTO `reservations` VALUES (52, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-01 11:38:45', '2022-04-01 11:38:45');
INSERT INTO `reservations` VALUES (53, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-19 15:11:39', '2022-04-19 15:11:39');
INSERT INTO `reservations` VALUES (54, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-20 20:13:03', '2022-04-20 20:13:03');
INSERT INTO `reservations` VALUES (55, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-21 06:57:08', '2022-04-21 06:57:08');
INSERT INTO `reservations` VALUES (56, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-21 08:16:16', '2022-04-21 08:16:16');
INSERT INTO `reservations` VALUES (57, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-21 09:13:51', '2022-04-21 09:13:51');
INSERT INTO `reservations` VALUES (58, '2022-07-16', '12:30:00', NULL, 1, 70, 76, 5, 15, 10, NULL, 100, '2022-04-21 12:54:56', '2022-07-04 13:25:01');
INSERT INTO `reservations` VALUES (59, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 10, 'i wanna do operation', 0, '2022-04-21 15:24:49', '2022-04-21 15:24:49');
INSERT INTO `reservations` VALUES (60, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 10, 'i wanna do operation', 0, '2022-04-21 15:24:58', '2022-04-21 15:24:58');
INSERT INTO `reservations` VALUES (61, '2022-07-14', '15:00:00', NULL, 1, 70, 73, 5, 15, 20, NULL, 100, '2022-04-23 07:21:32', '2022-07-04 13:20:06');
INSERT INTO `reservations` VALUES (62, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-23 09:37:32', '2022-04-23 09:37:32');
INSERT INTO `reservations` VALUES (63, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 0, 'q', 12, '2022-04-23 09:39:25', '2022-04-23 09:39:25');
INSERT INTO `reservations` VALUES (64, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-23 09:43:47', '2022-04-23 09:43:47');
INSERT INTO `reservations` VALUES (65, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-25 03:54:50', '2022-04-25 03:54:50');
INSERT INTO `reservations` VALUES (66, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 0, 'qqq', 123, '2022-04-25 04:53:41', '2022-04-25 04:53:41');
INSERT INTO `reservations` VALUES (67, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 1, NULL, 100, '2022-04-25 04:56:35', '2022-04-25 04:56:35');
INSERT INTO `reservations` VALUES (68, NULL, NULL, NULL, 1, 2, NULL, 5, 5, 0, 'afdadf', 120, '2022-05-16 09:46:06', '2022-05-16 09:46:06');
INSERT INTO `reservations` VALUES (69, NULL, NULL, NULL, 1, 70, NULL, 5, 5, 0, 'erwer', 120, '2022-05-24 08:18:02', '2022-05-24 08:18:02');
INSERT INTO `reservations` VALUES (70, NULL, NULL, NULL, 1, 70, NULL, 5, 5, 0, 'erwer', 120, '2022-05-24 08:18:02', '2022-05-24 08:18:02');
INSERT INTO `reservations` VALUES (71, NULL, NULL, NULL, 1, 70, NULL, 5, 5, 0, 'erwer', 120, '2022-05-24 08:19:49', '2022-05-24 08:19:49');
INSERT INTO `reservations` VALUES (72, NULL, NULL, NULL, 1, 70, NULL, 5, 5, 0, 'dsfdfadf', 1000, '2022-05-28 06:26:06', '2022-05-28 06:26:06');
INSERT INTO `reservations` VALUES (73, '2022-07-22', '18:15:00', NULL, 1, 70, 75, 5, 15, 10, NULL, 100, '2022-06-30 09:40:48', '2022-07-04 13:14:00');
INSERT INTO `reservations` VALUES (74, '2022-07-06', '17:15:00', NULL, 1, 70, 75, 5, 15, 5, NULL, 100, '2022-06-30 12:11:46', '2022-07-04 13:10:04');

-- ----------------------------
-- Table structure for rsv_categories
-- ----------------------------
DROP TABLE IF EXISTS `rsv_categories`;
CREATE TABLE `rsv_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `caegory_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rsv_categories_reservation_id_foreign`(`reservation_id`) USING BTREE,
  INDEX `rsv_categories_caegory_id_foreign`(`caegory_id`) USING BTREE,
  CONSTRAINT `rsv_categories_caegory_id_foreign` FOREIGN KEY (`caegory_id`) REFERENCES `mtb_part_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `rsv_categories_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rsv_hope_times
-- ----------------------------
DROP TABLE IF EXISTS `rsv_hope_times`;
CREATE TABLE `rsv_hope_times`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time(0) NULL DEFAULT NULL,
  `end_time` time(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rsv_hope_times_reservation_id_foreign`(`reservation_id`) USING BTREE,
  CONSTRAINT `rsv_hope_times_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 282 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rsv_hope_times
-- ----------------------------
INSERT INTO `rsv_hope_times` VALUES (1, 1, '2003-07-14', '05:48:25', '08:43:18', '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `rsv_hope_times` VALUES (2, 1, '2009-10-13', '18:08:12', '11:11:55', '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `rsv_hope_times` VALUES (3, 1, '1992-10-06', '04:51:05', '12:51:20', '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `rsv_hope_times` VALUES (4, 1, '1998-08-07', '10:31:08', '21:19:35', '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `rsv_hope_times` VALUES (5, 1, '1976-10-24', '04:13:10', '05:27:09', '2021-02-11 05:49:41', '2021-02-11 05:49:41');
INSERT INTO `rsv_hope_times` VALUES (11, 3, '2009-02-16', '00:59:08', '15:58:46', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (12, 3, '1997-06-26', '09:02:04', '01:50:09', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (13, 3, '1991-02-28', '07:49:43', '16:55:36', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (14, 3, '1992-05-02', '10:51:28', '15:39:58', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (15, 3, '1983-11-25', '06:58:36', '07:36:01', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (16, 4, '1974-01-23', '05:15:25', '04:45:47', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (17, 4, '1972-06-11', '05:06:48', '23:22:51', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (18, 4, '1978-08-18', '12:47:25', '18:03:58', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (19, 4, '1975-11-22', '21:41:13', '19:25:31', '2021-02-11 05:49:43', '2021-02-11 05:49:43');
INSERT INTO `rsv_hope_times` VALUES (20, 4, '2015-04-30', '19:05:07', '23:07:38', '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `rsv_hope_times` VALUES (21, 5, '2008-01-06', '19:13:23', '11:23:17', '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `rsv_hope_times` VALUES (22, 5, '1986-04-11', '12:11:33', '02:32:57', '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `rsv_hope_times` VALUES (23, 5, '2009-04-07', '18:31:57', '15:49:59', '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `rsv_hope_times` VALUES (24, 5, '2007-04-17', '09:57:46', '01:04:29', '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `rsv_hope_times` VALUES (25, 5, '1998-05-21', '18:32:42', '07:24:02', '2021-02-11 05:49:44', '2021-02-11 05:49:44');
INSERT INTO `rsv_hope_times` VALUES (26, 6, '2017-07-01', '17:59:42', '23:48:35', '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `rsv_hope_times` VALUES (27, 6, '2011-12-23', '01:23:25', '11:13:01', '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `rsv_hope_times` VALUES (28, 6, '2013-04-20', '12:06:59', '22:10:39', '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `rsv_hope_times` VALUES (29, 6, '1981-08-29', '15:55:26', '19:18:04', '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `rsv_hope_times` VALUES (30, 6, '2003-03-17', '03:19:31', '20:33:14', '2021-02-11 05:49:45', '2021-02-11 05:49:45');
INSERT INTO `rsv_hope_times` VALUES (31, 7, '1981-12-16', '08:57:04', '05:50:07', '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `rsv_hope_times` VALUES (32, 7, '1997-12-28', '16:50:25', '20:26:58', '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `rsv_hope_times` VALUES (33, 7, '1996-07-26', '06:39:00', '20:01:16', '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `rsv_hope_times` VALUES (34, 7, '1987-02-08', '23:45:25', '15:46:20', '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `rsv_hope_times` VALUES (35, 7, '1995-05-01', '10:47:49', '07:16:17', '2021-02-11 05:49:46', '2021-02-11 05:49:46');
INSERT INTO `rsv_hope_times` VALUES (36, 8, '2010-10-05', '13:00:27', '02:59:00', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (37, 8, '1992-03-10', '04:33:30', '06:17:18', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (38, 8, '1986-07-03', '16:37:03', '15:18:09', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (39, 8, '2015-12-24', '01:55:29', '14:44:00', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (40, 8, '2012-02-06', '17:52:59', '22:32:54', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (41, 9, '1984-09-03', '21:33:06', '19:05:37', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (42, 9, '2017-05-23', '19:19:54', '23:41:33', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (43, 9, '1983-09-03', '14:05:22', '13:59:16', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (44, 9, '1971-08-06', '18:41:13', '21:41:53', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (45, 9, '1990-12-10', '14:36:39', '19:49:24', '2021-02-11 05:49:47', '2021-02-11 05:49:47');
INSERT INTO `rsv_hope_times` VALUES (46, 10, '1979-12-29', '15:21:37', '11:04:22', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (47, 10, '2017-06-01', '01:46:39', '23:43:33', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (48, 10, '2001-04-29', '13:39:50', '08:09:20', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (49, 10, '1973-05-29', '07:50:23', '05:06:35', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (50, 10, '2016-06-22', '19:58:23', '22:17:28', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (51, 11, '1989-05-26', '20:37:11', '22:32:29', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (52, 11, '2015-03-07', '05:56:41', '07:39:27', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (53, 11, '2003-01-19', '10:44:10', '12:04:13', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (54, 11, '2014-06-27', '00:44:17', '18:06:58', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (55, 11, '1971-10-20', '04:44:04', '18:39:40', '2021-02-11 05:49:48', '2021-02-11 05:49:48');
INSERT INTO `rsv_hope_times` VALUES (56, 12, '1998-12-18', '02:13:53', '10:58:45', '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `rsv_hope_times` VALUES (57, 12, '2011-02-18', '15:12:47', '01:50:14', '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `rsv_hope_times` VALUES (58, 12, '2014-09-15', '00:55:52', '10:27:50', '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `rsv_hope_times` VALUES (59, 12, '1976-01-06', '03:24:34', '11:09:19', '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `rsv_hope_times` VALUES (60, 12, '1972-10-09', '21:02:23', '16:29:39', '2021-02-11 05:49:49', '2021-02-11 05:49:49');
INSERT INTO `rsv_hope_times` VALUES (61, 13, '2003-04-01', '02:42:49', '11:55:02', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (62, 13, '1970-05-16', '10:55:26', '06:02:14', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (63, 13, '2011-09-07', '23:21:44', '06:38:52', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (64, 13, '1992-04-14', '20:50:04', '15:08:41', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (65, 13, '2001-10-30', '14:16:03', '03:23:14', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (66, 14, '1996-06-05', '03:10:21', '18:53:34', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (67, 14, '1970-02-15', '08:48:10', '05:35:00', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (68, 14, '1998-08-15', '19:39:32', '03:00:51', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (69, 14, '2014-03-02', '03:57:25', '17:12:32', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (70, 14, '1971-11-08', '09:21:51', '18:41:22', '2021-02-11 05:49:50', '2021-02-11 05:49:50');
INSERT INTO `rsv_hope_times` VALUES (71, 15, '2009-03-11', '20:36:07', '07:41:30', '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `rsv_hope_times` VALUES (72, 15, '2001-12-13', '13:54:44', '10:55:27', '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `rsv_hope_times` VALUES (73, 15, '2021-01-01', '22:25:50', '09:21:45', '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `rsv_hope_times` VALUES (74, 15, '2013-01-30', '08:19:27', '04:48:19', '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `rsv_hope_times` VALUES (75, 15, '1979-06-10', '01:36:17', '18:41:21', '2021-02-11 05:49:51', '2021-02-11 05:49:51');
INSERT INTO `rsv_hope_times` VALUES (76, 16, '2008-12-08', '03:40:25', '15:17:41', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (77, 16, '2016-02-15', '21:09:41', '05:55:34', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (78, 16, '2010-05-28', '03:29:41', '06:04:20', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (79, 16, '2013-11-14', '23:05:56', '04:59:39', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (80, 16, '1983-09-01', '05:14:20', '07:43:37', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (81, 17, '1998-09-14', '04:27:58', '20:00:56', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (82, 17, '2001-09-17', '22:29:56', '06:41:05', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (83, 17, '2002-11-11', '21:42:43', '00:12:06', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (84, 17, '2017-09-04', '06:13:17', '08:43:46', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (85, 17, '1981-05-12', '15:39:19', '19:52:51', '2021-02-11 05:49:52', '2021-02-11 05:49:52');
INSERT INTO `rsv_hope_times` VALUES (86, 18, '1995-03-30', '04:44:48', '07:42:45', '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `rsv_hope_times` VALUES (87, 18, '2007-05-24', '09:14:58', '00:35:34', '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `rsv_hope_times` VALUES (88, 18, '1973-02-14', '05:39:09', '21:25:13', '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `rsv_hope_times` VALUES (89, 18, '2001-09-08', '18:23:13', '18:23:55', '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `rsv_hope_times` VALUES (90, 18, '2015-03-15', '04:33:21', '19:29:04', '2021-02-11 05:49:53', '2021-02-11 05:49:53');
INSERT INTO `rsv_hope_times` VALUES (91, 19, '1986-07-22', '14:46:31', '10:17:53', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (92, 19, '1992-07-02', '00:20:45', '12:17:42', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (93, 19, '2018-04-30', '02:12:51', '00:01:44', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (94, 19, '1992-01-28', '16:26:42', '04:28:12', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (95, 19, '2014-12-12', '16:05:34', '13:46:34', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (96, 20, '1998-02-26', '01:45:14', '17:19:05', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (97, 20, '2006-08-17', '09:46:05', '07:28:39', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (98, 20, '1986-03-09', '00:29:31', '04:28:43', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (99, 20, '2019-03-15', '21:12:53', '23:50:51', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (100, 20, '1986-11-27', '20:30:02', '11:54:02', '2021-02-11 05:49:54', '2021-02-11 05:49:54');
INSERT INTO `rsv_hope_times` VALUES (101, 21, '1975-02-07', '07:40:48', '16:01:06', '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `rsv_hope_times` VALUES (102, 21, '2001-10-01', '06:58:08', '21:08:08', '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `rsv_hope_times` VALUES (103, 21, '2020-05-16', '17:35:46', '11:50:03', '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `rsv_hope_times` VALUES (104, 21, '1992-05-04', '11:23:21', '14:06:54', '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `rsv_hope_times` VALUES (105, 21, '1993-04-16', '14:00:39', '07:59:40', '2021-02-11 05:49:55', '2021-02-11 05:49:55');
INSERT INTO `rsv_hope_times` VALUES (106, 22, '2017-05-11', '11:16:55', '18:08:44', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (107, 22, '1976-11-26', '19:15:26', '16:51:00', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (108, 22, '1982-11-06', '09:12:25', '13:20:59', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (109, 22, '1984-04-23', '20:02:37', '17:31:23', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (110, 22, '1985-09-05', '16:09:16', '00:33:45', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (111, 23, '1987-12-09', '17:18:42', '15:32:14', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (112, 23, '1991-11-08', '13:44:12', '04:43:09', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (113, 23, '1999-03-22', '11:22:02', '08:46:53', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (114, 23, '1974-05-10', '07:00:04', '07:59:27', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (115, 23, '2019-04-18', '06:54:33', '03:19:40', '2021-02-11 05:49:56', '2021-02-11 05:49:56');
INSERT INTO `rsv_hope_times` VALUES (116, 24, '1994-06-10', '12:02:45', '00:26:01', '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `rsv_hope_times` VALUES (117, 24, '2004-05-19', '21:27:03', '10:37:07', '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `rsv_hope_times` VALUES (118, 24, '1979-11-17', '16:14:55', '03:52:13', '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `rsv_hope_times` VALUES (119, 24, '1995-03-14', '03:14:08', '22:01:55', '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `rsv_hope_times` VALUES (120, 24, '1995-03-31', '08:20:21', '19:44:46', '2021-02-11 05:49:57', '2021-02-11 05:49:57');
INSERT INTO `rsv_hope_times` VALUES (121, 25, '2010-11-05', '07:07:01', '21:50:28', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (122, 25, '1971-10-11', '12:00:29', '14:10:33', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (123, 25, '1985-08-01', '12:10:48', '05:54:37', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (124, 25, '1994-07-30', '19:06:30', '12:50:41', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (125, 25, '1998-05-27', '23:32:48', '23:45:13', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (126, 26, '1981-10-14', '20:12:43', '05:38:21', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (127, 26, '1973-02-17', '18:32:14', '13:13:17', '2021-02-11 05:49:58', '2021-02-11 05:49:58');
INSERT INTO `rsv_hope_times` VALUES (128, 26, '2019-02-27', '00:07:06', '23:52:16', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (129, 26, '2011-04-27', '08:38:41', '09:36:22', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (130, 26, '1972-08-08', '10:44:31', '07:00:47', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (131, 27, '2016-08-24', '05:14:34', '02:21:09', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (132, 27, '1993-11-15', '05:13:15', '22:38:42', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (133, 27, '2012-12-16', '10:59:10', '10:41:59', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (134, 27, '2012-03-01', '12:10:41', '13:29:15', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (135, 27, '1994-07-26', '13:41:04', '18:22:35', '2021-02-11 05:49:59', '2021-02-11 05:49:59');
INSERT INTO `rsv_hope_times` VALUES (136, 28, '2016-09-26', '08:56:33', '10:19:54', '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `rsv_hope_times` VALUES (137, 28, '2001-07-29', '00:46:12', '22:26:58', '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `rsv_hope_times` VALUES (138, 28, '2000-11-21', '07:40:56', '01:09:00', '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `rsv_hope_times` VALUES (139, 28, '1976-01-31', '01:48:28', '08:33:06', '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `rsv_hope_times` VALUES (140, 28, '1988-10-29', '16:23:11', '13:05:28', '2021-02-11 05:50:00', '2021-02-11 05:50:00');
INSERT INTO `rsv_hope_times` VALUES (141, 29, '1994-03-30', '14:21:49', '10:48:54', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (142, 29, '1987-03-10', '16:24:44', '17:59:40', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (143, 29, '2005-06-10', '03:07:26', '11:28:39', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (144, 29, '2001-04-09', '16:23:20', '16:49:18', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (145, 29, '2004-12-17', '01:38:46', '20:12:00', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (146, 30, '2000-04-20', '16:11:01', '00:25:35', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (147, 30, '1983-07-28', '06:20:42', '22:12:34', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (148, 30, '1988-05-23', '01:40:55', '23:33:55', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (149, 30, '1972-06-13', '14:57:38', '13:23:41', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (150, 30, '2020-01-03', '05:49:27', '22:14:03', '2021-02-11 05:50:01', '2021-02-11 05:50:01');
INSERT INTO `rsv_hope_times` VALUES (151, 31, '1990-12-23', '12:02:00', '03:23:29', '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `rsv_hope_times` VALUES (152, 31, '2006-01-13', '19:08:31', '08:15:37', '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `rsv_hope_times` VALUES (153, 31, '1990-01-05', '13:12:31', '07:45:38', '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `rsv_hope_times` VALUES (154, 31, '2006-11-06', '20:42:49', '01:49:26', '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `rsv_hope_times` VALUES (155, 31, '1975-12-13', '15:37:38', '01:29:14', '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `rsv_hope_times` VALUES (156, 32, '2012-12-11', '07:52:51', '03:22:09', '2021-02-11 05:50:02', '2021-02-11 05:50:02');
INSERT INTO `rsv_hope_times` VALUES (157, 32, '1976-07-27', '13:54:02', '05:22:04', '2021-02-11 05:50:03', '2021-02-11 05:50:03');
INSERT INTO `rsv_hope_times` VALUES (158, 32, '1989-10-15', '16:34:00', '22:16:51', '2021-02-11 05:50:03', '2021-02-11 05:50:03');
INSERT INTO `rsv_hope_times` VALUES (159, 32, '2010-01-20', '03:35:19', '10:19:36', '2021-02-11 05:50:03', '2021-02-11 05:50:03');
INSERT INTO `rsv_hope_times` VALUES (160, 32, '1981-11-15', '14:49:37', '14:48:58', '2021-02-11 05:50:03', '2021-02-11 05:50:03');
INSERT INTO `rsv_hope_times` VALUES (161, 33, '1978-06-17', '07:12:09', '01:15:01', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (162, 33, '2004-12-29', '15:11:43', '05:36:01', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (163, 33, '1998-05-20', '10:28:07', '02:38:52', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (164, 33, '1993-12-09', '23:25:36', '10:08:28', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (165, 33, '1984-12-17', '14:31:40', '04:30:30', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (166, 34, '2001-11-06', '06:17:42', '05:10:18', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (167, 34, '1974-07-26', '01:46:30', '05:28:01', '2021-02-11 05:50:04', '2021-02-11 05:50:04');
INSERT INTO `rsv_hope_times` VALUES (168, 34, '1995-12-15', '13:55:47', '21:30:17', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (169, 34, '2018-08-08', '21:21:08', '14:06:31', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (170, 34, '2020-05-15', '13:53:14', '15:58:42', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (171, 35, '1970-03-17', '11:12:22', '13:46:51', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (172, 35, '1999-07-11', '16:27:47', '13:14:07', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (173, 35, '1981-05-25', '05:54:29', '07:42:06', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (174, 35, '1983-08-07', '13:15:51', '02:34:16', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (175, 35, '1974-11-28', '12:25:35', '12:24:56', '2021-02-11 05:50:05', '2021-02-11 05:50:05');
INSERT INTO `rsv_hope_times` VALUES (176, 36, '1981-04-21', '10:36:10', '18:05:41', '2021-02-11 05:50:06', '2021-02-11 05:50:06');
INSERT INTO `rsv_hope_times` VALUES (177, 36, '2001-01-09', '15:16:05', '03:08:52', '2021-02-11 05:50:06', '2021-02-11 05:50:06');
INSERT INTO `rsv_hope_times` VALUES (178, 36, '2013-11-27', '17:16:41', '20:47:45', '2021-02-11 05:50:06', '2021-02-11 05:50:06');
INSERT INTO `rsv_hope_times` VALUES (179, 36, '1973-02-18', '00:21:16', '02:52:17', '2021-02-11 05:50:06', '2021-02-11 05:50:06');
INSERT INTO `rsv_hope_times` VALUES (180, 36, '2007-05-07', '16:18:31', '18:05:48', '2021-02-11 05:50:06', '2021-02-11 05:50:06');
INSERT INTO `rsv_hope_times` VALUES (191, 39, '2012-04-09', '16:01:19', '22:30:40', '2021-02-11 05:50:07', '2021-02-11 05:50:07');
INSERT INTO `rsv_hope_times` VALUES (192, 39, '1976-06-13', '23:23:16', '05:23:28', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (193, 39, '2005-01-23', '09:59:59', '16:40:55', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (194, 39, '1984-07-25', '03:26:29', '11:40:33', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (195, 39, '2001-01-17', '21:57:23', '18:31:17', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (196, 40, '1991-07-21', '21:08:09', '07:41:46', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (197, 40, '2019-07-30', '10:39:28', '23:58:33', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (198, 40, '1970-10-06', '22:31:54', '14:14:10', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (199, 40, '2007-05-14', '23:27:08', '23:22:56', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (200, 40, '1972-09-11', '22:29:55', '19:07:54', '2021-02-11 05:50:08', '2021-02-11 05:50:08');
INSERT INTO `rsv_hope_times` VALUES (201, 41, '1984-01-23', '13:43:49', '07:32:44', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (202, 41, '1974-08-27', '19:24:02', '19:12:14', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (203, 41, '2006-06-14', '16:04:18', '20:52:37', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (204, 41, '1994-07-31', '06:16:30', '09:12:00', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (205, 41, '2013-05-29', '19:56:12', '01:42:35', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (206, 42, '1976-03-17', '03:45:52', '19:09:33', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (207, 42, '2010-12-29', '05:51:34', '08:49:02', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (208, 42, '1989-03-24', '22:54:38', '09:16:35', '2021-02-11 05:50:09', '2021-02-11 05:50:09');
INSERT INTO `rsv_hope_times` VALUES (209, 42, '1988-10-31', '09:25:36', '17:29:26', '2021-02-11 05:50:10', '2021-02-11 05:50:10');
INSERT INTO `rsv_hope_times` VALUES (210, 42, '1974-06-23', '17:28:59', '05:23:16', '2021-02-11 05:50:10', '2021-02-11 05:50:10');
INSERT INTO `rsv_hope_times` VALUES (216, 44, '2008-08-26', '07:08:24', '00:23:46', '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `rsv_hope_times` VALUES (217, 44, '2008-01-23', '13:56:22', '03:41:09', '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `rsv_hope_times` VALUES (218, 44, '2020-11-28', '04:58:39', '18:57:47', '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `rsv_hope_times` VALUES (219, 44, '2019-12-16', '17:10:38', '00:27:16', '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `rsv_hope_times` VALUES (220, 44, '1972-09-27', '03:50:59', '10:44:39', '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `rsv_hope_times` VALUES (221, 45, '2005-08-23', '13:25:34', '08:03:41', '2021-02-11 05:50:11', '2021-02-11 05:50:11');
INSERT INTO `rsv_hope_times` VALUES (222, 45, '2008-05-12', '21:36:07', '02:56:48', '2021-02-11 05:50:12', '2021-02-11 05:50:12');
INSERT INTO `rsv_hope_times` VALUES (223, 45, '1986-11-27', '06:10:41', '10:13:41', '2021-02-11 05:50:12', '2021-02-11 05:50:12');
INSERT INTO `rsv_hope_times` VALUES (224, 45, '2003-12-05', '18:27:54', '19:40:09', '2021-02-11 05:50:12', '2021-02-11 05:50:12');
INSERT INTO `rsv_hope_times` VALUES (225, 45, '1990-09-11', '22:26:53', '20:14:24', '2021-02-11 05:50:12', '2021-02-11 05:50:12');
INSERT INTO `rsv_hope_times` VALUES (256, 52, '2020-11-12', '08:00:00', '15:00:00', '2022-04-01 11:38:45', '2022-04-01 11:38:45');
INSERT INTO `rsv_hope_times` VALUES (257, 52, '2020-11-13', '14:00:00', '18:00:00', '2022-04-01 11:38:45', '2022-04-01 11:38:45');
INSERT INTO `rsv_hope_times` VALUES (258, 53, '2020-11-12', '08:00:00', '15:00:00', '2022-04-19 15:11:39', '2022-04-19 15:11:39');
INSERT INTO `rsv_hope_times` VALUES (259, 53, '2020-11-13', '14:00:00', '18:00:00', '2022-04-19 15:11:39', '2022-04-19 15:11:39');
INSERT INTO `rsv_hope_times` VALUES (260, 54, '2020-11-12', '08:00:00', '15:00:00', '2022-04-20 20:13:03', '2022-04-20 20:13:03');
INSERT INTO `rsv_hope_times` VALUES (261, 54, '2020-11-13', '14:00:00', '18:00:00', '2022-04-20 20:13:03', '2022-04-20 20:13:03');
INSERT INTO `rsv_hope_times` VALUES (262, 55, '2020-11-12', '08:00:00', '15:00:00', '2022-04-21 06:57:08', '2022-04-21 06:57:08');
INSERT INTO `rsv_hope_times` VALUES (263, 55, '2020-11-13', '14:00:00', '18:00:00', '2022-04-21 06:57:08', '2022-04-21 06:57:08');
INSERT INTO `rsv_hope_times` VALUES (264, 56, '2020-11-12', '08:00:00', '15:00:00', '2022-04-21 08:16:16', '2022-04-21 08:16:16');
INSERT INTO `rsv_hope_times` VALUES (265, 56, '2020-11-13', '14:00:00', '18:00:00', '2022-04-21 08:16:16', '2022-04-21 08:16:16');
INSERT INTO `rsv_hope_times` VALUES (266, 57, '2020-11-12', '08:00:00', '15:00:00', '2022-04-21 09:13:51', '2022-04-21 09:13:51');
INSERT INTO `rsv_hope_times` VALUES (267, 57, '2020-11-13', '14:00:00', '18:00:00', '2022-04-21 09:13:51', '2022-04-21 09:13:51');
INSERT INTO `rsv_hope_times` VALUES (268, 61, '2020-11-12', '08:00:00', '15:00:00', '2022-04-23 07:21:32', '2022-04-23 07:21:32');
INSERT INTO `rsv_hope_times` VALUES (269, 61, '2020-11-13', '14:00:00', '18:00:00', '2022-04-23 07:21:32', '2022-04-23 07:21:32');
INSERT INTO `rsv_hope_times` VALUES (270, 62, '2020-11-12', '08:00:00', '15:00:00', '2022-04-23 09:37:32', '2022-04-23 09:37:32');
INSERT INTO `rsv_hope_times` VALUES (271, 62, '2020-11-13', '14:00:00', '18:00:00', '2022-04-23 09:37:32', '2022-04-23 09:37:32');
INSERT INTO `rsv_hope_times` VALUES (272, 64, '2020-11-12', '08:00:00', '15:00:00', '2022-04-23 09:43:47', '2022-04-23 09:43:47');
INSERT INTO `rsv_hope_times` VALUES (273, 64, '2020-11-13', '14:00:00', '18:00:00', '2022-04-23 09:43:47', '2022-04-23 09:43:47');
INSERT INTO `rsv_hope_times` VALUES (274, 65, '2020-11-12', '08:00:00', '15:00:00', '2022-04-25 03:54:50', '2022-04-25 03:54:50');
INSERT INTO `rsv_hope_times` VALUES (275, 65, '2020-11-13', '14:00:00', '18:00:00', '2022-04-25 03:54:50', '2022-04-25 03:54:50');
INSERT INTO `rsv_hope_times` VALUES (276, 67, '2020-11-12', '08:00:00', '15:00:00', '2022-04-25 04:56:35', '2022-04-25 04:56:35');
INSERT INTO `rsv_hope_times` VALUES (277, 67, '2020-11-13', '14:00:00', '18:00:00', '2022-04-25 04:56:35', '2022-04-25 04:56:35');
INSERT INTO `rsv_hope_times` VALUES (278, 73, '2020-11-12', '08:00:00', '15:00:00', '2022-06-30 09:40:49', '2022-06-30 09:40:49');
INSERT INTO `rsv_hope_times` VALUES (279, 73, '2020-11-13', '14:00:00', '18:00:00', '2022-06-30 09:40:49', '2022-06-30 09:40:49');
INSERT INTO `rsv_hope_times` VALUES (280, 74, '2020-11-12', '08:00:00', '15:00:00', '2022-06-30 12:11:46', '2022-06-30 12:11:46');
INSERT INTO `rsv_hope_times` VALUES (281, 74, '2020-11-13', '14:00:00', '18:00:00', '2022-06-30 12:11:46', '2022-06-30 12:11:46');

-- ----------------------------
-- Table structure for search
-- ----------------------------
DROP TABLE IF EXISTS `search`;
CREATE TABLE `search`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `text` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `followcount` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `follows_patient_id_foreign`(`text`) USING BTREE,
  INDEX `follows_follow_id_foreign`(`followcount`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of search
-- ----------------------------
INSERT INTO `search` VALUES (1, 'sss', 2, '2022-06-22 18:38:42', '2022-06-22 18:38:47');
INSERT INTO `search` VALUES (7, 'メニュー', 1, '2022-06-23 03:34:32', '2022-06-23 03:34:32');

-- ----------------------------
-- Table structure for stuff_specialities
-- ----------------------------
DROP TABLE IF EXISTS `stuff_specialities`;
CREATE TABLE `stuff_specialities`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stuff_id` bigint(20) UNSIGNED NOT NULL,
  `speciality_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stuff_specialities_stuff_id_foreign`(`stuff_id`) USING BTREE,
  INDEX `stuff_specialities_speciality_id_foreign`(`speciality_id`) USING BTREE,
  CONSTRAINT `stuff_specialities_speciality_id_foreign` FOREIGN KEY (`speciality_id`) REFERENCES `mtb_specialities` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `stuff_specialities_stuff_id_foreign` FOREIGN KEY (`stuff_id`) REFERENCES `stuffs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stuffs
-- ----------------------------
DROP TABLE IF EXISTS `stuffs`;
CREATE TABLE `stuffs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '氏名(漢字)',
  `kana` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'シメイ(カタカナ)',
  `duty` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '役職',
  `job_id` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '職種',
  `experience_year` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '医師歴',
  `career` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '資格',
  `profile` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '経歴',
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '写真',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `ave_diaries_rate` double(2, 1) NULL DEFAULT NULL COMMENT '日記平均',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stuffs_clinic_id_foreign`(`clinic_id`) USING BTREE,
  INDEX `stuffs_job_id_foreign`(`job_id`) USING BTREE,
  CONSTRAINT `stuffs_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `stuffs_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `mtb_jobs` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stuffs
-- ----------------------------
INSERT INTO `stuffs` VALUES (5, 1, 'ああああ', 'っっあああ', 'ああああ', 2, '0', 'ああああ', 'ああああ', NULL, '2021-06-21 13:15:35', '2021-06-27 22:17:09', NULL);
INSERT INTO `stuffs` VALUES (8, 1, 'さあああああ', 'カタカナ', 'ああああ', 2, '0', 'ああああ', 'ああああ', NULL, '2021-06-25 22:51:03', '2021-07-20 01:04:25', NULL);
INSERT INTO `stuffs` VALUES (9, 1, 'ああああ', 'ああああ', 'ああああ', 2, '0', 'ああああ', 'ああああ', 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/mZUPiO7185.jpg', '2021-06-26 07:33:02', '2021-08-08 20:57:48', NULL);
INSERT INTO `stuffs` VALUES (11, 1, '鈴木', 'スズキ', NULL, 2, NULL, NULL, NULL, NULL, '2021-07-20 00:39:37', '2021-07-20 00:39:55', NULL);
INSERT INTO `stuffs` VALUES (12, 1, '漢字', 'カタカナ', NULL, 2, NULL, NULL, NULL, NULL, '2021-07-20 04:46:29', '2021-07-20 04:46:29', NULL);
INSERT INTO `stuffs` VALUES (13, 1, '富安さん', 'トミヤス', NULL, 2, NULL, NULL, NULL, NULL, '2021-07-20 17:25:09', '2021-07-20 17:25:09', NULL);
INSERT INTO `stuffs` VALUES (14, 1, '123', '123', NULL, 2, NULL, NULL, NULL, 'https://clinic-reservation.s3-ap-northeast-1.amazonaws.com/clinic/stuffs/thumbs/HznKtO7867.jpg', '2022-06-22 13:25:52', '2022-06-22 13:25:52', NULL);

-- ----------------------------
-- Table structure for treat_progresses
-- ----------------------------
DROP TABLE IF EXISTS `treat_progresses`;
CREATE TABLE `treat_progresses`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `diary_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `from_treat_day` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `treat_progresses_diary_id_foreign`(`diary_id`) USING BTREE,
  CONSTRAINT `treat_progresses_diary_id_foreign` FOREIGN KEY (`diary_id`) REFERENCES `diaries` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of treat_progresses
-- ----------------------------
INSERT INTO `treat_progresses` VALUES (1, 10, 12, '1232112', NULL, '2022-06-21 08:44:18');

-- ----------------------------
-- Table structure for treat_status
-- ----------------------------
DROP TABLE IF EXISTS `treat_status`;
CREATE TABLE `treat_status`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `progress_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `indicator_id` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `value` tinyint(4) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `treat_status_progress_id_foreign`(`progress_id`) USING BTREE,
  INDEX `treat_status_indicator_id_foreign`(`indicator_id`) USING BTREE,
  CONSTRAINT `treat_status_indicator_id_foreign` FOREIGN KEY (`indicator_id`) REFERENCES `mtb_treat_indicators` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `treat_status_progress_id_foreign` FOREIGN KEY (`progress_id`) REFERENCES `treat_progresses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` enum('admin','clinic','patient','doctor') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `firebase_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `confirmation_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provider_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'クリニック1', 'clinic@gmail.com', NULL, '$2y$10$Km7Hzu78pwrhABCVleQoKeSerUvxit3YUdh.X4rWSUJ97fMhGMJpW', 'clinic', '1g0HUAR2W7WjOFBsvhsBwp7bfmCfVCTTtEMbcHPjiA5kuiH65QZIoB4tUkMW', '2021-02-11 05:49:40', '2022-07-12 14:44:47', 'YKo7jsNyr5yIXe79xK1T', NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (2, '患者_0', 'patient_0@test.com', NULL, '$2y$10$zhBAjFjWFYqaX7jfCijuZe3l1RS.CtWNUNYRMhkqEsxc6.TUMTYAq', 'patient', NULL, '2021-02-11 05:49:41', '2021-02-11 05:49:41', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (4, '患者_2', 'patient_2@test.com', NULL, '$2y$10$aQ689bqJVIhBlxMAaO/DFOzbv69P/yuF6fbzUjEcVcsH.UUN6v8ua', 'patient', NULL, '2021-02-11 05:49:42', '2021-02-11 05:49:42', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (5, '患者_3', 'patient_3@test.com', NULL, '$2y$10$CI.5H2DBDiTbyq9ISb46O.Q2JtjW6q5zDLVSrmPgI.xcmIJWdeVW2', 'patient', NULL, '2021-02-11 05:49:43', '2021-02-11 05:49:43', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (6, '患者_4', 'patient_4@test.com', NULL, '$2y$10$VGmsKKWPi965lcsYJyIwCu3Y7WBwx1j3wWOAKixIbOHM58KXW9NBK', 'patient', NULL, '2021-02-11 05:49:44', '2021-02-11 05:49:44', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (7, '患者_5', 'patient_5@test.com', NULL, '$2y$10$chADRYYHn9.tnHWbQDD1Z.DHecv3sPbCqEmvkO.knZsDTqz0uyT3.', 'patient', NULL, '2021-02-11 05:49:44', '2021-02-11 05:49:44', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (8, '患者_6', 'patient_6@test.com', NULL, '$2y$10$4LInhcjHHasp4I5prob1GuGYwnqt8I2oaRZCXoqoscFh4TtLo65zy', 'patient', NULL, '2021-02-11 05:49:45', '2021-02-11 05:49:45', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (9, '患者_7', 'patient_7@test.com', NULL, '$2y$10$NLW5XlQLoEMgWDY.wAW1oev4IV1aiLvG9SfyobDKYKiFg.p3MaYJe', 'patient', NULL, '2021-02-11 05:49:46', '2021-02-11 05:49:46', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (10, '患者_8', 'patient_8@test.com', NULL, '$2y$10$cqT5EMQKS2n8MLMSrDJFBeSgMF3UZlUqih17gDNx33ORQykeGKyv6', 'patient', NULL, '2021-02-11 05:49:47', '2021-02-11 05:49:47', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (11, '患者_9', 'patient_9@test.com', NULL, '$2y$10$V7973nu1.Ue77KMXUlpJ0uKihVX5SO5c03gZTEkFkzVs2YAR3nK7G', 'patient', NULL, '2021-02-11 05:49:47', '2021-02-11 05:49:47', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (12, '患者_10', 'patient_10@test.com', NULL, '$2y$10$kNYKEC66H1xODgajM2wddOZoW2xJzxlyBJt05BKVi933y.REqkv6O', 'patient', NULL, '2021-02-11 05:49:48', '2021-02-11 05:49:48', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (13, '患者_11', 'patient_11@test.com', NULL, '$2y$10$nNa.ftxfxVC6B4Gm9vlrku.6oga3hrhgBqkmXguoaAKHEzyudR8WW', 'patient', NULL, '2021-02-11 05:49:48', '2021-02-11 05:49:48', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (14, '患者_12', 'patient_12@test.com', NULL, '$2y$10$2pLm4txQZzt3ca1A6mnbeersFiZNpJmybdqZLnBfq6jneM1srPdK6', 'patient', NULL, '2021-02-11 05:49:49', '2021-02-11 05:49:49', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (15, '患者_13', 'patient_13@test.com', NULL, '$2y$10$xfomDviclBy4Wfm1TsXxhO1xeS7JZbSiRcXEU/iRH00KnD5ktH62m', 'patient', NULL, '2021-02-11 05:49:50', '2021-02-11 05:49:50', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (16, '患者_14', 'patient_14@test.com', NULL, '$2y$10$Hyz2p3bNfiDEAXxlSzIwpOuWPme0E8WoYYAA/vxLHwOnV9mLsmH3m', 'patient', NULL, '2021-02-11 05:49:50', '2021-02-11 05:49:50', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (17, '患者_15', 'patient_15@test.com', NULL, '$2y$10$VIv1bV.70ZoPkxyeaLGwSedfCGiIGy.5NC6vad4oaUPfo9Rhzw.MK', 'patient', NULL, '2021-02-11 05:49:51', '2021-02-11 05:49:51', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (18, '患者_16', 'patient_16@test.com', NULL, '$2y$10$7knrqWM3wKEd/jC8FX8I0efYlqBOyrw5iO/QBWTe5G7a4opITPPHC', 'patient', NULL, '2021-02-11 05:49:52', '2021-02-11 05:49:52', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (19, '患者_17', 'patient_17@test.com', NULL, '$2y$10$vHNbQiWEEJCwtxF/4.Kvue9kRld3aPsD/sNzqcUir/rKIbwyWi8Xa', 'patient', NULL, '2021-02-11 05:49:52', '2021-02-11 05:49:52', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (20, '患者_18', 'patient_18@test.com', NULL, '$2y$10$Kkb3QgPGXN.XSIYn9xIhSOrKIQ3onWtipeZYm/KLl8Bbfbwckb9H6', 'patient', NULL, '2021-02-11 05:49:53', '2021-02-11 05:49:53', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (21, '患者_19', 'patient_19@test.com', NULL, '$2y$10$eVkpCiSKzc4rGLWedz81reBjM79HFJMo8y.Rn6eiEN7UeTPXc2QQ2', 'patient', NULL, '2021-02-11 05:49:54', '2021-02-11 05:49:54', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (22, '患者_20', 'patient_20@test.com', NULL, '$2y$10$KlqNTXwEzDTtEE9Mz5sONeDN01SbiIPKI8cdQCo65Wp/q3OgEpAOO', 'patient', NULL, '2021-02-11 05:49:54', '2021-02-11 05:49:54', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (23, '患者_21', 'patient_21@test.com', NULL, '$2y$10$H4rlrO6cb0TFeGV2WPK1bOA2bi8uIQxnTDP16wEoJDyhd7zv.jksS', 'patient', NULL, '2021-02-11 05:49:55', '2021-02-11 05:49:55', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (24, '患者_22', 'patient_22@test.com', NULL, '$2y$10$1BIOE4..btosxmA.9eSMqegGMbLTDHjdJ5DM26lnSjdky5OIqO9Dq', 'patient', NULL, '2021-02-11 05:49:56', '2021-02-11 05:49:56', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (25, '患者_23', 'patient_23@test.com', NULL, '$2y$10$oldGGFp90sQrtJhAcdaeK.AX15ExZpx47.y1IBlyyhJnsqHJMUtLy', 'patient', NULL, '2021-02-11 05:49:56', '2021-02-11 05:49:56', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (26, '患者_24', 'patient_24@test.com', NULL, '$2y$10$Ds/FoTw3H7g8vbXcZNGQueTnC0pYOqHkenQwBzTyLH2l0Hjqkn216', 'patient', NULL, '2021-02-11 05:49:57', '2021-02-11 05:49:57', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (27, '患者_25', 'patient_25@test.com', NULL, '$2y$10$fkSrkk7gD/aRT/06wNHbo.r75njOGoXoxaknQMVV/MUqEuihm3Z9u', 'patient', NULL, '2021-02-11 05:49:58', '2021-02-11 05:49:58', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (28, '患者_26', 'patient_26@test.com', NULL, '$2y$10$IKlCPd/YB200IvfwU683eO7gVS/FG59UDMR93FuagNodG5lHmKhH6', 'patient', NULL, '2021-02-11 05:49:59', '2021-02-11 05:49:59', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (29, '患者_27', 'patient_27@test.com', NULL, '$2y$10$QvGCz0F6sSr.R1wS8ueXKuMA3gwl5RTuwbBJXVzrjMGV8f0NjPVya', 'patient', NULL, '2021-02-11 05:49:59', '2021-02-11 05:49:59', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (30, '患者_28', 'patient_28@test.com', NULL, '$2y$10$nEE68sRDUM/lLX3dJvYVkOwoBKayRGhvnHPAjvCFsjEzfQXm90rqu', 'patient', NULL, '2021-02-11 05:50:00', '2021-02-11 05:50:00', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (31, '患者_29', 'patient_29@test.com', NULL, '$2y$10$qA.13ATVOOI2kOPCn3giBeawpT1glyZY5gh8SKjll4uanJIRa.niu', 'patient', NULL, '2021-02-11 05:50:01', '2021-02-11 05:50:01', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (32, '患者_30', 'patient_30@test.com', NULL, '$2y$10$xVRcVekDYxOS0jpg3MrMZe6pNVpu9yAWjCskrCS1oDtfuxd.gm0aO', 'patient', NULL, '2021-02-11 05:50:01', '2021-02-11 05:50:01', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (33, '患者_31', 'patient_31@test.com', NULL, '$2y$10$kmNX6YsXQy3VOyKNSB9AzuCo.FrMy8qjAOTiXt9yKICnwoFXPprx2', 'patient', NULL, '2021-02-11 05:50:02', '2021-02-11 05:50:02', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (34, '患者_32', 'patient_32@test.com', NULL, '$2y$10$VzSiWeMSsbszEIn2qDczB.dsJZkd7WpAqSQmtmo8k3ShyCAwiiKiu', 'patient', NULL, '2021-02-11 05:50:03', '2021-02-11 05:50:03', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (35, '患者_33', 'patient_33@test.com', NULL, '$2y$10$5..a4jJTZ31btRjnBKu60ePr7Hp53rqtqTZx7LsevlJtrtmgp/kOG', 'patient', NULL, '2021-02-11 05:50:04', '2021-02-11 05:50:04', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (36, '患者_34', 'patient_34@test.com', NULL, '$2y$10$Oz9.KStCpwwgY7AqQscpZ.dZkhk/16RgnR22IVH9EbKHuFrSiwhm2', 'patient', NULL, '2021-02-11 05:50:05', '2021-02-11 05:50:05', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (37, '患者_35', 'patient_35@test.com', NULL, '$2y$10$1WOgYpbWJ/.ASPRmahIfJ.c8b8gERIqmdozwgkMPrhoeZoF4ROzj.', 'patient', NULL, '2021-02-11 05:50:05', '2021-02-11 05:50:05', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (38, '患者_36', 'patient_36@test.com', NULL, '$2y$10$lYZ6XbGUcdZu8CMdZzvAtOwRu3a1.BlL1iwGDG8fDDOCY3iQYERX6', 'patient', NULL, '2021-02-11 05:50:06', '2021-02-11 05:50:06', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (39, '患者_37', 'patient_37@test.com', NULL, '$2y$10$t3GIZPvNl23yRwRCRhb9yuvf/xJIAOckLWowqnTAE.Z2GHJZd8TbK', 'patient', NULL, '2021-02-11 05:50:06', '2021-02-11 05:50:06', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (40, '患者_38', 'patient_38@test.com', NULL, '$2y$10$Yk1ZBHe6MEdISV2GDHgv6O54RXlDZRBXKL5VHNm00Xseo4qU50jdS', 'patient', NULL, '2021-02-11 05:50:07', '2021-02-11 05:50:07', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (41, '患者_39', 'patient_39@test.com', NULL, '$2y$10$KqYpHkIbHzK9R2rrIaMBZumzxQDYQMARnGYoPXE4DwnwJKsmztv5i', 'patient', NULL, '2021-02-11 05:50:08', '2021-02-11 05:50:08', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (42, '患者_40', 'patient_40@test.com', NULL, '$2y$10$EfA/8Prxqb4yXDG8OOdUouY6OP4z0/yXz2Vl7R8s2RaviVPh65OBe', 'patient', NULL, '2021-02-11 05:50:08', '2021-02-11 05:50:08', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (43, '患者_41', 'patient_41@test.com', NULL, '$2y$10$sBxpPnZwtcneicMI.KMjb.cMiCt/NIIraPIw5m0.iGiK7nn7VMc1e', 'patient', NULL, '2021-02-11 05:50:09', '2021-02-11 05:50:09', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (44, '患者_42', 'patient_42@test.com', NULL, '$2y$10$sN0skrs2aYvxdnrAhiI3VuVPS047LLehbyF5LMWgFKTD/hW/Iuwii', 'patient', NULL, '2021-02-11 05:50:10', '2021-02-11 05:50:10', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (45, '患者_43', 'patient_43@test.com', NULL, '$2y$10$jMUTltwuzm0hyDqcGJ4/JOS1CcFQttzDQI6GiOFZZf07UZ0YI67h.', 'patient', NULL, '2021-02-11 05:50:10', '2021-02-11 05:50:10', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (46, '患者_44', 'patient_44@test.com', NULL, '$2y$10$TeGqPzq2DHcEaQo0VcN61e3n0GyXA3edglGauo8PbwHNhkyHiYWjG', 'patient', NULL, '2021-02-11 05:50:11', '2021-02-11 05:50:11', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (47, '患者_45', 'patient_45@test.com', NULL, '$2y$10$9ouxvSCGGe5h9HKVM2q9a.vrhaj.4IvYtI.UX5oaKO3mRgCJo968C', 'patient', NULL, '2021-02-11 05:50:12', '2021-02-11 05:50:12', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (48, '患者_46', 'patient_46@test.com', NULL, '$2y$10$ZvG2GjHQlPVPuN7oV0C.LuYnAgHcv7PkSVdYA5PGHjaRBvvTPH1/6', 'patient', NULL, '2021-02-11 05:50:12', '2021-02-11 05:50:12', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (49, '患者_47', 'patient_47@test.com', NULL, '$2y$10$kSh/5GSicRswUmnazlP09OtnIOmLDt1rKcrEdY5hJ6/48bD9kVi1u', 'patient', NULL, '2021-02-11 05:50:13', '2021-02-11 05:50:13', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (50, '患者_48', 'patient_48@test.com', NULL, '$2y$10$0ol7DDiBopg0AoYts8I9WO3F1lkwnIsvzwsiiZoKF50NjIradNQje', 'patient', NULL, '2021-02-11 05:50:13', '2021-02-11 05:50:13', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (51, '患者_49', 'patient_49@test.com', NULL, '$2y$10$BdLJJ7wGE1Wg4GqW33GuAuBDCgveZhTgksBffIBj1R4GuZQjookwy', 'patient', NULL, '2021-02-11 05:50:14', '2021-02-11 05:50:14', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (52, '患者_50', 'senior.webdev92@gmail.com', NULL, '$2y$10$buPcscvyJMN5TDqqZ2FF1.Ytu7TiEB45jNYqXkdTK2QT2pBAueU5O', 'patient', 'Rtb4NI5RIjobuNh6OmtQW8U4rbH4z4Jc4TflaTx5yj8IEIW1kdt5n5Ps6I05', '2021-02-11 05:50:15', '2022-03-20 18:31:49', NULL, NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (54, '患者_51', 'admin@admin.com', NULL, '$2y$10$EFbrMfVrIAyITY3GsjATmedaTY9cZUWVGareFtRPzkFGPsKkHk5mS', 'admin', NULL, '2021-02-11 05:50:15', '2021-02-11 05:50:15', 'dWJHV1YD2hHASqntpoe4', NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (57, 'tanakaDr11111', 'doctor@gmail.com', NULL, '$2y$10$zhBAjFjWFYqaX7jfCijuZe3l1RS.CtWNUNYRMhkqEsxc6.TUMTYAq', 'doctor', '', '2021-04-23 23:30:56', '2022-06-19 23:38:23', 'dWJHV1YD2hHASqntpoe4', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (58, '医師-2', 'doctor116@gmail.com', NULL, '$2y$10$xkNQnjZ0DudR2GDQACo31OAtzFHdzuASkRh0UcrEByqlq5Vl.1I9a', 'doctor', NULL, '2021-05-07 11:41:17', '2021-05-07 11:41:17', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (59, '医師-3', 'doctor59@gmail.com', NULL, '$2y$10$3WD/I2KTp1Mz818t2xHSJOEWCSExDWAWPvMtIGzJ3seXuObTXNX9S', 'doctor', NULL, '2021-05-07 11:43:40', '2021-05-07 11:43:40', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (60, '医師-4', 'doctor61@gmail.com', NULL, '$2y$10$mLuTtvnnnsrUHdZiFmmJC.RupIJhohkmkmbshAetFMKBujA6qz6Vq', 'doctor', NULL, '2021-05-07 11:49:58', '2021-05-07 11:49:58', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (61, '医師-5', 'ggg@gmail.com', NULL, '$2y$10$xifFrq668dljJAoTLaafL.nW4c73cobgpAOw50qmXo26ZJS5THLli', 'doctor', NULL, '2021-05-07 11:57:58', '2021-05-07 12:15:25', '1cCQT9ms4EOeVYLmRa0s', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (62, '医師-6', 'www@gmail.com', NULL, '$2y$10$KkPiGXMoNxejDPX5lGyxDuVBLNWypbInR62AWtanQ9C1PDsYQKPKC', 'doctor', NULL, '2021-05-07 11:59:29', '2021-05-07 11:59:29', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (63, '医師-7', 'vvv@gmail.com', NULL, '$2y$10$2OcMTKweToOoMPas4ehgFeQ6JOMBbLY2DlNXQWQtWpFYYGdXxWZwG', 'doctor', NULL, '2021-05-07 12:00:12', '2021-05-07 12:00:12', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (64, '医師-8', 'vvss@gmail.com', NULL, '$2y$10$2iTCRy1KEjV.8POiEJAfEOPRv85ds3AHWQS7jeC9EeNj9gv.NctR2', 'doctor', NULL, '2021-05-07 12:01:40', '2021-05-07 12:02:48', 'Wtx02lqqcG4k7Lx9Tnxs', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (65, '医師-9', 'eee@gmail.com', NULL, '$2y$10$MGSNTSN4FAXvt5MrnoIia..HraJ8gQfW4d01a1CiFpGhDiCn2gVhC', 'doctor', NULL, '2021-05-07 12:03:07', '2021-05-07 12:03:07', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (66, 'クリニック3', 'senior.webdev921@gmail.com', NULL, '$2y$10$hiG3GU.74sLZAmVHjgYGAuZWckg94J9/KgrZQEWnA9OgPwYBjVYTK', 'clinic', 'Z0wFvH8DvSbBMv2xopMglMvhIg9Gu7lpvPbPd9vMvWxH9IdVRKLPCLl9dlPN', '2021-02-11 05:49:40', '2021-07-19 05:00:32', 'YKo7jsNyr5yIXe79xK1T', NULL, 0, NULL, NULL);
INSERT INTO `users` VALUES (68, 'クリニック2', 'test1@test.com', NULL, '$2y$10$lWI.AFC3irBrE01xKKsv9.tX7aFgZQcenmM5wb94OcHfHgnsXgQzy', 'clinic', NULL, '2021-07-19 05:12:46', '2021-07-19 05:12:47', 'iP6VOazntAa647avKWlN', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (69, 'あだ', 'senior.webdev9212@gmail.com', NULL, '$2y$10$pNf2tg7RpKTZT/E9uTjBVOCG08D7d5GWBzxfdyy09iOIZWWOvjYOS', 'doctor', 'GsR2uHieDbU68I7nlQ08u3evLY99DKCFz7QikJbcak4W4RpY0jNs3SSe8yPk', '2021-04-23 23:30:56', '2021-07-21 03:57:03', 'dWJHV1YD2hHASqntpoe4', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (70, 'tanakaDr222', 'abc@gmail.com', NULL, '$2y$10$wiy3AgiIfKUJugr.HDf8Jet.qJ7iWj7Q7vNpoN1FdfLgcd1E7lWHu', 'doctor', NULL, '2021-08-18 02:20:34', '2021-08-18 02:21:32', 'p4h8MQCVrNAXXTQRODbi', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (71, NULL, 'abcd@gmail.com', NULL, '$2y$10$56LRqKML11qVTYT.7or/huFrOdlLWHsWpQmADQqN2R3arbQiil9lW', 'clinic', NULL, '2021-08-17 17:42:24', '2021-08-17 17:42:25', 'XMzWsAcr5h2X0Rg6EL49', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (72, NULL, 'p1@test.com', NULL, '$2y$10$DlEa.I2WmpMOCTNzc87xuOepAaOsWICl7EI2sVZaozfw2t77ounA2', 'patient', NULL, '2022-03-20 18:18:52', '2022-03-20 18:18:52', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (73, NULL, 'p6@test.com', NULL, '$2y$10$UquBQ5/Q3vDBdLGXId7yeuWFR1ELPvIi8e352fjwYquE3nmM7pvcq', 'patient', NULL, '2022-04-05 07:50:47', '2022-04-05 07:50:47', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (74, NULL, 'f2@1.com', NULL, NULL, 'patient', NULL, '2022-04-18 13:21:08', '2022-04-18 13:21:08', NULL, NULL, 1, 'facebook', '123123122');
INSERT INTO `users` VALUES (75, NULL, 'f222@1.com', NULL, NULL, 'patient', NULL, '2022-04-18 13:21:21', '2022-04-18 13:21:21', NULL, NULL, 1, 'facebook', '123123122');
INSERT INTO `users` VALUES (76, NULL, 'p2@test.com', NULL, '$2y$10$8CjMblWjiBlDKMd8SAkerejdgThpUc7j/bO2E/CWVD5UACjCUdJbG', 'patient', NULL, '2022-04-22 03:28:48', '2022-04-22 03:28:48', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (77, NULL, 'ryu@test.com', NULL, '$2y$10$MetAbSiHufnwOYNwVApIT.3mqxNhY0LJRlTVH1C4U09n/5.NoU3M2', 'patient', NULL, '2022-04-25 07:42:55', '2022-04-25 07:42:55', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (78, NULL, 'p11@test.com', NULL, '$2y$10$YBMAJIZd3eBqtVvz3Zg7yunlFj/oU5puoAfZM5O/dWkPS.MBat7uO', 'patient', NULL, '2022-04-25 12:07:06', '2022-04-25 12:07:06', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (79, NULL, 'zzz@test.com', NULL, '$2y$10$XVn6Wz3HGKy5DxnM71XgAu41BhZJ6GX8FthZykp7U/Z0pRk/pEM6G', 'patient', NULL, '2022-04-25 13:07:13', '2022-04-25 13:07:13', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (80, NULL, 'p427@test.com', NULL, '$2y$10$e5lmhSHdB/LIjEMNB8gQF.zdYo00YyjcCIbyK00nP22g9B.dWDvXe', 'patient', NULL, '2022-04-27 07:40:45', '2022-04-27 07:40:45', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (81, NULL, 'p236@test.com', NULL, '$2y$10$Ii1pEn8pDLRPqkAIsbjWtu.JnrnoLTUJw9f/g1pjnuEMyWST8Vmpm', 'patient', NULL, '2022-04-27 07:47:12', '2022-04-27 07:47:12', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (82, NULL, 'p101@test.com', NULL, '$2y$10$aqZsl6Ri44990zXakgUqJef2nj8PcFR8Uc2yM/553G8699ZEaiROC', 'patient', NULL, '2022-04-30 14:51:01', '2022-04-30 14:51:01', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (83, NULL, 'p102@test.com', NULL, '$2y$10$0gkqAUOXOkbqgGFqkqcp0OVfqAoAhLzOOu.NT9rXTuctBna8o6lwu', 'patient', NULL, '2022-04-30 14:54:49', '2022-04-30 14:54:49', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (84, NULL, 'mmm@test.com', NULL, '$2y$10$amOY76EUmrbQ1UMOljFUjuBL2MdtM6SS1EQTflvllcyzrGS/xQLtS', 'patient', NULL, '2022-05-02 08:18:33', '2022-05-02 08:18:33', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (85, NULL, 'p103@test.com', NULL, '$2y$10$4Cw2BBOsogIWch7Rh1nLz..vXgNZE1j9gQp8NKYlsw3JRtnyVfwCO', 'patient', NULL, '2022-05-02 08:24:29', '2022-05-02 08:24:29', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (86, NULL, 'hsmsk@gmai.com', NULL, '$2y$10$M.5mUkuVBOoEmTOdvg1loO6MpIsPVDuwZWKlklc9lnJaUrb3SNaXC', 'patient', NULL, '2022-05-17 13:28:59', '2022-05-17 13:28:59', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (87, NULL, 'a@gmail.com', NULL, '$2y$10$mZuPht6nV6D7.799kLD9qeZtToK5JTijcnMK7sajuPpwnVv1aIHMC', 'patient', NULL, '2022-05-18 02:25:14', '2022-05-18 02:25:14', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (88, NULL, 'qqq@gmail.com', NULL, '$2y$10$0zk.iyKLTaW0S0fPac/OfuFHTvGfHZoUQB2v7H9gV1YC9fIFOGDjK', 'patient', NULL, '2022-05-20 05:48:01', '2022-05-20 05:48:01', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (89, NULL, 'qqw@gmail.com', NULL, '$2y$10$KGaULgPCdMSl7yoMgStXq.9jJtOX7hA.SiLhdkzb0w3Y9XLoVRoH.', 'patient', NULL, '2022-05-20 05:56:28', '2022-05-20 05:56:28', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (90, NULL, 'patient_1@test.com', NULL, '$2y$10$zhBAjFjWFYqaX7jfCijuZe3l1RS.CtWNUNYRMhkqEsxc6.TUMTYAq', 'patient', NULL, '2022-05-20 14:03:17', '2022-05-20 14:03:17', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (91, NULL, 'ttt@gmail.com', NULL, '$2y$10$NVSkFlLfv93tuheNpeOf/.dD.3UYWcB.6A7Sfje44Bsx4RuJh0fNK', 'patient', NULL, '2022-05-24 08:30:22', '2022-05-24 08:30:22', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (92, NULL, 'ooo@gmail.com', NULL, '$2y$10$2Y1IGQY3M9A3RT87AE62sOdEWsBIJl6Y0oUphhsQ.iYsO6lc7cuDO', 'patient', NULL, '2022-05-28 09:09:56', '2022-05-28 09:09:56', NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (93, NULL, 'ttt2222@gmail.com', NULL, '$2y$10$tOQoqz1iJ9oF/F.1yTm2XO95YQbfvNKWB3iczizu/FpvG6eSwTgeS', 'clinic', NULL, '2022-06-01 18:24:47', '2022-06-01 18:42:25', 'ezNVBeYtDC7d1benwuE1', NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (94, NULL, 'ttt111@gmail.com', NULL, '$2y$10$guM5vdhqJCZOi24t6JQbpuGGxuLvG4gVQictZ.nD3IrVAhhU01Jc.', 'clinic', NULL, '2022-06-01 18:58:58', '2022-06-01 18:58:59', '7S1skrC0eXqBt6IKlIgm', NULL, 1, NULL, NULL);

-- ----------------------------
-- Table structure for viewables
-- ----------------------------
DROP TABLE IF EXISTS `viewables`;
CREATE TABLE `viewables`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `viewable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `viewable_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `viewables_viewable_type_viewable_id_index`(`viewable_type`, `viewable_id`) USING BTREE,
  INDEX `viewables_patient_id_foreign`(`patient_id`) USING BTREE,
  CONSTRAINT `viewables_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viewables
-- ----------------------------
INSERT INTO `viewables` VALUES (17, 67, 'App\\Models\\Doctor', 70, NULL, NULL);
INSERT INTO `viewables` VALUES (18, 67, 'App\\Models\\Diary', 1, NULL, NULL);
INSERT INTO `viewables` VALUES (19, 70, 'App\\Models\\Doctor', 70, NULL, NULL);
INSERT INTO `viewables` VALUES (20, 70, 'App\\Models\\Question', 1, NULL, NULL);
INSERT INTO `viewables` VALUES (21, 70, 'App\\Models\\Doctor', 74, NULL, NULL);
INSERT INTO `viewables` VALUES (22, 70, 'App\\Models\\Doctor', 78, NULL, NULL);
INSERT INTO `viewables` VALUES (23, 70, 'App\\Models\\Question', 13, NULL, NULL);
INSERT INTO `viewables` VALUES (24, 70, 'App\\Models\\Question', 12, NULL, NULL);
INSERT INTO `viewables` VALUES (25, 70, 'App\\Models\\Question', 10, NULL, NULL);
INSERT INTO `viewables` VALUES (26, 70, 'App\\Models\\Question', 11, NULL, NULL);
INSERT INTO `viewables` VALUES (27, 70, 'App\\Models\\Question', 9, NULL, NULL);
INSERT INTO `viewables` VALUES (28, 70, 'App\\Models\\Doctor', 71, NULL, NULL);
INSERT INTO `viewables` VALUES (29, 70, 'App\\Models\\Question', 5, NULL, NULL);
INSERT INTO `viewables` VALUES (30, 70, 'App\\Models\\Question', 4, NULL, NULL);
INSERT INTO `viewables` VALUES (31, 70, 'App\\Models\\Diary', 10, NULL, NULL);

-- ----------------------------
-- Table structure for withdraws
-- ----------------------------
DROP TABLE IF EXISTS `withdraws`;
CREATE TABLE `withdraws`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinic_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `month` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '年・月',
  `price` int(11) NULL DEFAULT 0 COMMENT '売上',
  `tax` double(8, 2) NULL DEFAULT 10 COMMENT '手数料',
  `system_fee` int(11) NULL DEFAULT 50000 COMMENT 'システム利用料',
  `paid_at` datetime(0) NULL DEFAULT NULL COMMENT '支払日',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `withdraws_clinic_id_foreign`(`clinic_id`) USING BTREE,
  CONSTRAINT `withdraws_clinic_id_foreign` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of withdraws
-- ----------------------------
INSERT INTO `withdraws` VALUES (1, 1, '2021-01', 604742, 10.00, 50000, '2021-01-28 12:00:00', '2021-02-11 05:50:16', '2021-02-11 05:50:16');
INSERT INTO `withdraws` VALUES (2, 1, '2020-12', 956306, 10.00, 50000, '2020-12-28 12:00:00', '2021-02-11 05:50:16', '2021-02-11 05:50:16');
INSERT INTO `withdraws` VALUES (3, 1, '2020-11', 202106, 10.00, 50000, '2020-11-28 12:00:00', '2021-02-11 05:50:16', '2021-02-11 05:50:16');
INSERT INTO `withdraws` VALUES (4, 1, '2020-10', 713334, 10.00, 50000, '2020-10-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (5, 1, '2020-09', 237198, 10.00, 50000, '2020-09-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (6, 1, '2020-08', 916973, 10.00, 50000, '2020-08-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (7, 1, '2020-07', 679513, 10.00, 50000, '2020-07-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (8, 1, '2020-06', 743249, 10.00, 50000, '2020-06-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (9, 1, '2020-05', 201877, 10.00, 50000, '2020-05-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (10, 1, '2020-04', 109769, 10.00, 50000, '2020-04-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (11, 1, '2020-03', 612293, 10.00, 50000, '2020-03-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (12, 1, '2020-02', 696280, 10.00, 50000, '2020-02-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (13, 1, '2020-01', 214580, 10.00, 50000, '2020-01-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (14, 1, '2019-12', 731037, 10.00, 50000, '2019-12-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (15, 1, '2019-11', 594083, 10.00, 50000, '2019-11-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (16, 1, '2019-10', 440376, 10.00, 50000, '2019-10-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (17, 1, '2019-09', 921646, 10.00, 50000, '2019-09-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (18, 1, '2019-08', 797579, 10.00, 50000, '2019-08-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (19, 1, '2019-07', 287624, 10.00, 50000, '2019-07-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (20, 1, '2019-06', 591557, 10.00, 50000, '2019-06-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (21, 1, '2019-05', 250241, 10.00, 50000, '2019-05-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (22, 1, '2019-04', 420855, 10.00, 50000, '2019-04-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (23, 1, '2019-03', 516691, 10.00, 50000, '2019-03-28 12:00:00', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (24, 1, '2019-02', 396451, 10.00, 50000, '2022-03-12 21:56:42', '2021-02-11 05:50:17', '2021-02-11 05:50:17');
INSERT INTO `withdraws` VALUES (25, 1, '2022-02', 160639, 10.00, 50000, '2022-03-10 22:08:34', '2022-03-11 12:57:18', '2022-03-16 19:35:55');
INSERT INTO `withdraws` VALUES (26, 1, '2022-06', 10000, 10.00, 50000, NULL, '2022-06-30 07:56:19', '2022-06-30 07:56:19');
INSERT INTO `withdraws` VALUES (27, 1, '2022-07', 48235, 10.00, 50000, NULL, '2022-07-04 11:17:26', '2022-07-04 13:14:10');

SET FOREIGN_KEY_CHECKS = 1;
