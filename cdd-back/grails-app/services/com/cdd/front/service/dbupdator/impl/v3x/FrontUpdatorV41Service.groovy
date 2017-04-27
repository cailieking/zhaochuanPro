package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV41Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			update cargo_ship_information set release_num = DATE_FORMAT(date_created,'%y%m%d');
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 41
	}
}
