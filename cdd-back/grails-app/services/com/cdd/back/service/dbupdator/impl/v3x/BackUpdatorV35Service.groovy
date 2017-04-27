package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV35Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username

		[
			[url: '/frontUser/downloadExample/**', description: '下载前端用户模板', authority: "AUTH_FRONT_USER_DOWNLOAD_EXAMPLE"],
			[url: '/frontUser/importData/**', description: '导入前端用户', authority: "AUTH_FRONT_USER_IMPORT_DATA"],
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
		return 35;
	}
}
