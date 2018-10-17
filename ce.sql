/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50168
Source Host           : localhost:3306
Source Database       : ce

Target Server Type    : MYSQL
Target Server Version : 50168
File Encoding         : 65001

Date: 2018-10-13 22:23:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('11', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add ce', '7', 'add_ce');
INSERT INTO `auth_permission` VALUES ('20', 'Can change ce', '7', 'change_ce');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete ce', '7', 'delete_ce');
INSERT INTO `auth_permission` VALUES ('22', 'Can add message', '8', 'add_message');
INSERT INTO `auth_permission` VALUES ('23', 'Can change message', '8', 'change_message');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete message', '8', 'delete_message');
INSERT INTO `auth_permission` VALUES ('25', 'Can add stu', '9', 'add_stu');
INSERT INTO `auth_permission` VALUES ('26', 'Can change stu', '9', 'change_stu');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete stu', '9', 'delete_stu');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('7', 'sqlapp', 'ce');
INSERT INTO `django_content_type` VALUES ('8', 'sqlapp', 'message');
INSERT INTO `django_content_type` VALUES ('9', 'sqlapp', 'stu');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-09-15 07:26:32');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2018-09-15 07:26:32');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('13', 'sessions', '0001_initial', '2018-09-15 07:26:33');
INSERT INTO `django_migrations` VALUES ('14', 'sqlapp', '0001_initial', '2018-09-15 07:26:33');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for sqlapp_ce
-- ----------------------------
DROP TABLE IF EXISTS `sqlapp_ce`;
CREATE TABLE `sqlapp_ce` (
  `username` varchar(15) NOT NULL,
  `password` varchar(15) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlapp_ce
-- ----------------------------
INSERT INTO `sqlapp_ce` VALUES ('13026366301', '111111');
INSERT INTO `sqlapp_ce` VALUES ('13212711433', '11111');
INSERT INTO `sqlapp_ce` VALUES ('13212777771', '11111');
INSERT INTO `sqlapp_ce` VALUES ('13512345698', 'liu123456');
INSERT INTO `sqlapp_ce` VALUES ('13789956145', '123456');
INSERT INTO `sqlapp_ce` VALUES ('15549605335', '123456');
INSERT INTO `sqlapp_ce` VALUES ('18112345612', 'liu123456');
INSERT INTO `sqlapp_ce` VALUES ('18671223731', '123456');
INSERT INTO `sqlapp_ce` VALUES ('18671223739', '123456');

-- ----------------------------
-- Table structure for sqlapp_message
-- ----------------------------
DROP TABLE IF EXISTS `sqlapp_message`;
CREATE TABLE `sqlapp_message` (
  `title` varchar(20) NOT NULL,
  `salarytreatment` int(11) NOT NULL,
  `demand` varchar(300) NOT NULL,
  `conpanyname` varchar(30) NOT NULL,
  `number` varchar(12) NOT NULL,
  `snum` varchar(300) NOT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlapp_message
-- ----------------------------
INSERT INTO `sqlapp_message` VALUES ('web', '3000', '熟练django模块', '武汉软帝信息科技有限公司', '13026366301', '/13789956145/');
INSERT INTO `sqlapp_message` VALUES ('python', '2000', '熟练掌握python技能', '北京滴滴信息科技有限公司', '13512345698', '/13789956145/13026366301/');
INSERT INTO `sqlapp_message` VALUES ('c', '20000', '好好工作，努力赚钱', '杭州阿里巴巴信息技术股份有限公司', '15549605335', '/13789956145/');
INSERT INTO `sqlapp_message` VALUES ('web', '100000', '会高级算法', '深圳腾讯信息科技有限公司', '18671223739', '/13789956145/');

-- ----------------------------
-- Table structure for sqlapp_stu
-- ----------------------------
DROP TABLE IF EXISTS `sqlapp_stu`;
CREATE TABLE `sqlapp_stu` (
  `stuname` varchar(15) NOT NULL,
  `stuage` int(11) NOT NULL,
  `stusex` varchar(3) NOT NULL,
  `stuhome` varchar(30) NOT NULL,
  `stuschool` varchar(30) NOT NULL,
  `stunumber` varchar(12) NOT NULL,
  `stuyz` int(11) NOT NULL,
  `stuaddress` varchar(30) NOT NULL,
  `stugrjs` varchar(500) NOT NULL,
  `bnum` varchar(300) NOT NULL,
  PRIMARY KEY (`stuname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlapp_stu
-- ----------------------------
INSERT INTO `sqlapp_stu` VALUES ('刘德华', '21', '男', '湖北武汉', '武汉大学', '13512345698', '123456', '湖北武汉', '疯狂热爱python', '18671223739//');
INSERT INTO `sqlapp_stu` VALUES ('刘方圆', '21', '男', '湖北', '北京大学', '13026366301', '432600', '湖北', '冲钱就能让你变得更强', '13512345698//');
INSERT INTO `sqlapp_stu` VALUES ('剑圣', '21', '男', '湖北', '湖师', '13212711433', '432600', '巨神峰', '我是易大师', '/');
INSERT INTO `sqlapp_stu` VALUES ('张三', '22', '男', '湖北武汉', '北京大学', '15512345678', '123456', '湖北武汉', '疯狂热爱IT', '/');
INSERT INTO `sqlapp_stu` VALUES ('范冰冰', '35', '女', '中国上海', '上海戏剧学院', '13023451798', '123456', '上海市', '演员', '18671223739//');
INSERT INTO `sqlapp_stu` VALUES ('马云', '55', '男', '浙江省杭州市', '杭州师范大学', '15549605335', '432600', '杭州阿里巴巴', '国人评价马云多是觉得他是一个神话般的人物，是中国的骄傲。而外媒评价马云，则是觉得他是一个像沃伦·巴菲特一样智慧的人。 马云是一个有理想的人，拥有一个不屈的灵魂。（温家宝总理评） [123]  看到大陆的年轻人这么棒我感到非常开心。（李嘉诚评） [108]  马云是一个非常优秀的CEO，是中国互联网的一个传奇。（郎咸平评价）', '/');
INSERT INTO `sqlapp_stu` VALUES ('马化腾', '48', '男', '广东省汕头市', '深圳大学', '13789956145', '432600', '深圳市腾讯公司', '冲钱就能让你变得更强', '15549605335/13026366301/18671223739//');
