package com.cdd.back.service.dbupdator.impl.v13x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV135Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		
		
		return sqls
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		Menu menu_system1 = Menu.findByName("注册用户")
		menuHelper.createMenu([authority: 'AUTH_SHORTMESSAGE_SENDPAGE',
			url: '/shortMessage/sendPage/**',
			description: '发送短信'],
		[name: '发送短信', icon: 'file-text-o',orders:1], menu_system1);
		
		[
			[url: '/shortMessage/send', description: '短信发送', authority: "permitAll"]
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
		return 135;
	}
}
