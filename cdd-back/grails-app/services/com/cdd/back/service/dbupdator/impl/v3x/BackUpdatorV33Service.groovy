package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV33Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username

		[
			[url: '/order/delete/**', description: '删除订单', authority: "AUTH_ORDER_DELETE"],
			[url: '/shipInfo/delete/**', description: '删除货代', authority: "AUTH_SHIP_INFO_DELETE"],
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
		return 33;
	}
}
