package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV109Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			alter table search_log drop column `name` 

		"""
		
		sqls << """
			alter table search_log modify  `result_count` int(1) 

		"""
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			[
				[url: '/shipInfo/saveInfoConsuming/**', description: '搜索记录log', authority: "AUTH_SAVE_SEARCH_LOG"]
				
			].each { params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				Requestmap map = new Requestmap(params)
				map.save()
			}
			
			return null
	}

	@Override
	public int getOrder() {
		return 109
	}
}