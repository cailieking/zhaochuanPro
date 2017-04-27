package com.cdd.back.service.dbupdator

import grails.plugin.springsecurity.SpringSecurityService

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.security.crypto.keygen.KeyGenerators

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class SuperAdminSettingService {
	SpringSecurityService springSecurityService

	GrailsApplication grailsApplication
	
	def update() {
		def superadminConfig = grailsApplication.config.superadmin
		BackUser superadmin = BackUser.findByUsername(superadminConfig.username)
		boolean toUpdate = false
		
		if (!superadmin) {
			superadmin = new BackUser()
			superadmin.username = superadminConfig.username
			superadmin.salt = KeyGenerators.string().generateKey()
			superadmin.password = springSecurityService.encodePassword(superadminConfig.password, superadmin.salt)
			toUpdate = true
		}
		
		Role role = Role.findByName(superadminConfig.role.name)
		if(!role) {
			role = new Role(name: superadminConfig.role.name, 
					description: superadminConfig.role.description, 
					createBy: User.SYSTEM.username,
					updateBy: User.SYSTEM.username)
		}
		def auths = role.authorities
		auths?.clear()
		auths = Requestmap.findAllByAuthorityNotEqual(SpringSecurityConstant.AUTH_PERMIT_ALL)
		auths?.each { requestmap ->
			RoleAuthority auth = new RoleAuthority(map: requestmap, 
					createBy: User.SYSTEM.username, 
					updateBy: User.SYSTEM.username)
			role.addToAuthorities(auth)
		}
		role.save()
		
		if(!superadmin.role) {
			superadmin.role = role
			toUpdate = true
		}
		
//		String newPassword = springSecurityService.encodePassword(superadminConfig.password, superadmin.salt)
//		if (superadmin.password != newPassword) {
//			superadmin.password = newPassword
//			toUpdate = true
//		}
		
		[
			'email',
			'firstname',
			'middlename',
			'lastname',
			'sex',
			'birth',
			'mobile',
			'description'
		].each {
			if(superadminConfig[it] && superadmin[it] != superadminConfig[it]) {
				superadmin[it] = superadminConfig[it]
				toUpdate = true
			}
		}
		
		if (toUpdate) {
			if(!superadmin.createBy) {
				superadmin.createBy = User.SYSTEM.username
			}
			superadmin.updateBy = User.SYSTEM.username
			superadmin.save()
			if(superadmin.hasErrors()) {
				throw new IllegalStateException(superadmin.errors.allErrors.toString())
			}
		}
	}
}
