package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV4Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			ALTER TABLE `front_user` 
			CHANGE COLUMN `city` `city_id` bigint(20) NOT NULL; 
			"""
		sqls << """
			ALTER TABLE `front_user` 
			ADD CONSTRAINT `FK_683b8ffh0dfpsk2q36ogf09l2` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);
			"""
		
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 4;
	}
}
