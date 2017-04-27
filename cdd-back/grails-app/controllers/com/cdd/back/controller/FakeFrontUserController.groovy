package com.cdd.back.controller

import grails.plugin.springsecurity.SpringSecurityService
import java.text.SimpleDateFormat

import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem
import org.springframework.security.crypto.keygen.KeyGenerators
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.back.domain.FakeFrontUser
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontAuthority
import com.cdd.base.domain.FrontUser
import com.cdd.base.enums.FrontUserType
import com.cdd.base.enums.Sex
import com.cdd.base.exception.BusinessException
import com.cdd.base.util.CommonUtils

class FakeFrontUserController extends BaseController {
	SpringSecurityService springSecurityService
	def excludeFields = ['salt', 'password']

	def model = 'fakeFrontUser'

	def list() {
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
		
		
		
		
		def searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		render getList(model: model, domainClass: FakeFrontUser, excludeFields: excludeFields, queryHandler: {
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
			if(params.createStratDate||params.createEndDate){
				SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf3.parse(params.createStratDate);
				def date2=sdf3.parse(params.createEndDate)+1;
				
				and{
					
					 between ("dateCreated" , date1,date2)
				}
			}
			if(params.checkStartDate||params.checkEndDate){
				SimpleDateFormat sdf4 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf4.parse(params.checkStartDate);
				def date2=sdf4.parse(params.checkEndDate)+1;
				
				and{
					
					 between ("lastUpdated" , date1,date2)
				}
			}
			if(params.createBy){
				or{
					like "createBy", "%${params.createBy}%"
				}
				
			}
			if(params.checkBy){
				or{
					like "checkBy", "%${params.checkBy}%"
				}
				
			}
			if(params.type) {
				eq "type", FrontUserType.valueOf(params.type)
			}
			if(params.registered) {
				eq "registered", Boolean.valueOf(params.registered)
			}
		}) {
			item, map ->
			if(item.type == FrontUserType.Cargo) {
				map.type = '货主'
			} else if(item.type == FrontUserType.Agent) {
				map.type = '货代'
			}
			map.dateCreated = sdf.format(item.dateCreated)
		}
	}

	def data() {
		render data(model: model, menuName: '导入用户信息', domainClass: FakeFrontUser, excludeFields: excludeFields)
	}

