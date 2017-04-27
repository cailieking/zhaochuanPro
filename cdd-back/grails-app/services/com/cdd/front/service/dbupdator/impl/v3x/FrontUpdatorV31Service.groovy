package com.cdd.front.service.dbupdator.impl.v3x

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV31Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `front_user` CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}


	@Override
	public int getOrder() {
		return 31
	}
}
