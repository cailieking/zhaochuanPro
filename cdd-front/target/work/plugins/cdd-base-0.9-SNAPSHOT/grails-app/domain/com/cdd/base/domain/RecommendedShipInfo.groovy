package com.cdd.base.domain

class RecommendedShipInfo extends BaseDomain {
	CargoShipInformation info
	
	static belongsTo = [order: Order]
	
	static mapping = {
		table 'recommended_ship_info'
	} 
}
