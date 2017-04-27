package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV128Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
				
			CREATE TABLE `supplier_manager` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `company_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `address` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `post_code` int(6) DEFAULT NULL,
			  `faxes` varchar(20) COLLATE utf8_bin DEFAULT NULL,
			  `phone` varchar(50) COLLATE utf8_bin DEFAULT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `del_tag` int(1) NOT NULL DEFAULT '0',
			  `supplier_tag_id` BIGINT(20) DEFAULT NULL,
              `supplier_account_id` BIGINT(20) DEFAULT NULL,
			  `supplier_group_id` BIGINT(20) DEFAULT NULL,
              `supplier_level_id` BIGINT(20) DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  CONSTRAINT  FOREIGN KEY (`supplier_tag_id`) REFERENCES `supplier_tag` (`id`),
			  CONSTRAINT  FOREIGN KEY (`supplier_account_id`) REFERENCES `supplier_account` (`id`),
			  CONSTRAINT  FOREIGN KEY (`supplier_group_id`) REFERENCES `supplier_group` (`id`),
			  CONSTRAINT  FOREIGN KEY (`supplier_level_id`) REFERENCES `supplier_level` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_bin


		"""
		sqls << """
				
			CREATE TABLE `supplier_person` (
				 `id` bigint(20) NOT NULL AUTO_INCREMENT,
				 `person_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
				 `email` varchar(128) COLLATE utf8_bin DEFAULT NULL,
				 `phone` varchar(32) COLLATE utf8_bin DEFAULT NULL,
				 `qq` varchar(16) COLLATE utf8_bin DEFAULT NULL,
				 `tag_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
				 `create_by` varchar(65) COLLATE utf8_bin DEFAULT NULL,
				 `date_created` datetime NOT NULL,
				 `last_updated` datetime NOT NULL,
				 `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL,
				 `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				 `supplier_manager_id` bigint(20) NOT NULL,
				  PRIMARY KEY (`id`),
				  CONSTRAINT  FOREIGN KEY (`supplier_manager_id`) REFERENCES `supplier_manager` (`id`)
				) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_bin

		"""
		sqls << """

			CREATE TABLE `supplier_manager_routes` (
				`supplier_manager_id` BIGINT(20) NOT NULL,
				`new_route_id` BIGINT(20) NOT NULL,
				PRIMARY KEY (`supplier_manager_id`,`new_route_id`),
				FOREIGN KEY (`supplier_manager_id`) REFERENCES `supplier_manager` (`id`),
				FOREIGN KEY (`new_route_id`) REFERENCES `new_route` (`id`)
		  	) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin
		
		"""
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
		
			
			[
				[url: '/supplierManager/searchSuppliers/**', description: '查询供应商', authority: "AUTH_SEACH_SUPPS"],
				[url: '/supplierManager/saveSupplier/**', description: '保存供应商', authority: "AUTH_SAVE_SUPP"],
				[url: '/supplierManager/delSupllier/**', description: '删除供应商', authority: "AUTH_DEL_SUPP"],
				[url: '/supplierManager/exportSuppliers/**', description: '批量导出供应商', authority: "AUTH_EXPORT_SUPPS"],
				[url: '/supplierManager/importSuppliers/**', description: '批量导入供应商', authority: "AUTH_IMPORT_SUPPS"],
			//	[url: '/supplierManager/delSupplierPerson/**', description: '删除供应商联系人', authority: "AUTH_DEL_SUPP_PERSON"],
				[url: '/supplierManager/saveSupplierPerson/**', description: '添加供应商联系人', authority: "AUTH_SAVE_SUPP_PERSON"],
				[url: '/supplierManager/editSupplier/**', description: '编辑供应商', authority: "AUTH_EDIT_SUPP"],
				[url: '/supplierManager/downloadExample/**', description: '模板', authority: "AUTH_SUPP_DOWN_EXAMPLE"],
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
		return 128
	}
}