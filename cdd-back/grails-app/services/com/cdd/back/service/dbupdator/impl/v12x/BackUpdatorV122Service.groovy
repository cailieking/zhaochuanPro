package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV122Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			CREATE TABLE `client_type` (
			  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
			  `type_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `create_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` DATETIME NOT NULL,
			  `update_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` DATETIME NOT NULL,
			  `customer_count` INT(11) NOT NULL DEFAULT '0',
			  `del_tag` INT(1) NOT NULL DEFAULT '0',
			  PRIMARY KEY (`id`)
			) ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin

		"""
	
		sqls << """
		CREATE TABLE `demand_class` (
		  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
		  `demand_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
		  `create_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
		  `date_created` DATETIME NOT NULL,
		  `update_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
		  `last_updated` DATETIME NOT NULL,
		  `customer_count` INT(11) NOT NULL DEFAULT '0',
		  `del_tag` INT(1) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`id`)
		) ENGINE=INNODB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin

		"""
		
		sqls << """
			CREATE TABLE `group_manager` (
			  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
			  `group_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `create_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` DATETIME NOT NULL,
			  `update_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` DATETIME NOT NULL,
			  `customer_count` INT(11) NOT NULL DEFAULT '0',
			  `description` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL,
			  `del_tag` INT(1) NOT NULL DEFAULT '0',
			  PRIMARY KEY (`id`)
			) ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin

		"""
		
		sqls << """
			CREATE TABLE `tag_manager` (
			  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
			  `tag_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `create_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` DATETIME NOT NULL,
			  `update_by` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` DATETIME NOT NULL,
			  `customer_count` INT(11) NOT NULL DEFAULT '0',
			  `description` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL,
			  `del_tag` INT(1) NOT NULL DEFAULT '0',
			  PRIMARY KEY (`id`)
			) ENGINE=INNODB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin

		"""
//		sqls << """
//			CREATE TABLE `client_manager` (
//			`id` bigint(20) NOT NULL AUTO_INCREMENT,
//			`company_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//			`firstname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//			  `address` varchar(500) COLLATE utf8_bin DEFAULT NULL,
//			  `post_code` int(6) DEFAULT NULL,
//			  `telephone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
//			  `faxes` varchar(20) COLLATE utf8_bin DEFAULT NULL,
//			  `phone` varchar(50) COLLATE utf8_bin DEFAULT NULL,
//			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//			  `date_created` datetime NOT NULL,
//			  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//			  `last_updated` datetime NOT NULL,
//			  `tag_id` bigint(20) DEFAULT NULL,
//			  `group_id` bigint(20) DEFAULT NULL,
//			  `demand_id` bigint(20) DEFAULT NULL,
//			  `type_id` bigint(20) DEFAULT NULL,
//			  `qq` varchar(50) COLLATE utf8_bin DEFAULT NULL,
//			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//			  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL,
//			  `del_tag` int(1) NOT NULL DEFAULT '0',
//			  PRIMARY KEY (`id`),
//			  KEY `FK_tag_id` (`tag_manager_id`),
//			  KEY `FK_group_id` (`group_id`),
//			  KEY `FK_demand_id` (`demand_id`),
//			  KEY `FK_type_id` (`type_id`),
//			  CONSTRAINT `FK_demand_id` FOREIGN KEY (`demand_id`) REFERENCES `demand_class` (`id`),
//			  CONSTRAINT `FK_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_manager` (`id`),
//			  CONSTRAINT `FK_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag_manager` (`id`),
//			  CONSTRAINT `FK_type_id` FOREIGN KEY (`type_id`) REFERENCES `client_type` (`id`)
//			) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin
//
//		"""
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			Menu menu_system1 = new Menu(name: '客户管理', icon: 'calendar-o', createBy: systemUser, updateBy: systemUser).save()
			Menu menu_system2 = new Menu(name: '供应商管理', icon: 'calendar-o', createBy: systemUser, updateBy: systemUser).save()
			
			menuHelper.createMenu([authority: 'AUTH_CLIENT_LIST',
				url: '/clientManager/list/**',
				description: '客户列表'],
			[name: '客户列表', icon: 'file-text-o',orders:1], menu_system1);
			
			menuHelper.createMenu([authority: 'AUTH_CLIENT_ATTR_LIST',
				url: '/clientAttrManager/list/**',
				description: '客户属性管理'],
			[name: '属性管理', icon: 'file-text-o',orders:2], menu_system1);
		
			menuHelper.createMenu([authority: 'AUTH_SUPPLIER_LIST',
				url: '/supplierManager/list/**',
				description: '供应商列表'],
			[name: '供应商列表', icon: 'file-text-o',orders:1], menu_system2);
		
			menuHelper.createMenu([authority: 'AUTH_SUPPLIER_ATTR_LIST',
				url: '/supplierAttrManager/list/**',
				description: '供应商属性管理'],
			[name: '供应商属性管理', icon: 'file-text-o',orders:2], menu_system2);
//			
//			[
//				[url: '/inquiryOfferPrice/inquiry/**', description: '今日询盘', authority: "AUTH_INQUIRYOFFERPRICE_INQUIRY"],
//				[url: '/inquiryOfferPrice/offerPrice/**', description: '今日应价', authority: "AUTH_INQUIRYOFFERPRICE_OFFERPRICE"],
//				
//			].each { params ->
//				params.createBy = systemUser
//				params.updateBy = systemUser
//				Requestmap map = new Requestmap(params)
//				map.save()
//			}
		
		
			return null
			
	}

	@Override
	public int getOrder() {
		return 122
	}
}