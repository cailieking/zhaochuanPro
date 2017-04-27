package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV3Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			ALTER TABLE `front_authority_users` 
			CHANGE COLUMN `authority_id` `front_authority_id` bigint(20) NOT NULL, 
			DROP PRIMARY KEY, ADD PRIMARY KEY (`front_authority_id`, `front_user_id`);
		"""

		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 3;
	}
}
