package com.cdd.back.service.dbupdator.impl.v4x

import org.hibernate.SessionFactory

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV44Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	SessionFactory sessionFactory
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/user/assign/**', description: '指派任务页面', authority: "AUTH_USER_ASSIGN"],
			[url: '/user/assignTo/**', description: '指派任务给用户', authority: "AUTH_USER_ASSIGN_TO"],
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
		return 44;
	}
}
