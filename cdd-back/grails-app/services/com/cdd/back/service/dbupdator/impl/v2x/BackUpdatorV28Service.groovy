package com.cdd.back.service.dbupdator.impl.v2x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV28Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	MenuHelper menuHelper
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		Menu menu_system = new Menu(name: '参数管理', icon: 'book', createBy: systemUser, updateBy: systemUser).save()

		menuHelper.createMenu([authority: 'AUTH_ROUTE_LIST',
			url: '/route/list/**',
			description: '航线分类管理'],
		[name: '航线分类管理', icon: 'file-code-o'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 28;
	}
}
