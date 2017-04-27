package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.back.util.MenuHelper;
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV44Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `front_user`
			ADD COLUMN `login_out_time`  datetime DEFAULT NULL,
			ADD COLUMN `ip` varchar(50) DEFAULT NULL,
			ADD COLUMN `is_online` INT(2) NOT NULL;
		"""
		return sqls
	}
	MenuHelper menuHelper
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		Menu menu_system = Menu.findByName('注册用户')
		
		menuHelper.createMenu([authority: 'AUTH_LOGINLOG_LIST',
			url: '/loginLog/list/**',
			description: '登录日志'],
		[name: '登录日志', icon: 'file-text-o'], menu_system);
		
		
		
		[
			[url: '/loginLog/list/**', description: '登录日志', authority: "AUTH_LOGINLOG_LIST"],
			[url: '/loginLog/export/**', description: '导出日志', authority: "AUTH_LOGINLOG_EXPORT"],
			[url: '/frontUser/export/**', description: '导出日志', authority: "AUTH_FRONTUSER_EXPORT"]
			
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
		return 44
	}
}