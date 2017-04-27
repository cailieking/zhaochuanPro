package com.cdd.base.domain

import java.util.Date;

import com.cdd.base.enums.AdvertisementType


class AdvCorporation extends BaseDomain {
	String content
	String image
	int order
	AdvertisementType type
	int state
	Date endDate
	String title
	String alt
	String href
	String customName
	String contractNumber
	String sales
	static mapping = {
		table 'adv_corporation'
		order column: 'orders'
	}
	static constraints = {
		content nullable: false, blank: false, unique: false, maxSize: 2000
		image nullable: false, blank: false, unique: false, maxSize: 500
		type nullable: false, blank: false, unique: false, maxSize: 50
		
		state nullable:false
		endDate nullable:true
		title nullable:true
		alt nullable:true
		href nullable:true
		customName nullable:true
		contractNumber nullable:true
		sales nullable:true
	}
}
