package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV129Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
	
		sqls << """
			alter table `supplier_tag` add column `description` varchar(256) COLLATE utf8_bin DEFAULT NULL 
		
		"""
		
		sqls << """
			alter table `supplier_account` add column `description` varchar(256) COLLATE utf8_bin DEFAULT NULL 
		
		"""
		
		sqls << """
			alter table `supplier_account` add column `post_code` varchar(6) COLLATE utf8_bin DEFAULT NULL 
		
		"""
		
	
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
		
		return null
			
	}

	@Override
	public int getOrder() {
		return 129
	}
}