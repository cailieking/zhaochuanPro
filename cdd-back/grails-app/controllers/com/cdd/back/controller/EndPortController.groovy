package com.cdd.back.controller
import java.text.SimpleDateFormat;

import com.cdd.back.service.UserService;
import com.cdd.base.domain.EndPort;

import grails.converters.JSON;
class EndPortController extends BaseController {
	
	def excludeFields = ['salt', 'password']
	def model = 'endPort' 
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
	def list() {
		def searchKey;
		if(params.search){
			searchKey="%${params.search}%"
		}

		render getList(model: model, domainClass: EndPort,excludeFields: excludeFields, isConjunction: true, queryHandler:{
			if(searchKey){
				or{
					like "portName" ,searchKey
					like "portEnglishName" ,searchKey
					like "countryCh" ,searchKey
					like "countryEn" ,searchKey
					
				}
			}
			
		}){ item, map ->
			map.dateCreated = sdf.format(item.dateCreated)
			
		};
	}
	
	def data={
		render data(model: model, menuName: '目的港', domainClass: EndPort,excludeFields: excludeFields)
	}
	
	def edit= {
		def data
		
		if(params.id != 'new') {
			data = EndPort.get(params.id as Long)
		} else {
			data = flash.data ?: new EndPort()
		}
		render view: "/${model}/edit", model: [data: data, settings: getSettings(getMenu('目的港信息', "/${model}/list"))]
	}
	
	def delete() {
		delete(EndPort, model)
	}
	
	def save={
		
		EndPort data = new EndPort(params)
		if(params.id) {
			data.id = params.id as Long
		}
		save(data, model)
	}
}
