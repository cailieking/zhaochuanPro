package com.cdd.front.service.dbupdator.impl.v2x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV20Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `ship_prices` CHANGE COLUMN `extra` `extra` decimal(19,2);
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 20;
	}
}
