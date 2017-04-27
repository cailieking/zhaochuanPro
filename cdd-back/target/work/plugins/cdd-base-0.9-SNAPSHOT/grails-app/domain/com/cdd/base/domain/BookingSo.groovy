package com.cdd.base.domain

class BookingSo {
	String soNumber
	String shipCompany
	String shipName
	String voyageNo
	String startPort
	String endPort
	Integer gp20Num
	Integer gp40Num
	Integer hq40Num
	Date endDate
	Date startShipDate
	String soFilePath
	String remark
	
	static mapping = {
		table 'booking_so'
	}
	
	static constraints = {
		
		 soNumber nullable:true
		 shipCompany nullable:true
		 shipName nullable:true
		 voyageNo nullable:true
		 startPort nullable:true
		 endPort nullable:true
		 gp20Num nullable:true
		 gp40Num nullable:true
		 hq40Num nullable:true
		 endDate nullable:true
		 startShipDate nullable:true
		 soFilePath nullable:true
		 remark nullable:true
		
	}
}
