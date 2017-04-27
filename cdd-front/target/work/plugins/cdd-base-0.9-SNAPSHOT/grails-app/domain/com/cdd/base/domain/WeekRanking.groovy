package com.cdd.base.domain

import java.util.Date;

class WeekRanking extends BaseDomain {
	Date startTime
	Date endTime
	String startPort
	String endPort
	String shipCompany
	
	static mapping = {
		table 'week_ranking'
	}
	
	static constraints = {
		startTime nullable:false
		endTime nullable:false
		
		startPort nullable:true
		endPort nullable:true
		shipCompany nullable:true
	}
}
