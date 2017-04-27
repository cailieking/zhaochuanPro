package com.cdd.back.controller

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory;

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.BackUser
import grails.converters.JSON


class RoleController extends BaseController {
	SessionFactory sessionFactory
	def list() {
		/*if(params.search) {
			def searchKey = "%${params.search}%"
			params.f_like_name = searchKey
		}
		render getList(model: 'role', domainClass: Role)*/
		SQLQuery roleList = sessionFactory.getCurrentSession().createSQLQuery("SELECT back_role.name ,back_role.description,COUNT(back_user.id) AS total,back_role.id  FROM back_user RIGHT JOIN back_role on back_role.id = back_user.role_id  GROUP BY back_role.id ")
		List list =  roleList.list().collect{
			 def data = [:]
			 data.name = it[0]
			 data.num = it[2]
			 data.des = it[1]
			 data.id = it[3]
			 return data
			 }
			
			render view:"/role/list", model:[map:list]
	}
	
	def aa(){
		
		def allRequestmap = Requestmap.findAllByAuthorityNotEqual(SpringSecurityConstant.AUTH_PERMIT_ALL)
		render allRequestmap as JSON
		
	}
	
	
	def getRoleData(){
		
	}
	
	def data() {
		List usedMap = []
		def modelAndView = data(model: 'role', menuName: '角色信息', domainClass: Role)
		if(modelAndView.model) {
			def usedAuths = modelAndView.model.data.authorities
			def allRequestmap = Requestmap.findAllByAuthorityNotEqual(SpringSecurityConstant.AUTH_PERMIT_ALL)
			for(def map in allRequestmap) {
				for(def auth in usedAuths) {
					if(auth.map.id == map.id) {
						//map.used = true
						if(map){
						usedMap.add(map)
					}
					}
				}
			}
			modelAndView.model.allReqeustmap = allRequestmap
		}
		render usedMap as JSON
	}

	def save() {
		Role data = new Role(params)
		if(params.id) {
			Role oldData = Role.get(params.id as Long)
			oldData.name = data.name
			oldData.description = data.description
			data = oldData
		}
		data.users?.clear()
		def arr = params.userIds
		if(arr instanceof String) {
			arr = [arr]
		}
		arr.each { userId ->
			def user = BackUser.get(userId as Long)
			data.addToUsers(user)
		}
		data.authorities?.clear()
		arr = params.mapIds
		if(arr instanceof String) {
			arr = [arr]
		}
		arr.each { mapId ->
			RoleAuthority auth = new RoleAuthority(map: Requestmap.get(mapId as Long))
			data.addToAuthorities(auth)
		}
		save(data, 'role')
	}
	
	def delete() {
		delete(Role, 'role')
	}

	def roleSave(){
		Role data = new Role(params)
		if(params.id) {
			Role oldData = Role.get(params.id as Long)
			oldData.name = data.name
			oldData.description = data.description
			data = oldData
		}
		data.save(flash:true)
		
		redirect uri: "/role/list"
	}
	
	def roleRquestmapSave(){
		Role role =Role.findByName(params.roleName)
		role.authorities?.clear()
		def arr = params.mapIds.split(",")
		arr.collect { 
			RoleAuthority auth = new RoleAuthority(map: Requestmap.get(it as Long))
			role.addToAuthorities(auth)
		}
		redirect uri: "/role/list"
	}
	
}
