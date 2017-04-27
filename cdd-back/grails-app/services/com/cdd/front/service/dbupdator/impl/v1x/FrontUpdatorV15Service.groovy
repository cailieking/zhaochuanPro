package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV15Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `show_on_index` bit not null;
		"""
	
		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `address` varchar(255) AFTER `show_on_index`;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 15;
	}
}
