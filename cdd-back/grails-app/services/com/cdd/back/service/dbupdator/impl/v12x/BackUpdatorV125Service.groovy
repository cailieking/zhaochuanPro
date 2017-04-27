package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV125Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			alter table `client_manager` drop tag_id ,drop group_id, drop type_id, drop demand_id,drop firstname,

			drop email,drop qq,drop phone
		"""
		
		sqls << """
				
			CREATE TABLE `contact_person` (
				 `id` bigint(20) NOT NULL AUTO_INCREMENT,
				 `person_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
				 `email` varchar(128) COLLATE utf8_bin DEFAULT NULL,
				 `phone` varchar(32) COLLATE utf8_bin DEFAULT NULL,
				 `qq` varchar(16) COLLATE utf8_bin DEFAULT NULL,
				 `create_by` varchar(65) COLLATE utf8_bin DEFAULT NULL,
				 `date_created` datetime NOT NULL,
				 `last_updated` datetime NOT NULL,
				 `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL,
				 `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				 `client_manager_id` bigint(20) NOT NULL,
				  PRIMARY KEY (`id`),
				  CONSTRAINT  FOREIGN KEY (`client_manager_id`) REFERENCES `client_manager` (`id`)
				) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_bin

		"""
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
		
		[
			[url: '/clientManager/searchClients/**', description: '查询客户', authority: "AUTH_SEACH_CLIENTS"],
			[url: '/clientManager/saveClient/**', description: '保存客户', authority: "AUTH_SAVE_CLIENT"],
			[url: '/clientManager/delClient/**', description: '删除客户', authority: "AUTH_DEL_CLIENT"],
			[url: '/clientManager/exportClients/**', description: '批量导出客户', authority: "AUTH_EXPORT_CLIENTS"],
			[url: '/clientManager/importClients/**', description: '批量导入客户', authority: "AUTH_IMPORT_CLIENTS"],
			[url: '/clientManager/delContact/**', description: '删除客户联系人', authority: "AUTH_DEL_CLIENT_CONTACT"]
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
		return 125
	}
}