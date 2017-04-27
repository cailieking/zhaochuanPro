package com.cdd.base.domain

class DatabaseUpdate extends BaseDomain {
	String module
	int ver
	
	static mapping = {
		table 'database_update'
	}
	
	static constraints = {
		module maxSize: 255, blank: false, unique: false, nullable: false
		ver validator: { val, obj, errors ->
			if (val <= 0) errors.rejectValue('ver', 'errors.dbupdate.version.minimun.out.of.range')
		}
	}
}
