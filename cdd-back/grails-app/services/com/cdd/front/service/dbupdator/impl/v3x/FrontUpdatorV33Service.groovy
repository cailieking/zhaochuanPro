package com.cdd.front.service.dbupdator.impl.v3x

import grails.plugin.springsecurity.SpringSecurityService

import com.cdd.base.domain.FrontUser
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV33Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE `recommended_route` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,
				`user_id` bigint(20) NOT NULL,
				`category` varchar(50) NOT NULL,
				PRIMARY KEY (`id`),
				CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `front_user` (`id`),
				INDEX `idx_user_id` USING BTREE (`user_id`) comment ''
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
		return 33
	}
}
