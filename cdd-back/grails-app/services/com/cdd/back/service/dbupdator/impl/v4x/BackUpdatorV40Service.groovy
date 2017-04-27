package com.cdd.back.service.dbupdator.impl.v4x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV40Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `stat_staff` CHANGE COLUMN `import_front_users` `import_agent_users` int(11) NOT NULL, 
			ADD COLUMN `import_cargo_users` int(11) NOT NULL AFTER `cert_passed`;
		"""
		
		return sqls
	}
	
	
	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 40;
	}
}
