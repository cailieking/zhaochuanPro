package com.cdd.back.service.dbupdator.impl.v1x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV16Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `image_information` CHANGE COLUMN `html` `content` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""
		
		sqls << """
			RENAME TABLE advertisement TO adv_corporation
		"""
		
		return sqls
	}
	
	MenuHelper menuHelper
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/advCorp/data/**', description: '合作商信息', authority: "AUTH_ADV_CORP_DATA"],
			[url: '/advCorp/save/**', description: '保存合作商', authority: "AUTH_ADV_CORP_SAVE"],
			[url: '/advCorp/delete/**', description: '删除合作商', authority: "AUTH_ADV_CORP_DELETE"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		Menu menu_system = Menu.findByName('资讯管理')
		
		menuHelper.createMenu([authority: 'AUTH_ADV_CORP_LIST',
			url: '/advCorp/list/**',
			description: '合作厂商管理'],
		[name: '合作厂商管理', icon: 'external-link'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 16;
	}
}
