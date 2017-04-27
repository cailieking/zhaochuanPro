package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV73Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		
		
		 
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/frontUser/isOldMobile/**', description: '验证用户是否存在', authority: "AUTH_FRONTUSER_ISOLDMOBILE"],
			
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
		return 73
	}
}
