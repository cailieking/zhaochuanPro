package com.cdd.base.domain

import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
class LoginLog extends BaseDomain {
	
		String username
		String ip
		String city
		Date loginTime
		Date loginOutTime
		
		static mapping = {
			table 'login_log'
		}
		
		static constraints = {
			username nullable: true
			ip nullable: true
			city nullable: true
			loginTime nullable: true
			loginOutTime nullable: true
		}
	}
	

