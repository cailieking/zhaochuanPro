package com.cdd.base.domain


class ClientManager extends BaseDomain {
	
	String companyName
	String address
	String remark
	String postCode
	String telephone  
	String faxes
	String email
	TagManager tagManager
	GroupManager groupManager
	DemandClass demandClass
	ClientType  clientType
//	TagManager tag
//	GroupManager group
//	DemandClass demand
//	ClientType type
	int delTag
	
	static belongsTo = [tagManager: TagManager, groupManager: GroupManager, demandClass: DemandClass, clientType: ClientType]
	
	static hasMany = [contactPersons: ContactPerson]
	//static manytomany = [tagManager: TagManager]
	
	static mapping = {
		table 'client_manager'
		contactPersons cascade: 'all-delete-orphan'
	}
	
	static constraints = {
		companyName nullable: true, blank: true, unique: true, maxSize: 255
		address nullable: true, blank: true, unique: false, maxSize: 500
		remark nullable: true, maxSize: 500
		postCode nullable: true, blank: false, unique: false, maxSize: 6
		telephone nullable: true, blank: true, unique: false, maxSize: 20
		faxes nullable: true, blank: true, unique: false, maxSize: 20
		email nullable:true,black:false,unique:false,maxsize: 64
		tagManager nullable: true
		groupManager nullable: true
		demandClass nullable: true
		clientType nullable: true 
		delTag nullable: true
	}

}
