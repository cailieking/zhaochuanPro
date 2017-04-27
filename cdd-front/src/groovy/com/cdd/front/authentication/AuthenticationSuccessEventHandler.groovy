package com.cdd.front.authentication

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.InteractiveAuthenticationSuccessEvent
import org.springframework.web.context.request.RequestContextHolder;
import com.cdd.base.domain.FrontUser

class AuthenticationSuccessEventHandler implements ApplicationListener<InteractiveAuthenticationSuccessEvent> {
	@Override
	public void onApplicationEvent(InteractiveAuthenticationSuccessEvent event) {
		FrontUser user = FrontUser.findByUsername(event.authentication.name)
		GrailsWebRequest webRequest = RequestContextHolder.currentRequestAttributes()
		HttpSession ses = webRequest.getSession()
		UsersListener uocl = new UsersListener()
		uocl.setUid(Integer.parseInt(String.valueOf(user.id)));
		ses.setAttribute("userId",uocl);
		//user.loginTime = new Date()
		//user.save(flush: true)
	}
	
	
}
