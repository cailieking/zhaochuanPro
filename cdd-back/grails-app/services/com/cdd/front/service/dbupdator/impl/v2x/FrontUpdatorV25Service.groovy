package com.cdd.front.service.dbupdator.impl.v2x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV25Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
//		sqls << """
//			ALTER TABLE `orders` ADD COLUMN `deleted` bit(1) NOT NULL AFTER `end_port_cn`;
//		"""
//		
//		sqls << """
//			ALTER TABLE `cargo_ship_information` ADD COLUMN `deleted` bit(1) NOT NULL AFTER `middle_port_cn`;
//		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		
		return null
	}


	@Override
	public int getOrder() {
		return 25;
	}
}
