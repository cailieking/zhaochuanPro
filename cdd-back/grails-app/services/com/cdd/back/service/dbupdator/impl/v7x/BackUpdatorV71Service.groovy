package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV71Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		
		
		 
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/frontUser/addBackUser/**', description: '添加后台注册用户', authority: "AUTH_COMPANY_FRONTUSER"],
			[url: '/frontUser/saveBackUser/**', description: '后台添加用户', authority: "AUTH_FRONTUSER_SAVEBACKUSER"],
			
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
		return 71
	}
}
