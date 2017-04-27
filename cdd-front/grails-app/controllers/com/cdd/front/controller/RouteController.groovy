package com.cdd.front.controller



import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.CargoShipInformation;
import com.cdd.base.domain.EndPort;
import com.cdd.base.domain.Route
import com.cdd.base.domain.StartPort;
import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.RouteType
import com.cdd.base.service.common.CRUDService
import com.cdd.front.service.RouteService

class RouteController implements ExceptionHandler {
	CRUDService CRUDService

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def endPortList() {
		render getListByType(RouteType.End) as JSON
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
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
	
	
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def list() {
//				def map = [:]
//				map.startPortList = getListByType(RouteType.Start)
//				map.endPortList = getListByType(RouteType.End)
//				render map as JSON

		def map2=[:]
		//def a=EndPort.executeQuery("""select distinct (a.portName),a.portEnglishName from EndPort a""")
		//def b=StartPort.executeQuery("""select distinct (b.portName),b.portEnglishName from StartPort b""")
		def e=CargoShipInformation.executeQuery("""select distinct c.shipCompany from CargoShipInformation c where c.shipCompany is not null """)
		def a=EndPort.list()
		def c=StartPort.list()
		//def e=CargoShipInformation.list()
		def b=a.collect(){
			def map=[:]
			map.endPortCn=it.portName
			map.endPort=it.portEnglishName
			return map
		}
		def d=c.collect(){
			def map1=[:]
			map1.startPortCn=it.portName
			map1.startPort=it.portEnglishName
			return map1
		}
		// def map3=[:]

		//  map3.shipCompanyPort=e
		def Result
		def status
		def message

		if(e==[null]||a==[null]||c==[null]){

			status=0;
			Result="false"
			message="加载数据出现异常"

		}else {
			status=1
			Result="success"
			message=""
		}
		def map3=[:]
		map3.put("startPort",d)
		map3.put("endPort",b)
		map3.put("shipCompany",e)
		//map3.put("total",total)
		map2.put("message",message)
		map2.put("result",map3)
		map2.put("status",status)
		//println [message:message,result:map3,status:status] as JSON

		render ([message:message,result:map3,status:status] as JSON)

	}

	private def getListByType(RouteType type) {
		def result = CRUDService.list(Route, [sort: 'port', order: 'asc', f_type: type]) //, f_groupProperty_category: null
		return result.list?.collect {
			def data = [:]
			data.port = it.port
			data.category = it.category ? it.category.name() : "";
			return data
		}
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def associateStart() {
		associate(RouteType.Start)
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def associateEnd() {
		associate(RouteType.End)
	}

	private def associate(RouteType type) {
		def list = []
		String port = params.port?.toUpperCase()
		if(port) {
			def result = CRUDService.list(Route, [f_like_port: "${port}%", f_type: type])
			list = result.list?.collect { Route route ->
				[port: route.port, category: route.category?.text, city: route.city]
			}
			def cityList = []
			list?.each { item ->
				def cityRoutes = Route.findAllByCity(item.city)
				cityRoutes.each { Route cityRoute ->
					def compareItem
					if(!list.any {
						if(cityRoute.port == it.port) {
							compareItem = it
							return true
						} else {
							return false
						}
					}) {
						cityList << [port: cityRoute.port, category: cityRoute.city]
					}
					if(compareItem) {
						compareItem.category = cityRoute.city
					}
				}
			}
			list.addAll cityList
		}
		render list as JSON
	}

	SpringSecurityService springSecurityService

	RouteService routeService

	@Secured(['ROLE_CLIENT'])
	def recommend() {
		def user = springSecurityService.currentUser
		def list  = new ArrayList();
//		def list = user.recommendedRoutes?.collect {
//			//		def list= [RouteCategory.AoXin, RouteCategory.DongNanYa].collect {
//			return routeService.findRecommendedPort(user, it.category)
//		}
		
		user.recommendedRoutes?.collect {
		   routeService.findRecommendedPort(user, it.category)?.collect{ result ->
			   list.add(result)
		   }
		}
		render list as JSON
	}
}
