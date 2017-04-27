package com.cdd.back.controller

import grails.plugin.springsecurity.SpringSecurityService;

import org.springframework.security.crypto.keygen.KeyGenerators

import java.text.SimpleDateFormat

import grails.converters.JSON;

import com.cdd.base.domain.City
import com.cdd.base.domain.FrontAuthority
import com.cdd.back.domain.FakeFrontUser
import com.cdd.back.service.UserService
import com.cdd.base.domain.FrontUser
import com.cdd.base.enums.FrontUserType
import com.cdd.base.service.SmsService;
import com.cdd.base.util.CommonUtils

import jxl.write.WritableWorkbook
import jxl.write.WritableSheet
import jxl.SheetSettings
import jxl.Workbook
import jxl.write.WritableFont
import jxl.write.WritableCellFormat
import jxl.write.Label
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
class FrontUserController extends BaseController {
	SpringSecurityService springSecurityService

	def excludeFields = ['salt', 'password',]

	def model = 'frontUser'
	def limit = 10
	def offset = 0
	def state = false
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd")
	
	def list() {
		
		
		/*def searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		render getList(model: model, domainClass: FrontUser, excludeFields: excludeFields, queryHandler: {
			if(searchKey) {
				or {
					like "username", searchKey
					like "firstname", searchKey
					like "companyName", searchKey
				}
			}
			if(params.cityId){
				or{
					eq "city", City.get(params.cityId as Long) //params.cityId
				}
			}
			if(params.comeFrom){
				println params.comeFrom
				or{
				eq "comeFrom", params.comeFrom
				}
			}
			if(params.createBy){
				or{
					like "createBy", "%${params.createBy}%"
				}
				
			}
			if(params.checkBy){
				or{
					like "updateBy", "%${params.checkBy}%"
				}
				
			}
			
			if(params.invitationCode){
				or{
					like "invitationCode", "%${params.invitationCode}%"
				}
				
			}
			
			if(params.registerStratDate||params.registerEndDate){
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf5.parse(params.registerStratDate);
				def date2=sdf5.parse(params.registerEndDate)+1;
				and{
					
					 between ("dateCreated", date1,date2)
				}
			}
			
			if(params.type) {
				eq "type", FrontUserType.valueOf(params.type)
			}
		}) { item, map ->
			if(item.isCargoOwner()) {
				map.type = '货主'
			} else {
				map.type = '货代'
			}
			 map.dateCreated = sdf.format(item.dateCreated)
			
			  if(item.loginTime){
				map.loginTime = sdf.format(item.loginTime)
			}
		}*/
		println params
		def searchKey
		if(params.searchKey) {
			searchKey = "%${params.searchKey}%"
		}
		if(params.offset == null && params.limit == null){
			params.offset = offset
			params.limit = limit
		}
		
		def result = CRUDService.list(FrontUser,params){
			if(searchKey) {
				or {
					like "username", searchKey
					like "firstname", searchKey
					like "companyName", searchKey
					like "createBy", searchKey
					like "invitationCode", searchKey
				}
			}
			if(params.startDate&&params.endDate) {
				//def date2=new java.sql.Date(sdf.parse(params.endDate).getTime())
				def date1 = sdf1.parse(params.startDate)
				def date2 = sdf1.parse(params.endDate)
				and{
					between ("loginTime", date1,date2)
				}
			}else if(params.startDate) {
				def date=sdf1.parse(params.startDate)
			
					ge "loginTime", date
				
			}else if(params.endDate) {
				def date=sdf1.parse(params.endDate)
					le "loginTime", date
			
			}else {
			}
			
			if(params.createDateStart&&params.createDateEnd) {
				def date1 = sdf1.parse(params.createDateStart)
				def date2 = sdf1.parse(params.createDateEnd)
				and{
					between ("dateCreated", date1,date2)
				}
			}else if(params.startDate) {
				def date=sdf1.parse(params.startDate)
			
					ge "dateCreated", date
				
			}else if(params.endDate) {
				def date=sdf1.parse(params.endDate)
					le "dateCreated", date
			
			}else {
			}
			if(params.cityId){
				or{
					eq "city", City.get(params.cityId as Long) //params.cityId
				}
			}
			
			if(params.frontType) {
				eq "type", FrontUserType.valueOf(params.frontType)
			}
			
			if(params.comefrom){
				or{
					eq "comeFrom", params.comefrom
				}
			}
			
			if(params.selIsEnabled){
				or{
					eq "enabled", Boolean.valueOf(params.selIsEnabled)
				}
			}
			
			if(params.selIsOnline){
				or{
					eq "isOnline", Boolean.valueOf(params.selIsOnline)
				}
			}
		}
		if(!params.state){
			Map map = [totalCount:result.totalCount,rows:result]
			render view:"/frontUser/list",model:[map:map]
		}else {
			Map map = [totalCount:result.totalCount,rows:[]]
			result.list.each { FrontUser frontUser ->
				def data=[:]
				data.id = frontUser.id
				data.username = frontUser.username
				data.firstname = frontUser.firstname
				data.city = frontUser.city.name
				data.type = frontUser.type.text
				data.dateCreated = frontUser.dateCreated
				data.loginOutTime = frontUser.loginOutTime
				data.createBy = frontUser.createBy
				data.invitationCode = frontUser.invitationCode
				data.enabled = frontUser.enabled
				data.isOnline = frontUser.isOnline
				data.hornest = frontUser.hornest
				data.safety = frontUser.safety
				data.verified = frontUser.verified
				map.rows << data
			}
			render map as JSON
		}
		
		
		}
	/***********用户详细页面**************/
	def data(){
		println params.id
		def user = [:]
		def datas = [user:user]
		FrontUser frontuser = FrontUser.get(params.id as Long)
		datas.user.id = frontuser.id
		datas.user.username = frontuser.username
		datas.user.firstname = frontuser.firstname
		datas.user.companyName = frontuser.companyName
		datas.user.city = frontuser.city.name
		datas.user.createBy = frontuser.createBy
		datas.user.type = frontuser.type.text
		datas.user.enabled = frontuser.enabled
		datas.user.hornest = frontuser.hornest
		datas.user.safety = frontuser.safety
		datas.user.qq = frontuser.qq
		datas.user.email = frontuser.email
		datas.user.verified = frontuser.verified
		datas.user.invitationCode = frontuser.invitationCode
		datas.user.dateCreated = frontuser.dateCreated
		datas.user.loginOutTime = frontuser.loginOutTime
		datas.user.isOnline = frontuser.isOnline
		
		println datas
		
		render datas as JSON
		//render data(model: model, menuName: '注册用户管理', domainClass: FrontUser, excludeFields: excludeFields)
	}
	
