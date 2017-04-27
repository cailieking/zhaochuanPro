package com.cdd.back.service.dbupdator.impl.v4x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.User

class BackUpdatorV46Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username

		Menu menu_system = new Menu(name: '前台用户管理', icon: 'users', createBy: systemUser, updateBy: systemUser).save()

		Menu front_user_menu = Menu.findByName('注册用户管理')
		front_user_menu?.parent = menu_system
		front_user_menu?.save()
		
		menuHelper.createMenu([authority: 'AUTH_FAKE_FRONT_USER_LIST',
			url: '/fakeFrontUser/list/**',
			description: '导入用户管理'],
		[name: '导入用户管理', icon: 'users'], menu_system)

		return null
	}

	@Override
	public int getOrder() {
		return 46;
	}
}
