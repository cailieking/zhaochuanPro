package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV97Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls<< """

				delete from  `database_update` where ver = 101  
		
		"""
		return sqls
	}

	@Override
	def updateData() {
		
		return null
	}

	@Override
	public int getOrder() {
		return 97
	}
}