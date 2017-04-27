package com.cdd.base.domain

class TagManager extends BaseDomain{
	
		String tagName
		int customerCount
		String description 
		int delTag
		
		static hasMany = [clientManagers: ClientManager]
	
		static mapping = {
			table 'tag_manager'
		}
		static constraints = {
			tagName nullable: true, blank: false, unique: true, maxSize: 255
			customerCount nullable: true, blank: false, unique: false, maxSize: 11
			description nullable: true, blank: true, unique: false, maxSize: 500
			delTag nullable: true
		}
}

