package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV107Service extends AbstractBackDatabaseUpdator {

	
	@Override
	public Object updateSchema() {
		def sqls = []
		sqls << """
			update  `back_menu` set orders = 1 where  name = '运价维护'
		"""
		sqls << """
			 update cargo_ship_information  set release_num = DATE_FORMAT(date_created,'%Y%m%d%H%i%s')
		"""
		return sqls
	}
	MenuHelper menuHelper
	@Override
	public Object updateData() {
		def systemUser = User.SYSTEM.username
		return null
	}
	
	@Override
	public int getOrder() {
		return 107;
	}

}
