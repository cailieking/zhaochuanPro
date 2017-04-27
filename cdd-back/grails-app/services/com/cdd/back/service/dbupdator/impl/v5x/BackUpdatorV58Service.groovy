package com.cdd.back.service.dbupdator.impl.v5x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV58Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/frontUser/enable/**', description: '启用禁用用户', authority: "AUTH_FRONT_USER_ENABLE"],
			[url: '/frontUser/hornest/**', description: '设置诚信', authority: "AUTH_FRONT_USER_HORNEST"],
			[url: '/frontUser/safety/**', description: '设置保障', authority: "AUTH_FRONT_USER_SAFETY"],
			[url: '/frontUser/verified/**', description: '设置认证', authority: "AUTH_FRONT_USER_VERIFIED"]
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
		return 58
	}
}
