package com.cdd.base.domain


class JobTitle extends BaseDomain{
	
	String name
	String pId
	String description
	static hasMany = [users: BackUser]
	
	static mapping = {
		table 'back_job_title'
	}
	
  	static constraints = {
		name maxSize: 32, blank: false, unique: true, nullable: false
		pId maxSize: 11
		description maxSize: 255, blank: true, unique: false, nullable: true
	}
}
