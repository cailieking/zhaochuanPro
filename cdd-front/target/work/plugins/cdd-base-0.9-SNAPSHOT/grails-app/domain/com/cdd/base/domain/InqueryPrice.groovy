package com.cdd.base.domain

class InqueryPrice extends BaseDomain{
	String number
	String companyName
	String mobile
	String qq
	String createBy
	String updateBy
	String operateBy
	String finishBy
	String operateOpinion
	String status
	String orderDescript
	String remark
	String contactMan
	String deleteStatus
	Date dateCreated
	Date lastUpdated
	Date operateTime
	CargoShipInformation info
	Order order
	
	static mapping = {
		table 'inquery_price'
	}
	
	static constraints = {
		number nullable:false
		companyName nullable:false
		mobile nullable:false
		qq nullable:true
		createBy nullable:false
		updateBy nullable:false
		operateBy nullable:true
		finishBy nullable:true
		operateOpinion nullable:true
		status nullable:false
		orderDescript nullable:true
		remark nullable:true
		contactMan nullable:true
		dateCreated nullable:false
		lastUpdated nullable:true
		operateTime nullable:true
		info nullable:true
		order nullable:true
		deleteStatus nullable:true
	}
}
