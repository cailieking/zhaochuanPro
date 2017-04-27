package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class BackDepartment extends BaseDomain {
	
	Long pId
	String name
	String manager
	String description
	static hasMany = [users: BackUser]
	
	static mapping = {
		table 'back_department'
		//authorities cascade: 'all-delete-orphan'
		//fetch: 'join'
	}
	
	
	static constraints = {
		pId maxSize: 11
		name maxSize: 255, blank: false, unique: true, nullable: false
		manager maxSize: 32, nullable: true
		description maxSize: 255, blank: true, unique: false, nullable: true
  }
}
