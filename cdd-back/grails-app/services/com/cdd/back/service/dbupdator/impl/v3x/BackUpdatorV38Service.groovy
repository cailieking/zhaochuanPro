package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV38Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		Menu menu_system = new Menu(name: '数据统计', icon: 'calculator', createBy: systemUser, updateBy: systemUser).save()

		menuHelper.createMenu([authority: 'AUTH_STAT_STAFF_LIST',
			url: '/statStaff/list/**',
			description: '员工数据统计'],
		[name: '员工数据统计', icon: 'bar-chart'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 38;
	}
}
