package com.cdd.back.controller
import java.text.SimpleDateFormat;

import com.cdd.base.domain.StartPort;

import grails.converters.JSON;
class StartPortController extends BaseController {
	
	def excludeFields = ['salt', 'password']
	def model = 'startPort'
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
	def list() {
		def searchKey;
		if(params.search){
			searchKey="%${params.search}%"
		}

		render getList(model: model, domainClass: StartPort,excludeFields: excludeFields, isConjunction: true, queryHandler:{
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
		render data(model: model, menuName: '起始港', domainClass: StartPort)
	}
	
	def edit= {
		def data
		
		if(params.id != 'new') {
			data = StartPort.get(params.id as Long)
		} else {
			data = flash.data ?: new StartPort()
		}
		render view: "/${model}/edit", model: [data: data, settings: getSettings(getMenu('起始港信息', "/${model}/list"))]
	}
	
	def delete() {
		delete(StartPort, model)
	}
	
	def save={
		
		StartPort data = new StartPort(params)
		if(params.id) {
			data.id = params.id as Long
		}
		save(data, model)
	}

}
