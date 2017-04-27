package com.cdd.back.controller

import java.text.SimpleDateFormat
import java.util.List;
import javax.swing.text.html.HTML

import grails.plugin.springsecurity.SpringSecurityService
import jxl.write.WritableWorkbook
import jxl.write.WritableSheet
import jxl.Cell
import jxl.Sheet
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

import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.hibernate.collection.internal.PersistentSet
import org.hibernate.criterion.Restrictions
import org.springframework.security.crypto.keygen.KeyGenerators

import com.cdd.base.domain.ClientManager
import com.cdd.base.domain.ClientType
import com.cdd.base.domain.ContactPerson
import com.cdd.base.domain.DemandClass
import com.cdd.base.domain.FrontAuthority
import com.cdd.base.exception.BusinessException
import com.cdd.base.service.common.CommonService
import com.cdd.base.util.CommonUtils
import com.cdd.base.domain.GroupManager
import com.cdd.base.domain.TagManager
import com.sun.xml.internal.bind.v2.util.DataSourceSource;

import grails.converters.JSON;
import grails.gorm.DetachedCriteria
import groovy.sql.Sql

class ClientManagerController extends BaseController {

	def model = 'clientManager'
	
	def rgbs = ["0,255,0":Colour.BLUE,"255,255,0":Colour.RED,"68,68,68":Colour.GREEN,"255,0,0":Colour.YELLOW,"166,77,166":Colour.BROWN,"0,255,255":Colour.WHITE,"192,192,192":Colour.ORANGE,"255,183,255":Colour.BLACK,"0,0,255":Colour.BLUE2]
	
	/**
	 *  query Customer
	 * @return
	 */
	def list() {
		render view : "/${model}/list"
		return 
		
	}
	
	def searchClients(){
		//def user = springSecurityService.currentUser
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
		
		if(params.pageSize && params.pageOffset){
			params.limit = Integer.parseInt(params.pageSize)
			params.offset = Integer.parseInt(params.pageOffset)
		}else{
			params.limit = 10
			params.offset = 0
		}
		params.dataType = 'json'
		
//		render getList(model: model, domainClass: ClientManager , isConjunction: true,queryHandler: { eq "delTag", 0
//			
//			if(params.search) {
//				searchKey = "%${params.search}%"
//			}
//			
//			if(searchKey) {
//				or {
//					like "firstname", searchKey
//					like "companyName", searchKey
//					like "email", searchKey
//					like "phone", searchKey
//				}
//			}
//			
//			if(params.groupid){
//				or{
//					eq "group", GroupManager.get(params.groupid as Long) //params.groupid
//				}
//			}
//			if(params.tagid){
//				or{
//					eq "tag", TagManager.get(params.tagid as long) //params.tagid
//				}
//			}
//		})
		//ContactPerson c = ContactPerson.findByPersonName(params.serachKey)
	
		
//		s = [1 as long,2 as long] 
//		for(long j: s){
//			s1.add(j)
//		}
		//ContactPerson.findByClientManager("2")
		//grails.gorm.DetachedCriteria
		def result = getList()
//		def cps =  CRUDService.list(ContactPerson,params){
//			like "personName", params.serachKey
//		}
//		List<Long> ll = new ArrayList<Long>()
//		cps.list?.collect{
//			ll << it.clientManager.id
//		}
//		def result = CRUDService.list(ClientManager,params){
//			eq "delTag" , 0
//			if(params.serachKey) {
//				or {
//					//like "contactPersons", ContactPerson.findByPersonName(params.serachKey)
//					//like "contactPersons",aa
//					like "companyName", "%"+params.serachKey+"%"
//					like "email", "%"+params.serachKey+"%"
//					like "telephone", "%"+params.serachKey+"%"
//				}
//			}
//			if(ll.size()>0){
//				or{
//					'in'("id" , ll)
//				}
//			}
//			if(params.tagName && "rgb(255, 255, 255)" != params.tagName && "transparent" != params.tagName){
//				and {
//						eq "tagManager", TagManager.findByTagName(params.tagName)
//					}		
//			}
//			if(params.demandId && "全部" != params.demandId){
//				and {
//					eq "demandClass", DemandClass.get(params.demandId as long)
//				}
//			}
//			if(params.typeId && "全部" != params.typeId ){
//				and {
//					eq "clientType", ClientType.get(params.typeId as long)
//				}
//			}
//			if(params.groupId && "全部" != params.groupId){
//				and {
//					eq "groupManager", GroupManager.get(params.groupId as long)
//				}
//			}
//		}
		Map map = [rows:[]]
		map.totalcount = result.totalCount
		result.list?.collect{
			ClientManager cm = it
			def data=[:]
			def persons = []
			data.id = it.id
			data.tagName = it.tagManager?.tagName?:"-"
			it.contactPersons?.collect{ person ->
					def cp = [:]
					cp.id =  person.id
					cp.personName = person.personName?:"-"
					cp.email = person.email?:"-"
					cp.phone = person.phone?:"-"
					cp.qq = person.qq?:"-"
					cp.tagName = person.tagName?:"-"
					persons << cp
			}
			data.companyName = it.companyName?:"-"
			data.address = it.address?:"-"
			data.telephone = it.telephone?:"-"
			data.faxes = it.faxes?:"-"
			data.postCode = it.postCode?:"-"
			data.persons = persons?:"-"
			data.demandName = it.demandClass?.demandName?:"-"
			data.typeName = it.clientType?.typeName?:"-"
			data.groupName = it.groupManager?.groupName?:"-"
			
			map.rows << data
		}
		render map as JSON
		return 
	}
		
	
/*	def groupTest(){
		CommonService  se= new CommonService()
		List<TagManager> ct =se.getTagManager()
		 for(int i=0;i<ct.size();i++){
			 TagManager  tag = ct.get(i);
		 }
		// render ([view: "/shipInfo/list", model: [rows: tag]])
		 //render tag  as JSON
	}
	*/
	
