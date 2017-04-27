package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class Role extends BaseDomain {
	
	String name
	String description
	
	static hasMany = [users: BackUser, authorities: RoleAuthority]
	
	static mapping = {
		table 'back_role'
		authorities cascade: 'all-delete-orphan'
	}
	
	static constraints = {
		name maxSize: 255, blank: false, unique: true, nullable: false
		description maxSize: 255, blank: true, unique: false, nullable: true
  }
}
