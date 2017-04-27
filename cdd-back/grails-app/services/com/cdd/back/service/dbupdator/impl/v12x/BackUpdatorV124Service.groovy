package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV124Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
				
			CREATE TABLE `client_manager` (
			`id` bigint(20) NOT NULL AUTO_INCREMENT,
			`company_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			`firstname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `address` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `post_code` int(6) DEFAULT NULL,
			  `telephone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
			  `faxes` varchar(20) COLLATE utf8_bin DEFAULT NULL,
			  `phone` varchar(50) COLLATE utf8_bin DEFAULT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `tag_id` bigint(20) DEFAULT NULL,
			  `group_id` bigint(20) DEFAULT NULL,
			  `demand_id` bigint(20) DEFAULT NULL,
			  `type_id` bigint(20) DEFAULT NULL,
			  `qq` varchar(50) COLLATE utf8_bin DEFAULT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `del_tag` int(1) NOT NULL DEFAULT '0',
			  `demand_class_id` BIGINT(20) DEFAULT NULL,
              `group_manager_id` BIGINT(20) DEFAULT NULL,
			  `tag_manager_id` BIGINT(20) DEFAULT NULL,
              `client_type_id` BIGINT(20) DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  CONSTRAINT  FOREIGN KEY (`demand_class_id`) REFERENCES `demand_class` (`id`),
			  CONSTRAINT  FOREIGN KEY (`group_manager_id`) REFERENCES `group_manager` (`id`),
			  CONSTRAINT  FOREIGN KEY (`tag_manager_id`) REFERENCES `tag_manager` (`id`),
			  CONSTRAINT  FOREIGN KEY (`client_type_id`) REFERENCES `client_type` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin


		"""
		//			  KEY `FK_tag_id` (`tag_manager_id`),
		//			  KEY `FK_group_id` (`group_id`),
		//			  KEY `FK_demand_id` (`demand_id`),
		//			  KEY `FK_type_id` (`type_id`),
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
		
//		[
//			[url: '/clientAttrManager/getTags/**', description: '查询标签', authority: "AUTH_GET_TAG"],
//			[url: '/clientAttrManager/saveTag/**', description: '保存标签', authority: "AUTH_SAVE_TAG"],
//			[url: '/clientAttrManager/delTag/**', description: '删除标签', authority: "AUTH_DEL_TAG"],
//			[url: '/clientAttrManager/getGroups/**', description: '查询群组', authority: "AUTH_GET_GROUP"],
//			[url: '/clientAttrManager/saveGroup/**', description: '保存群组', authority: "AUTH_SAVE_GROUP"],
//			[url: '/clientAttrManager/delGroup/**', description: '删除群组', authority: "AUTH_DEL_GROUP"],
//			[url: '/clientAttrManager/getDemands/**', description: '查询需求', authority: "AUTH_GET_DEMAND"],
//			[url: '/clientAttrManager/saveDemand/**', description: '保存需求', authority: "AUTH_SAVE_DEMAND"],
//			[url: '/clientAttrManager/delDemand/**', description: '删除需求', authority: "AUTH_DEL_DEMAND"],
//			[url: '/clientAttrManager/getClientTypes/**', description: '查询客户类型', authority: "AUTH_GET_CLIENT_TYPE"],
//			[url: '/clientAttrManager/saveClientType/**', description: '保存客户类型', authority: "AUTH_SAVE_CLIENT_TYPE"],
//			[url: '/clientAttrManager/delClientType/**', description: '删除客户类型', authority: "AUTH_DEL_CLIENT_TYPE"]
//			
//		].each { params ->
//			params.createBy = systemUser
//			params.updateBy = systemUser
//			Requestmap map = new Requestmap(params)
//			map.save()
//		}
		return null
			
	}

	@Override
	public int getOrder() {
		return 124
	}
}