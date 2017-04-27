package com.cdd.base.domain

import grails.plugin.springsecurity.SpringSecurityService
import grails.validation.Validateable

import java.text.SimpleDateFormat

import com.cdd.base.constant.CommonConstant
import com.cdd.base.json.JsonObject

@Validateable
abstract class BaseDomain implements JsonObject {
	transient SpringSecurityService springSecurityService
	static transients = [
		'springSecurityService',
	]

	Long id
	String createBy // username, which can not change so its good to track
	Date dateCreated
	String updateBy // same definition as createBy
	Date lastUpdated

	static constraints = {
		createBy nullable: true, blank: false, maxSize: 255
		updateBy nullable: true, blank: false, maxSize: 255
	}

	def beforeInsert() {
		
		if(!createBy) {
			String modifiyUser
			if(springSecurityService.currentUser) {
				modifiyUser = springSecurityService.currentUser.username
			}
			if(modifiyUser) {
				createBy = modifiyUser
			}
			if(!createBy) {
				throw new IllegalArgumentException('createBy cannot be empty')
			}
		}
		
		if(!updateBy) {
			String modifiyUser
			if(springSecurityService.currentUser) {
				modifiyUser = springSecurityService.currentUser.username
			}
			if(modifiyUser) {
				updateBy = modifiyUser
			}
			if(!updateBy) {
				throw new IllegalArgumentException('updateBy cannot be empty')
			}
		}
		
	}

	def beforeUpdate() {
		if(springSecurityService.currentUser) {
			updateBy = springSecurityService.currentUser.username
		}
		if(!updateBy) {
			throw new IllegalArgumentException('updateBy cannot be empty')
		}
	}
	
	def getDateString(date) {
		if(date) {
			return new SimpleDateFormat(CommonConstant.DATE_FORMAT).format(date)
		} else {
			return null
		}
	}

}
