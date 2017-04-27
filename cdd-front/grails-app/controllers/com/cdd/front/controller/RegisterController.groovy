package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.mail.MailService;
import grails.plugin.springsecurity.annotation.Secured
import java.text.SimpleDateFormat

import org.springframework.security.crypto.keygen.KeyGenerators

import com.cdd.base.constant.CommonConstant
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontAuthority
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.RecommendedRoute
import com.cdd.base.enums.FrontUserType
import com.cdd.base.enums.RouteCategory
import com.cdd.base.util.CommonUtils
import com.cdd.front.constant.Constant
import com.google.code.kaptcha.Constants

@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
class RegisterController implements ExceptionHandler {
	MailService mailService
	def grailsApplication
	def isOldMobile(){
		def map = [:]
		FrontUser dbUser = FrontUser.findByUsername(params.mobile)
		if(dbUser) {
			render ([msg: '手机号码已经注册', status: Constant.STATUS_FAILED] as JSON)
			return
		}else{
		render ([msg: '', status: Constant.STATUS_SUCCESS] as JSON)
		return
		}
	}
	def goStep2() {
		def map = [:]
		if(!CommonConstant.MOBILE_PATTERN.matcher(params.mobile).matches()) {
			render ([msg: '手机号码格式有误', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		if(params.image != session[Constants.KAPTCHA_SESSION_KEY]) {
			render ([msg: '图片验证码不匹配', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		if(params.code != session[Constant.SESSION_SMS_CODE]) {
			render ([msg: '手机验证码不匹配', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		FrontUser dbUser = FrontUser.findByUsername(params.mobile)
		if(dbUser) {
			render ([msg: '手机号码已经注册', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		FrontUser newUser = new FrontUser(params)
		newUser.username = params.mobile
		println params.invitationCode
		if(params.invitationCode){
			newUser.invitationCode = params.invitationCode
		}
		session.newUser = newUser
		render ([status: Constant.STATUS_SUCCESS] as JSON)
	}
	
	def springSecurityService

	def finish() {
		FrontUser newUser = session.newUser
		if(!newUser) {
			render ([msg:'请重新返回第一步注册', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(!params.password) {
			render ([msg:'密码不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(params.password.length() < 6) {
			render ([msg:'密码不能小于6位', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(params.password.length() > 16) {
			render ([msg:'密码不能大于16位', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		
		if(!params.confirmPassword) {
			render ([msg:'确认密码不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(params.password != params.confirmPassword) {
			render ([msg:'密码和确认密码不一致', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		
		if(!params.firstname) {
			render ([msg:'真实姓名不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		
		if(params.firstname.length() > 10) {
			render ([msg:'真实名称不能大于10位', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		
		if(!params.companyName) {
			render ([msg:'公司名称不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		
		if(params.companyName.length() > 50) {
			render ([msg:'公司名称不能大于50位', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(!params.qq){
			render ([msg:'qq不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(!params.email){
			render ([msg:'email不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}else{
			if(!params.email.matches("[\\w\\.\\-]+@([\\w\\-]+\\.)+[\\w\\-]+")){
				render ([msg:'email格式不正确', status: Constant.STATUS_FAILED] as JSON)
				return
			}
		}
		
		City city
		if((!params.city_id) || (Integer.parseInt(params.city_id) < 1)) {
			render ([msg:'请选择公司所在地', status: Constant.STATUS_FAILED] as JSON)
			return
		} else {
			city = City.findByCode(params.city_id);
			if (city == null) {
				render ([msg:'公司所在地不合法', status: Constant.STATUS_FAILED] as JSON)
				return
			} 
		}
		
		if(!params.type) {
			render ([msg:'请选择企业类型', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		
		FrontAuthority typeAuth
		typeAuth = FrontAuthority.findByAuthority("ROLE_${params.type}")
		if(!typeAuth) {
			render ([msg:'用户类型不合法', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		/*if(params.invitationCode){
			newUser.invitationCode = params.invitationCode
		}*/
		newUser.password = params.password
		newUser.firstname = params.firstname
		newUser.companyName = params.companyName
		newUser.qq = params.qq
		newUser.email = params.email
		newUser.city = city
		def recommendedRoutes = params.recommendedRoutes?.split ","
		if(recommendedRoutes) {
			if(recommendedRoutes.size() > 3) {
				render ([msg:'不能超过3个推荐航线', status: Constant.STATUS_FAILED] as JSON)
				return
			}
			newUser.recommendedRoutes = recommendedRoutes?.collect {
				if(it) {
					new RecommendedRoute(user: newUser, category: it, createBy: newUser.username, updateBy: newUser.username)
				}
			}
		}
		
		newUser.salt = KeyGenerators.string().generateKey()
		
		//use for reg success
		session[Constant.SESSION_PASSWORD] = newUser.password
		
		newUser.password = springSecurityService.encodePassword(newUser.password, newUser.salt)
		
		
		FrontAuthority clientAuth = FrontAuthority.findByAuthority('ROLE_CLIENT')
		newUser.addToAuths(clientAuth);
		newUser.addToAuths(typeAuth);
		if(typeAuth.authority == 'ROLE_SHIP_AGENT') {
			newUser.type = FrontUserType.Agent
		} else {
			newUser.type = FrontUserType.Cargo
		}
		
		newUser.createBy = newUser.username
		newUser.updateBy = newUser.username
		newUser.comeFrom ="Z"
		newUser.save(flush: true)
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		def now = df.format(new Date());// new Date()为获取当前系统时间
		mailService.sendMail {
			async true
			to "custom@zhao-chuan.com" //data.service.email
			from grailsApplication.config.grails.mail.username
			subject "前台新用户注册"
			body """
							你好,亲爱的找船网工作人员
							用户${newUser.username}已于${now}在找船网前台注册成功
							联  系  人: ${newUser.username}
							联系方式: ${newUser.mobile}
							邮       箱 : ${newUser.email}

								请登录后台及时处理！

							系统后台自动发送，无需回复
							${now}
						"""
		}

		if(!newUser.hasErrors()) {
			render ([status: Constant.STATUS_SUCCESS] as JSON)
		} else {
			render ([msg: g.message(code: newUser.errors.allErrors[0].codes[0]), status: Constant.STATUS_FAILED] as JSON)
		}
	}
	
	def info() {
		FrontUser newUser = session.newUser
		newUser.password = session[Constant.SESSION_PASSWORD]
		session.removeAttribute("newUser")
		session.removeAttribute(Constants.KAPTCHA_SESSION_KEY)
		session.removeAttribute(Constant.SESSION_SMS_CODE)
		session.removeAttribute(Constant.SESSION_PASSWORD)
		flash[Constant.SESSION_PASSWORD] = newUser.password
		def dataMap = CommonUtils.tranferToMap(newUser)
		render ([data: dataMap] as JSON)
	}
	
	def goCenter() {
		redirect url: "/j_spring_security_check?j_username=${params.username}&j_password=${flash[Constant.SESSION_PASSWORD]}&spring-security-redirect=/member"
	}
	
}
