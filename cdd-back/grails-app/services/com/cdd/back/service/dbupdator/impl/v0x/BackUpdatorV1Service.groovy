package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV1Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """\

			CREATE TABLE `back_requestmap` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `authority` varchar(255) COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `method` varchar(255) COLLATE utf8_bin NULL,
			  `description` varchar(255) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `url` varchar(255) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_url` (`url`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""

		sqls << """\
		
			CREATE TABLE `back_role` (
		  	`id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_name` (`name`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""

		sqls << """\
		
			CREATE TABLE `back_role_authority` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `map_id` bigint(20) NOT NULL,
			  `role_id` bigint(20) NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`),
			  KEY `FK_request_map_id` (`map_id`),
			  KEY `FK_role_id` (`role_id`),
			  CONSTRAINT `FK_requestmap_id` FOREIGN KEY (`map_id`) REFERENCES `back_requestmap` (`id`),
			  CONSTRAINT `FK_role_id` FOREIGN KEY (`role_id`) REFERENCES `back_role` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""

		sqls << """\
		
			CREATE TABLE `back_user` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `account_expiry_date` date NULL,
			  `account_locked_count` int(11) NOT NULL,
			  `birth` date DEFAULT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `email` varchar(255) COLLATE utf8_bin NOT NULL,
			  `enabled` bit(1) NOT NULL,
			  `firstname` varchar(255) COLLATE utf8_bin NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `lastname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `middlename` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `mobile` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `password` varchar(255) COLLATE utf8_bin NOT NULL,
			  `password_expiry_date` date NULL,
			  `role_id` bigint(20) NOT NULL,
			  `salt` varchar(20) COLLATE utf8_bin NOT NULL,
			  `sex` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `username` varchar(255) COLLATE utf8_bin NOT NULL,
				`login_time` datetime DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_email` (`email`),
			  UNIQUE KEY `UK_username` (`username`),
				KEY `FK_user_role_id` (`role_id`),
				CONSTRAINT `FK_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `back_role` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		
		"""

		sqls << """
		
			CREATE TABLE `back_menu` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `icon` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `map_id` bigint(20) DEFAULT NULL,
				`orders` int(11) NOT NULL,
			  `name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `parent_id` bigint(20) DEFAULT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_name` (`name`),
			  KEY `FK_map` (`map_id`),
			  KEY `FK_parent` (`parent_id`),
			  CONSTRAINT `FK_map` FOREIGN KEY (`map_id`) REFERENCES `back_requestmap` (`id`),
			  CONSTRAINT `FK_parent` FOREIGN KEY (`parent_id`) REFERENCES `back_menu` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		
		"""

		return sqls
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/', description: '首页'],
			[url: '/**/favicon.ico', description: '网址logo'],
			[url: '/assets/**', description: '静态资源'],
			[url: '/**/js/**', description: 'javascript'],
			[url: '/**/css/**', description: 'css'],
			[url: '/**/images/**', description: '图片'],
			[url: '/login/**', description: '登陆'],
			[url: '/logout/**', description: '退出'],
			[url: '/entry/**', description: '系统入口', authority: "AUTH_ENTRY"],
			[url: '/user/enable/**', description: '禁用/启用用户', authority: "AUTH_USER_ENABLE"],
			[url: '/user/delete/**', description: '删除用户', authority: "AUTH_USER_DELETE"],
			[url: '/user/save/**', description: '保存用户', authority: "AUTH_USER_SAVE"],
			[url: '/user/data/**', description: '查看用户信息', authority: "AUTH_USER_DATA"],
			[url: '/user/resetPassword/**', description: '重置密码', authority: "AUTH_USER_RESET_PASSWORD"],
			[url: '/user/self/**', description: '查看本人信息', authority: "AUTH_USER_SELF"],
			[url: '/user/saveSelf/**', description: '保存本人信息', authority: "AUTH_USER_SAVE_SELF"],
			[url: '/role/delete/**', description: '删除角色', authority: "AUTH_ROLE_DELETE"],
			[url: '/role/save/**', description: '保存角色', authority: "AUTH_ROLE_SAVE"],
			[url: '/role/data/**', description: '查看角色信息', authority: "AUTH_ROLE_DATA"],
			[url: '/authority/data/**', description: '查看权限信息', authority: "AUTH_REQUESTMAP_DATA"],
			[url: '/authority/save/**', description: '保存权限', authority: "AUTH_REQUESTMAP_SAVE"],
			[url: '/authority/delete/**', description: '删除权限', authority: "AUTH_REQUESTMAP_DELETE"],
			[url: '/menu/data/**', description: '查看菜单信息', authority: "AUTH_MENU_DATA"],
			[url: '/menu/save/**', description: '保存菜单', authority: "AUTH_MENU_SAVE"],
			[url: '/menu/delete/**', description: '删除菜单', authority: "AUTH_MENU_DELETE"],
		].each { params ->
			if(!params.authority) {
				params.authority = SpringSecurityConstant.AUTH_PERMIT_ALL
			}
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		Menu menu_system = new Menu(name: '系统管理', icon: 'cogs', createBy: systemUser, updateBy: systemUser).save()

		menuHelper.createMenu([authority: 'AUTH_USER_LIST',
			url: '/user/list/**',
			description: '用户管理'],
		[name: '用户管理', icon: 'users'], menu_system)

		menuHelper.createMenu([authority: 'AUTH_ROLE_LIST',
			url: '/role/list/**',
			description: '角色管理'],
		[name: '角色管理', icon: 'user'], menu_system)

		menuHelper.createMenu([authority: 'AUTH_AUTHORITY_LIST',
			url: '/authority/list/**',
			description: '权限管理'],
		[name: '权限管理', icon: 'sliders'], menu_system)

		menuHelper.createMenu([authority: 'AUTH_MENU_LIST',
			url: '/menu/list/**',
			description: '菜单管理'],
		[name: '菜单管理', icon: 'list-alt'], menu_system)
		return null
	}

	@Override
	public int getOrder() {
		return 1;
	}
}
