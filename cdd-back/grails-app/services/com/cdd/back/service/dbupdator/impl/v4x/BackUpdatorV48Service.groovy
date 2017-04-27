package com.cdd.back.service.dbupdator.impl.v4x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV48Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `route` ADD COLUMN `city` varchar(255) AFTER `type`, ADD COLUMN `short_name` varchar(255) AFTER `city`;
		"""
		
		return sqls
	}


	@Override
	def updateData() {

		return null
	}

	@Override
	public int getOrder() {
		return 48
	}
}
