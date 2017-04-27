package com.cdd.back.service.dbupdator.impl.v2x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV24Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
//		sqls << """
//			ALTER TABLE `orders` CHANGE COLUMN `deal_price` `deal_price` decimal(19,2);
//		"""
		
		return sqls
	}
	
	
	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 24;
	}
}
