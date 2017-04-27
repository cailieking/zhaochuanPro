package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV100Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `adv_corporation` 
			ADD COLUMN `custom_name` varchar(50) DEFAULT NULL,
			ADD COLUMN `contract_number` varchar(50) DEFAULT NULL,	
			ADD COLUMN `sales` varchar(50) DEFAULT NULL,	
			ADD COLUMN `state` INT(2) NOT NULL,
			ADD COLUMN `end_date` datetime DEFAULT CURRENT_TIMESTAMP(),
			ADD COLUMN `title` varchar(50) DEFAULT NULL,
			ADD COLUMN `alt` varchar(50) DEFAULT NULL,
			ADD COLUMN `href` varchar(255) DEFAULT NULL;
		"""
		return sqls
	}

	@Override
		def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/advManage/**', description: '广告管理'],
			
		].each { params ->
			if(!params.authority) {
				params.authority = SpringSecurityConstant.AUTH_PERMIT_ALL
			}
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		return null
	}

	@Override
	public int getOrder() {
		return 100
	}
}