package com.cdd.back.service.dbupdator.impl.v2x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV27Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			CREATE TABLE `route` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
				`update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `port` varchar(255) COLLATE utf8_bin NOT NULL,
				`category` varchar(255) COLLATE utf8_bin NOT NULL,
				`type` varchar(50) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/route/data/**', description: '查看航线信息', authority: "AUTH_ROUTE_DATA"],
			[url: '/route/save/**', description: '保存航线信息', authority: "AUTH_ROUTE_SAVE"],
			[url: '/route/delete/**', description: '删除航线信息', authority: "AUTH_ROUTE_DELETE"],
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
		return 27;
	}
}
