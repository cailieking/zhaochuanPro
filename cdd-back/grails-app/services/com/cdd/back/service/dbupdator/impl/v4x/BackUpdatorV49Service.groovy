package com.cdd.back.service.dbupdator.impl.v4x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV49Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/recommendAgent/list/**', description: '显示推送货代列表', authority: "AUTH_RECOMMEND_AGENT_LIST"],
			[url: '/recommendAgent/save/**', description: '推送货代信息', authority: "AUTH_RECOMMEND_AGENT_SAVE"],
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
		return 49
	}
}
