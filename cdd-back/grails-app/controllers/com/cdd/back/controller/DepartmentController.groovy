package com.cdd.back.controller

import com.cdd.back.service.UserService;
import com.cdd.base.domain.BackDepartment
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.Role
import com.cdd.base.domain.JobTitle
import com.cdd.base.domain.NewRoute
import grails.converters.JSON
import org.hibernate.collection.internal.PersistentSet
import org.springframework.security.crypto.keygen.KeyGenerators

class DepartmentController extends BaseController{
	UserService userService
	
	def model = "/department/list"
	
    def list() {
		render view: "/department/list"
	}
	def initDepartmentData(){
		params.dataType = 'json'
//		params.sort = params.name 
//		params.order = 'asc'
		def result = CRUDService.list(BackDepartment,params) 
		
		//def result = getList(model: model, domainClass: BackDepartment)
		//JSON j = new JSON()
		//List<BackDepartment> list = new ArrayList<BackDepartment>()
		List<BackUser> list = new ArrayList<BackUser>()
		//Set<BackUser> uSet = new PersistentSet<BackUser>()
		//list.addAll(result.list)
		def data = [dps:[],users:[]]
		//if("show".equals(params.tag)){
			result.list?.collect{
				def dps = [:]
				dps.id = it.id
				dps.name = it.name 
				dps.pId = it.pId
				dps.manager = it.manager?:"无"
				dps.users = []
				it.users?.collect{ backUser ->
					def bUser  = [:]
					bUser.id = backUser.id
					bUser.firstname = backUser.firstname
					bUser.username = backUser.username
					bUser.roleName = backUser.role.name
					bUser.mobile = backUser.mobile?:" -"
					bUser.enabled = backUser.enabled
					bUser.jobTitle = backUser.jobTitle?.name?:" -"
					bUser.email = backUser.email?:" -"
					bUser.jobNum = backUser.jobNum?:" -"
					bUser.enName = backUser.enName?:" -"
					bUser.extNum = backUser.extNum?:" -"
					bUser.department = backUser.department?.name?:" -"
					bUser.department = backUser.department?.name?:" -"
					bUser.routes = []
					backUser.routes?.collect{  
						bUser.routes.add(it.routeName)
					}
					
					dps.users << bUser
					data.users << bUser
				}
				data.dps << dps
				
			}
		//}
		
		data.roles = CRUDService.list(Role,params)
		data.jobTitles = CRUDService.list(JobTitle,params)
//		else{
//			result.list?.collect{
//				def dps = [:]
//				dps.id = it.id
//				dps.name = it.name
//				dps.pId = it.pId
//				dps.manager = it.manager
//				data << dps
//			}
//		}
		
		render data as JSON
	}
	
	def saveDepartment(){
		BackUser user
		def bdepartment = BackDepartment.findByName(params.name)
		if(bdepartment){
			bdepartment.pId = params.pId as long
			bdepartment.name = params.name
			bdepartment.manager = params.manager
			bdepartment.description = params.description
			user = BackUser.findByFirstname(params.manager)
		}else{
			user = BackUser.findByFirstname(params.manager)
			bdepartment = new BackDepartment(params)
		}
		bdepartment.save(); 
		
		if(user){
			user.department = bdepartment
			user.save();
		}
		if(bdepartment.hasErrors()){
			println bdpartment.errors
			render false
		}else {
			render true
		}
		
	}
	
	def addEmployee(){
		BackUser user = new BackUser()
		String password
		if(!params.id){
			user.salt = KeyGenerators.string().generateKey()
			password = KeyGenerators.string().generateKey()
			user.password = springSecurityService.encodePassword(password, user.salt)
			user.firstname = params.firstname
			user.username = params.username
			user.enName = params.enName
			user.qq = params.qq?:null
			user.mobile = params.mobile?:null
			user.email = params.email
			user.jobNum = params.jobNum?:null
			user.enName = params.enName?:null
			user.extNum = params.ext_num?:null
			//user.birth = params.birth?:null
			user.inviteCode = params.invate_code?:null
			
		}else{
			user = BackUser.get(params.id as long)
			user.firstname = params.firstname
			user.username = params.username
			user.qq = params.qq?:null
			user.mobile = params.mobile?:null
			user.email = params.email
			user.jobNum = params.jobNum?:null
			user.enName = params.enName?:null
			user.extNum = params.ext_num?:null
			//user.birth = params.birth?:null
			user.inviteCode = params.invate_code?:null
			user.routes = []
		
		}
		
		if(params.role){
			Role role = Role.findByName(params.role)
			user.role = role
		}
		if(params.dpData){
			println params.dpData
			BackDepartment deparment = BackDepartment.findByName(params.dpData)
			user.department = deparment
		}
		if(params.jtData){
			JobTitle jt = JobTitle.findByName(params.jtData)
			user.jobTitle = jt
		}
		if(params.routes){
			List<NewRoute> routeList1 = new ArrayList<NewRoute>();
			List<BackUser> userList = new ArrayList<BackUser>();
			userList.add(user)
			def routeList  = params.routes.split(",")
			NewRoute route1 
			routeList.collect{
				route1= NewRoute.findByRouteName(it)
				user.addToRoutes(route1)
				//route.users = userList
				//route.remark = null
				//route.save()
				//user.routes.putAt(password, user)(route)
				//if(route.hasErrors()){
					//println route.errors
					
				//}
				routeList1.add(route1)
			}
			//user.addToRoutes(routeList1)
			//println routeList1.size()
			//user.routes = routeList1
		}
		
		user.save();
		if(user.hasErrors()){
			println user.errors
			render false
			return
		}
		render true
		
		
	}
	
	def delEmployee(){
		def result = false
		BackUser user = BackUser.get(params.id as long)
		if(user){
			result = userService.removeUser(user)
			render result
			return
		}
		render result
		
	}
	def enable(){
		def result = false;
		BackUser user = BackUser.get(params.id as Long)
		if(user) {
			user.enabled = Boolean.valueOf(!params.enabled)
			user.save()
			if(user.hasErrors()) {
				flash.errors = user.errors
				result = false
			} else {
				def enable = user.enabled ? '启用' : '禁用';
				flash.msgs = [
					"${user.username}${enable}成功"
				]
				result = true
			}
		}
		render result
	
	}
	
//	def detailData(){
//		def data = [:]
//		
//		
//		def roles = CRUDService.list(Role,params)
//		def postions = CRUDService.list(Position,params)
//		
//		data.roles = roles
//		data.positions = postions
//		
//		render data as JSON
//		
//	}
	
	def deleteDepartment(){
		def result = false;
		BackDepartment bd = BackDepartment.findByName(params.dpName)
		if(bd){
			bd.delete();
			if(bd.hasErrors()){
				println bd.errors
				result = false
			}else {
				result = true
			}
		}
		
		render result
	}
	
}
