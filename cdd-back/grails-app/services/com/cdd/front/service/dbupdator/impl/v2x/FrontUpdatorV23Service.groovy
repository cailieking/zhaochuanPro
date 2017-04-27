package com.cdd.front.service.dbupdator.impl.v2x

import com.cdd.base.domain.FrontUser
import com.cdd.base.enums.FrontUserType
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator


class FrontUpdatorV23Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `front_user` ADD COLUMN `type` varchar(50) AFTER `username`;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		
		FrontUser.all?.each { FrontUser user ->
			if(user.isShipAgent()) {
				user.type = FrontUserType.Agent
			} else {
				user.type = FrontUserType.Cargo
			}
			user.save()
		}
		
		return null
	}


	@Override
	public int getOrder() {
		return 23;
	}
}
