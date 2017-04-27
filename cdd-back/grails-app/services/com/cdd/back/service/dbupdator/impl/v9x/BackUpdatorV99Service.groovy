package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV99Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		
		return null
	}

	@Override
		def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/imageInfo/changeState/**', description: '启用禁用', authority: "AUTH_IMAGEINFO_CHANGESTATE"],
			[url: '/imageInfo/deleteOssImage/**', description: '删除oss图片', authority: "AUTH_IMAGEINFO_DELETEOSSIMAGE"],
			
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
		return 99
	}
}