	/**********后台注册用户*********/
	/*def addBackUser = {
		render  view: "/${model}/addBackUser",menuName: '后台注册用户',domainClass: FrontUser, excludeFields: excludeFields
		
	}*/
	
	
	/**********保存************/
	def save= {
		/*FrontUser newData=null;
		if(!params.id){
			//params.id=KeyGenerators.string().generateKey()
			  newData = new FrontUser(params)
		}else{
			if(params.password){
				newData=FrontUser.get(params.id as Long)
				newData.salt = KeyGenerators.string().generateKey()
				params.password = springSecurityService.encodePassword(params.password, newData.salt)
				newData.properties=params
			}
			if(!params.password){
				newData=FrontUser.get(params.id as Long)
				params.password = newData.password
				newData.properties=params
			}
		}
		if(params.type=="Agent"){
			sessionFactory.currentSession.createSQLQuery("update  front_authority_users set front_authority_id=5 where front_user_id=${params.id} and front_authority_id=2").executeUpdate()
			}else{
			sessionFactory.currentSession.createSQLQuery("update  front_authority_users set front_authority_id=2 where front_user_id=${params.id} and front_authority_id=5").executeUpdate()
			
			}
		params.uri="/frontUser/list"
		save(newData,'frontUser',params.uri)*/
		println params
		
		FrontUser user = FrontUser.get(params.id as Long)
		
		if(params.password){
			println params.password
			user.salt = KeyGenerators.string().generateKey()
			user.password = springSecurityService.encodePassword(params.password, user.salt)
		}
		user.username = params.username
		user.firstname = params.firstname
		
		user.companyName = params.companyName
		user.qq = params.qq
		user.email = params.email
		City city = City.findByName(params.city)
		user.city = city
		if(params.type=="货代"){
			sessionFactory.currentSession.createSQLQuery("update  front_authority_users set front_authority_id=5 where front_user_id=${params.id} and front_authority_id=2").executeUpdate()
			}else{
			sessionFactory.currentSession.createSQLQuery("update  front_authority_users set front_authority_id=2 where front_user_id=${params.id} and front_authority_id=5").executeUpdate()
			
			}
		def map = [status:"ok"]
		user.enabled = Boolean.valueOf(params.enabled)
		user.hornest = Boolean.valueOf(params.hornest)
		user.safety = Boolean.valueOf(params.safety)
		user.verified = Boolean.valueOf(params.verified)
		user.save()
		if(user.hasErrors()) {
			flash.errors =  user.errors
		}
		render map as JSON
	}
	def enable() {
		FrontUser user = FrontUser.get(params.id as Long)
		if(user) {
			user.enabled = Boolean.valueOf(params.enabled)
			user.save()
			if(user.hasErrors()) {
				flash.errors = user.errors
			} else {
				def enable = user.enabled ? '启用' : '禁用';
				flash.msgs = [
					"${user.username}${enable}成功"
				]
			}
		}
		redirect url: "/${model}/list"
	}
	
