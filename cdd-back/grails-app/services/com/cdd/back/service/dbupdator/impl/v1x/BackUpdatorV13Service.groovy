package com.cdd.back.service.dbupdator.impl.v1x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV13Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		
		return null
	}
	
	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/imageInfo/data/**', description: '图片广告', authority: "AUTH_IMAGE_INFO_DATA"],
			[url: '/imageInfo/save/**', description: '保存图片广告', authority: "AUTH_IMAGE_INFO_SAVE"],
			[url: '/imageInfo/delete/**', description: '删除图片广告', authority: "AUTH_IMAGE_INFO_DELETE"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		Menu menu_system = new Menu(name: '资讯管理', icon: 'rss-square', createBy: systemUser, updateBy: systemUser).save()
		
		menuHelper.createMenu([authority: 'AUTH_IMAGE_INFO_LIST',
			url: '/imageInfo/list/**',
			description: '图片广告管理'],
		[name: '图片广告管理', icon: 'picture-o'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 13;
	}
}
