package com.cdd.front.service.dbupdator.impl.v2x

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV27Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `pin_service_type` varchar(50) AFTER `deleted`;
		"""
		
		sqls << """
			ALTER TABLE `ship_prices` ADD COLUMN `cbm` decimal(19,2) AFTER `update_by`, ADD COLUMN `weight` decimal(19,2) AFTER `cbm`;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 27
	}
}
