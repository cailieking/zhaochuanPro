package com.cdd.front.service.dbupdator.impl.v2x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV21Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `ship_prices` CHANGE COLUMN `extra` `extra` varchar(1000) DEFAULT NULL;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 21;
	}
}
