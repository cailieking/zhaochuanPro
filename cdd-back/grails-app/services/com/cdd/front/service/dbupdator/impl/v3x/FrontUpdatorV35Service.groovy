package com.cdd.front.service.dbupdator.impl.v3x

import com.cdd.base.domain.FrontAuthority
import com.cdd.base.domain.FrontUser
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV35Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	@Override
	def updateData() {
		FrontAuthority clientAuth = new FrontAuthority()
		clientAuth.authority = 'ROLE_CLIENT'
		clientAuth.createBy = 'system'
		clientAuth.updateBy = 'system'
		clientAuth.save()
		FrontAuthority agentAuth = new FrontAuthority()
		agentAuth.authority = 'ROLE_SHIP_AGENT'
		agentAuth.createBy = 'system'
		agentAuth.updateBy = 'system'
		agentAuth.save()
		
		FrontUser.all.each { FrontUser user ->
			if(!user.auths) {
				user.addToAuths(agentAuth)
			}
			user.addToAuths(clientAuth)
			user.save()
		}
		return null
	}


	@Override
	public int getOrder() {
		return 35
	}
}
