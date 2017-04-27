package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import org.springframework.security.crypto.keygen.KeyGenerators

import com.cdd.base.constant.CommonConstant
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.RecommendedRoute
import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.Status
import com.cdd.front.constant.Constant
import com.google.code.kaptcha.Constants

@Secured('ROLE_CLIENT')
class UserController implements ExceptionHandler {

	SpringSecurityService springSecurityService

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def loginInfo() {
		def map
		if(springSecurityService.isLoggedIn()) {
			def user = springSecurityService.currentUser
			def role = '';
			if(user.isCargoOwner()) {
				role = 'cargo';
			} else if (user.isShipAgent()) {
				role = 'ship';
			}
			map = [data: [username: user.username, name: user.firstname, role:role]]
		} else {
			map = [data: null]
		}
		render (map as JSON)
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def resetForgottenPass() {

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

		String username = session.forgetPassUsername
		FrontUser user = FrontUser.findByUsername(username)
		if(!user) {
			render ([msg:'手机号码信息不正确，请重新返回上页', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		user.salt = KeyGenerators.string().generateKey()
		user.password = springSecurityService.encodePassword(params.password, user.salt)
		user.save(flush: true)

		//use for reset success
		session[Constant.SESSION_PASSWORD] = params.password

		if(!user.hasErrors()) {
			render ([status: Constant.STATUS_SUCCESS] as JSON)
		} else {
			render ([msg: g.message(code: user.errors.allErrors[0].codes[0]), status: Constant.STATUS_FAILED] as JSON)
		}
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def validateForget() {
		if(params.image != session[Constants.KAPTCHA_SESSION_KEY]) {
			render ([msg: '图片验证码不匹配', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		if(params.code != session[Constant.SESSION_SMS_CODE]) {
			render ([msg: '手机验证码不匹配', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		session.forgetPassUsername = params.mobile

		render ([status: Constant.STATUS_SUCCESS] as JSON)
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def resetpassinfo() {
		def firstname = session["forgetPassUsername"]
		def password = session[Constant.SESSION_PASSWORD];
		session.removeAttribute(Constant.SESSION_PASSWORD)
		session.removeAttribute("forgetPassUsername")
		render ([data: [firstname:firstname, password:password]] as JSON)
	}

	//	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	//	def inputNewPass() {
	//		session.username = params.mobile
	//		render view: '/user/newPass'
	//	}

	def updatePassword() {
		FrontUser user = springSecurityService.currentUser
		if(!params.oldPassword) {
			render ([msg:'旧密码不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		def encryptedOldPassword = springSecurityService.encodePassword(params.oldPassword, user.salt)
		if(user.password != encryptedOldPassword) {
			render ([msg:'旧密码不正确', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		if(!params.password) {
			render ([msg:'新密码不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(params.password.length() < 6) {
			render ([msg:'新密码不能小于6位', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		if(params.password.length() > 16) {
			render ([msg:'新密码不能大于16位', status: Constant.STATUS_FAILED] as JSON)
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

		user.salt = KeyGenerators.string().generateKey()
		user.password = springSecurityService.encodePassword(params.password, user.salt)
		user.save(flush: true)
		if(!user.hasErrors()) {
			render ([status: Constant.STATUS_SUCCESS] as JSON)
		} else {
			render ([msg: g.message(code: user.errors.allErrors[0].codes[0]), status: Constant.STATUS_FAILED] as JSON)
		}
	}


	def goResetPhoneStep2() {
		if(params.image != session[Constants.KAPTCHA_SESSION_KEY]) {
			render ([msg: '图片验证码不匹配', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		if(params.code != session[Constant.SESSION_SMS_CODE]) {
			render ([msg: '手机验证码不匹配', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		session.removeAttribute(Constants.KAPTCHA_SESSION_KEY)
		session.removeAttribute(Constant.SESSION_SMS_CODE)
		render ([status: Constant.STATUS_SUCCESS] as JSON)
	}

	def resetUsername() {
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

		FrontUser user = springSecurityService.currentUser
		user.username = params.mobile
		user.mobile = params.mobile
		user.save(flush: true)
		if(!user.hasErrors()) {
			session.invalidate()
			render ([status: Constant.STATUS_SUCCESS] as JSON)
		} else {
			render ([msg: g.message(code: user.errors.allErrors[0].codes[0]), status: Constant.STATUS_FAILED] as JSON)
		}
	}

	def update() {


		if(!params.firstname) {
			render ([msg:'联系人不能为空', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		if(params.firstname.length() > 10) {
			render ([msg:'联系人不能大于10位', status: Constant.STATUS_FAILED] as JSON)
			return
		}

		/*		if(!params.companyName) {
		 render ([msg:'公司名称不能为空', status: Constant.STATUS_FAILED] as JSON)
		 return
		 }
		 if(params.companyName.length() > 50) {
		 render ([msg:'公司名称不能大于50位', status: Constant.STATUS_FAILED] as JSON)
		 return
		 }*/

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

		FrontUser user = springSecurityService.currentUser
		//user.companyName = params.companyName
		user.firstname = params.firstname
		user.city = city
		if(params.email) {
			user.email = params.email
		}
		if(params.address) {
			user.address = params.address
		}
		if(params.qq) {
			user.qq = params.qq
		}
		if(params.phone) {
			user.phone = params.phone
		}

		def list = RecommendedRoute.findAllByUser(user)
		if(list) {
			list*.delete(flush: true)
		}
		user.recommendedRoutes.clear()
		if(params.recommendedRoutes) {
			def recommendedRoutes = params.recommendedRoutes?.split ","
			if(recommendedRoutes.size() > 3) {
				render ([msg:'不能超过3个推荐航线', status: Constant.STATUS_FAILED] as JSON)
				return
			}
			user.recommendedRoutes = recommendedRoutes.collect {
				new RecommendedRoute(user: user, category: it, createBy: user.username, updateBy: user.username)
			}
		}

		user.save(flush: true)
		if(!user.hasErrors()) {
			render ([status: Constant.STATUS_SUCCESS] as JSON)
		} else {
			render ([msg: g.message(code: user.errors.allErrors[0].codes[0]), status: Constant.STATUS_FAILED] as JSON)
		}
	}

	def index() {
		FrontUser user = springSecurityService.currentUser
		def data = [:]
		data.user = [:]
		data.user.username = user.username
		data.user.firstname = user.firstname
		data.user.companyName = user.companyName

		def criteria
		if(user.isCargoOwner()) {
			criteria = Order.createCriteria()
		} else {
			criteria = CargoShipInformation.createCriteria()
		}
		data.inVerifyNum = criteria.count {
			eq "owner", user
			or {
				eq "status", Status.UnVerify
				eq "status", Status.InVerify
			}
		}

		render ([data: data] as JSON)
	}

	def getaccount() {
		def map
		if(springSecurityService.isLoggedIn()) {
			def user = springSecurityService.currentUser
			map = [data: [
				companyName: user.companyName, 
				email: user.email, 
				firstname: user.firstname,
				city: user.city,
				address: user.address,
				qq: user.qq,
				phone: user.phone, 
				mobile:user.mobile,
				recommendedRoutes: []
			]]
			user.recommendedRoutes?.each {
				map.data.recommendedRoutes << it.category
			}
		} else {
			map = [data: null]
		}
		render (map as JSON)
	}
}
