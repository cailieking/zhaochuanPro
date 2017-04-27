package com.cdd.back.controller

import grails.converters.JSON

import org.springframework.security.crypto.keygen.KeyGenerators

import com.cdd.back.enums.Position
import com.cdd.back.service.UserService
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.Role
import com.cdd.base.exception.BusinessException

class UserController extends BaseController {

	def excludeFields = [
		'salt',
		'password',
		'role',
		'superior',
	]

	def model = 'user' 
	
	def list() {
		def searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		def user = springSecurityService.currentUser
		if(user.admin) {
//			if(params.search) {
//				params.f_like_username = searchKey
//				params.f_like_firstname = searchKey
//				params.f_like_email = searchKey
//				params.f_like_mobile = searchKey
//			}
			render getList(model: model, domainClass: BackUser, excludeFields: excludeFields, isConjunction: true, queryHandler: {
				if(searchKey) {
					or {
						like "username", searchKey
						like "firstname", searchKey
						like "email", searchKey
						like "mobile", searchKey
					}
				}
			}) { item, map ->
				map.positionName = item.position?.text
			}
		} else {
			render getList(model: model, domainClass: BackUser, excludeFields: excludeFields, isConjunction: true, queryHandler: {
					like "positionLevel", "${user.positionLevel}%"
					if(searchKey) {
						or {
							like "username", searchKey
							like "firstname", searchKey
							like "email", searchKey
							like "mobile", searchKey
						}
					}
			}) { item, map ->
				map.positionName = item.position.text
			}
		}
	}

	def data() {
		def modelAndView = data(model: model, menuName: '用户信息', domainClass: BackUser, excludeFields: excludeFields)
		if(modelAndView) {
			modelAndView.model.superiors = getSuperiorList(modelAndView.model.data.role)?.list
		}
		render modelAndView
	}

	def enable() {
		BackUser user = BackUser.get(params.id as Long)
		if(user) {
			user.enabled = Boolean.valueOf(params.enabled)
			user.save()
			if(user.hasErrors()) {
				flash.errors = user.errors
			} else {
				def enable = user.enabled ? '启用' : '禁用';
				flash.msgs = [
					"${user.username}${enable}成功"
				]
			}
		}
		redirect url: "/${model}/list"
	}

	def self() {
		params.id = springSecurityService.currentUser.id
		def modelAndView = data(model: model, menuName: '用户信息', domainClass: BackUser, excludeFields: excludeFields)
		if(modelAndView.model) {
			modelAndView.model.isSelf = true
		}
		render modelAndView
	}

	def saveSelf() {
		params.id = springSecurityService.currentUser.id
		if(!(params.newPass && params.confirmPass || !params.newPass && !params.confirmPass)) {
			flash.errors = [msgs: ['新密码和确认密码不同']]
			render view: 'data', model: [isSelf: true, data: new BackUser(params), settings: getSettings(getMenu('用户信息', "/${model}/list"))]
			return
		}
		params.uri = '/entry'
		save()
	}

	UserService userService

	def save() {
		BackUser data = new BackUser(params)
		String password
		if(!params.id) {
			data.salt = KeyGenerators.string().generateKey()
			password = KeyGenerators.string().generateKey()
			data.password = springSecurityService.encodePassword(password, data.salt)
		} else {
			BackUser oldData = BackUser.get(params.id as Long)
			oldData.firstname = data.firstname
			oldData.email = data.email
			oldData.sex = data.sex
			oldData.mobile = data.mobile
			oldData.birth = data.birth
			data = oldData
			if(params.newPass) {
				password = params.newPass
				data.password = springSecurityService.encodePassword(password, data.salt)
			}
		}

		if(params.roleIdValue) {
			Role role = Role.get(params.roleIdValue as Long)
			data.role = role
			if(role.name == '客服' || role.name == '业务员') {
				if(!params.superiorLevel) {
					flash.errors = [:]
					flash.errors.msgs = ['请选择一个上级领导']
					flash.data = data
					redirect uri: "/${model}/data/" + (data.id ?: 'new')
					return
				}
			}
			if(role.name != '系统管理员') {
				data.positionLevel = userService.createPositionLevel(params.superiorLevel)
			}
		}

		if(log.debugEnabled && password) {
			log.debug("${data.username}'s password is: ${password}")
		}
		save(data, 'user', params.uri) {
			if(!params.id) {
				// send mail
				sendMail {
					async true
					to data.email
					from grailsApplication.config.grails.mail.username
					subject "${grailsApplication.config.appInfo.title}-通知"
					body """
						你好，${data.firstname}
						你的账号已经被创建，你现在可以使用以下用户名和密码登陆后台：
						用户名：${data.username}
						密码：${password}
						登陆地址：http://${request.serverName}:${request.serverPort}/
					"""
				}
			}
		}
	}
	
