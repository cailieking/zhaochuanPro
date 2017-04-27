package com.cdd.back.service.dbupdator.impl.v5x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV59Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `front_user` ADD COLUMN `hornest` bit(1) NOT NULL AFTER `type`, ADD COLUMN `safety` bit(1) NOT NULL AFTER `hornest`, ADD COLUMN `verified` bit(1) NOT NULL AFTER `safety`;
		"""
		return sqls
	}


	@Override
	def updateData() {
		def sqls = []
		sqls << """
			update orders set order_status='UnTrade' where order_status='InTrade'
		"""
		return sqls
	}

	@Override
	public int getOrder() {
		return 59
	}
}
