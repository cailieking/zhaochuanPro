package com.cdd.front.controller
import grails.converters.JSON
import com.cdd.base.domain.City;
import com.cdd.base.domain.Company
import com.cdd.base.domain.CompanyCertificate;
import com.cdd.base.domain.FrontUser;

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured








import java.text.SimpleDateFormat

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import java.awt.image.BufferedImage

import javax.imageio.ImageIO
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest

import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.Transaction
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.service.OssService
import com.cdd.base.service.SmsService
import com.cdd.front.constant.Constant
import com.google.code.kaptcha.Constants
import com.google.code.kaptcha.Producer


import com.cdd.base.domain.ArticleInformation;
import com.cdd.base.enums.AgentType;
import com.cdd.base.enums.ArticleType
import com.cdd.base.service.common.CRUDService;
import com.cdd.base.util.CommonUtils;

@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
class CompanyController  {
	CRUDService CRUDService
     OssService ossService
	SpringSecurityService springSecurityService
	SessionFactory sessionFactory
	
	GrailsApplication grailsApplication
	int maxSize = 1024 * 1024 * 10
	
	/*******所有公司的页面***************/
	def list={
		if (!params.sort) {
			params.sort = "dateCreated";
			params.order = "desc";
		}
		//搜索
		def queryHandler={
			//搜索公司名称
			if(params.companyName){
				or {
					like "companyName", "%"+params.companyName+"%"
				}
			}
			//搜索航线
			if(params.startPort) {
				or {
					like "startPort", "%"+params.startPort.toUpperCase()+"%"
					like "startPortCn", "%"+params.startPort.toUpperCase()+"%"
				}
			}
			if(params.endPort) {
				or {
					like "endPort", "%"+params.endPort.toUpperCase()+"%"
					like "endPortCn", "%"+params.endPort.toUpperCase()+"%"
				}
			}
		}
		def result = CRUDService.list(Company,params,queryHandler);
		def total = result.totalCount;
		FrontUser newUser = springSecurityService.currentUser
		def list = result?.list.collect {
			def data = [:]
			data.company_name = it.companyName
			//data.advantage_route =it.advancedRoute  //
			data.advantage_route =it.advancedRoute   //
			data.advance_service = it.specialService
			data.company_location = it.address
			//			data.quantity = new Random().nextInt(10)
			data.infoId = it.id
			data.city = it.city
			data.hornest = it.honest
			data.safety  = it.safety//设计为 int
			data.verified = it.verified
			def userHornest=newUser?.hornest
			Cookie cookie
			if(userHornest){
				cookie=new Cookie("honest","1");
			}else{
				cookie=new Cookie("honest","0");
			}
			cookie.setMaxAge(3600);
			cookie.setPath("/");
			response.addCookie(cookie);
			return data
		}
		render ([total: total, rows: list] as JSON)
	}
	/******该公司的详细内容***************/

