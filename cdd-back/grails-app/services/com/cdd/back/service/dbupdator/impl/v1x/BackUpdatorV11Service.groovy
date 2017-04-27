package com.cdd.back.service.dbupdator.impl.v1x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV11Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/order/save/**', description: '保存订单信息', authority: "AUTH_ORDER_SAVE"],
			[url: '/order/edit/**', description: '编辑订单信息', authority: "AUTH_ORDER_EDIT"],
			[url: '/shipInfo/save/**', description: '保存货代信息', authority: "AUTH_SHIP_INFO_SAVE"],
			[url: '/shipInfo/edit/**', description: '编辑货代信息', authority: "AUTH_SHIP_INFO_EDIT"],
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
		return 11;
	}
}
