package com.cdd.front.controller

import java.text.SimpleDateFormat;

import grails.converters.JSON;
import grails.plugin.springsecurity.annotation.Secured;

import com.cdd.base.constant.SpringSecurityConstant;
import com.cdd.base.domain.ArticleInformation
import com.cdd.base.enums.ArticleType

class ArticleController implements ExceptionHandler {
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def data() {
		ArticleInformation data = ArticleInformation.get(params.id as Long)
		//return [data: data]
		def result
		if(data){
			++data.readCount
			data.save()
			if(data.hasErrors()){
				 log.info "Error: " + data.errors
				  result = false
			}
			result = true
		}
		render data as JSON
		return 
		}
}
