package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV78Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
		
			ALTER TABLE `Orders` 	ADD COLUMN `order_come`  varchar(50)  AFTER `booking_file_path`;
		"""
		return sqls
		
		
		 
		
	}

	@Override
	def updateData() {
		
		
		return null
	}

	@Override
	public int getOrder() {
		return 78
	}
}
