/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50643
 Source Host           : localhost:3306
 Source Schema         : sens_blog_init

 Target Server Type    : MySQL
 Target Server Version : 50643
 File Encoding         : 65001

 Date: 04/11/2019 20:48:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sens_attachment
-- ----------------------------
DROP TABLE IF EXISTS `sens_attachment`;
CREATE TABLE `sens_attachment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attach_name` varchar(255) DEFAULT NULL,
  `attach_path` varchar(255) DEFAULT NULL,
  `attach_size` varchar(255) DEFAULT NULL,
  `attach_small_path` varchar(255) DEFAULT NULL,
  `attach_suffix` varchar(255) DEFAULT NULL,
  `attach_type` varchar(255) DEFAULT NULL,
  `attach_wh` varchar(255) DEFAULT NULL,
  `attach_location` varchar(255) DEFAULT NULL,
  `attach_origin` int(1) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_category
-- ----------------------------
DROP TABLE IF EXISTS `sens_category`;
CREATE TABLE `sens_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(100) DEFAULT NULL,
  `cate_url` varchar(100) DEFAULT NULL,
  `cate_pid` bigint(20) DEFAULT NULL,
  `cate_sort` int(11) DEFAULT '1',
  `cate_level` int(11) DEFAULT '1',
  `cate_desc` varchar(100) DEFAULT NULL,
  `path_trace` varchar(1000) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_comment
-- ----------------------------
DROP TABLE IF EXISTS `sens_comment`;
CREATE TABLE `sens_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_agent` varchar(255) DEFAULT NULL,
  `comment_author` varchar(255) DEFAULT NULL,
  `comment_author_email_md5` varchar(255) DEFAULT NULL,
  `comment_author_email` varchar(255) DEFAULT NULL,
  `comment_author_ip` varchar(255) DEFAULT NULL,
  `comment_author_url` varchar(255) DEFAULT NULL,
  `comment_content` text,
  `comment_parent` bigint(20) DEFAULT NULL,
  `comment_status` int(11) DEFAULT NULL,
  `is_admin` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `path_trace` varchar(1000) DEFAULT NULL,
  `comment_author_avatar` varchar(255) DEFAULT NULL,
  `accept_user_id` bigint(20) DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(255) DEFAULT 'admin',
  `update_by` varchar(255) DEFAULT 'admin',
  `comment_type` int(1) DEFAULT '0',
  `del_flag` int(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKlhqkt5diooecok7509whj2li6` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4254 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_link
