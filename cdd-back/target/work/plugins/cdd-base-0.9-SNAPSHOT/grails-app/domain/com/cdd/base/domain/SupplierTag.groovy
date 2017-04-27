package com.cdd.base.domain

class SupplierTag extends BaseDomain{
	
		String tagName
		int customerCount
		int delTag
		String description
		
		static hasMany = [supplierManagers: SupplierManager]
	
		static mapping = {
			table 'supplier_tag'
		}
		static constraints = {
			tagName nullable: true, blank: false, unique: true, maxSize: 255
			customerCount nullable: true, blank: false, unique: false, maxSize: 11
			delTag nullable: true
			description nullable: true
		}
}

