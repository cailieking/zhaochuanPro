package com.cdd.back.service.dbupdator.impl.v4x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV47Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/frontUser/delete/**', description: '删除前端用户', authority: "AUTH_FRONT_USER_DELETE"],
			[url: '/fakeFrontUser/delete/**', description: '删除导入用户', authority: "AUTH_FAKE_FRONT_USER_DELETE"],
			[url: '/fakeFrontUser/importData/**', description: '导入导入用户', authority: "AUTH_FAKE_FRONT_USER_IMPORT_DATA"],
			[url: '/fakeFrontUser/downloadExample/**', description: '下载导入用户模板', authority: "AUTH_FAKE_FRONT_USER_DOWNLOAD_EXAMPLE"],
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
		return 47;
	}
}
