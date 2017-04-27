package com.cdd.front.controller

import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.CityService

class CityController implements ExceptionHandler {
	
	CityService cityService
	
	JsonConverterFactory jsonConverterFactory
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def getCitys() {
		render jsonConverterFactory.create().toJSON(cityService.getCities(Integer.valueOf(params.pcode)))
	}

}