	/***
	 * save Customer
	 * @return
	 */
	def saveClient(){
		ClientManager data
		if(params.id){
			data = ClientManager.get(params.id as Long)
			data.companyName = params.companyName
			data.address = params.address
			data.telephone = params.telephone
			data.faxes = params.faxes
			//	data.properties=params
		}else{
			data = new ClientManager()
			data.companyName = params.companyName
			data.address = params.address
			data.telephone = params.telephone
			data.faxes = params.faxes
			
		}
		if(params.tagName){
			TagManager tm = TagManager.findByTagName(params.tagName)
			data.tagManager = tm
		}
		if(params.demandId && !"未分类".equals(params.demandId)){
			DemandClass dc= DemandClass.get(params.demandId as long)
			data.demandClass = dc
		}
		if(params.typeId  && !"未分类".equals(params.typeId)){
			ClientType ct = ClientType.get(params.typeId as long)
			data.clientType = ct
		}
		if(params.groupId  && !"未分类".equals(params.groupId)){
			GroupManager gm = GroupManager.get(params.groupId as long)
			data.groupManager = gm
		}
		
		//def cps = []
		if(params.count_person){
			for( int i=1;i < Integer.parseInt(params.count_person)+1; i++){
				ContactPerson cp = new ContactPerson()
				cp.personName = params["linkman_name_${i}"]
				cp.phone = params["linkman_phone_${i}"]
				cp.email = params["linkman_email_${i}"]
				cp.qq = params["linkman_qq_${i}"]
				cp.tagName = params["linkman_tagName_${i}"]
				//cp.clientManager = data
				data.addToContactPersons(cp)
				//cps << cp
			}
		}
		data.save()
		def result
		//save(data,'clientManager',params.uri)
		if(data.hasErrors()){
			println data.errors
			result = false
		}else {
			result = true
		}
		render result
		return 
	}
	
