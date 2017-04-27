package com.cdd.back.controller

import com.cdd.base.service.common.CRUDService
import com.cdd.base.domain.SupplierTag
import com.cdd.base.domain.SupplierAccount
import com.cdd.base.domain.SupplierGroup
import com.cdd.base.domain.SupplierLevel
import grails.converters.JSON
class SupplierAttrManagerController extends BaseController{
	def model = "supplierAttrManager"
	CRUDService CRUDService
	def list(){
		render view : "/${model}/list"
		return
	}
	
	def getTags(){
		
		params.dataType = 'json'
		
		def rs = CRUDService.list(SupplierTag, params)
		
		rs.list?.collect{
			it.customerCount =  it.supplierManagers.size()
			return it
		}
		
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveTag(){
			SupplierTag supplierTag
			if(params.id){
				supplierTag = SupplierTag.get(params.id as Long)
				supplierTag.properties=params
			}else{
				supplierTag = new SupplierTag(params)
			}
			
			def rs;
			supplierTag.save()
			if(supplierTag.hasErrors()) {
				println supplierTag.errors
				rs = false
			} else {
				rs = true
			}
			render rs
	}
	
	def delTag(){
			def result
			if(params.id){
				SupplierTag st = SupplierTag.get(params.id as long)
				if(st){
					st.delete();
					if(st.hasErrors()){
						println st.errors
						result = false
					}else {
						result = true
					}
				}
			}
			render result
		}
	
	
	def getAccounts(){
		params.dataType = 'json'
		def rs = CRUDService.list(SupplierAccount, params)
		
		rs.list?.collect{
			it.customerCount =  it.supplierManagers.size()
			return it
		}
		
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveAccount(){
		SupplierAccount supplierAccount
		if(params.id){
			supplierAccount = SupplierAccount.get(params.id as Long)
			supplierAccount.accountName = params.accountName
		}else{
			supplierAccount = new SupplierAccount(params)
		}
		
		def rs;
		supplierAccount.save()
		if(supplierAccount.hasErrors()) {
			println supplierAccount.errors
			rs = false
		} else {
			rs = true
		}
		render rs
	}
	
	def delAccount(){
		def result
		if(params.id){
			SupplierAccount sa = SupplierAccount.get(params.id as long)
			if(sa){
				sa.delete();
				if(sa.hasErrors()){
					println sa.errors
					result = false
				}else {
					result = true
				}
			}
		}
		render result
	}
	
	def getLevels(){
		params.dataType = 'json'
		def rs = CRUDService.list(SupplierLevel, params)
		
		rs.list?.collect{
			it.customerCount =  it.supplierManagers.size()
			return it
		}
		
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveLevel(){
		SupplierLevel supplierLevel
		if(params.id){
			supplierLevel = SupplierLevel.get(params.id as Long)
			supplierLevel.levelName = params.levelName
		}else{
			supplierLevel = new SupplierLevel(params)
		}
		
		def rs;
		supplierLevel.save()
		if(supplierLevel.hasErrors()) {
			//flash.errors = tagManager.errors
			println supplierLevel.errors
			//flash.data = tagManager
			rs = false
		} else {
			rs = true
		}
		render rs
	}
	
	def delLevel(){
		def result
		if(params.id){
			SupplierLevel sl = SupplierLevel.get(params.id as long)
			if(sl){
				sl.delete();
				if(sl.hasErrors()){
					println sl.errors
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
		def rs = CRUDService.list(SupplierGroup, params)
		
		rs.list?.collect{
			it.customerCount =  it.supplierManagers.size()
			return it
		}
		
		def total = rs.totalCount
		render  ([total: total, rows: rs] as JSON)
	}
	
	def saveGroup(){
		SupplierGroup supplierGroup
		if(params.id){
			supplierGroup = SupplierGroup.get(params.id as Long)
			supplierGroup.groupName = params.groupName
			supplierGroup.description = params.description
		}else{
			supplierGroup = new SupplierGroup(params)
		}
		
		def rs;
		supplierGroup.save()
		if(supplierGroup.hasErrors()) {
			println supplierGroup.errors
			rs = false
		} else {
			rs = true
		}
		render rs
	}
	
	def delGroup(){
		def result
		if(params.id){
			SupplierGroup sg = SupplierGroup.get(params.id as long)
			if(sg){
				sg.delete();
				if(sg.hasErrors()){
					println sg.errors
					result = false
				}else {
					result = true
				}
			}
		}
		render result
	}
	
}
