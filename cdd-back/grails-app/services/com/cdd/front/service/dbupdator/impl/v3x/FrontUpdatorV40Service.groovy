package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV40Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `release_num` VARCHAR(64) DEFAULT NULL
		"""
		
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 40
	}
}
