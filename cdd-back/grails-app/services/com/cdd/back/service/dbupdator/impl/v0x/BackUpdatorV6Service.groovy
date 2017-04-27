package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV6Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/order/data/**', description: '查看订单', authority: "AUTH_ORDER_DATA"],
			[url: '/orderAudit/data/**', description: '查看审核订单', authority: "AUTH_ORDER_AUDIT_DATA"],
			[url: '/orderTrade/data/**', description: '查看交易订单', authority: "AUTH_ORDER_TRADE_DATA"],
			[url: '/orderAudit/update/**', description: '修改订单审核信息', authority: "AUTH_ORDER_AUDIT_UPDATE"],
			[url: '/orderTrade/update/**', description: '修改订单交易信息', authority: "AUTH_ORDER_TRADE_UPDATE"],
			[url: '/orderTrade/uploadCertification/**', description: '上传交易凭证', authority: "AUTH_ORDER_TRADE_UPLOAD_CERT"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		Menu menu_system = Menu.findByName('订单管理')

		menuHelper.createMenu([authority: 'AUTH_ORDER_AUDIT_LIST',
			url: '/orderAudit/list/**',
			description: '审核订单'],
		[name: '审核订单', icon: 'bookmark-o'], menu_system)

		menuHelper.createMenu([authority: 'AUTH_ORDER_TRADE_LIST',
			url: '/orderTrade/list/**',
			description: '撮合交易'],
		[name: '撮合交易', icon: 'bookmark-o'], menu_system)

		return null
	}

	@Override
	public int getOrder() {
		return 6;
	}
}
