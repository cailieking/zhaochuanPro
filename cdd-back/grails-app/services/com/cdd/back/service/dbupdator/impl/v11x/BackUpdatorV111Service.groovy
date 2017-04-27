package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV111Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `back_menu` 
			ADD COLUMN `is_hide` bit(1) NOT NULL;
		"""
		
		sqls << """
			ALTER TABLE `back_requestmap` 
			ADD COLUMN `menu_id` bigint(20) ;

		"""
		
		sqls << """
			alter table back_requestmap add constraint FK_ID foreign key(menu_id) REFERENCES back_menu(id);

		"""
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			[
				[url: '/menu/menuData/**', description: '菜单信息', authority: "AUTH_MENU_MENUDATA"],
				
				[url: '/menu/show/**', description: '隐藏或显示菜单', authority: "AUTH_MENU_SHOW"],
				[url: '/role/aa/**', description: '获取URL', authority: "AUTH_ROLE_AA"],
				[url: '/role/roleSave/**', description: '保存新角色', authority: "AUTH_ROLE_ROLESAVE"],
				[url: '/role/roleRquestmapSave/**', description: '角色权限保存', authority: "AUTH_ROLE_ROLEREQUESTMAPSAVE"]
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
		return 111
	}
}