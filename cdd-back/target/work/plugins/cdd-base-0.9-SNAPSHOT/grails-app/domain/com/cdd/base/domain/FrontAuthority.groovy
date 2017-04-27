package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class FrontAuthority extends BaseDomain {
	
	String authority
	
	static hasMany = [users: FrontUser] 

	static mapping = {
		table 'front_authority'
	}
	
	static constaints = {
		authority unique: true, maxSize: 50, blank: false, nullable: false
	}
	
}
