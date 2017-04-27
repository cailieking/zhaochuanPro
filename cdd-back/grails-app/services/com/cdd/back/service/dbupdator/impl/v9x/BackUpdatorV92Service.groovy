package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV92Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `ship_prices` ADD COLUMN `gp20vip` decimal(19,2) AFTER `hq45`,ADD COLUMN `gp40vip` decimal(19,2) AFTER `gp20vip`,ADD COLUMN `hq40vip` decimal(19,2) AFTER `gp40vip`;
		"""
		
	}

	@Override
	def updateData() {
		return null
	}
	@Override
	public int getOrder() {
		return 92
	}
}