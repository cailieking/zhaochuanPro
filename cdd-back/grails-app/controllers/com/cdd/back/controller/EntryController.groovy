package com.cdd.back.controller

import grails.plugin.springsecurity.SpringSecurityService

import javax.servlet.http.Cookie
import javax.servlet.http.HttpSession

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest

import com.cdd.back.util.UsersListener
import com.cdd.base.domain.BackUser

import org.springframework.web.context.request.RequestContextHolder;


class EntryController {
	
	SpringSecurityService springSecurityService

	def index() {
		GrailsWebRequest webRequest = RequestContextHolder.currentRequestAttributes()
		HttpSession ses = webRequest.getSession()
		ses.setMaxInactiveInterval(3*60*60);
		BackUser user = springSecurityService.currentUser
		
		UsersListener uocl = new UsersListener()
		uocl.setUid(Integer.parseInt(String.valueOf(user.id)));
		ses.setAttribute("userId",uocl);
		def authority = user.authorities.find {
			if(it.authority == 'AUTH_USER_LIST') {
				return it
			}
		}
		String	uri = authority ? '/user/list' : '/order/list'
//		Cookie myCookie =
//  new Cookie("jsessionid", session.id);
//  response.addCookie(myCookie);
		redirect uri: uri
//		if(authority) {
//			forward controller: 'user', action: 'list'
//		} else {
//			forward controller: 'order', action: 'list'
//		}
//		response.sendRedirect(uri)
	}
	
}
