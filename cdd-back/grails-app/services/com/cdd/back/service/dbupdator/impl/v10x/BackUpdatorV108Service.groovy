package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV108Service extends AbstractBackDatabaseUpdator {

	@Override
	public Object updateSchema() {
		def sqls = []
		
		sqls << """
			 update cargo_ship_information  set release_num = CONCAT('P',DATE_FORMAT(date_created,'%H%i%s'))
		"""
		return sqls
	}
	
	MenuHelper menuHelper
	@Override
	public Object updateData() {
		return null;
	}
	@Override
	public int getOrder() {
		return 108;
	}

}
