package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import java.awt.image.BufferedImage

import javax.imageio.ImageIO

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.service.SmsService
import com.cdd.front.constant.Constant
import com.google.code.kaptcha.Constants
import com.google.code.kaptcha.Producer

@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
class CaptchaController implements ExceptionHandler {

	Producer captchaProducer

	def image() {
		// Set to expire far in the past.
		response.setDateHeader("Expires", 0)
		// Set standard HTTP/1.1 no-cache headers.
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate")
		// Set IE extended HTTP/1.1 no-cache headers (use addHeader).
		response.addHeader("Cache-Control", "post-check=0, pre-check=0")
		// Set standard HTTP/1.0 no-cache header.
		response.setHeader("Pragma", "no-cache")

		// create the text for the image
		String capText = captchaProducer.createText()

		// store the text in the session
		session[Constants.KAPTCHA_SESSION_KEY] = capText

		// create the image with the text
		BufferedImage bi = captchaProducer.createImage(capText)
		
		ByteArrayOutputStream out = new ByteArrayOutputStream()
		
		// write the data out
		ImageIO.write(bi, "jpg", out)
		
		render file: new ByteArrayInputStream(out.buf), contentType: 'image/jpeg'
	}
	
	SmsService smsService

	def sms() {
		String mobile = params.mobile;
		if (!mobile || mobile.trim().length() != 11) {
			render ([msg: '手机号不正确', status: Constant.STATUS_FAILED] as JSON)
		}
		String code = captchaProducer.createText()
		//String code = 1111
		if(log.debugEnabled) {
			log.debug "sms code is ${code}" 
		}
		
		smsService.sendMsg(mobile.trim(), "您的验证码是：${code}。请不要把验证码泄露给其他人。")
		session[Constant.SESSION_SMS_CODE] = code
		render ([msg: '发送成功', status: Constant.STATUS_SUCCESS] as JSON)
	}

}
