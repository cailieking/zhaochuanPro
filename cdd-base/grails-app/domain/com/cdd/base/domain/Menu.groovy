package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class Menu extends BaseDomain {
	
	String name
	Menu parent
	String icon
	Requestmap map
	int orders
	boolean isHide
	
	static {
		transients << 'children'
	}
	List<Menu> children
	static mapping = {
		table 'back_menu'
	}
	
	static constraints = {
		name maxSize: 255, blank: false, unique: true, nullable: false
		icon maxSize: 255, blank: false, unique: false, nullable: true
		map nullable: true
		isHide nullable: false
  }
}
