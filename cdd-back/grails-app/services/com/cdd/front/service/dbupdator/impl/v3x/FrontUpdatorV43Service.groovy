package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV43Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `back_user` 
			ADD COLUMN `is_online` INT(2) NOT NULL;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 43
	}
}