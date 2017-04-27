package com.cdd.back.service.dbupdator.impl.v13x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV136Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		
		return sqls
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/tariffManager/downloadExampleFront/**', description: '对外运价模板下载', authority: 'permitAll'],
			[url: '/tariffManager/importDataFront/**', description: '对外运价导入', authority: "permitAll"]
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
		return 136;
	}
}
