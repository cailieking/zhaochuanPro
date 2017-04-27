package com.cdd.front.service.dbupdator.impl.v2x

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV28Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `cargo_ship_score` ADD COLUMN `hornest` bit(1) NOT NULL AFTER `company_name`, ADD COLUMN `safety` bit(1) NOT NULL AFTER `hornest`, ADD COLUMN `verified` bit(1) NOT NULL AFTER `safety`;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 28
	}
}