-- ----------------------------
DROP TABLE IF EXISTS `sens_link`;
CREATE TABLE `sens_link` (
  `id` bigint(20) NOT NULL,
  `link_desc` varchar(255) DEFAULT NULL,
  `link_name` varchar(255) DEFAULT NULL,
  `link_pic` varchar(255) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_log
-- ----------------------------
DROP TABLE IF EXISTS `sens_log`;
CREATE TABLE `sens_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cost_time` int(11) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` longtext,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `log_type` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sens_mail_retrieve
-- ----------------------------
DROP TABLE IF EXISTS `sens_mail_retrieve`;
CREATE TABLE `sens_mail_retrieve` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `outTime` datetime DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_menu
-- ----------------------------
DROP TABLE IF EXISTS `sens_menu`;
CREATE TABLE `sens_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu_icon` varchar(255) DEFAULT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `menu_sort` int(11) DEFAULT NULL,
  `menu_target` varchar(255) DEFAULT NULL,
  `menu_url` varchar(255) DEFAULT NULL,
  `menu_pid` bigint(20) DEFAULT NULL,
  `menu_type` int(1) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_options
-- ----------------------------
DROP TABLE IF EXISTS `sens_options`;
CREATE TABLE `sens_options` (
  `option_name` varchar(127) NOT NULL,
  `option_value` longtext,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_options_name` (`option_name`) USING BTREE COMMENT '唯一'
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_post
-- ----------------------------
DROP TABLE IF EXISTS `sens_post`;
CREATE TABLE `sens_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `allow_comment` int(11) DEFAULT NULL,
  `post_content` longtext,
  `post_status` int(11) DEFAULT NULL,
  `post_summary` varchar(2000) DEFAULT NULL,
  `post_thumbnail` varchar(255) DEFAULT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `post_type` varchar(255) DEFAULT NULL,
  `post_url` varchar(255) DEFAULT NULL,
  `post_views` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `post_source` int(11) DEFAULT NULL,
  `comment_size` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `post_likes` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(255) DEFAULT 'admin',
  `update_by` varchar(255) DEFAULT 'admin',
  `del_flag` int(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK5hvavpcp1efcf6vxo09bhi9a7` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9445 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_post_category_ref
-- ----------------------------
DROP TABLE IF EXISTS `sens_post_category_ref`;
CREATE TABLE `sens_post_category_ref` (
  `post_id` bigint(20) NOT NULL,
  `cate_id` bigint(20) NOT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKatntuqmrfdi01vecyyi24arus` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=981 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_post_tag_ref
-- ----------------------------
DROP TABLE IF EXISTS `sens_post_tag_ref`;
CREATE TABLE `sens_post_tag_ref` (
  `post_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKix1v0nbpp1c84a3v9b917u9ii` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1100 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_rbac_permission
-- ----------------------------
DROP TABLE IF EXISTS `sens_rbac_permission`;
CREATE TABLE `sens_rbac_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT 'admin',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT 'admin',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort` double(11,0) DEFAULT '1',
  `target` varchar(20) DEFAULT '_self',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_rbac_role
-- ----------------------------
DROP TABLE IF EXISTS `sens_rbac_role`;
CREATE TABLE `sens_rbac_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `level` int(1) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_role` (`role`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_rbac_role_permission_ref
-- ----------------------------
DROP TABLE IF EXISTS `sens_rbac_role_permission_ref`;
CREATE TABLE `sens_rbac_role_permission_ref` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=822 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_rbac_user_role_ref
-- ----------------------------
DROP TABLE IF EXISTS `sens_rbac_user_role_ref`;
CREATE TABLE `sens_rbac_user_role_ref` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_slide
-- ----------------------------
DROP TABLE IF EXISTS `sens_slide`;
CREATE TABLE `sens_slide` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slide_title` varchar(255) DEFAULT NULL,
  `slide_sort` int(11) DEFAULT NULL,
  `slide_target` varchar(255) DEFAULT NULL,
  `slide_url` varchar(255) DEFAULT NULL,
  `slide_picture_url` varchar(255) DEFAULT NULL,
  `slide_type` int(1) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_tag
-- ----------------------------
DROP TABLE IF EXISTS `sens_tag`;
CREATE TABLE `sens_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(100) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_third_app_bind
-- ----------------------------
DROP TABLE IF EXISTS `sens_third_app_bind`;
CREATE TABLE `sens_third_app_bind` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) DEFAULT NULL,
  `app_type` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_user
-- ----------------------------
DROP TABLE IF EXISTS `sens_user`;
CREATE TABLE `sens_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_enable` varchar(10) DEFAULT NULL,
  `login_error` int(11) DEFAULT NULL,
  `login_last` datetime DEFAULT NULL,
  `user_avatar` varchar(255) DEFAULT NULL,
  `user_desc` varchar(255) DEFAULT NULL,
  `user_display_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_pass` varchar(255) DEFAULT NULL,
  `user_site` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `email_enable` varchar(10) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(255) DEFAULT 'admin',
  `update_by` varchar(255) DEFAULT 'admin',
  `del_flag` int(1) DEFAULT '0',
  `is_admin` int(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sens_widget
-- ----------------------------
DROP TABLE IF EXISTS `sens_widget`;
CREATE TABLE `sens_widget` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `widget_title` varchar(255) DEFAULT NULL,
  `widget_content` varchar(3000) DEFAULT NULL,
  `widget_type` int(1) DEFAULT NULL,
  `is_display` int(1) DEFAULT NULL,
  `del_flag` int(1) DEFAULT '0',
  `create_by` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
