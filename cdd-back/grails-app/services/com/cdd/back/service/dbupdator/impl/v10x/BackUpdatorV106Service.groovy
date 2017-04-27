package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV106Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE `search_log` (
		  	  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `start_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `end_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `ship_company` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `search_user` varchar(32) COLLATE utf8_bin DEFAULT NULL,
			  `result_count` bigint(11) DEFAULT NULL,	
			  `search_source` varchar(4) COLLATE utf8_bin DEFAULT NULL,
			  `search_time` datetime  DEFAULT NULL,
			  `consuming` varchar(16) COLLATE utf8_bin DEFAULT NULL,
			  `deleted` bit(1) NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			Menu menu_system = Menu.findByName('搜索管理')
			
			//Menu menu_system = new Menu(name: '搜索管理', icon: 'calendar-o', createBy: systemUser, updateBy: systemUser).save()
		
			menuHelper.createMenu([authority: 'AUTH_BACK_SEARCH_LOG',
				url: '/searchLog/list/**',
				description: '搜索日志'],
			[name: '搜索日志', icon: 'file-text-o'], menu_system)
			
			[
				[url: '/searchLog/export/**', description: '导出', authority: "AUTH_SEARCH_LOG_EXPORT"],
				
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
		return 106
	}
}