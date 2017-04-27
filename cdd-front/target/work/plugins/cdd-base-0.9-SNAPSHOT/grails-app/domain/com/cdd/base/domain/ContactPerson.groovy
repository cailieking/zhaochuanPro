package com.cdd.base.domain

class ContactPerson extends BaseDomain{
	
	String personName
	String phone
	String qq
	String email
	String tagName
	static belongsTo = [clientManager:ClientManager]
	
	static mapping = {
		table 'contact_person'
	}
	
    static constraints = {
		personName nullable:false, blank: true, unique: false, maxSize: 32
		phone nullable: true, blank: true, unique: false, maxSize: 16
		qq nullable: true, blank: true, unique: false, maxSize: 16
		email nullable: true, blank: true, unique: false, maxSize: 64
		tagName nullable: true, blank: true, unique: false, maxSize: 16
    }
}
