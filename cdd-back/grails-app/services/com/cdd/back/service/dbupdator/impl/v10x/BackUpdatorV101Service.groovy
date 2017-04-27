package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV101Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE `end_port_mapping` (
				  `id` bigint(20) NOT NULL AUTO_INCREMENT,
				  `changfan_port` varchar(255) DEFAULT NULL,
				  `end_port_id` bigint(20) DEFAULT NULL,
				  PRIMARY KEY (`id`),
				  KEY `end_port_id` (`end_port_id`),
				  CONSTRAINT `end_port_id` FOREIGN KEY (`end_port_id`) REFERENCES `end_port` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
				) ENGINE=InnoDB AUTO_INCREMENT=808 DEFAULT CHARSET=utf8;
		"""
		return sqls
	}

	@Override
		def updateData() {
		
		return null
	}

	@Override
	public int getOrder() {
		return 101
	}
}