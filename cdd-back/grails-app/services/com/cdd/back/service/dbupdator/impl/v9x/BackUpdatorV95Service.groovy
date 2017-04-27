package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV95Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		
		return null
	}

	@Override
		def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/upload/excute/**', description: '上传图片', authority: "AUTH_UPLOAD_DATA"],
			
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
		return 95
	}
}