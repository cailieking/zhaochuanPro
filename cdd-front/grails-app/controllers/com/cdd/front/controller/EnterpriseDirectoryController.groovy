package com.cdd.front.controller
import org.hibernate.SessionFactory;
import com.cdd.base.domain.EnterpriseDirectory
import com.cdd.base.domain.FrontUser
import grails.converters.JSON;
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.OssService;
import com.cdd.base.service.common.CRUDService;

class EnterpriseDirectoryController implements ExceptionHandler{
	CRUDService CRUDService
	OssService ossService
    SessionFactory sessionFactory
	SpringSecurityService springSecurityService
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def list(){
		FrontUser user = springSecurityService.currentUser
		boolean isLoggedIn = springSecurityService.isLoggedIn();
		//println user.verified
		if(!isLoggedIn){
			redirect url: "/login/auth"
			//redirect url: '/login/auth'
			println "未登录"
		}else{
		println "已登录!!!!!"
		def verified =user.verified
		
		if (!params.sort) {
			params.sort = "dateCreated";
			params.order = "desc";
		}
		def queryHandler={
			if(params.companyName){
				or {
					like "companyName", "%"+params.companyName+"%"
				}
			}
			eq "showOnIndex", true
		}
		def map = [:]
		map.list=[]
		def curPage
		int pagesize=8
		if(!params.curPage&&params.curPage<0){
			curPage=0
		}else{
			curPage=Integer.parseInt(params.curPage)
		}
		def result = CRUDService.list(EnterpriseDirectory,[sort: 'dateCreated', order: 'desc'],queryHandler);
		def total = result.size();
		def start=curPage*pagesize
		def end=(curPage+1)*pagesize<(total-1)?(curPage+1)*pagesize:(total-1)
		def maptotal=['total':total]
		def mappagesize=['pagesize':pagesize]
		def mappage=['curPage':curPage]
		def mapstart=['start':start]
		def mapend=['end':end]
	
		result?.each {data ->
			def maps = [:]
			maps.companyName = data.companyName
			maps.address = data.address
			maps.mobile = data.mobile
			maps.contactName = data.contactName
			maps.companyEnglish = data.companyEnglish
			maps.telephone = data.telephone
			maps.qq = data.qq
			maps.email = data.email
			maps.city = data.city
			map.list<<maps
		}
		map<<maptotal
		map<<mappage
		map<<mappagesize
		map<<mapstart
		map<<mapend
	
		//render (view:'/enterpriseDirectory/index',model:[map:map,verified:verified]) //([total: total, rows: list] as JSON)
		render ([map:map,verified:verified] as JSON) //([total: total, rows: list] as JSON)
		
		}
	}

}	
