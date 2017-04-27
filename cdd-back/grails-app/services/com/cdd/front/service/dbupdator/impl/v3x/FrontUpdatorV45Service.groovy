package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.back.util.MenuHelper;
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator;

class FrontUpdatorV45Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE IF NOT EXISTS `login_log`(
					  `id` bigint(20) NOT NULL AUTO_INCREMENT,
					  `username` varchar(50) DEFAULT NULL,
					  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				  	  `date_created` datetime NOT NULL,
					  `last_updated` datetime NOT NULL,
					  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
					  `login_time` datetime DEFAULT NULL,
					  `login_out_time` datetime DEFAULT NULL,
					  `ip` varchar(500) DEFAULT NULL,
					  `city` varchar(500) DEFAULT NULL,
					  PRIMARY KEY (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		"""
		return sqls
	}
	MenuHelper menuHelper
	@Override
	def updateData() {
		
		return null
	}

	@Override
	public int getOrder() {
		return 45
	}
}