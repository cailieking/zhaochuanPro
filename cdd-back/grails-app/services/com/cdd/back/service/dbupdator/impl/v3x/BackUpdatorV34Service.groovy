package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV34Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `route` CHANGE COLUMN `category` `category` varchar(255) COLLATE utf8_bin DEFAULT NULL;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 34;
	}
}
