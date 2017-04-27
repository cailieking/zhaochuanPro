package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV36Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/shipScore/data/**', description: '查看货代评分信息', authority: "AUTH_SHIP_SCORE_DATA"],
			[url: '/shipScore/save/**', description: '保存货代评分', authority: "AUTH_SHIP_SCORE_SAVE"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}

		Menu menu_system = Menu.findByName('货代管理')

		menuHelper.createMenu([authority: 'AUTH_SHIP_SCORE_LIST',
			url: '/shipScore/list/**',
			description: '货代评分列表'],
		[name: '货代评分查询', icon: 'file-code-o'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 36;
	}
}
