package com.cdd.base.domain

class DemandClass extends BaseDomain {
	
	String demandName
	int customerCount
	int delTag
	
	static hasMany = [clientManagers: ClientManager]
	
	static mapping = {
		table 'demand_class'
	}
	static constraints = {
		demandName nullable: true, blank: false, unique: true, maxSize: 255
		customerCount nullable: true, blank: false, unique: false, maxSize: 11
		delTag  nullable: true
	}
	
}
