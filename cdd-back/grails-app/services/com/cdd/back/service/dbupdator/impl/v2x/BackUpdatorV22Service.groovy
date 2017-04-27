package com.cdd.back.service.dbupdator.impl.v2x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV22Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
//		sqls << """
//			ALTER TABLE `cargo_ship_information` 
//				ADD COLUMN `start_port_cn` varchar(255) AFTER `wanted_order_id`, 
//				ADD COLUMN `end_port_cn` varchar(255) AFTER `start_port_cn`, 
//				ADD COLUMN `middle_port_cn` varchar(255) AFTER `end_port_cn`;
//		"""
		
		return sqls
	}
	
	
	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 22;
	}
}
