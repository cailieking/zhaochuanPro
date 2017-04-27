package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV12Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `days` `days` int(11), 
			CHANGE COLUMN `shipping_days` `shipping_days` int(11);
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 12;
	}
}
