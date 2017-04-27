package com.cdd.back.security.authentication

import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional
import javax.servlet.http.HttpSession

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.springframework.security.authentication.AuthenticationServiceException
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider
import org.springframework.security.core.AuthenticationException
import org.springframework.security.core.userdetails.UserDetails

import com.cdd.base.domain.BackUser
import com.cdd.base.authentication.BaseUserDetails
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.springframework.web.context.request.RequestContextHolder;
import grails.plugin.springsecurity.SpringSecurityUtils


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
		BackUser user = BackUser.findByUsername(username)
		if(!user) {
			throw new BadCredentialsException('用户名或密码有误')
		}

		if(!user.enabled) {
			throw new AuthenticationServiceException("用户已被禁用，请联系管理员开放权限后再次尝试登陆")
		}

		if(user.accountExpired || user.passwordExpired) {
			throw new AuthenticationServiceException("用户已过期，请联系管理员开放权限后再次尝试登陆")
		}

		if(user.password != springSecurityService.encodePassword(authentication.credentials, user.salt) && user.lockDown()) {
			throw new BadCredentialsException('用户名或密码有误')
		}

		if(user.accountLockedCount >= 5) {
			def leftMins = user.leftMinutes
			if(leftMins <= 0) {
				user.reset()
			} else {
				throw new AuthenticationServiceException("用户已被锁定，请在${leftMins}分钟后再次尝试登陆")
			}
		} else {
			user.reset()
		}
		
		println SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
		return new BaseUserDetails(user)
	}
}
