package com.cdd.back.controller

import org.apache.poi.hssf.usermodel.HSSFRow
import org.springframework.security.crypto.keygen.KeyGenerators;

import com.cdd.base.domain.Company;
import com.cdd.base.domain.CompanyCertificate
import com.cdd.base.domain.FrontUser
import com.cdd.base.enums.AgentType;
import grails.converters.JSON;
import java.text.SimpleDateFormat
class CompanyController extends BaseController{
	def excludeFields = ['salt', 'password']
	def model='company'
	
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
	/**********返回公司列表****************/
	def list={
		def searchKey;
		if(params.search){
			searchKey="%${params.search}%"
		}
		render getList(model:model,domainClass:Company,excludeFields: excludeFields, isConjunction: true, queryHandler:{
			if(searchKey){
				or{
					like "companyName" ,searchKey
					like "city" ,searchKey
					like "specialService" ,searchKey
				}
			}
			if(params.type) {
				eq "type", AgentType.valueOf(params.type)
			}
		}) { item, map ->
			map.dateCreated = sdf.format(item.dateCreated)
			
		};
	}
	
	
	def getQueryCompanyList={
		def companyList;
		companyList = Company.findAllByCompanyNameLike("%${params.companyName}%")
		def nameList =[]
		companyList.each{
			nameList.add(it.companyName)
		}
		render nameList as JSON
	}
	def getCompanyDetail={
		
		def company;
		company = Company.findByCompanyName("${params.companyName}")
		
		def map=[companyName:company.companyName,address:company.address,businessLicenseNum:company.businessLicenseNum,
			types:company.type,regCapital:company.regCapital,workers:company.workers,businessLicenseImg:company.businessLicenseImg,
			taxImg:company.taxImg,companyCodeImg:company.companyCodeImg,advancedRoute:company.advancedRoute,telephone:company.telephone]
		
		
		render map as JSON
		
	}
	
