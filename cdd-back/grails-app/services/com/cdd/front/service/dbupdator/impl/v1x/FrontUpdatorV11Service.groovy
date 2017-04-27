package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV11Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `orders` 
			CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""
		sqls << """
			ALTER TABLE `cargo_ship_information` 
			CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 11;
	}
}
