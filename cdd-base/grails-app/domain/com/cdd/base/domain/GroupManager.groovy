package com.cdd.base.domain

class GroupManager extends BaseDomain {
	String groupName
	int customerCount 
	String description
	int delTag
	
	
	static hasMany = [clientManagers: ClientManager]
	
	static mapping = {
		table 'group_manager'
	}
	static constraints = {
		groupName nullable: true, blank: false, unique: true, maxSize: 255
		customerCount nullable: true, blank: false, unique: false, maxSize: 11
		description nullable: true, blank: true, unique: false, maxSize: 500
		delTag  nullable: true
	}
}
