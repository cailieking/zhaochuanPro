package com.cdd.back.service.dbupdator.impl.v1x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV18Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `article_information` CHANGE COLUMN `url` `image` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin;
		"""
		
		return sqls
	}
	
	MenuHelper menuHelper
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/article/data/**', description: '文章信息', authority: "AUTH_ARTICLE_DATA"],
			[url: '/article/save/**', description: '保存文章', authority: "AUTH_ARTICLE_SAVE"],
			[url: '/article/delete/**', description: '删除文章', authority: "AUTH_ARTICLE_DELETE"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		
		Menu menu_system = Menu.findByName('资讯管理')
		
		menuHelper.createMenu([authority: 'AUTH_ARTICLE_LIST',
			url: '/article/list/**',
			description: '文章管理'],
		[name: '文章管理', icon: 'file-pdf-o'], menu_system)
		
		return null
	}

	@Override
	public int getOrder() {
		return 18;
	}
}
