package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV4Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		
		Menu menu_system = Menu.findByName('系统管理') 

		menuHelper.createMenu([authority: 'AUTH_FRONTUSER_LIST',
			url: '/frontUser/list/**',
			description: '前端用户管理'],
		[name: '前端用户管理', icon: 'users'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 4;
	}
}
