package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV67Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `company` ADD COLUMN `business_license_num` varchar(50)   AFTER `advanced_route`,
								  ADD COLUMN  `business_license_img`  varchar(500) AFTER `business_license_num`,
								  ADD COLUMN  `tax_img` varchar(500) AFTER `business_license_img`,
								  ADD COLUMN  `company_code_img` varchar(500) AFTER `tax_img`;
		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 67
	}
}
