package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV69Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
				ALTER TABLE `company_certificate` ADD COLUMN `reg_capital` varchar(50) ;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 69
	}
}