	def importData() {
		final SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
	/*	importDataWithHandler() {
			HSSFRow row ->
			FakeFrontUser data = new FakeFrontUser()
			try {
				data.username = row.getCell(0)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.username = row.getCell(0)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(0).numericCellValue).longValue()) : null
			}
			data.salt = KeyGenerators.string().generateKey()
			try {
				data.password = row.getCell(1)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.password = row.getCell(1)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(1).numericCellValue).longValue()) : null
			}
			data.password = springSecurityService.encodePassword(data.password, data.salt)
			data.email = row.getCell(2)?.stringCellValue?.trim() ?: null
			data.firstname = row.getCell(3)?.stringCellValue?.trim() ?: null
			data.mobile = data.username
			data.sex =  row.getCell(4)?.stringCellValue?.trim() ? Sex.getCodeByText(row.getCell(4).stringCellValue.trim()) : null
			data.city = row.getCell(5)?.stringCellValue?.trim() ? City.findByName(row.getCell(5).stringCellValue.trim()) : null
			data.companyName = row.getCell(6)?.stringCellValue?.trim() ?: null
			data.address = row.getCell(7)?.stringCellValue?.trim() ?: null
			try {
				data.phone = row.getCell(8)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.phone = row.getCell(8)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(8).numericCellValue).longValue()) : null
			}
			data.type = row.getCell(9)?.stringCellValue?.trim() ? FrontUserType.getCodeByText(row.getCell(9).stringCellValue.trim()) : null
			if(!data.type) {
				throw new BusinessException('请填上用户类型：货代/货主')
			}
			data.remark = row.getCell(10)?.stringCellValue?.trim() ?: null
			return data
		}*/
		
		
		//CommonsMultipartFile file = request.getFile('file')
		
		FileInputStream fs=new FileInputStream("e://UsersData.xls")
		
		HSSFWorkbook wb = new HSSFWorkbook(fs)
		HSSFSheet sheet = wb.getSheetAt(0)
		int rowCount = sheet.physicalNumberOfRows
		def datas = []
		FileOutputStream out=new FileOutputStream("e://UsersData.xls");
		try{
		for(int i=0;i<rowCount-1;i++){
			FrontUser data = new FrontUser()
			int num = i + 1;
			HSSFRow  row = sheet.getRow(num)
			data.companyName = row.getCell(0)?.stringCellValue?.trim() ?: null
			def name = row.getCell(1)?.stringCellValue?.trim() ?: null
			//def position = row.getCell(3)?.stringCellValue?.trim() ?: null
			data.firstname = name 
			//+ position
			
			try {
				data.username = row.getCell(4)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.username = row.getCell(4)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(4).numericCellValue).longValue()) : null
			}
			
			try {
				data.phone = row.getCell(5)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.phone = row.getCell(5)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(5).numericCellValue).longValue()) : null
			}
			
			
			
			
			
			data.address = row.getCell(7)?.stringCellValue?.trim()
			data.middlename = row.getCell(9)?.stringCellValue?.trim()?: null
			data.email = row.getCell(11)?.stringCellValue?.trim()?: null
			try {
				data.qq = row.getCell(10)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.qq = row.getCell(10)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(10).numericCellValue).longValue()) : null
			}
			
			def chengshi = row.getCell(15)?.stringCellValue?.trim()
			City city = City.findByName(chengshi)
			
			data.city = city
			data.invitationCode = row.getCell(16)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(16).numericCellValue).longValue()) : null
			data.salt = KeyGenerators.string().generateKey()
			def password = "123456"
			data.password = springSecurityService.encodePassword(password, data.salt)
			data.type = "Cargo"
			FrontAuthority clientAuth = FrontAuthority.findByAuthority('ROLE_CLIENT')
			FrontAuthority cargoAuth = FrontAuthority.findByAuthority('ROLE_CARGO_OWNER')
			FrontAuthority agentAuth = FrontAuthority.findByAuthority('ROLE_SHIP_AGENT')
			data.addToAuths(clientAuth)
			if(data.isCargoOwner()) {
				data.addToAuths(cargoAuth)
			} else {
				data.addToAuths(agentAuth)
			}
			data.comeFrom = "HTZC"
			if( !data.save() ) { 
				HSSFCell cell_17 = row.createCell((short)17);
				cell_17.setCellValue("0")
				 data.errors.each {      
					   println it   
				 	}
				 }else{
				 	data.save(flush:true)
					 HSSFCell cell_17 = row.createCell((short)17);
					 cell_17.setCellValue("1")
				 }
		}
		
		out.flush();
		wb.write(out);
		}catch(IOException e){
		}
		finally{
		out.close();
		
		}
		/*FileInputStream fs=new FileInputStream("d://test.xls");  //获取d://test.xls
		POIFSFileSystem ps=new POIFSFileSystem(fs);  //使用POI提供的方法得到excel的信息
		HSSFWorkbook wb=new HSSFWorkbook(ps);
		HSSFSheet sheet=wb.getSheetAt(0);  //获取到工作表，因为一个excel可能有多个工作表
		HSSFRow row=sheet.getRow(1);  //获取第一行（excel中的行默认从0开始，所以这就是为什么，一个excel必须有字段列头），即，字段列头，便于赋值
		def aa = row.getCell(0)?.stringCellValue?.trim()
		println aa
		//System.out.println(sheet.getLastRowNum()+" "+row.getLastCellNum());  //分别得到最后一行的行号，和一条记录的最后一个单元格
		  
		FileOutputStream out=new FileOutputStream("d://test.xls");  //向d://test.xls中写数据
		row=sheet.createRow((short)(sheet.getLastRowNum()+1)); //在现有行号后追加数据
		row.createCell(0).setCellValue("leilei"); //设置第一个（从0开始）单元格的数据
		row.createCell(1).setCellValue(24); //设置第二个（从0开始）单元格的数据
  
		  
		out.flush();
		wb.write(out);
		out.close();
		//System.out.println(row.getPhysicalNumberOfCells()+" "+row.getLastCellNum());
*/	}

	def downloadExample() {
		downloadExampleWithInfo(fileName: '前端用户上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/frontUser.xls')
	}

	//	def delete() {
	//		delete(FakeFrontUser, model)
	//	}

	def transfer() {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			for(def id in ids) {
				FakeFrontUser fakeUser = FakeFrontUser.get(id as Long)
				FrontUser oldUser = FrontUser.findByUsername(fakeUser.username)
				if(oldUser) {
					fakeUser.registered = true
					fakeUser.save()
					continue
				}
				//				fakeUser.delete(flush: true)
				fakeUser.registered = true
				fakeUser.checkBy = springSecurityService.currentUser.username
				fakeUser.save()
				/*导入用户从前台剥离，核实后的fakeUser不存入frontUser中*/
				/*FrontUser user = new FrontUser(fakeUser.properties)
				if(!user.type) {
					flash.errors = [:]
					flash.errors.msgs = [
						"${fakeUser.username}没有类型，请先修改类型为货代/货主"
					]
					redirect uri: "/${model}/list"
					return
				}
				FrontAuthority clientAuth = FrontAuthority.findByAuthority('ROLE_CLIENT')
				FrontAuthority cargoAuth = FrontAuthority.findByAuthority('ROLE_CARGO_OWNER')
				FrontAuthority agentAuth = FrontAuthority.findByAuthority('ROLE_SHIP_AGENT')
				user.addToAuths(clientAuth)
				if(user.isCargoOwner()) {
					user.addToAuths(cargoAuth)
				} else {
					user.addToAuths(agentAuth)
				}
				user.createBy = fakeUser.createBy
				user.comeFrom = "D"
				
				
				user.updateBy =springSecurityService.currentUser.username
				user.save()
				if(user.hasErrors()) {
					flash.errors = user.errors
					flash.data = user
					redirect uri: "/${model}/list/"
					return
				}*/
			}
			flash.msgs = ['核实成功']
		}
		redirect uri: "/${model}/list"
	}

	def update() {
		FakeFrontUser newData = new FakeFrontUser(params)
		FakeFrontUser data = FakeFrontUser.get(params.id as Long)
		if(data) {
			data.username = newData.username
			data.mobile = newData.username
			if(params.newPassword) {
				data.password = springSecurityService.encodePassword(params.newPassword, data.salt)
			}
			data.type = newData.type
			data.firstname = newData.firstname
			data.companyName = newData.companyName
			if(params.cityId) {
				data.city = City.get(params.cityId as Long)
			} else {
				data.city = null
			}
			data.address = newData.address
			data.phone = newData.phone
			data.qq = newData.qq
			data.email = newData.email
			data.sex = newData.sex
			data.remark = newData.remark
			save(data, model)
			return
		}
		redirect uri: "/$model/list"
	}
}
