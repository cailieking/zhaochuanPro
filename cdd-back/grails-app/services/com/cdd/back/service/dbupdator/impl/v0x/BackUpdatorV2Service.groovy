package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV2Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `back_user` ADD COLUMN `position` varchar(50) AFTER `login_time`, 
			ADD COLUMN `position_level` varchar(50) AFTER `position`;
		"""
		
		return sqls
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/order/update/**', description: '修改订单', authority: "AUTH_ORDER_UPDATE"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}

		Menu menu_system = new Menu(name: '订单管理', icon: 'calendar-o', createBy: systemUser, updateBy: systemUser).save()

		menuHelper.createMenu([authority: 'AUTH_ORDER_LIST',
			url: '/order/list/**',
			description: '订单查询'],
		[name: '订单查询', icon: 'file-text-o'], menu_system)

		[
			[name: '总监', description: '业务总监/客服总监'],	
			[name: '经理', description: '业务经理/客服经理'],	
			[name: '业务员', description: '一般销售人员'],	
			[name: '客服', description: '客户服务人员'],	
		].each { roleItem ->
			Role role = new Role(roleItem)
			role.createBy = systemUser
			role.updateBy = systemUser
			role.save(flush: true)
		}
		return null
	}

	@Override
	public int getOrder() {
		return 2;
	}
}