	def editClient(){
		ClientManager data
		if(params.id){
			data = ClientManager.get(params.id as Long)
			data.companyName = params.companyName
			data.address = params.address
			data.telephone = params.telephone
			data.faxes = params.faxes
			//	data.properties=params
		}else{
			data = new ClientManager()
			data.companyName = params.companyName
			data.address = params.address
			data.telephone = params.telephone
			data.faxes = params.faxes
		}
		if(params.tagName){
			TagManager tm = TagManager.findByTagName(params.tagName)
			data.tagManager = tm
		}
		if(params.demandId){
			DemandClass dc= DemandClass.get(params.demandId as long)
			data.demandClass = dc
		}
		if(params.typeId){
			ClientType ct = ClientType.get(params.typeId as long)
			data.clientType = ct
		}
		if(params.groupId){
			GroupManager gm = GroupManager.get(params.groupId as long)
			data.groupManager = gm
		}
		
		//def cps = []
		def oldCount = 0
		data.contactPersons?.clear()
		if(params.count_old_person){
			oldCount  = Integer.parseInt(params.count_old_person)
			for(int i=0; i < oldCount; i++){
				def aa = params["linkman_old_${i}"].split(",")
				ContactPerson cp = new ContactPerson()
				cp.personName = aa[0]
				cp.phone = aa[1]
				cp.email = aa[2]
				cp.qq = aa[3]
				cp.tagName = aa[4]
				data.addToContactPersons(cp)
			}
		}
		
		if(params.count_new_person){
			for( int i=oldCount+1; i < Integer.parseInt(params.count_new_person)+1+oldCount; i++){
				ContactPerson cp = new ContactPerson()
				cp.personName = params["linkman_name_${i}"]
				cp.phone = params["linkman_phone_${i}"]
				cp.email = params["linkman_email_${i}"]
				cp.qq = params["linkman_qq_${i}"]
				cp.tagName = params["linkman_tagName_${i}"]
				//cp.clientManager = data
				data.addToContactPersons(cp)
				//cps << cp
			}
		}
		
		data.save()
		def result
		//save(data,'clientManager',params.uri)
		if(data.hasErrors()){
			println data.errors
			result = false
		}else {
			result = true
		}
		render result
		return
		
	}
	
	
	def saveContact(){
		def result = false
		if(params.id){
			ClientManager cm = ClientManager.get(params.id as long)
			ContactPerson cp = new ContactPerson()
			cp.personName = params.personName
			cp.phone = params.phone
			cp.email = params.email
			cp.qq = params.qq
			cp.clientManager = cm
				
			cp.save()
			
			if(cp.hasErrors()){
				println cp.errors
				result = false
			}else {
				result = true
			}
		}
		render result
		return
	} 
	
	
	/**
	 * Add demand
	 * @return
	 */
	def saveDemand(){
		//def  demandTest  = 3
		DemandClass data
		if(params.id){
			data = DemandClass.get(params.id as Long)
			data.properties=params
		}else{
			data = new DemandClass(params)
		}
		params.uri="/demandClass/list"
		save(data,'demandClass',params.uri)
		
		//render ([view: "/demandClass/list", model: [rows: list]])
	}
	
	/***
	 * Add type
	 * @return
	 */
	def addType(){
		ClientType data
		if(params.id){
			data = ClientType.get(params.id as Long)
			data.properties=params
		}else{
			data = new ClientType(params)
		}
		params.uri="/clientType/list"
		save(data,'clientType',params.uri)
	}
		
	/***
	 * Add  tag
	 * @return
	 */
	def addTag(){
		TagManager data
		if(params.id){
			data = TagManager.get(params.id as Long)
			data.properties=params
		}else{
			data = new TagManager(params)
		}
		params.uri="/tagManager/list"
		save(data,'tagManager',params.uri)
	 }
	
	/***
	 * Add Group
	 * @return
	 */
    def data(){
		GroupManager data
		if(params.id){
			data = GroupManager.get(params.id as Long)
			data.properties=params
		}else{
			data = new GroupManager(params)
		}
		params.uri="/groupManager/list"
		save(data,'groupManager',params.uri)
	}
	

	/****
	 *  import Customer
	 * @return
	 */
	int maxSize = 1024 * 1024 * 1 // 1MB maximum
	
