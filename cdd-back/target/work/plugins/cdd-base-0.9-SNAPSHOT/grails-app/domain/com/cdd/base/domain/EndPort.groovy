package com.cdd.base.domain

class EndPort extends BaseDomain {
	
	String portName
	String portEnglishName
	String countryCh
	String countryEn
	String code
	String codeSimple
	String remark
	NewRoute route
	
	
	
	static mapping = {
		table 'end_port'
	}
	
	static constraints = {
		portName nullable: false, unique: false, blank: false, maxSize: 100
		portEnglishName nullable: true, unique: false, blank: false, maxSize: 100
		countryCh nullable: true
		countryEn nullable: true
		code nullable: true
		codeSimple nullable: true
		remark nullable: true
		route nullable: true
	}

}
