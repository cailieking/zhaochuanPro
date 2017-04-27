package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV102Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE `week_ranking` (
				  `id` bigint(20) NOT NULL AUTO_INCREMENT,
				  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				  `date_created` datetime NOT NULL,
				  `last_updated` datetime NOT NULL,
				  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
					`start_time` datetime NOT NULL,
					`end_time` datetime NOT NULL,
					`start_port` varchar(255) DEFAULT NULL,
					`end_port` varchar(255) DEFAULT NULL,
					`ship_company` varchar(255) DEFAULT NULL,
				   PRIMARY KEY (`id`)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		"""
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			[
				[url: '/searchManage/doSearch/**', description: '周排名查询', authority: "AUTH_SEARCHMANAGE_DOSEARCH"],
				
			].each { params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				Requestmap map = new Requestmap(params)
				map.save()
			}
			
			Menu menu_system = new Menu(name: '搜索管理', icon: 'calendar-o', createBy: systemUser, updateBy: systemUser).save()
		
			menuHelper.createMenu([authority: 'AUTH_SEARCHMANAGE_LIST',
				url: '/searchManage/list/**',
				description: '周排名查询'],
			[name: '周排名', icon: 'file-text-o'], menu_system)
			return null
	}

	@Override
	public int getOrder() {
		return 102
	}
}