package com.cdd.front.service.dbupdator.impl.v3x

import grails.plugin.springsecurity.SpringSecurityService

import com.cdd.base.domain.FrontUser
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV32Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		
		return null
	}
	
	SpringSecurityService springSecurityService
	
	@Override
	def updateData() {
		FrontUser.all.each { FrontUser data ->
			if(data.createBy == 'pengliya') {
				data.password = springSecurityService.encodePassword('111111', data.salt)
				data.save()
			}
		}
		return null
	}


	@Override
	public int getOrder() {
		return 32
	}
}
