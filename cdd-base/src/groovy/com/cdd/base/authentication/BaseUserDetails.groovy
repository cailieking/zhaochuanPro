package com.cdd.base.authentication

import grails.plugin.springsecurity.userdetails.GrailsUser

import com.cdd.base.domain.User

class BaseUserDetails extends GrailsUser {
	
	String salt
	
//	User user

	public BaseUserDetails(User user) {
		super(user.username, user.password, true, true, true, true, user.authorities, user.id);
//		this.user = user;
		this.salt = user.salt;
	}
}
