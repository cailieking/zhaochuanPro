package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV32Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username

		[
			[url: '/orderTrash/data/**', description: '查看垃圾订单', authority: "AUTH_ORDER_TRASH_DATA"],
			[url: '/shipInfoTrash/data/**', description: '查看垃圾货代', authority: "AUTH_SHIP_INFO_TRASH_DATA"],
			[url: '/orderTrash/revert/**', description: '还原垃圾订单', authority: "AUTH_ORDER_TRASH_REVERT"],
			[url: '/shipInfoTrash/revert/**', description: '还原垃圾货代', authority: "AUTH_SHIP_INFO_TRASH_REVERT"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}

		Menu orderMenu = Menu.findByName('订单管理')

		menuHelper.createMenu([authority: 'AUTH_ORDER_TRASH_LIST',
			url: '/orderTrash/list/**',
			description: '垃圾订单查询'],
		[name: '垃圾订单查询', icon: 'file-text-o'], orderMenu)

		Menu shipMenu = Menu.findByName('货代管理')

		menuHelper.createMenu([authority: 'AUTH_SHIP_INFO_TRASH_LIST',
			url: '/shipInfoTrash/list/**',
			description: '垃圾货代查询'],
		[name: '垃圾货代查询', icon: 'file-text-o'], shipMenu)

		return null
	}

	@Override
	public int getOrder() {
		return 32;
	}
}
