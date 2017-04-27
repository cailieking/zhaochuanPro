package com.cdd.base.domain

class Matchmaking extends BaseDomain{
	String saler
	Date commitDate
	Date startShipDate
	String bookingNo
	String blNo
	String shipCompany
	String cargoName
	String offerName
	String area
	String companyScale
	String gp20
	String gp40
	String hq40
	String productName
	String startPort
	String endPort
	String route
	String ofUsd
	String ispsUsd
	String thcRmb
	String docRmb
	String sealRmb
	String eirRmb
	String otherRmb
	String remark
	static mapping = {
		table 'matchmaking'
	}
	
	static constraints = {
		saler nullable: true
		commitDate nullable: true
		startShipDate nullable: true
		bookingNo nullable: true
		blNo nullable: true
		shipCompany nullable: true
		cargoName nullable: true
		offerName nullable: true
		area nullable: true
		companyScale nullable: true
		gp20 nullable: true
		gp40 nullable: true
		hq40 nullable: true
		productName nullable: true
		startPort nullable: true
		endPort nullable: true
		route nullable: true
		ofUsd nullable: true
		ispsUsd nullable: true
		thcRmb nullable: true
		docRmb nullable: true
		sealRmb nullable: true
		eirRmb nullable: true
		otherRmb nullable: true
		remark nullable: true
		
		
	}
}
