package com.cdd.back.service.dbupdator.impl.v8x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV89Service extends AbstractBackDatabaseUpdator {
	@Override
	def updateSchema() {
		
		def systemUser = User.SYSTEM.username
					
		[
			[url: '/orderAudit/close/**',description: '关闭审核货盘', authority: "AUTH_ORDER_AUDIT_CLOSE"],
			[url: '/orderAudit/sureClosed/**',description: '确定关闭审核货盘', authority: "AUTH_ORDER_AUDIT_SURE_CLOSED"]
			
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		return null
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 89
	}
}
