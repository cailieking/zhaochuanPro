package com.cdd.base.domain

class AccessLog extends BaseDomain {
	
	String visitor
	String type
	String url
	Date time
	String ip
	String city
	
	
	
	static mapping = {
		table 'access_log'
	}
	
	static constraints = {
		visitor nullable: true
		type nullable: true
		url nullable: true
		time nullable: true
		ip nullable: true
		city nullable: true
	}

}
