package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV91Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `booking` ADD COLUMN `operate_by` varchar(255);
		"""
		
		sqls << """
			ALTER TABLE `booking` ADD COLUMN `finished_by` varchar(255);
		"""
		
		
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
										 	
		[
			
			[url: '/booking/finishReasult/**', description: '订单结单', authority: "AUTH_BOOKING_FINISHREASULT"],
			
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
		return 91
	}
}