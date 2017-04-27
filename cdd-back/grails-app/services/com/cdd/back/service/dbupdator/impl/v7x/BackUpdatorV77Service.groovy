package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV77Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		return null
		
		 
		
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/frontUser/data/**', description: '用户详细信息', authority: "AUTH_FRONTUSER_DATA"],
			[url: '/frontUser/save/**', description: '保存用户信息', authority: "AUTH_FRONTUSER_SAVE"],
			
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
		return 77
	}
}