	def data() {
		Company company = Company.get(params.id as Long);
		def user=null;
			user=listusers(company);
		def list=[];
		def map=[:]
		map.company=company
		map.user=user
		['params':map] 
	}
	/******查询某个员工的具体信息****************/
    def finduser={
      def user=FrontUser.get(params.id)
	  render (view:'manager',model:['user':user]  )
	}
	/******列出所有的该公司员工***********/
	def listusers(def company){
		if (!params.sort) {
			params.sort = "dateCreated";
			params.order = "desc";
		}
		def x=company 
		def queryHandler={
			//搜索公司名称
			if(x){
				and{ eq "company", x }
			}
		}
		def result = CRUDService.list(FrontUser,params,queryHandler);
		return result
	}
	/*************保存用户注册公司信息********************/
	def save() {
		CompanyCertificate certificate=new CompanyCertificate()
		Company company=new Company()
		FrontUser newUser = springSecurityService.currentUser
			certificate.companyName = params.companyName
			certificate.city=params.city[0]
			certificate.address = params.address
			certificate.workers = params.workers
			certificate.type = params.type
			certificate.state = 0
			certificate.advancedRoute = params.recommendedRoutes
			
			certificate.createBy=newUser.username;
			certificate.updateBy=newUser.username;
			certificate.businessLicenseNum=params.businessLicenseNum
			fileExistOrNot1( flash, certificate,'file1')
			fileExistOrNot2( flash, certificate,'file2')
			fileExistOrNot3( flash, certificate,'file3')
			
			//certificate.company=newUser.company
			println "aaaaassssssssssdd"
			if( !certificate.save() ) {   certificate.errors.each {        println it   }}
			certificate.save(flush:true)
			
		/*Company company=new Company();
		CompanyCertificate certificate1=new CompanyCertificate();
		CompanyCertificate certificate2=new CompanyCertificate();
		CompanyCertificate certificate3=new CompanyCertificate();
	    FrontUser newUser = springSecurityService.currentUser+++++
			company.companyName = params.companyName
			company.city=params.city[0]
			company.address = params.address
			company.workers = params.workers
			company.type = params.type
			company.type = params.type
			company.advancedRoute = params.recommendedRoutes
			company.createBy=newUser.firstname;
			company.updateBy=newUser.firstname;
			company.save();
		fileExistOrNot(company, flash, certificate1,'file1')
		fileExistOrNot(company, flash, certificate2,'file2')
		fileExistOrNot(company, flash, certificate3,'file3')
		flash.mesg="创建公司成功"
        newUser.company=company;
		newUser.save();
		certificate1.createBy=newUser;
		certificate2.createBy=newUser;
		certificate3.createBy=newUser;
		certificate1.updateBy=newUser;
		certificate2.updateBy=newUser;
		certificate3.updateBy=newUser;
		certificate1.save();
		certificate2.save();
		certificate3.save();*/
	}
	/********前端ajax判断公司是否存在***********/
	/*def findCompany={
		def name=params.CompanyName;
		def company=Company.findByCompanyName(name)
		if(company!=null){
			render("公司已注册，若需重新注册，请联系客服对该公司进行删除后重新注册")as JSON
		}else{
			render("^^该公司可注册")as JSON
		}
		
	}*/
	/*****判断图片是否为空等******/
	
	
	private fileExistOrNot1( Map flash,CompanyCertificate certificate,String file) {
		CommonsMultipartFile f = request.getFile(file)
		if(f.size <= 0 && !data.image) {
			flash.msgs = ['请上传图片']+file
			return
		}
		if(f.size > maxSize) {
			flash.msgs  = ['图片不能超过10MB']
			return
		}
		if(f.size > 0) {
			String fileName = "files/company/certificate/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
					"files/company/certificate/" + f.fileItem.fileName)
			certificate.businessLicenseImg = fileName
			
		}
	}
	private fileExistOrNot2( Map flash,CompanyCertificate certificate,String file) {
		CommonsMultipartFile f = request.getFile(file)
		if(f.size <= 0 && !data.image) {
			flash.msgs = ['请上传图片']+file
			return
		}
		if(f.size > maxSize) {
			flash.msgs  = ['图片不能超过10MB']
			return
		}
		if(f.size > 0) {
			String fileName = "files/company/certificate/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
					"files/company/certificate/" + f.fileItem.fileName)
			certificate.taxImg = fileName
			
		}
	}
	private fileExistOrNot3( Map flash,CompanyCertificate certificate,String file) {
		CommonsMultipartFile f = request.getFile(file)
		if(f.size <= 0 && !data.image) {
			flash.msgs = ['请上传图片']+file
			return
		}
		if(f.size > maxSize) {
			flash.msgs  = ['图片不能超过10MB']
			return
		}
		if(f.size > 0) {
			String fileName = "files/company/certificate/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
					"files/company/certificate/" + f.fileItem.fileName)
			certificate.companyCodeImg = fileName
			//certificate.company=company
		}
	}
	/*private fileExistOrNot(Company company, Map flash,CompanyCertificate certificate,String file) {
		CommonsMultipartFile f = request.getFile(file)
		if(f.size <= 0 && !data.image) {
			flash.msgs = ['请上传图片']+file
			return
		}
		if(f.size > maxSize) {
			flash.msgs  = ['图片不能超过10MB']
			return
		}
		if(f.size > 0) {
			String fileName = "files/company/certificate/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
					"files/company/certificate/" + f.fileItem.fileName)
			certificate.image = fileName
			certificate.company=company
		}
	}*/
	
}