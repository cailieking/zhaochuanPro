package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV39Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `image_information` 
			ADD COLUMN `state` INT(2) NOT NULL,
			ADD COLUMN `end_date` datetime DEFAULT NULL,
			ADD COLUMN `title` varchar(50) DEFAULT NULL,
			ADD COLUMN `alt` varchar(50) DEFAULT NULL,
			ADD COLUMN `href` varchar(255) DEFAULT NULL;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 39
	}
}
