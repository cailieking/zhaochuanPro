 package com.cdd.back.domain

import com.cdd.base.domain.City
import com.cdd.base.domain.User
import com.cdd.base.enums.FrontUserType

class FakeFrontUser extends User {
	String companyName
	City city
	String address
	String qq
	String phone
	FrontUserType type
	boolean registered
	String remark
	String checkBy
	
	static mapping = {
		table 'fake_front_user'
	}
	
	static constraints = {
		username size: 5..255, blank: false, unique: true, nullable: false, matches: '\\d{11}'
		companyName nullable: false, blank: false, unique: false, maxSize: 255
		city nullable: false
		address nullable: true, blank: false, unique: false, maxSize: 500
		phone nullable: true, blank: false, unique: false, maxSize: 50
		qq nullable: true, blank: false, unique: false, maxSize: 50
		type nullable: true
		registered nullable: false
		remark nullable: true, maxSize: 500
		checkBy nullable: true
		
	}
}
