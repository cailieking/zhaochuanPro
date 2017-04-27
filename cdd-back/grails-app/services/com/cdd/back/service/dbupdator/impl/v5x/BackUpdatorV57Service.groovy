package com.cdd.back.service.dbupdator.impl.v5x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV57Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/recommendAgent/send/**', description: '推送航线信息', authority: "AUTH_RECOMMEND_AGENT_SEND"],
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
		return 57
	}
}
