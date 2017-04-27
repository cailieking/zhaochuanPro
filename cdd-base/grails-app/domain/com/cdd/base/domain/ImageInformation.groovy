package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain

class ImageInformation extends BaseDomain {
	String content
	String image
	int order
	int state
	Date endDate
	String title
	String alt
	String href
	
	static mapping = {
		table 'image_information'
		order column: 'orders'
		content type: 'text'
	}
	
	static constraints = {
		content nullable: false, blank: false
		image nullable: false, blank: false, unique: false, maxSize: 255
		state nullable:false
		endDate nullable:true
		title nullable:true
		alt nullable:true
		href nullable:true
	}
	
}
