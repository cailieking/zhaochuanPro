package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV8Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			ALTER TABLE `cargo_ship_information` 
			MODIFY COLUMN `user_id` bigint(20) DEFAULT NULL; 
			"""
		sqls << """
			ALTER TABLE `orders` 
			MODIFY COLUMN `agent_id` bigint(20) DEFAULT NULL; 
			"""
		sqls << """
			ALTER TABLE `orders` 
			MODIFY COLUMN `owner_id` bigint(20) DEFAULT NULL; 
			"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 8;
	}
}
