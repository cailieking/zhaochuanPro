package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV13Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `orders` 
			MODIFY COLUMN `city_id` bigint(20) DEFAULT NULL; 
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 13;
	}
}
