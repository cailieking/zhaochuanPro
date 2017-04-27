package com.cdd.base.domain

class ClientType extends BaseDomain {
	String typeName
	int customerCount
	int delTag
	
	
	static hasMany = [clientManagers: ClientManager]
	
	static mapping = {
		table 'client_type'
	}
	static constraints = {
		typeName nullable: true, blank: false, unique: true, maxSize: 255
		customerCount nullable: true, blank: false, unique: false, maxSize: 11
		delTag  nullable: true
	}
	
}
