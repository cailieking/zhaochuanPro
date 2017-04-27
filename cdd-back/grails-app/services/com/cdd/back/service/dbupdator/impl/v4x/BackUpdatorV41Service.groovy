package com.cdd.back.service.dbupdator.impl.v4x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV41Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/mail/list/**', description: '查询注册用户邮箱', authority: "AUTH_MAIL_LIST"],
			[url: '/mail/send/**', description: '发送邮件给注册用户', authority: "AUTH_MAIL_SEND"],
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
		return 41;
	}
}
