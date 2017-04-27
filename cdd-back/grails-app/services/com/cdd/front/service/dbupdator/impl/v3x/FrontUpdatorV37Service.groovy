package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV37Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `cargo_ship_item_score` 
			ADD COLUMN `service_content` int(11) NOT NULL AFTER `service_quality`;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_score` 
			ADD COLUMN `service_content` double NOT NULL AFTER `service_quality`;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 37
	}
}
