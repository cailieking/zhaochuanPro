package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV60Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE IF NOT EXISTS `recommended_ship_info` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,
				`info_id` bigint(20) NOT NULL,
				`order_id` bigint(20) NOT NULL,
				PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 60
	}
}
