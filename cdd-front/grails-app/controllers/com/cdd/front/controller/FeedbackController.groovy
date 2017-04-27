package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.front.constant.Constant
import com.google.code.kaptcha.Constants

@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
class FeedbackController implements ExceptionHandler {
	def grailsApplication
	
	def save() {
		if(!params.captcha || params.captcha != session[Constants.KAPTCHA_SESSION_KEY]) {
			render ([msg: '验证码有误', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		sendMail {
			async true
			to grailsApplication.config.ceo.mail
			from grailsApplication.config.grails.mail.username
			subject "${grailsApplication.config.appInfo.title}-用户反馈"
			body """
					你好，收到用户反馈如下
					类型: ${params.type}
					联系人: ${params.name}
					联系方式: ${params.contact}
					错误地址: ${params.error}
					内容：${params.content}
			"""
		}
		render ([msg: '发送成功', status: Constant.STATUS_SUCCESS] as JSON)
	}
}
