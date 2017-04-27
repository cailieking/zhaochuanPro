package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV68Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `company_certificate` 
								ADD COLUMN `company_name` varchar(100) NOT NULL,
								ADD COLUMN `address` varchar(100) NOT NULL,
								ADD COLUMN `city` varchar(10) NOT NULL,
								ADD COLUMN `special_service` varchar(100) ,
								ADD COLUMN `verified` bit(1) ,
								ADD COLUMN `honest` bit(1) ,
								ADD COLUMN `safety` bit(1) ,
								ADD COLUMN `introduce` varchar(2000) ,
								ADD COLUMN `workers` varchar(50) ,
								ADD COLUMN `scale` varchar(50) ,
								ADD COLUMN `website` varchar(50) ,
								ADD COLUMN `mailbox` varchar(50) ,
								ADD COLUMN `telephone` varchar(20) ,
								ADD COLUMN `business_range` varchar(100) ,
								ADD COLUMN `type` varchar(50) NOT NULL,
								ADD COLUMN `price_info` varchar(100) ,
								ADD COLUMN `remark` varchar(500) ,
								ADD COLUMN `bulid_time` varchar(50) ,
								ADD COLUMN `english_name` varchar(50) ,
								ADD COLUMN `advanced_route` varchar(50) ,
								
								
								ADD COLUMN `business_license_num` varchar(50)   AFTER `advanced_route`,
								ADD COLUMN  `business_license_img`  varchar(500) AFTER `business_license_num`,
							    ADD COLUMN  `tax_img` varchar(500) AFTER `business_license_img`,
								ADD COLUMN  `company_code_img` varchar(500) AFTER `tax_img`,
								ADD COLUMN  `state` int(10) NOT NULL AFTER `company_code_img`;

		"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 68
	}
}
