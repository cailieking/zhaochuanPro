package com.cdd.base.domain

class SupplierGroup extends BaseDomain {
	String groupName
	int customerCount 
	int delTag
	String description
	
	static hasMany = [supplierManagers: SupplierManager]
	
	static mapping = {
		table 'supplier_group'
	}
	static constraints = {
		groupName nullable: true, blank: false, unique: true, maxSize: 255
		customerCount nullable: true, blank: false, unique: false, maxSize: 11
		delTag  nullable: true
		description  nullable: true
	}
}
