package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV39Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `stat_staff` CHANGE COLUMN `id` `id` bigint(20) NOT NULL AUTO_INCREMENT;
		"""
		
		return sqls
	}
	

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 39;
	}
}
