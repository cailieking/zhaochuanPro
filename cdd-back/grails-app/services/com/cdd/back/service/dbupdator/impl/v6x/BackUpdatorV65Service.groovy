package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV65Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `front_user` ADD COLUMN `come_from` varchar(50)  NOT NULL DEFAULT  'Z';
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 65
	}
}
