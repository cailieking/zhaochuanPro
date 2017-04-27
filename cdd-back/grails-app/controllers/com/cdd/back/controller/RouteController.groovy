package com.cdd.back.controller


import org.apache.poi.hssf.usermodel.HSSFRow

import com.cdd.base.domain.Route
import com.cdd.base.domain.EndPort
import com.cdd.base.domain.StartPort
import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.RouteType
import com.cdd.base.service.OrderService
import grails.converters.JSON


class RouteController extends BaseController {

	def model = 'route'

	def excludeFields = []

	def list() {
		String searchKey
		if(params.search) {
//			params.f_like_category = "%${params.search}%"
			params.f_like_port = "%${params.search}%"
		}

		render getList(model: model, domainClass: Route, excludeFields: excludeFields, queryHandler: {
			if(params.search) {
				like "port", "%${params.search}%"
			}
			if(params.type) {
				eq "type", RouteType.valueOf(params.type)
			}
			if(params.category) {
				eq "category", RouteCategory.valueOf(params.category)
			}
		})
	}

	def data() {
		render data(model: model, menuName: '航线信息', domainClass: Route, excludeFields: excludeFields)
	}

	OrderService orderService

	def save() {
		Route data = new Route(params)
		if(params.id) {
			data.id = params.id as Long
		}
		save(data, model)
	}

	def delete() {
		delete(Route, model)
	}

	def importData() {
		importDataWithHandler() { HSSFRow row ->
			Route data = new Route()
			data.category = row.getCell(0)?.stringCellValue?.trim() ? RouteCategory.getCodeByText(row.getCell(0).stringCellValue.trim()) : null
			data.port = row.getCell(1)?.stringCellValue?.trim() ?: null
			data.type = row.getCell(2)?.stringCellValue?.trim() ? RouteType.getCodeByText(row.getCell(2).stringCellValue.trim()) : null
			data.shortName = row.getCell(3)?.stringCellValue?.trim() ?: null
			data.city = row.getCell(4)?.stringCellValue?.trim() ?: null
			return data
		}
	}
	
	def port(){
		def a=EndPort.list()
		def c=StartPort.list()
		def b=a.collect(){
			def map=[:]
			map.value=""
			map.country=it.countryEn?it.countryEn:""
			map.port_code=it.code?it.code:""
			map.title=it.portName?it.portName:""
			map.label=it.portEnglishName?it.portEnglishName:""
			return map
		}
		def d=c.collect(){
			def map1=[:]
			map1.value=""
			map1.country=it.countryEn?it.countryEn:""
			map1.port_code=it.code?it.code:""
			map1.title=it.portName?it.portName:""
			map1.label=it.portEnglishName?it.portEnglishName:""
			return map1
		}
		//def Result
		def status
		def message
		if(a==[null]||c==[null]){
			
						status=0;
						//Result="false"
						message="加载数据出现异常"
			
		}else {
						status=1
						//Result="success"
						message=""
		}
					def map3=[:]
					map3.put("startPort",d)
					map3.put("endPort",b)
					
			 //println map3 as JSON
			render ([message:message,result:map3,status:status] as JSON)
	}
	

	def downloadExample() {
		downloadExampleWithInfo(fileName: '航线分类上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/route.xls')
	}
}
