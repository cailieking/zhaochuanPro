package com.cdd.back.domain

import javax.persistence.Id;
import javax.persistence.IdClass;

class PersistentSchema implements Serializable {
	
	String username;
	String series;
	String token;
	Date   lastUsed   
	static mapping = {
		table 'persistent_schema'
		id generator: 'assigned',name:'series',column:'series',nullable:false, unique: true
		token nullable: false
		lastUsed nullable: false
	}
	
}