	def ajax  =  {}
	
	def delete() {
		//request.view = "/$model/list"
		String[] ids = params.ids.split(',(\\s)*')
		String msg;
		if(ids) {
			def objs = []
			
			for(def id in ids) {
				BackUser user = BackUser.get(id as Long)
				if(user) {
					userService.removeUser(user)
				}
			}
		}
		//return "true";
		render ([msg:'刪除成功' ,status: 1] as JSON);
		redirect uri: "/${model}/list";
		//flash.msgs = ['删除成功']
		//redirect uri: "/${model}/list"
	}

	def resetPassword() {
		BackUser user
		if(params.id) {
			user = BackUser.get(params.id as Long)
		}
		if(user) {
			String password = KeyGenerators.string().generateKey()
			if(log.debugEnabled) {
				log.debug("${user.username}'s password is: $password")
			}
			user.password = springSecurityService.encodePassword(password, user.salt)
			user.save()
			if(!user.hasErrors()) {
				// send mail
				sendMail {
					async true
					to user.email
					from grailsApplication.config.grails.mail.username
					subject "${grailsApplication.config.appInfo.title}-通知"
					body """\
						你好，${user.firstname}
							你的密码已经重置成功，请登录后台及时修改：
							用户名：${user.username}
							密码：${password}
							登陆地址：http://${request.serverName}:${request.serverPort}/
					"""
				}
				flash.msgs = ['密码重置成功']
			} else {
				flash.errors = user.errors
			}
		}
		redirect uri: "/${model}/list"
	}

	def superiors() {
		Role role = Role.get(params.id as Long)
		def list = getSuperiorList(role)?.list
		list = list.collect {
			def data = [:]
			data.positionLevel = it.positionLevel
			data.firstname = it.firstname
			return data
		}
		render (list as JSON)
	}

	private def getSuperiorList(Role role) {
		Position position = Position.values().find {
			it.text == role?.name
		}
		position = Position.values().sort({ a, b ->
			b.level <=> a.level
		}).find {
			it.level == (position ? position.level + 1 : null)
		}
		if(position) {
			return CRUDService.list(BackUser, ['f_position': position])
		} else {
			return [list: []]
		}
	}
	
	def assign() {
		BackUser user = BackUser.get(params.id)
		render view: 'assign', model: [data: user, settings: getSettings(getMenu('指派任务', "/${model}/list"))]
	}
	
	def assignTo() {
		request.view = "/$model/assign/${params.id}"
		if(params.id) {
			BackUser fromUser = BackUser.get(params.id as Long)
			BackUser toUser = BackUser.findByUsername(params.username)
			if(!fromUser || !toUser) {
				throw new BusinessException("没有此员工")
			}
			userService.assign(fromUser, toUser)
		}
		flash.msgs = ['指派成功']
		redirect uri: "/${model}/list"
	}
	
	
	def isAccountEmail(){
		//BackUser user = BackUser.findByEmail(params.email)
		def userList = CRUDService.list(BackUser,params,{eq "email", params.email;eq "deleteTag", false})
		
		if(userList[0]) {
			render false
		}else{
			render true
			//return
		}
	}
	
	def isAccount(){
		//BackUser user = BackUser.findByEmail(params.email)
		def userList = CRUDService.list(BackUser,params,{eq "username", params.username; eq "deleteTag", false})
		
		if(userList[0]) {
			render false
		}else{
			render true
			//return
		}
	}
}
