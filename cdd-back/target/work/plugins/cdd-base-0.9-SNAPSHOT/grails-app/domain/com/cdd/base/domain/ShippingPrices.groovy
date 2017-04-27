package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class ShippingPrices extends BaseDomain {
	BigDecimal gp20
	BigDecimal gp40
	BigDecimal hq40
	BigDecimal gp20Vip
	BigDecimal gp40Vip
	BigDecimal hq40Vip
	BigDecimal hq45
	String extra
	BigDecimal cbm
	String lowestCost
	
	CargoShipInformation info
	static belongsTo = [info: CargoShipInformation]
	
	static mapping = {
		table 'ship_prices'
	}
	
	static constraints = {
		gp20 nullable: true
		gp40 nullable: true
		hq40 nullable: true
		gp20Vip nullable: true
		gp40Vip nullable: true
		hq40Vip nullable: true
		hq45 nullable: true
		cbm nullable: true
		lowestCost nullable: true, maxSize: 500, blank: false, unique: false
		extra nullable: true, maxSize: 1000, blank: false, unique: false
	}
	
}