	def hornest() {
		FrontUser user = FrontUser.get(params.id as Long)
		if(user) {
			user.hornest = Boolean.valueOf(params.hornest)
			user.save()
			if(user.hasErrors()) {
				flash.errors = user.errors
			} else {
				def hornest = user.hornest ? '设置诚信' : '取消诚信';
				flash.msgs = [
					"${user.username}${hornest}成功"
				]
			}
		}
		redirect url: "/${model}/list"
	}
	
	def safety() {
		FrontUser user = FrontUser.get(params.id as Long)
		if(user) {
			user.safety = Boolean.valueOf(params.safety)
			user.save()
			if(user.hasErrors()) {
				flash.errors = user.errors
			} else {
				def safety = user.safety ? '设置诚信' : '取消诚信';
				flash.msgs = [
					"${user.username}${safety}成功"
				]
			}
		}
		redirect url: "/${model}/list"
	}
	
	def verified() {
		FrontUser user = FrontUser.get(params.id as Long)
		if(user) {
			user.verified = Boolean.valueOf(params.verified)
			user.save()
			if(user.hasErrors()) {
				flash.errors = user.errors
			} else {
				def verified = user.verified ? '设置诚信' : '取消诚信';
				flash.msgs = [
					"${user.username}${verified}成功"
				]
			}
		}
		redirect url: "/${model}/list"
	}
	
	UserService userService

