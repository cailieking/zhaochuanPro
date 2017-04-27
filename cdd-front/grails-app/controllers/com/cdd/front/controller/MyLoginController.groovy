package com.cdd.front.controller

import grails.plugin.springsecurity.LoginController
import grails.plugin.springsecurity.SpringSecurityUtils
import javax.servlet.http.HttpSession
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.access.annotation.Secured

@Secured('permitAll')
class MyLoginController extends LoginController{

	def index() {
			if (springSecurityService.isLoggedIn()) {
				if(params.url){
					redirect uri:params.url
				}else {
					redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
				}
			}
			else {
				redirect action: 'auth', params: params
			}
		}
		
	
	def auth() {
		def config = SpringSecurityUtils.securityConfig
	    //session.setAttribute("reUrl", params.url)
		//HttpSession session = request.getSession(true);
		//SecurityContextHolder.getContext().
		//session.setAttribute("reUrl",params.url)
		if (springSecurityService.isLoggedIn()) {
			println params.url
			if(params.url){
				redirect uri:params.url
			}else {
				redirect uri: config.successHandler.defaultTargetUrl
			}
			return
		}
		if(params.url != null){
			config.switchUser.targetUrl = "/"+params.url
		}else{
			config.switchUser.targetUrl = "/"
		}
		
		String view = 'auth'
		String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
		render view: view, model: [postUrl: postUrl,
		                           rememberMeParameter: config.rememberMe.parameter]
	}
}
