package com.cdd.back.controller

import com.cdd.base.domain.JobTitle
import grails.converters.JSON

class PositionController extends BaseController{
	
	def model = "/position/list"
	
	def list(){
		render view:model
	}
	
	def initPosition(){
		params.sort = params.id
		params.order = 'asc'
		def jtList = [] 
		params.dataType = 'json'
		def jts = CRUDService.list(JobTitle, params)
		jts?.collect{
			def jt = [:]
			jt.id = it.id
			jt.pId = it.pId
			jt.name = it.name
			jt.uLength = it.users.size()
			jt.description = it.description
			jtList << jt
		}
		
		render  jtList as JSON
		
	}
	
	def saveJobTitle(){
		def result = false
		def jt = JobTitle.findByName(params.name)
		if(jt == null){
			jt = new JobTitle()
		}
		
		JobTitle jtParent = JobTitle.findByName(params.jtData)
		//params.pId = jtParent.pId
		jt.pId = jtParent.id
		jt.description = params.description
		jt.save();
		if(jt.hasErrors()){
			println jt.errors
			result = false
		}else {
			result = true
		}
		render result 
		return 
	}
	
	def deleteJobTilte(){
		
		println params.names
		def jts = []
		String[] ids = params.names.split(',(\\s)*')
		for(def id in ids){
			jts << JobTitle.get(id as long)
		}
		JobTitle.deleteAll(jts)
//		if(jts.hasErrors()){
//			println jts.errors
//			result = false
//		}else{
//			result = true
//		}
		
//		def jt = JobTitle.findByName(params.name)
//		if(jt){
//			jt.delete()
//			if(jt.hasErrors()){
//				println jt.errors
//				result =false
//			}else{
//				result = true
//			}
//		}
		render true
		return
	}
	
	def isExists(){
			def jt = JobTitle.findByName(params.jt_name)
			if(jt){
				render false
			}else {
				render true
			}
		
	}
}
