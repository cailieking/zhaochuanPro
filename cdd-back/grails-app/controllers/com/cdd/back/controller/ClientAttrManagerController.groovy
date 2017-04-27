package com.cdd.back.controller

import com.cdd.base.service.common.CRUDService
import com.cdd.base.domain.ClientType
import com.cdd.base.domain.GroupManager
import com.cdd.base.domain.TagManager
import com.cdd.base.domain.DemandClass
import grails.converters.JSON
class ClientAttrManagerController extends BaseController{
	def model = "clientAttrManager"
	CRUDService CRUDService
	def list(){
		render view : "/${model}/list"
		return
	}
	
	def getTags(){
		
		params.dataType = 'json'
		
		def rs = CRUDService.list(TagManager, params)
		
		rs.list?.collect{
			it.customerCount =  it.clientManagers.size()
			return it
		}
		
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveTag(){
			TagManager tagManager
			if(params.id){
				tagManager = TagManager.get(params.id as Long)
				tagManager.properties=params
			}else{
				tagManager = new TagManager(params)
			}
			def rs;
			tagManager.save()
			if(tagManager.hasErrors()) {
				//flash.errors = tagManager.errors
				println tagManager.errors
				//flash.data = tagManager
				//redirect uri: "/${model}/data/" + (data.id ?: 'new')
				rs = false
			} else {
				//flash.msgs = ['保存成功']
				//def targetUri = uri ?: "/${model}/list"
				//redirect uri: targetUri
				rs = true
			}
			render rs
	}
	def delTag(){
			def result
			if(params.id){
				TagManager t = TagManager.get(params.id as long)
				if(t){
					t.delete();
					if(t.hasErrors()){
						println t.errors
						result = false
					}else {
						result = true
					}
				}
			}
			render result
		}
	
	
	def getDemands(){
		params.dataType = 'json'
		def rs = CRUDService.list(DemandClass, params)
		rs.list?.collect{
			it.customerCount =  it.clientManagers.size()
			return it
		}
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveDemand(){
		DemandClass demandClass
		if(params.id){
			demandClass = DemandClass.get(params.id as Long)
			demandClass.demandName = params.demandName
		}else{
			demandClass = new DemandClass(params)
		}
		def rs;
		demandClass.save()
		if(demandClass.hasErrors()) {
			//flash.errors = tagManager.errors
			println demandClass.errors
			//flash.data = tagManager
			rs = false
		} else {
			rs = true
		}
		render rs
	}
	
	def delDemand(){
		def result
		if(params.id){
			DemandClass dc = DemandClass.get(params.id as long)
			if(dc){
				dc.delete();
				if(dc.hasErrors()){
					println dc.errors
					result = false
				}else {
					result = true
				}
			}
		}
		render result
	}
	
	def getClientTypes(){
		params.dataType = 'json'
		def rs = CRUDService.list(ClientType, params)
		rs.list?.collect{
			it.customerCount =  it.clientManagers.size()
			return it
		}
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveClientType(){
		ClientType clientType
		if(params.id){
			clientType = ClientType.get(params.id as Long)
			clientType.typeName = params.typeName
		}else{
			clientType = new ClientType(params)
		}
		
		def rs;
		clientType.save()
		if(clientType.hasErrors()) {
			//flash.errors = tagManager.errors
			println clientType.errors
			//flash.data = tagManager
			rs = false
		} else {
			rs = true
		}
		render rs
	}
	
	def delClientType(){
		def result
		if(params.id){
			ClientType ct = ClientType.get(params.id as long)
			if(ct){
				ct.delete();
				if(ct.hasErrors()){
					println ct.errors
					result = false
				}else {
					result = true
				}
			}
		}
		render result
	}
	
	
	def getGroups(){
		params.dataType = 'json'
		def rs = CRUDService.list(GroupManager, params)
		
		rs.list?.collect{
			it.customerCount =  it.clientManagers.size()
			return it
		}
		
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveGroup(){
		GroupManager groupManager
		if(params.id){
			groupManager = GroupManager.get(params.id as Long)
			groupManager.groupName = params.groupName
			groupManager.description = params.description
		}else{
			groupManager = new GroupManager(params)
		}
		
		def rs;
		groupManager.save()
		if(groupManager.hasErrors()) {
			//flash.errors = tagManager.errors
			println groupManager.errors
			//flash.data = tagManager
			rs = false
		} else {
			rs = true
		}
		render rs
	}
	
	def delGroup(){
		def result
		if(params.id){
			GroupManager cm = GroupManager.get(params.id as long)
			if(cm){
				cm.delete();
				if(cm.hasErrors()){
					println cm.errors
					result = false
				}else {
					result = true
				}
			}
		}
		render result
	}
	
}