	def importClients() {
		
		def file = request.getFile('xls')
		
		def data  = [:]
		if(file.size > maxSize) {
			render(text: "<script>alert('文件不能超过1MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		//String name = file.fileItem.fileName
		/*if(!name.endsWith('.xls')) {
			render(text: "<script>zcAlert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}*/
		Workbook book = Workbook.getWorkbook(file.inputStream)
		Sheet sheet = book.getSheet(0)
		int rows=sheet.getRows();
		
		int columns=sheet.getColumns();
		def result = false
		def errors = []
		def success = []
		if(rows < 1) {
			render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
			return ;
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
			
			for (int i=1; i<rows; i++) {

				ClientManager  cm = new ClientManager()
				def errorRow = [:]
				def successRow = [:]
				errorRow.sequence = i
				
				for(int j=0; j < columns; j++ ){
					switch(j){
						case 1: if(sheet.getCell(j,i)?.getContents()?.trim()==null){
										errorRow.companyName  = "公司名称不能为空"
								}else if(sheet.getCell(j,i).getContents().length()>64){
										errorRow.companyName = "公司名称不能超过32个汉子或64个字符"
								}else{
										successRow.companyName = sheet.getCell(j,i).getContents()
								}
								continue;
						case 2: if(sheet.getCell(j,i)?.getContents()?.trim()==null){
										errorRow.address  = "公司地址不能为空"
								}else if(sheet.getCell(j,i).getContents()?.length()>64){
										errorRow.address = "公司地址不能超过32个汉子或64个字符"
								}else{
										successRow.address = sheet.getCell(j,i).getContents()
								}
								continue;
					
						case 3 : if(sheet.getCell(j,i)?.getContents()?.trim()==null){
									errorRow.tel = "电话不能为空"
								 }else if(sheet.getCell(j,i).getContents()?.length() > 20){
								 	errorRow.tel = "电话长度不能大于20个字符"
								 }else{
								 	successRow.tel = sheet.getCell(j,i).getContents()
								 }	
								 continue;
						case 4 : if(sheet.getCell(j,i).getContents()?.length() > 20){
								 	errorRow.faxes = "传真长度不能大于20个字符"
								 }else{
								 	successRow.faxes = sheet.getCell(j,i).getContents()
								 }	
								 continue;
						case 5: if(sheet.getCell(j,i).getContents()?.length() != 6){
									 errorRow.postCode = "邮编必须是6位数字"
								 }else{
									 try{
										 def postCode = Integer.parseInt(sheet.getCell(j,i))
										 successRow.postCode = sheet.getCell(j,i).getContents()
									 }catch(Exception e){
										 errorRow.postCode = "邮编必须由数字组成"
									 }
								 }
							 continue;
//						case 6 : if(sheet.getCell(j,i).getContents()?.length() > 20){
//								 	errorRow.email = "邮箱长度不能大于50个字符"
//								 }else{
//								 	successRow.email = sheet.getCell(j,i).getContents()
//								 }	
//								 continue;
						case 7 : if(sheet.getCell(j,i).getContents().trim()==null){
									errorRow.persons = "联系人不能为空"
								 }else if(sheet.getCell(j,i).getContents().length() > 20){
								 	errorRow.persons = "联系人名称不能超过10个汉字或20个字符，多个联系人用逗号隔开"
								 }else{
								 	successRow.persons = sheet.getCell(j,i).getContents()
								 }	
								 continue;
						default : 
								 continue;		 
					}
				}	
				success << successRow
				errors  << errorRow
			}
		}
		if(errors.size() > 0){
			data.result = false
			data.errors =  errors
		}else {
			data.result = true
			success.collect{
				ClientManager cm = new ClientManager()
				cm.companyName = it.companyName
				cm.address = it.address
				cm.postCode = it.postCode
				cm.telephone = it.tel
				cm.faxes = it.faxes
				cm.email = it.email
				def pSize = it.persons.split(",")
				for(int i = 0; i<pSize; i++){
					ContactPerson cp = new ContactPerson()
					cp.personName = it.persons[i]
					cp.tagName = "联系人 " + i
					cm.addToContactPersons(cp)
				}
				cm.save()
				if(cm.hasErrors()){
					println cm.errors
				}
			}
			//data.success =  success
		}
		render  data as JSON
	}
	
	
	
	def downloadExample() {
		String fname = new String('批量导入客户模板'.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.xls")
		response.outputStream << servletContext.getResourceAsStream("/files/clientManager.xls")
	}
	
	
	def exportClients (){
		def result = getList()
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyymmddHHMMSS")
		
		String[] Title=["序号","标签","联系人","需求","类型","群组"];
		
		String fileName = sdf1.format(new Date())+"客户.xls"
		try {
		 OutputStream os = response.getOutputStream();
		 response.reset();
		 response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("GB2312"),"ISO8859-1"));
		 // 设定输出文件头
		 response.setContentType("application/msexcel");
		 
		
		 WritableWorkbook workbook = Workbook.createWorkbook(os);
		 WritableSheet sheet = workbook.createSheet("客户", 0);
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
		// wcf_left.set
		
		 String s;
		 for (int i = 0; i < Title.length; i++) {
		  sheet.addCell(new Label(i, 0,Title[i],wcf_center));
		 }
		 //int i=1;
		// def color = ["BLUE":null,"RED":null,"GREEN":null,"BLACK":null,"ORAGE":null,"YELLOW":null]
		 for(int k = 0;k < result.size(); k++){
			
			 WritableCellFormat wcf_left1 = new WritableCellFormat(NormalFont);
			 wcf_left1.setBorder(Border.NONE, BorderLineStyle.THIN);
			 wcf_left1.setVerticalAlignment(VerticalAlignment.CENTRE);
			 wcf_left1.setAlignment(Alignment.LEFT);
			 wcf_left1.setWrap(false);
			 
			 Colour c = null
			 
			 //wcf_left1.setBackground(null)
			 StringBuffer  contactPersons = new StringBuffer("")
			 result[k].contactPersons?.collect{
				 contactPersons.append(it.personName+",")
			 }
			 
			 
			 if(result[k].tagManager){
				 def tag =  result[k].tagManager.tagName
				 
				 def arr = getRGB(tag)
				 rgbs.each{key,value ->
					 if(key.equals(arr)){
						 def col = arr.split(",")
						 workbook.setColourRGB(value,Integer.parseInt(col[0]),Integer.parseInt(col[1]),Integer.parseInt(col[2]))
						 wcf_left1.setBackground(value)
					 } 
				 }
				 
			//	 def bColor = rgb2Hex(result[k].tagManager.tagName)
//				 workbook.setColourRGB(Colour.LIGHT_BLUE, Integer.parseInt(arr[0].trim()),Integer.parseInt(arr[1].trim()), Integer.parseInt(arr[2].trim()))
//				 wcf_left1.setBackground(Colour.LIGHT_BLUE);
			 }else{
			 	 //wcf_left1.setBackground(Colour.WHITE);
			 }
			 
			 sheet.addCell(new Label(0, k+1,k+1+"",wcf_left))
			 sheet.addCell(new Label(1, k+1,result[k].tagManager?"":"-",wcf_left1))
			 sheet.addCell(new Label(1, k+1,result[k].companyName?"":"-",wcf_left))
			 sheet.addCell(new Label(2, k+1,contactPersons.toString(), wcf_left))
			 sheet.addCell(new Label(3, k+1,result[k].demandClass?.demandName?:"-", wcf_left))
			 sheet.addCell(new Label(4, k+1,result[k].clientType?.typeName?:"-", wcf_left))
			 sheet.addCell(new Label(5, k+1,result[k].groupManager?.groupName?:"-", wcf_left))
			 
//			 for(int l = 0; l <result[k].size(); l++){
//					 if(result[k][l] !=null ){
//						 sheet.addCell(new Label(l+1, k+1,result[k][l].toString(), wcf_left))
//					}else{
//						 sheet.addCell(new Label(l+1, k+1,"-", wcf_left))
//					}
//			 }
		 }

		 workbook.write();
		 workbook.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	   }
	
	
	
	
	
	/***
	 *  delete Customer
	 */
	def delete() {
		request.view = "/$model/list"
		if(params.id){
					ClientManager client = ClientManager.get(params.id as Long)
					client.delete(flush:true);
		}
		else{
			String[] ids = params.ids.split(',(\\s)*')
			if(ids) {
				def objs = []
				for(def id in ids) {
					ClientManager client = ClientManager.get(id as Long)
					client.delete(flush:true);
				}
			}
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}
	
	
	def getList(){
		
		def cps =  CRUDService.list(ContactPerson,params){
			like "personName", params.searchKey
		}
		List<Long> ll = new ArrayList<Long>()
		ll = [24L,25L]
		//def s = [1 as long,2 as long]
		
		cps.list?.collect{
			ll << it.clientManager.id
		}
		
		return  CRUDService.list(ClientManager,params){
			eq "delTag" , 0
			if(params.serachKey) {
				or {
					//like "contactPersons", ContactPerson.findByPersonName(params.serachKey)
					//like "contactPersons",aa
					like "companyName", "%"+params.searchKey+"%"
					like "email", "%"+params.searchKey+"%"
					like "telephone", "%"+params.searchKey+"%"
					'in'("id" , ll)
				}
			}
			if(params.tagName && "rgb(255, 255, 255)" != params.tagName && "transparent" != params.tagName){
				and {
						eq "tagManager", TagManager.findByTagName(params.tagName)
					}
			}
			if(params.demandId && "全部" != params.demandId){
				and {
					eq "demandClass", DemandClass.get(params.demandId as long)
				}
			}
			if(params.typeId && "全部" != params.typeId ){
				and {
					eq "clientType", ClientType.get(params.typeId as long)
				}
			}
			if(params.groupId && "全部" != params.groupId){
				and {
					eq "groupManager", GroupManager.get(params.groupId as long)
				}
			}
//			if(startDate && endDate){
//				def date1=sdf1.parse(startDate)
//				def date2=sdf1.parse(endDate)
//				and {
//					between ("searchTime", date1,date2)
//				}
//			}else if(startDate){
//				def date=sdf1.parse(startDate)
//				and {
//					between ("searchTime", date,date+1)
//				}
//			}else if(endDate){
//				def date=sdf1.parse(endDate)
//					and {
//						between ("searchTime", date,date+1)
//					}
//			}else{
//
//			}
//			if(searchSource){
//				and {
//					like "searchSource", "%"+searchSource+"%"
//				}
//			}
//			if(resultCount){
//				if(resultCount.equals('0')){
//					and{
//						eq "resultCount" , 0
//					}
//				}
//				else if(resultCount.indexOf('~')>0){
//					def countArray = resultCount.split('~')
//					and{
//						between ("resultCount" ,countArray[0] as int ,countArray[1] as int)
//					}
//				}else if(!resultCount.equals("")){
//					and {
//						gt("resultCount" , 500)
//					}
//
//				}else {
//				}
//			}
		}
		
	}
	
	def rgb2Hex(String rgb) {
		StringBuilder sb = new StringBuilder();
		
//		if (!ColorUtils.isRgb(rgb)) {
//			def msg = "颜色 RGB 格式【" + rgb + "】 不合法，请确认！";
//			println msg
//			//logger.error(msg);
//		}
		
		String r = Integer.toHexString(getRed(rgb)).toUpperCase();
		String g = Integer.toHexString(getGreen(rgb)).toUpperCase();
		String b = Integer.toHexString(getBlue(rgb)).toUpperCase();
		
		sb.append("#");
		
	//	def a = []
//		def red = r.length() == 1 ? "0" + r : r
//		def green = r.length() == 1 ? "0" +  g : g
//		def blue = b.length() == 1 ? "0" + b : b
		
		sb.append(r.length() == 1 ? "0" + r : r);
		sb.append(g.length() == 1 ? "0" + g : g);
		sb.append(b.length() == 1 ? "0" + b : b);
		return sb.toString();
	}
	
	def getRed(String rgb){
		         return Integer.valueOf(getRGB(rgb)[0].toString().trim());
		     }
	
	def getGreen(String rgb){
		
		         return Integer.valueOf(getRGB(rgb)[1].toString().trim());
     }
	
	def getBlue(String rgb){
		         return Integer.valueOf(getRGB(rgb)[2].toString().trim());
    }
	
	def  getRGB(String rgb){
		
				String a = rgb.substring(rgb.indexOf("(")+1,rgb.indexOf(")")).replaceAll("\\s+", "").trim()
				//println a
				return a
				//return a.split(",")
	 }
	
//	public static boolean isRgb(String rgb) {
//		        boolean r = getRed(rgb) >= 0 && ColorUtils.getRed(rgb) <= 255;
//		         boolean g = getGreen(rgb) >= 0 && ColorUtils.getGreen(rgb) <= 255;
//		        boolean b = getBlue(rgb) >= 0 && ColorUtils.getBlue(rgb) <= 255;
//		       return isRgbFormat(rgb) && r && g && b;
//	}
	
}
