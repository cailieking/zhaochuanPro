package com.cdd.base.domain

class SupplierLevel extends BaseDomain {
	String levelName
	int customerCount 
	int delTag
	String description
	
	static hasMany = [supplierManagers: SupplierManager]
	
	static mapping = {
		table 'supplier_level'
	}
	static constraints = {
		levelName nullable: true, blank: false, unique: true, maxSize:128
		customerCount nullable: true, blank: false, unique: false, maxSize: 11
		delTag  nullable: true
		description  nullable: true
	}
}
