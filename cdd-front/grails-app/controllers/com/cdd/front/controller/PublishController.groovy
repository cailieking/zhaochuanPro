package com.cdd.front.controller

import grails.converters.JSON;
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.CargoShipInformation;
import com.cdd.base.domain.FrontUser;
import com.cdd.base.domain.InqueryPrice;
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.CityService

class PublishController implements ExceptionHandler {
	
	SpringSecurityService springSecurityService
	
	@Secured('ROLE_CLIENT')
	def findcargo() {
		FrontUser user = springSecurityService.currentUser
		def  startPort = params.startPort ? java.net.URLEncoder.encode(params.startPort) : '';
		def  endPort = params.endPort ? java.net.URLEncoder.encode(params.endPort) : '';
		def  startPortCn = params.startPortCn ? java.net.URLEncoder.encode(params.startPortCn) : '';
		def  endPortCn = params.endPortCn ? java.net.URLEncoder.encode(params.endPortCn) : '';
		if (user.isShipAgent()) {
			if (params.orderId) {
				redirect url: "/member/ship?orderId="+params.orderId+"&startPort="+startPort+"&endPort="+endPort
			} else {
				redirect url: "/member/ship"
			}
		} else {
			render(text: "<script>alert('货主不可报价航线信息');</script>", contentType: "text/html", encoding: "UTF-8")
		}
	}
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def findship() {
		boolean isLoggedIn = springSecurityService.isLoggedIn();
		
		
		if (isLoggedIn) {
			def  startPort = params.startPort ? java.net.URLEncoder.encode(params.startPort) : '';
			def  endPort = params.endPort ? java.net.URLEncoder.encode(params.endPort) : '';
			def  startPortCn = params.startPortCn ? java.net.URLEncoder.encode(params.startPortCn) : '';
			def  endPortCn = params.endPortCn ? java.net.URLEncoder.encode(params.endPortCn) : '';
		
//			if (params.infoId) {
//				//def phone=user.phone
//				//def company=user.companyName
//				//def userName=user.username
//				redirect url: "/member/cargo?infoId="+params.infoId+"&startPort="+startPort+"&endPort="+endPort+"&startPortCn="+startPortCn+"&endPortCn="+endPortCn
//				//redirect url: "/member/cargo?infoId="+params.infoId+"&startPort="+startPort+"&endPort="+endPort+"&startPortCn="+startPortCn+"&endPortCn="+endPortCn
//			} else {
//				redirect url: "/member/cargo"
//				//redirect url: "/member/cargo"
//			}
			if (params.infoId) {
				FrontUser user = springSecurityService.currentUser
				CargoShipInformation ship = CargoShipInformation.get(params.infoId as Long)
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
				def endDate = formatter.format(ship.endDate)
				def startDate = formatter.format(ship.startDate)
				
				//def inquery=InqueryPrice.findByInfo(ship)
				//println params.infoId
				//println inquery
				
				//def	orderDescript="----"
				def	userName=user.firstname
					//println userName
				def	qq=user.qq
				def	mobile=user.username
				def	companyName=user.companyName
					
				
				//println userName
				//println qq
				//println mobile
				//println companyName
				//def companyName=u
				//println endDate
				//println startDate
				//println ship 
				//println ship.remark
				//render view: '/publish/pubcargo', model: [data: ship]
				render view: '/cargoInquery.gsp', model: [data: ship,endDate:endDate,startDate:startDate,userName:userName,companyName:companyName,qq:qq,mobile:mobile]
						//redirect url: "/publish/pubcargo?infoId="+params.infoId+"&startPort="+startPort+"&endPort="+endPort+"&startPortCn="+startPortCn+"&endPortCn="+endPortCn
			}
	    }else{
		        redirect url : '/login/auth'  
		}
	}
}
