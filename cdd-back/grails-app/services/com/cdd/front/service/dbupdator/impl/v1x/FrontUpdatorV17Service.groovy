package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator


class FrontUpdatorV17Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `wanted_order_id` bigint(20) AFTER `address`;
		"""
		
		return sqls
	}


	@Override
	def updateData() {

		return null
	}

	@Override
	public int getOrder() {
		return 17;
	}
}
