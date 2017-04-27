package com.cdd.base.domain

class SupplierPerson extends BaseDomain{
	
	String personName
	String phone
	String qq
	String email
	String tagName
	static belongsTo = [supplierManager:SupplierManager]
	
	static mapping = {
		table 'supplier_person'
	}
	
    static constraints = {
		personName nullable:false, blank: true, unique: false, maxSize: 32
		phone nullable: true, blank: true, unique: false, maxSize: 16
		qq nullable: true, blank: true, unique: false, maxSize: 16
		email nullable: true, blank: true, unique: false, maxSize: 64
		tagName nullable: true, blank: true, unique: false, maxSize: 16
    }
}
