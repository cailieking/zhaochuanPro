package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV127Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
//		sqls << """
//			alter table `client_manager` add column email varchar(64) default null
//		"""
//		
//		sqls << """
//			alter table `contact_person` add column tag_name varchar(16) default null
//		"""
		
		sqls << """
			CREATE TABLE `supplier_tag` (
			  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
			  `tag_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
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
		CREATE TABLE `supplier_account` (
		  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
		  `account_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
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
			CREATE TABLE `supplier_group` (
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
			CREATE TABLE `supplier_level` (
			  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
			  `level_name` VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
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
		return sqls
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
			[
				 [url: '/clientManager/downloadExample/**', description: '模板', authority: "AUTH_DOWN_EXAMPLE"],
				 [url: '/supplierAttrManager/getTags/**', description: '查询供应商标签', authority: "AUTH_GET_SUPP_TAG"],
				 [url: '/supplierAttrManager/saveTag/**', description: '保存供应商标签', authority: "AUTH_SAVE_SUPP_TAG"],
				 [url: '/supplierAttrManager/delTag/**', description: '删除供应商标签', authority: "AUTH_DEL_SUPP_TAG"],
				 [url: '/supplierAttrManager/getGroups/**', description: '查询供应商群组', authority: "AUTH_GET_SUPP_GROUP"],
				 [url: '/supplierAttrManager/saveGroup/**', description: '保存供应商群组', authority: "AUTH_SAVE_SUPP_GROUP"],
				 [url: '/supplierAttrManager/delGroup/**', description: '删除供应商群组', authority: "AUTH_DEL_SUPP_GROUP"],
				 [url: '/supplierAttrManager/getAccounts/**', description: '查询供应商账期', authority: "AUTH_GET_SUPP_ACCOUNT"],
				 [url: '/supplierAttrManager/saveAccount/**', description: '保存供应商账期', authority: "AUTH_SAVE_SUPP_ACCOUNT"],
				 [url: '/supplierAttrManager/delAccount/**', description: '删除供应商账期', authority: "AUTH_DEL_SUPP_ACCOUNT"],
				 [url: '/supplierAttrManager/getLevels/**', description: '查询供应商级别', authority: "AUTH_GET_SUPP_LEVEL"],
				 [url: '/supplierAttrManager/saveLevel/**', description: '保存供应商级别', authority: "AUTH_SAVE_SUPP_LEVEL"],
				 [url: '/supplierAttrManager/delLevel/**', description: '删除供应商级别', authority: "AUTH_DEL_SUPP_LEVEL"]
			].each { params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				Requestmap map = new Requestmap(params)
				map.save()
			}
			return null
			
	}

	@Override
	public int getOrder() {
		return 127
	}
}