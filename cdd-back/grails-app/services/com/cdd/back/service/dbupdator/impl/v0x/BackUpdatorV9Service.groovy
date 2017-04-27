package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV9Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/shipAudit/data/**', description: '查看货代审核信息', authority: "AUTH_SHIP_AUDIT_DATA"],
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
		return 9;
	}
}
