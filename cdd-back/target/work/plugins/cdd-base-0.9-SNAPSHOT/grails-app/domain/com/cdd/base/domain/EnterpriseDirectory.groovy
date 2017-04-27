package com.cdd.base.domain

class EnterpriseDirectory extends BaseDomain{
	String companyName
	String companyEnglish
	String city
	String address
	String email
	String mobile
	String contactName
	String telephone
	String qq
	boolean showOnIndex
	String remark1
	String remark2
	
	static mapping = {
		table 'enterprise_directory'
	}
		
	static constraints = {
		companyName  nullable:true
		companyEnglish  nullable:true
		city  nullable:true
		address  nullable:true
		email  nullable:true
		mobile  nullable:true
		contactName  nullable:true
		telephone  nullable:true
		qq  nullable:true
		remark1  nullable:true
		remark2  nullable:true
	}
}
