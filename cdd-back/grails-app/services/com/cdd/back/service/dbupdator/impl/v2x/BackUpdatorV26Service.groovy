package com.cdd.back.service.dbupdator.impl.v2x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV26Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
//		sqls << """
//			ALTER TABLE `orders` CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
//		"""
//		
//		sqls << """
//			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
//		"""
		
		return sqls
	}
	
	
	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 26;
	}
}
