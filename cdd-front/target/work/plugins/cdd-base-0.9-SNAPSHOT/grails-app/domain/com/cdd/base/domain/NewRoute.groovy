package com.cdd.base.domain


import com.cdd.base.domain.BackUser
class NewRoute extends BaseDomain {
	String routeName
	String routeEnglishName
	String englishName
	String remark
	
	static belongsTo = BackUser
	
	static hasMany = [endPort: EndPort,users : BackUser]
	static mapping = {
		table 'new_route'
	}
	static contraints = {
		routeName maxSize: 255, blank: false, unique: true, nullable: false
		routeName maxSize: 255, blank: false, unique: true, nullable: false
		englishName nullable: true
		remark nullable: true
	}
}
