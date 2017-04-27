package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV6Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			ALTER TABLE `front_user`  MODIFY COLUMN `email` varchar(255) DEFAULT NULL;
			
		"""
		
		sqls << """
			ALTER TABLE `front_user`  MODIFY COLUMN `address` varchar(500) DEFAULT NULL;
		"""
		
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 6;
	}
}
