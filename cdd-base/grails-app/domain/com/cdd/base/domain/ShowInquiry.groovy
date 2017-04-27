package com.cdd.base.domain

class ShowInquiry extends BaseDomain{
	String number
	String textarea1
	String textarea2
	String textarea3
	String textarea4
	static mapping = {
		table 'show_inquiry'
	}
	
	static constraints = {
		number nullable:false
		textarea1 nullable:true
		textarea2 nullable:true
		textarea3 nullable:true
		textarea4 nullable:true
		 
	}
}
