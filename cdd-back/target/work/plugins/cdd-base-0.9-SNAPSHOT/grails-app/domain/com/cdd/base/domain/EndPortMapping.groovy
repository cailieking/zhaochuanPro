package com.cdd.base.domain

import com.cdd.base.json.JsonObject;

class EndPortMapping implements JsonObject{
	String changfanPort
	EndPort endPort
	
	static belongsTo = [endPort: EndPort]
	static mapping = {
		table 'end_port_mapping'
	}
	
	static constraints = {
		changfanPort nullable: true
	}
}
