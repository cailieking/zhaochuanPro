package com.cdd.base.domain


class SupplierManager extends BaseDomain {
	
	String companyName
	String address
	String postCode
	String phone  
	String faxes
	String email
	SupplierTag supplierTag
	SupplierGroup supplierGroup
	SupplierAccount supplierAccount
	SupplierLevel  supplierLevel
//	TagManager tag
//	GroupManager group
//	DemandClass demand
//	ClientType type
	int delTag
	
	static belongsTo = [supplierTag: SupplierTag, supplierGroup: SupplierGroup, supplierAccount: SupplierAccount, supplierLevel: SupplierLevel]
	
	static hasMany = [supplierPersons: SupplierPerson,routes:NewRoute]
	//static manytomany = [tagManager: TagManager]
	
	static mapping = {
		table 'supplier_manager'
		supplierPersons cascade: 'all-delete-orphan'
	}
	
	static constraints = {
		companyName nullable: true, blank: true, unique: true, maxSize: 255
		address nullable: true, blank: true, unique: false, maxSize: 500
		postCode nullable: true, blank: false, unique: false, maxSize: 6
		phone nullable: true, blank: true, unique: false, maxSize: 20
		faxes nullable: true, blank: true, unique: false, maxSize: 20
		email nullable:true,black:false,unique:false,maxsize: 64
		supplierTag nullable: true
		supplierGroup nullable: true
		supplierAccount nullable: true
		supplierLevel nullable: true 
		delTag nullable: true
	}

}
