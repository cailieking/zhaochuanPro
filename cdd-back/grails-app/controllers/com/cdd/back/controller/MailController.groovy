package com.cdd.back.controller


import grails.converters.JSON

import org.apache.poi.hssf.usermodel.HSSFRow

import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Route
import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.RouteType
import com.cdd.base.service.OrderService
import com.cdd.base.service.common.CRUDService


class MailController {

	CRUDService CRUDService

	def list() {
		String searchKey
		if(params.search) {
			params.f_like_email = "%${params.search}%"
			params.f_like_username = "%${params.search}%"
			params.f_like_firstname = "%${params.search}%"
		}
		params.f_isNotNull_email = null
		def result = CRUDService.list(FrontUser, params)
		def list = result?.list?.collect { FrontUser data ->
			data.email
		}

		render ([list: list, total: result?.totalCount] as JSON)
	}

	def send() {
		def list = params.list.split ";"
		sendMail {
			to list
			from grailsApplication.config.grails.mail.username
			subject "${grailsApplication.config.appInfo.title}-消息推送"
			body params.content
		}
		redirect uri: params.view
	}
}