	/***********添加经理****************/
	/*def addmanager={
		def id=params.id
		FrontUser user = FrontUser.findByUsername(params.phone?.trim());
		if(user){
		  user.company=Company.get(id as Long)
		  user.save(flush:true);
		  if( user.company){
			  log.info "添加经理成功"
			  flash.msgs= ['添加经理成功']
		  }else{
			log.info "添加经理失败"
			flash.msgs = ['添加经理失败']
		  }
		}else{
 
		}
	}*/
	/***列出所有的公司三证照片**/
	def certificate={

		def id=params.id
				CompanyCertificate companyCertificate=CompanyCertificate.get(id as Long)
		 render (view:'certificate',model:[data: companyCertificate])
	}
	/**********认证公司三证，一键认证******************/
	def recognized={
		def company
		def companyCertificate
		def frontUser
			if(params.verifyState=="1"){
				company = Company.findByCompanyName("${params.companyName}")
				companyCertificate = CompanyCertificate.findById("${params.companyCertificateId}")
				frontUser =FrontUser.findByCreateBy(companyCertificate.createBy) 
				//println params.companyCertificateId
				companyCertificate.verified=1;
				companyCertificate.honest=1;
				companyCertificate.safety=1;
				companyCertificate.state=1;
				companyCertificate.remark=params.auditAdvice
				if( !companyCertificate.save() ) {   companyCertificate.errors.each {        println it   }}
				company.verified=1
				company.honest=1;
				company.safety=1;
				if( !company.save() ) {   company.errors.each {        println it   }}
				company.save(flush:true);
				companyCertificate.save(flush:true);
				frontUser.verified = "1"
				if( !frontUser.save() ) {   frontUser.errors.each {        println it   }}
				frontUser.save(flush:true);
				flash.msgs = ['认证成功']
				
			}
			if(params.verifyState=="-1"){
				//company = Company.findByCompanyName("${params.companyName}")
				companyCertificate = CompanyCertificate.findById("${params.companyCertificateId}")
				
				companyCertificate.verified=0;
				companyCertificate.honest=0;
				companyCertificate.safety=0;
				companyCertificate.state=-1;
				companyCertificate.remark=params.auditAdvice
				companyCertificate.save(flush:true);
				flash.msgs = ['认证拒绝']
				
			}
			if(params.verifyState=="0"){
				println  "asdasdadasdasdasdasd"
				companyCertificate = CompanyCertificate.findById("${params.companyCertificateId}")
				frontUser =FrontUser.findByCreateBy(companyCertificate.createBy)
				
				companyCertificate.verified=1;
				companyCertificate.honest=1;
				companyCertificate.safety=1;
				companyCertificate.state=1;
				companyCertificate.remark="${params.auditAdvice}"
				companyCertificate.save(flush:true);
				
				Company companynew = new Company();
				companynew.verified=1;
				companynew.honest=1;
				companynew.safety=1;
						companynew.companyName = companyCertificate.companyName
						companynew.address = companyCertificate.address
						companynew.advancedRoute = companyCertificate.advancedRoute
						companynew.workers = companyCertificate.workers
						companynew.telephone = companyCertificate.telephone
						companynew.type = companyCertificate.type
						companynew.remark = companyCertificate.remark
						companynew.regCapital = companyCertificate.regCapital
						companynew.businessLicenseNum = companyCertificate.businessLicenseNum
						companynew.businessLicenseImg = companyCertificate.businessLicenseImg
						companynew.taxImg = companyCertificate.taxImg
						companynew.companyCodeImg = companyCertificate.companyCodeImg
						companynew.website = companyCertificate.website
						companynew.city = companyCertificate.city
						println companynew
				companynew.save(flush:true);
				
				
				frontUser.verified = "1"
				if( !frontUser.save() ) {   frontUser.errors.each {        println it   }}
				frontUser.save(flush:true);
				flash.msgs = ['添加成功']
				
			}
			redirect uri: "/companyCertificate/list"
		
		
	}
	/********查找经理***************/
	def findmanager={
		FrontUser user = FrontUser.findByUsername(params.id.trim());
		if(user) {
			   def a=['data':"存在该经理："+user.firstname]
			   render a as JSON
		}else{
		 def a=['data':"未找到"]
			   render a as JSON
		}
	}
	/***********公司详细页面**************/
	def data={
		render data(model: model, menuName: '公司一览', domainClass: Company, excludeFields: excludeFields)
	}
	/**********保存************/
	def save= {
		Company newData=null;
		if(!params.id){
			//params.id=KeyGenerators.string().generateKey()
			  newData = new Company(params)
		}else{
			newData=Company.get(params.id as Long)
			newData.properties=params
		}
		params.uri="/company/list"
		save(newData,'company',params.uri)
	}
	/********删除*******/
	def delete={
		request.view = "/$model/list"
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				Company	 com = Company.get(id as Long)
				com.delete(flush:true);
			}
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}
	/********公司三证认证*********/
	def verified(){
		
	}
	/*******下载模板********/
	def downloadExample() {
		downloadExampleWithInfo(fileName: '认证公司上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/company.xls')
	}
	/*********导入excel******/
	def importData() {
		final SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		importDataWithHandler() { HSSFRow row ->
			Company data = new Company()
			data.companyName = row.getCell(0)?.stringCellValue?.trim() ?: null
			data.address = row.getCell(1)?.stringCellValue?.trim() ?: null
			data.city = row.getCell(2)?.stringCellValue?.trim() ?: null
			data.introduce = row.getCell(3)?.stringCellValue?.trim() ?: null
			try {
				data.workers = row.getCell(4)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.workers = row.getCell(4)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(4).numericCellValue).longValue()) : null
			}
			try {
				data.scale = row.getCell(5)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.scale = row.getCell(5)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(5).numericCellValue).longValue()) : null
			}
			//					data.workers = row.getCell(4)?.stringCellValue?.trim() ?: null
			//					data.scale = row.getCell(5)?.stringCellValue?.trim() ?: null
			data.website = row.getCell(6)?.stringCellValue?.trim() ?: null
			data.mailbox = row.getCell(7)?.stringCellValue?.trim() ?: null
			try {
				data.telephone = row.getCell(8)?.stringCellValue?.trim() ?: null
			} catch(e) {
			data.telephone = row.getCell(8)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(8).numericCellValue).longValue()) : null
		}
				data.businessRange = row.getCell(9)?.stringCellValue?.trim() ?: null
			data.type = AgentType.getCodeByText(row.getCell(10)?.stringCellValue?.trim() ?: null)
			data.priceInfo = row.getCell(11)?.stringCellValue?.trim() ?: null
			data.remark = row.getCell(12)?.stringCellValue?.trim() ?: null
			try {
				data.bulidTime = row.getCell(13)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.bulidTime = row.getCell(13)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(13).numericCellValue).longValue()) : null
			}
			try {
				data.regCapital = row.getCell(14)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.regCapital = row.getCell(14)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(14).numericCellValue).longValue()) : null
			}
			//					data.bulidTime = row.getCell(13)?.stringCellValue?.trim() ?: null
			//					data.regCapital = row.getCell(14)?.stringCellValue?.trim() ?: null
			data.specialService = row.getCell(15)?.stringCellValue?.trim() ?: null
			data.englishName = row.getCell(16)?.stringCellValue?.trim() ?: null
			data.advancedRoute = row.getCell(17)?.stringCellValue?.trim() ?: null
			return data
		}
	}
}