	def delete() {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			for(def id in ids) {
				FrontUser user = FrontUser.get(id as Long)
				if(user) {
					FakeFrontUser fakeUser = FakeFrontUser.findByUsername(user.username)
					if(fakeUser) {
						fakeUser.registered = false
						fakeUser.save()
					}
					userService.removeFrontUser(user)
				}
			}
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}

	
	def saveBackUser(){
		//FrontUser oprUser = springSecurityService.currentUser
		
		
		FrontUser addUser = new FrontUser()
		addUser.username = params.mobile
		addUser.mobile = params.mobile
		addUser.firstname = params.username
		addUser.companyName = params.companyName
		addUser.qq = params.qq
		addUser.email = params.email
		addUser.address = params.address
		println params.cityId
		addUser.city = City.get(params.cityId as Long)
		addUser.type = params.type
		
		FrontAuthority clientAuth = FrontAuthority.findByAuthority('ROLE_CLIENT')
		FrontAuthority cargoAuth = FrontAuthority.findByAuthority('ROLE_CARGO_OWNER')
		FrontAuthority agentAuth = FrontAuthority.findByAuthority('ROLE_SHIP_AGENT')
		addUser.addToAuths(clientAuth)
		if(addUser.isCargoOwner()) {
			addUser.addToAuths(cargoAuth)
		} else {
			addUser.addToAuths(agentAuth)
		}
		addUser.comeFrom = "HTZC"
		addUser.salt =KeyGenerators.string().generateKey()
		def password ="${params.mobile}".substring("${params.mobile}".length()-6,"${params.mobile}".length())
		addUser.password = springSecurityService.encodePassword(password, addUser.salt)//"${params.mobile}".substring("${params.mobile}".length()-7,"${params.mobile}".length()-1)
		
		addUser.createBy = springSecurityService.currentUser.username
		addUser.updateBy = springSecurityService.currentUser.username
		//if( !addUser.save() ) {   addUser.errors.each {        println it   }}
		if(addUser.validate()){
		addUser.save(flush:true)
		}else{
		addUser.errors.allErrors.each {
			print it
			}
		}
		
		render (view:"saveBackUser",model:[data:addUser])
	}
	
	
	def isOldMobile(){
		println params
		def map = [:]
		FrontUser dbUser = FrontUser.findByUsername(params.mobile)
		if(dbUser) {
			render ([msg: '手机号码已经注册', status: -1] as JSON)
			return
		}else{
		render ([msg: '', status: 1] as JSON)
		return
		}
	}
	SmsService smsService
	def sendSms(){
		if(params.mobile){
		def mobiles = params.mobile.split(";")
			if(params.sendMsg=="ship"){
				for(def mobile in mobiles){
				FrontUser dbUser = FrontUser.findByUsername(mobile)
				def firstname =  dbUser.firstname
				smsService.sendMsg(mobile.trim(),"尊敬的${firstname}先生/女士，您在找船网关注的运价信息，有新的运价发布，请登录找船网运价信息查看：www.zhao-chuan.com。")
					}
				flash.msgs = ['发送成功']
			}else{
			for(def mobile in mobiles){
				FrontUser dbUser = FrontUser.findByUsername(mobile)
				def firstname =  dbUser.firstname
				smsService.sendMsg(mobile.trim(),"尊敬的${firstname}先生/女士，您在找船网关注的货盘信息，有新的货盘发布，请登录找船网货盘信息查看：www.zhao-chuan.com。")
					}
				flash.msgs = ['发送成功']
			}
		
		}else{
			flash.msgs = ['收信人手机号不能为空！！！']
		}
		redirect uri: "/${model}/list"
		
	}
	def export() {
			println "aaaaaaaaaaaaa"
			println params
			def searchKey
			if(params.searchKey) {
				searchKey = "%${params.searchKey}%"
			}
			def result = CRUDService.list(FrontUser,params){
				if(searchKey) {
					or {
						like "username", searchKey
						like "firstname", searchKey
						like "companyName", searchKey
						like "createBy", searchKey
						like "invitationCode", searchKey
					}
				}
				if(params.startDate&&params.endDate) {
					//def date2=new java.sql.Date(sdf.parse(params.endDate).getTime())
					def date1 = sdf1.parse(params.startDate)
					def date2 = sdf1.parse(params.endDate)
					and{
						between ("loginTime", date1,date2)
					}
				}else if(params.startDate) {
					def date=sdf1.parse(params.startDate)
				
						ge "loginTime", date
					
				}else if(params.endDate) {
					def date=sdf1.parse(params.endDate)
						le "loginTime", date
				
				}else {
				}
				
				if(params.createDateStart&&params.createDateEnd) {
					def date1 = sdf1.parse(params.createDateStart)
					def date2 = sdf1.parse(params.createDateEnd)
					and{
						between ("dateCreated", date1,date2)
					}
				}else if(params.startDate) {
					def date=sdf1.parse(params.startDate)
				
						ge "dateCreated", date
					
				}else if(params.endDate) {
					def date=sdf1.parse(params.endDate)
						le "dateCreated", date
				
				}else {
				}
				if(params.cityId){
					or{
						eq "city", City.get(params.cityId as Long) //params.cityId
					}
				}
				
				if(params.frontType) {
					eq "type", FrontUserType.valueOf(params.frontType)
				}
				
				if(params.comefrom){
					or{
						eq "comeFrom", params.comefrom
					}
				}
				
				if(params.selIsEnabled){
					or{
						eq "enabled", Boolean.valueOf(params.selIsEnabled)
					}
				}
				
				if(params.selIsOnline){
					or{
						eq "isOnline", Boolean.valueOf(params.selIsOnline)
					}
				}
			}
			
			println result
			def excelData = result
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmSS")
			
			String[] Title=["序号","用户名","姓名","所在地","类型","注册时间","最后登录时间","创建者","邀请码","许可","状态"];
			String fileName = sdf1.format(new Date())+"用户列表.xls"
			
			try {
				OutputStream os = response.getOutputStream();
				response.reset();
				response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("GB2312"),"ISO8859-1"));
				// 设定输出文件头
				response.setContentType("application/msexcel");
				
			   
				WritableWorkbook workbook = Workbook.createWorkbook(os);
			   
			   
				WritableSheet sheet = workbook.createSheet("用户列表", 0);
			   
