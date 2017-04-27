package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class CargoShipScore extends BaseDomain {
	
	Double shipInTime;
	Double docInTime;
	Double infoInTime;
	Double serviceQuality;
	Double serviceContent;
	String companyName;
	boolean hornest;
	boolean safety;
	boolean verified;
	
	static mapping = {
		table 'cargo_ship_score'
	}
	
	static constraints = {
		shipInTime nullable: false
		docInTime nullable: false
		infoInTime nullable: false
		serviceQuality nullable: false
		serviceContent nullable: false
		companyName nullable: false, unique: true, maxSize: 50
	}
}
