package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV98Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			CREATE TABLE `persistent_schema` (
			  `username` VARCHAR(64) NOT NULL,
			  `series` VARCHAR(64)  COLLATE utf8_bin NOT NULL,
			  `token` VARCHAR(64) COLLATE utf8_bin NOT NULL,
			  `last_used` TIMESTAMP NOT NULL
			) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""
		return sqls
	}

	@Override
	def updateData() {
		
		return null
	}

	@Override
	public int getOrder() {
		return 98
	}
}