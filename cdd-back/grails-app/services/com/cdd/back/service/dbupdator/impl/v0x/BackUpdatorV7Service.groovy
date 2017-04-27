package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV7Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/files/certs/**', description: '查看凭证', authority: "AUTH_TRADE_CERT"],
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
		return 7;
	}
}
