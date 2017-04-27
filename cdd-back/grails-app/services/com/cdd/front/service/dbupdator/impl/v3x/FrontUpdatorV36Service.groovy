package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV36Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	@Override
	def updateData() {
		def sqls = []
		sqls << """
			update orders set order_status='UnTrade' where order_status is null and status='VerifyPassed';
		"""
		return sqls
	}


	@Override
	public int getOrder() {
		return 36
	}
}
