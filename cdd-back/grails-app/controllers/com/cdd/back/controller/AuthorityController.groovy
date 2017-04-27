package com.cdd.back.controller

import org.codehaus.groovy.grails.commons.GrailsApplication

import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.base.domain.User
import com.cdd.base.service.common.CRUDService;
import grails.converters.JSON

class AuthorityController extends BaseController {
	
	GrailsApplication grailsApplication
	CRUDService CRUDService
	def model = 'authority'

	def list() {
		/*def searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
//			params.f_like_authority = searchKey
//			params.f_like_url = searchKey
//			params.f_like_description = searchKey
		}
		render getList(model: model, domainClass: Requestmap, isConjunction: false, queryHandler: {
			if(searchKey) {
				or {
					like "authority", searchKey 
					like "url", searchKey 
					like "description", searchKey 
				}
			}
		})*/
		def model = 'authority'
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}
		def searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		def result=CRUDService.list(Requestmap, params){
			
			if(searchKey) {
				or {
					like "authority", searchKey
					like "url", searchKey
					like "description",searchKey
				}
			}
		}
		def map=[rows:[],total:result.totalCount]
		result.list.each { Requestmap requestmap ->
			def data=[:]
			data.id = requestmap.id
			data.authority = requestmap.authority
			data.url = requestmap.url
			data.description = requestmap.description
			data.method = requestmap.method
			
			map.rows << data
		}
		render map as JSON
	}

	def data() {
		render data(model: model, menuName: '权限信息', domainClass: Requestmap)
	}

	def save() {
		Requestmap data = new Requestmap(params)
		if(params.id) {
			Requestmap oldData = Requestmap.get(params.id as Long)
			oldData.authority = data.authority
			oldData.url = data.url
			oldData.method = data.method
			oldData.description = data.description
			data = oldData
		}
		save(data, model, null) {
			if(!params.id) {
				Role role = Role.findByName(grailsApplication.config.superadmin.role.name)
				role.addToAuthorities(new RoleAuthority(map: data, 
					createBy: User.SYSTEM.username, 
					updateBy: User.SYSTEM.username))
				role.save()
			}
			springSecurityService.clearCachedRequestmaps()
		}
	}
	
	def delete() {
		def auths = []
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			for(def id in ids) {
				auths.addAll RoleAuthority.findAllByMap(Requestmap.get(id as Long))
			}
			RoleAuthority.deleteAll(auths)
		}
		delete(Requestmap, model) {
			springSecurityService.clearCachedRequestmaps()
		}
	}

}
