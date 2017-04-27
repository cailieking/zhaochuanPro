package com.cdd.base.domain

import com.cdd.base.json.JsonObject;


class City implements JsonObject {
	Integer pcode
	Integer code
	String name
	
	static mapping = {
		table 'city'
		cache true
	}
	
	static constraints = {
		pcode nullable: false
		code nullable: false
		name nullable: false
	}
}
