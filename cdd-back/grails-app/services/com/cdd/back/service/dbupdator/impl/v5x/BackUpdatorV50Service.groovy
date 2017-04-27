package com.cdd.back.service.dbupdator.impl.v5x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV50Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/fakeFrontUser/transfer/**', description: '注册导入用户', authority: "AUTH_FAKE_FRONT_USER_TRANSFER"],
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
		return 50
	}
}
