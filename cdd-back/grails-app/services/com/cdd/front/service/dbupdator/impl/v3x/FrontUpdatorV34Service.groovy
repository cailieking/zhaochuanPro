package com.cdd.front.service.dbupdator.impl.v3x

import grails.plugin.springsecurity.SpringSecurityService

import com.cdd.base.domain.FrontUser
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV34Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `cargo_ship_information` DROP INDEX `idx_companyName`, DROP INDEX `idx_routeName`, ADD INDEX `idx_companyName` USING HASH (`company_name`) comment '', ADD INDEX `idx_routeName` USING HASH (`route_name`) comment '', ADD INDEX `idx_end_port` USING HASH (`end_port`) comment '', ADD INDEX `idx_start_port` USING HASH (`start_port`) comment '';
		"""
		sqls << """
			ALTER TABLE `route` ADD INDEX `idx_port` USING HASH (`port`) comment '', ADD INDEX `idx_category` USING HASH (`category`) comment '';
		"""
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 34
	}
}
