package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV14Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `cargo_ship_information` 
			MODIFY COLUMN `city_id` bigint(20) DEFAULT NULL; 
		"""
		sqls << """
			ALTER TABLE `cargo_ship_information` 
			DROP COLUMN `days`; 
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 14;
	}
}
