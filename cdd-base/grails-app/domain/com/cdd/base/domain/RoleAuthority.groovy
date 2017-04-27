package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class RoleAuthority extends BaseDomain {
	
	static belongsTo = [role: Role]
	Requestmap map
	
	static mapping = {
		table 'back_role_authority'
	}
	
}
