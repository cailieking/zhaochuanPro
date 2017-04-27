package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV76Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `front_user`ADD COLUMN `invitation_code`  varchar(50)  AFTER `come_from`;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 76
	}
}
