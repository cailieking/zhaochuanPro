package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV8Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		
		return null
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/shipInfo/data/**', description: '查看货代信息', authority: "AUTH_SHIP_INFO_DATA"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}

		Menu menu_system = new Menu(name: '货代管理', icon: 'anchor', createBy: systemUser, updateBy: systemUser).save()

		menuHelper.createMenu([authority: 'AUTH_SHIP_INFO_LIST',
			url: '/shipInfo/list/**',
			description: '货代查询'],
		[name: '货代查询', icon: 'file-text-o'], menu_system)
		
		menuHelper.createMenu([authority: 'AUTH_SHIP_AUDIT_LIST',
			url: '/shipAudit/list/**',
			description: '货代审核'],
		[name: '货代审核', icon: 'bookmark-o'], menu_system)

		return null
	}

	@Override
	public int getOrder() {
		return 8;
	}
}
