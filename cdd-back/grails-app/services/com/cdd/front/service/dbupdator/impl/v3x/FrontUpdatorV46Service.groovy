package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.back.util.MenuHelper;
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV46Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE IF NOT EXISTS `access_log`(
					  `id` bigint(20) NOT NULL AUTO_INCREMENT,
					  `visitor` varchar(50) DEFAULT NULL,
						`type` varchar(50) DEFAULT NULL,
					  `url` varchar(255) DEFAULT NULL,
					  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				  	  `date_created` datetime NOT NULL,
					  `last_updated` datetime NOT NULL,
					  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
					  `time` datetime DEFAULT NULL,
					  `ip` varchar(500) DEFAULT NULL,
					  `city` varchar(500) DEFAULT NULL,
					  PRIMARY KEY (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		"""
		return sqls
	}
	MenuHelper menuHelper
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		Menu menu_system = Menu.findByName('注册用户')
		
		menuHelper.createMenu([authority: 'AUTH_ACCESSLOG_LIST',
			url: '/accessLog/list/**',
			description: '访问日志'],
		[name: '访问日志', icon: 'file-text-o'], menu_system);
		
		
		
		[
			[url: '/accessLog/list/**', description: '登录日志', authority: "AUTH_LOGINLOG_LIST"],
			[url: '/accessLog/export/**', description: '导出日志', authority: "AUTH_LOGINLOG_EXPORT"],
			
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
		return 46
	}
}