package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV126Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			alter table `client_manager` add column email varchar(64) default null
		"""
		
		sqls << """
			alter table `contact_person` add column tag_name varchar(16) default null
		"""
		return sqls
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
			[
				[url: '/clientManager/saveContact/**', description: '添加联系人', authority: "AUTH_SAVE_CONTACT"],
				[url: '/clientManager/editClient/**', description: '编辑客户', authority: "AUTH_EDIT_CLIENT"]
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
		return 126
	}
}