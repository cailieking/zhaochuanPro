package com.cdd.base.domain

import com.cdd.base.enums.RouteType

class NewComeIn extends BaseDomain {
	int agent
	int orders
	boolean manual
	
	static mapping = {
		table 'new_come_in'
	} 
	
}
