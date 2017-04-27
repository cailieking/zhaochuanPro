package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV93Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `booking` ADD COLUMN `of_money` varchar(255);
		"""
		sqls << """
			ALTER TABLE `booking` ADD COLUMN `local_money` varchar(255);
		"""
		
		return sqls
	}

	@Override
	def updateData() {
		return null
	}
	@Override
	public int getOrder() {
		return 93
	}
}