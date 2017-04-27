package com.cdd.front.authentication

import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional

import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider
import org.springframework.security.core.AuthenticationException
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.core.userdetails.UserDetails
import grails.plugin.springsecurity.SpringSecurityUtils
import com.cdd.base.authentication.BaseUserDetails
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Requestmap;

class UserDetailsProvider extends AbstractUserDetailsAuthenticationProvider {

	
	@Override
	protected void additionalAuthenticationChecks(UserDetails userDetails,
			UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
		// TODO Auto-generated method stub

	}

	SpringSecurityService springSecurityService

	@Transactional
	@Override
	protected UserDetails retrieveUser(String username, UsernamePasswordAuthenticationToken authentication)
	throws AuthenticationException {
		FrontUser user = FrontUser.findByUsername(username)
		if(!user) {
			throw new BadCredentialsException('用户名或密码有误')
		}

		if(user.password != springSecurityService.encodePassword(authentication.credentials, user.salt)) {
			throw new BadCredentialsException('用户名或密码有误')
		}
		return new BaseUserDetails(user)
	}
}
