package com.cdd.back.security.authentication

import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.InteractiveAuthenticationSuccessEvent

import com.cdd.base.domain.BackUser

class AuthenticationSuccessEventHandler implements ApplicationListener<InteractiveAuthenticationSuccessEvent> {

	@Override
	public void onApplicationEvent(InteractiveAuthenticationSuccessEvent event) {
		BackUser user = BackUser.findByUsername(event.authentication.name)
		user.loginTime = new Date()
		user.save(flush: true)
	}
}
