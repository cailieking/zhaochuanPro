package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV105Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			update  `back_menu` set orders = 2 where  name = '运价审核'
		"""
		
		sqls << """
			update  `back_menu` set orders = 3 where  name = '无效运价查询'
		"""
		
		sqls << """
			update  `cargo_ship_information` set `from_by` = '后台' where  `from_by` is null
		"""
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			return null
	}

	@Override
	public int getOrder() {
		return 105
	}
}