package com.cdd.base.domain

import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.RouteType

class Route extends BaseDomain {
	String port
	RouteCategory category
	RouteType type
	String city
	String shortName
	
	static mapping = {
		table 'route'
	} 
	
	static constraints = {
		port nullable: false, blank: false, unique: false, maxSize: 255
		shortName nullable: true, blank: false, unique: false, maxSize: 255
		city nullable: true, blank: false, unique: false, maxSize: 255
		category nullable: true
		type nullable: false
	}
}