				SheetSettings sheetset = sheet.getSettings();
				sheetset.setProtected(false);
				sheetset.setDefaultColumnWidth(20)
			   
				WritableFont NormalFont = new WritableFont(WritableFont.ARIAL, 10);
				WritableFont BoldFont = new WritableFont(WritableFont.ARIAL, 10,WritableFont.BOLD);
			   
				WritableCellFormat wcf_center = new WritableCellFormat(BoldFont);
				wcf_center.setBackground(Colour.LIGHT_TURQUOISE);
				wcf_center.setBorder(Border.ALL, BorderLineStyle.THIN);
				wcf_center.setVerticalAlignment(VerticalAlignment.CENTRE);
				wcf_center.setAlignment(Alignment.CENTRE);
				wcf_center.setWrap(false);
				  
				WritableCellFormat wcf_left = new WritableCellFormat(NormalFont);
				wcf_left.setBorder(Border.NONE, BorderLineStyle.THIN);
				wcf_left.setVerticalAlignment(VerticalAlignment.CENTRE);
				wcf_left.setAlignment(Alignment.LEFT);
				wcf_left.setWrap(false);
				
			   
				String s;
				for (int i = 0; i < Title.length; i++) {
				 sheet.addCell(new Label(i, 0,Title[i],wcf_center));
				}
				int i=1;
				
				for(int k = 0;k < excelData.size(); k++){
					sheet.addCell(new Label(0, k+1,k+1+"",wcf_left))
					sheet.addCell(new Label(1,k+1,excelData[k].username.toString(), wcf_left))
					sheet.addCell(new Label(2,k+1,excelData[k].firstname.toString(), wcf_left))
					sheet.addCell(new Label(3,k+1,excelData[k].city.name.toString(), wcf_left))
					sheet.addCell(new Label(4,k+1,excelData[k].type.text.toString(), wcf_left))
					sheet.addCell(new Label(5,k+1,excelData[k].dateCreated.toString(), wcf_left))
					sheet.addCell(new Label(6,k+1,excelData[k].loginOutTime.toString(), wcf_left))
					sheet.addCell(new Label(7,k+1,excelData[k].createBy.toString(), wcf_left))
					sheet.addCell(new Label(8,k+1,excelData[k].invitationCode.toString(), wcf_left))
					sheet.addCell(new Label(9,k+1,excelData[k].enabled.toString(), wcf_left))
					sheet.addCell(new Label(10,k+1,excelData[k].isOnline.toString(), wcf_left))
				}
	   
