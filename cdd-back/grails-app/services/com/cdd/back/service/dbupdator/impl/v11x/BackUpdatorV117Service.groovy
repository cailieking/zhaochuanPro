package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV117Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			[
				[url: '/department/addEmployee/**', description: '添加员工', authority: "AUTH_SAVE_EP"],
				[url: '/department/delEmployee/**', description: '删除员工', authority: "AUTH_DEL_EP"],
				
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
		return 117
	}
}