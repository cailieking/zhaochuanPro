package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV30Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			CREATE TABLE `new_come_in` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
				`update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `agent` int(11),
				`orders` int(11),
				`date` datetime NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		return sqls
	}
	
	MenuHelper menuHelper
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/newComeIn/save/**', description: '保存新增信息', authority: "AUTH_NEW_COME_IN_SAVE"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		Menu menu_system = Menu.findByName('参数管理')
		
		menuHelper.createMenu([authority: 'AUTH_NEW_COME_IN_DATA',
			url: '/newComeIn/data/**',
			description: '修改新增信息'],
		[name: '修改新增信息', icon: 'file-code-o'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 30;
	}
}
