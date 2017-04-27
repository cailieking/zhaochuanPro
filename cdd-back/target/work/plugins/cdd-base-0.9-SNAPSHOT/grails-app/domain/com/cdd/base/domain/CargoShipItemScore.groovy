package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class CargoShipItemScore extends BaseDomain {
	
	Integer shipInTime;
	Integer docInTime;
	Integer infoInTime;
	Integer serviceQuality;
	Integer serviceContent;
	String companyName
	
	Order order;
	
	static mapping = {
		table 'cargo_ship_item_score'
	}
	
	static constraints = {
		shipInTime nullable: false
		docInTime nullable: false
		infoInTime nullable: false
		serviceQuality nullable: false
		serviceContent nullable: false
		order nullable: false
		companyName nullable: false, unique: false, maxSize: 50
	}
}
