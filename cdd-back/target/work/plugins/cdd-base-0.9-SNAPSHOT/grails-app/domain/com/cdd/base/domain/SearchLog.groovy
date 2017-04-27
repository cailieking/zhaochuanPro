package com.cdd.base.domain

import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType

class SearchLog extends BaseDomain {
	String startPort
	String endPort
	String shipCompany
	String searchUser
	int resultCount
	String searchSource
	Date searchTime
	String consuming
	boolean deleted
	static mapping = {
		table 'search_log'
	}
	
	static constraints = {
		startPort nullable: true, blank: true, unique: false, maxSize: 255
		endPort nullable: true, blank: true, unique: false, maxSize: 255
		shipCompany nullable: true, blank: true, unique: false, maxSize: 255
		searchUser nullable: true, blank: false, unique: false, maxSize: 32
		resultCount nullable: true, blank: false, unique: false, maxSize: 11
		searchSource nullable: true, blank: false, unique: false, maxSize: 4
		searchTime nullable: true
		consuming nullable: true, blank: false, unique: false, maxSize: 16
		deleted nullable: false
	}
}