				workbook.write();
				workbook.close();
			   
			   }catch (Exception e) {
			   		e.printStackTrace();
			   }
		}
		
		def importData() {
			
			
		}

	//	def importData() {
	//		final SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
	//
	//		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery("""
	//			insert front_user(username, salt, password, email,
	//					firstname, mobile, sex, city_id,
	//					company_name, address, phone, type,
	//					account_locked_count, date_created, last_updated, create_by,
	//					update_by, enabled)
	//			values(?, ?, ?, ?,
	//				?, ?, ?, ?,
	//				?, ?, ?, ?,
	//				0, now(), now(), '${springSecurityService.currentUser.username}',
	//				'${springSecurityService.currentUser.username}', 1)
	//		""")
	//
	//
	//		importDataWithHandlerAndNativeSQL('insert front_authority_users values(?, ?)', { HSSFRow row ->
	//			FrontUser data = new FrontUser()
	//			try {
	//				data.username = row.getCell(0)?.stringCellValue?.trim() ?: null
	//			} catch(e) {
	//				data.username = row.getCell(0)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(0).numericCellValue).longValue()) : null
	//			}
	//			data.salt = KeyGenerators.string().generateKey()
	//			try {
	//				data.password = row.getCell(1)?.stringCellValue?.trim() ?: null
	//			} catch(e) {
	//				data.password = row.getCell(1)?.numericCellValue ? String.valueOf(row.getCell(1).numericCellValue) : null
	//			}
	//			data.password = springSecurityService.encodePassword(data.password, data.salt)
	//			data.email = row.getCell(2)?.stringCellValue?.trim() ?: null
	//			data.firstname = row.getCell(3)?.stringCellValue?.trim() ?: null
	//			data.mobile = data.username
	//			data.sex =  row.getCell(4)?.stringCellValue?.trim() ? Sex.getCodeByText(row.getCell(4).stringCellValue.trim()) : null
	//			data.city = row.getCell(5)?.stringCellValue?.trim() ? City.findByName(row.getCell(5).stringCellValue.trim()) : null
	//			data.companyName = row.getCell(6)?.stringCellValue?.trim() ?: null
	//			data.address = row.getCell(7)?.stringCellValue?.trim() ?: null
	//			try {
	//				data.phone = row.getCell(8)?.stringCellValue?.trim() ?: null
	//			} catch(e) {
	//				data.phone = row.getCell(8)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(8).numericCellValue).longValue()) : null
	//			}
	//			data.type = row.getCell(9)?.stringCellValue?.trim() ? FrontUserType.getCodeByText(row.getCell(9).stringCellValue.trim()) : null
	//
	//			[data.username, data.salt, data.password, data.email,
	//					data.firstname, data.mobile, data.sex?.name(), data.city?.id,
	//					data.companyName, data.address, data.phone, data.type?.name()].eachWithIndex { arg, pos ->
	//				query.setParameter(pos, arg)
	//			}
	//			query.executeUpdate()
	//
	//			data = FrontUser.findByUsername(data.username)
	//			if(!data) {
	//				throw new RuntimeException('数据有误')
	//			}
	//
	//			String type
	//			if(data.cargoOwner) {
	//				type = 'CARGO_OWNER'
	//			} else {
	//				type = 'SHIP_AGENT'
	//			}
	//
	//			return [[data.id, FrontAuthority.findByAuthority('ROLE_CLIENT')], [data.id, FrontAuthority.findByAuthority("ROLE_${type}")]]
	//		})
	//	}

	//	def downloadExample() {
	//		downloadExampleWithInfo(fileName: '前端用户上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/frontUser.xls')
	//	}
}

