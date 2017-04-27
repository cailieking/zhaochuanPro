package com.cdd.front.service.dbupdator.impl.v2x

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV29Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `shipping_day` `shipping_day` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 29
	}
}
