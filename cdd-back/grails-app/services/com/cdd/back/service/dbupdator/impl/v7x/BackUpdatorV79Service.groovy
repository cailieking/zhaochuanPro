package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV79Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/shipAudit/view/**', description: '运价审核信息', authority: "AUTH_SHIP_AUDIT_VIEW"],
			[url: '/orderAudit/view/**', description: '货盘审核信息', authority: "AUTH_ORDER_AUDIT_VIEW"],
			
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
		return 79
	}
}
