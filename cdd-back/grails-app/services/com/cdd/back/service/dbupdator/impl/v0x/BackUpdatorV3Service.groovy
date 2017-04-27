package com.cdd.back.service.dbupdator.impl.v0x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV3Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}


	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username

		def requestmaps = [
	     Requestmap.findByAuthority('AUTH_ENTRY'),
	     Requestmap.findByAuthority('AUTH_USER_RESET_PASSWORD'),
	     Requestmap.findByAuthority('AUTH_USER_SELF'),
	     Requestmap.findByAuthority('AUTH_USER_SAVE_SELF'),
	     Requestmap.findByAuthority('AUTH_ORDER_LIST'),
	     Requestmap.findByAuthority('AUTH_ORDER_UPDATE'),
    ]
		
		[
			Role.findByName('总监'),	
			Role.findByName('经理'),	
			Role.findByName('业务员'),	
			Role.findByName('客服'),	
		].each { role ->
			if(role.name == '总监' || role.name  == '经理') {
				requestmaps << Requestmap.findByAuthority('AUTH_USER_DATA')
			}
			requestmaps.each {
				RoleAuthority auth = new RoleAuthority()
				auth.role = role
				auth.map = it
				auth.createBy = systemUser
				auth.updateBy = systemUser
				auth.save()
			}
		}
		return null
	}

	@Override
	public int getOrder() {
		return 3;
	}
}
