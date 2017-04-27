package com.cdd.back.service.dbupdator.impl.v1x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV17Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `adv_corporation` CHANGE COLUMN `url` `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""
		
		return sqls
	}
	
	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 17;
	}
}
