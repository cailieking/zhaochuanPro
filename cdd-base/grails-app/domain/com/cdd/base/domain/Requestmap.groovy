package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain


/**
 * the request authority mapping
 * @author GeorgeZeng
 *
 */
class Requestmap extends BaseDomain {
	static {
		transients << 'uri'
		transients << 'used'
	}
	boolean used
	String authority
	String url
	String method
	String description
	Menu menu
	
	String getUri() {
		int index = url.lastIndexOf('**')
		if(index > -1) {
			return url.substring(0, index)
		}
		return url
	}
	
	void setUri(String uri) {
		if(uri.lastIndexOf('**') == -1) {
			if(uri.lastIndexOf('/') < uri.length() - 1) {
				uri += "/"
			}
			url = uri + "**"
		}
	}
	
	static mapping = {
		table 'back_requestmap'
	}
	
	static constraints = {
		url maxSize: 255, blank: false, unique: true, nullable: false
		authority maxSize: 255, blank: false, unique: false, nullable: false
		method maxSize: 255, blank: false, unique: false, nullable: true
		description maxSize: 255, blank: true, unique: false, nullable: true
		menu nullable:true
  }
}
