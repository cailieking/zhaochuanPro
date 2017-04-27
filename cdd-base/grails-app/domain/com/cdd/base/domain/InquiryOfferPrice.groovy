package com.cdd.base.domain

class InquiryOfferPrice extends BaseDomain{
	String number
	String startPort
	String endPort
	int gp20
	int gp40
	int hq40
	int hq45
	String remarks
	String businessMan
	String shipCompany
	String ordersType
	String ordersName
	String weight
	String ordersStatus
	Date sendTime
	String specialContainer
	String freeDemurrage
	String otherRemarks
	String shipper
	String companyName
	String customName
	String phone
	String qq
	String email
	String inquirySales
	String inquiryStatus
	
	BigDecimal priceGp20
	BigDecimal priceGp40
	BigDecimal priceHq40
	BigDecimal priceHq45
	BigDecimal newGp20
	BigDecimal newGp40
	BigDecimal newHq40
	BigDecimal newHq45
	String shipCompanyBusiness
	String shippingDayBusiness
	String shippingdays
	String weightLimit
	String supplier
	String freeDemurrageBusiness
	String priceRemarks
	String finalReason
	static mapping = {
		table 'inquiry_offer_price'
	}
	
	static constraints = {
		number nullable:false
		startPort nullable:true
		endPort nullable:true
		gp20 nullable:true
		gp40 nullable:true
		hq40 nullable:true
		hq45 nullable:true
		remarks nullable:true
	    businessMan nullable:true
		shipCompany nullable:true
		ordersType nullable:true
		ordersName nullable:true
		weight nullable:true
		ordersStatus nullable:true
		sendTime nullable:true
		specialContainer nullable:true
		freeDemurrage nullable:true
		otherRemarks nullable:true
		shipper nullable:true
		companyName nullable:true
		customName nullable:true
		phone nullable:true
		qq nullable:true
		email nullable:true
		inquirySales nullable:true
		inquiryStatus nullable:true
		 
		priceGp20 nullable:true
		priceGp40 nullable:true
		priceHq40 nullable:true
		priceHq45 nullable:true
		newGp20 nullable:true
		newGp40 nullable:true
		newHq40 nullable:true
		newHq45 nullable:true
		shipCompanyBusiness nullable:true
		shippingDayBusiness nullable:true
		shippingdays nullable:true
		 weightLimit nullable:true
		 supplier nullable:true
		 freeDemurrageBusiness nullable:true
		 priceRemarks nullable:true
		 finalReason nullable:true
	} 
}
