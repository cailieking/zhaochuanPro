package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV5Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}


	@Override
	def updateData() {
		
		new Requestmap([
			url: '/user/superiors/**',
			authority: 'AUTH_USER_SUPERIORS',
			description: '获取所属上级列表',
			createBy: User.SYSTEM.username, 
			updateBy: User.SYSTEM.username]).save()
		
		return null
	}

	@Override
	public int getOrder() {
		return 5;
	}
}
