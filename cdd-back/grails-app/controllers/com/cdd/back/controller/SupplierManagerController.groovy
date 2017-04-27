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

import com.cdd.base.domain.NewRoute
import com.cdd.base.domain.SupplierManager
import com.cdd.base.domain.SupplierLevel
import com.cdd.base.domain.SupplierPerson
import com.cdd.base.domain.SupplierAccount
import com.cdd.base.domain.FrontAuthority
import com.cdd.base.exception.BusinessException
import com.cdd.base.service.common.CommonService
import com.cdd.base.util.CommonUtils
import com.cdd.base.domain.SupplierGroup
import com.cdd.base.domain.SupplierTag
import com.sun.xml.internal.bind.v2.util.DataSourceSource;

import grails.converters.JSON;
import grails.gorm.DetachedCriteria
import groovy.sql.Sql

class SupplierManagerController extends BaseController {

	def model = 'supplierManager'
	
	def rgbs = ["0,255,0":Colour.BLUE,"255,255,0":Colour.RED,"68,68,68":Colour.GREEN,"255,0,0":Colour.YELLOW,"166,77,166":Colour.BROWN,"0,255,255":Colour.WHITE,"192,192,192":Colour.ORANGE,"255,183,255":Colour.BLACK,"0,0,255":Colour.BLUE2]
	
	/**
	 *  query Customer
	 * @return
	 */
	def list() {
		render view : "/${model}/list"
		return
		
	}
	def searchSuppliers(){
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
		

		def result = getList()
		Map map = [rows:[]]
		map.totalcount = result.totalCount
		result.list?.collect{
			SupplierManager cm = it
			def data=[:]
			def persons = []
			data.id = it.id
			data.tagName = it.supplierTag?.tagName?:"-"
			it.supplierPersons?.collect{ person ->
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
			data.phone = it.phone?:"-"
			data.faxes = it.faxes?:"-"
			data.postCode = it.postCode?:"-"
			data.persons = persons?:"-"
			data.accountName = it.supplierAccount?.accountName?:"-"
			data.levelName = it.supplierLevel?.levelName?:"-"
			data.groupName = it.supplierGroup?.groupName?:"-"
			data.routes = []
			it.routes?.collect{route ->
				data.routes.add(route.routeName)
			}
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
	def saveSupplier(){
		SupplierManager data
		if(params.id){
			data = supplierManager.get(params.id as Long)
			data.routes = []
			//	data.properties=params
		}else{
			data = new SupplierManager()
		}
		
		data.companyName = params.companyName
		data.address = params.address
		data.phone = params.phone
		data.faxes = params.faxes
		data.postCode = params.postCode
		if(params.tagName){
			SupplierTag st = SupplierTag.findByTagName(params.tagName)
			data.supplierTag = st
		}
		if(params.accountId && !"未分类".equals(params.accountId)){
			SupplierAccount sa= SupplierAccount.get(params.accountId as long)
			data.supplierAccount = sa
		}
		if(params.levelId  && !"未分类".equals(params.levelId)){
			SupplierLevel sl = SupplierLevel.get(params.levelId as long)
			data.supplierLevel = sl
		}
		if(params.groupId  && !"未分类".equals(params.groupId)){
			SupplierGroup sg = SupplierGroup.get(params.groupId as long)
			data.supplierGroup = sg
		}
		if(params.routes){
			//List<NewRoute> routeList1 = new ArrayList<NewRoute>();
			//List<SupplierManager> userList = new ArrayList<SupplierManager>();
			//userList.add(data)
			def routeList  = params.routes.split(",")
			NewRoute route1
			routeList.collect{
				route1= NewRoute.findByRouteName(it)
				data.addToRoutes(route1)
				//routeList1.add(route1)
			}
		}
		//def cps = []
		if(params.count_person){
			for( int i=1;i < Integer.parseInt(params.count_person)+1; i++){
				SupplierPerson sp = new SupplierPerson()
				sp.personName = params["linkman_name_${i}"]
				sp.phone = params["linkman_phone_${i}"]
				sp.email = params["linkman_email_${i}"]
				sp.qq = params["linkman_qq_${i}"]
				sp.tagName = params["linkman_tagName_${i}"]
				//cp.clientManager = data
				data.addToSupplierPersons(sp)
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
	
	
	def editSupplier(){
		SupplierManager data
		if(params.id){
			data = SupplierManager.get(params.id as Long)
			data.routes = []
			//	data.properties=params
		}else{
			data = new SupplierManager()
			
		}
		
		data.companyName = params.companyName
		data.address = params.address
		data.phone = params.phone
		data.faxes = params.faxes
		if(params.tagName){
			SupplierTag st = SupplierTag.findByTagName(params.tagName)
			data.supplierTag = st
		}
		
		if(params.accountId && !"未分类".equals(params.accountId)){
			SupplierAccount sa= SupplierAccount.get(params.accountId as long)
			data.supplierAccount = sa
		}
		if(params.levelId  && !"未分类".equals(params.levelId)){
			SupplierLevel sl = SupplierLevel.get(params.levelId as long)
			data.supplierLevel = sl
		}
		if(params.groupId  && !"未分类".equals(params.groupId)){
			SupplierGroup sg = SupplierGroup.get(params.groupId as long)
			data.supplierGroup = sg
		}
		if(params.routes){
			//List<NewRoute> routeList1 = new ArrayList<NewRoute>();
			//List<SupplierManager> userList = new ArrayList<SupplierManager>();
			//userList.add(data)
			def routeList  = params.routes.split(",")
			NewRoute route1
			routeList.collect{
				route1= NewRoute.findByRouteName(it)
				data.addToRoutes(route1)
			}
		}
		//def cps = []
		def oldCount = 0
		data.supplierPersons?.clear()
		if(params.count_old_person){
			oldCount  = Integer.parseInt(params.count_old_person)
			for(int i=0; i < oldCount; i++){
				def aa = params["linkman_old_${i}"].split(",")
				SupplierPerson sp = new SupplierPerson()
				sp.personName = aa[0]
				sp.phone = aa[1]
				sp.email = aa[2]
				sp.qq = aa[3]
				sp.tagName = aa[4]
				data.addToSupplierPersons(sp)
			}
		}
		
		if(params.count_new_person){
			for( int i=oldCount+1; i < Integer.parseInt(params.count_new_person)+1+oldCount; i++){
				SupplierPerson sp1 = new SupplierPerson()
				sp1.personName = params["linkman_name_${i}"]
				sp1.phone = params["linkman_phone_${i}"]
				sp1.email = params["linkman_email_${i}"]
				sp1.qq = params["linkman_qq_${i}"]
				sp1.tagName = params["linkman_tagName_${i}"]
				//cp.clientManager = data
				data.addToSupplierPersons(sp1)
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
	
	
	def saveSupplierPerson(){
		def result = false
		if(params.id){
			SupplierManager sm= SupplierManager.get(params.id as long)
			int countPerson = sm.supplierPersons?.size()
			SupplierPerson sp = new SupplierPerson()
			sp.personName = params.personName
			sp.phone = params.phone
			sp.email = params.email
			sp.qq = params.qq
			sp.supplierManager = sm
			sp.tagName = "联系人  " + (countPerson+1)
			sp.save()
			
			if(sp.hasErrors()){
				println sp.errors
				result = false
			}else {
				result = true
			}
		}
		render result
		return
	}
	

	/****
	 *  import Customer
	 * @return
	 */
	int maxSize = 1024 * 1024 * 1 // 1MB maximum
	
	def importSuppliers() {
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
					    case 5 : if(sheet.getCell(j,i).getContents()?.length() != 6){
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
//									 errorRow.email = "邮编长度不能大于50个字符"
//								 }else{
//									 successRow.email = sheet.getCell(j,i).getContents()
//								 }
//								 continue;
						case 6 : if(sheet.getCell(j,i).getContents().trim()==null){
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
				SupplierManager cm = new SupplierManager()
				cm.companyName = it.companyName
				cm.address = it.address
				cm.postCode = it.postCode
				cm.telephone = it.tel
				cm.faxes = it.faxes
				cm.email = it.email
				def pSize = it.persons.split(",")
				for(int i = 0; i<pSize; i++){
					SupplierPerson cp = new SupplierPerson()
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
		String fname = new String('批量导入供应商模板'.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.xls")
		response.outputStream << servletContext.getResourceAsStream("/files/supplierManager.xls")
	}
	
	
	def exportSuppliers (){
		
		def result = getList()
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyymmddHHMMSS")
		
		String[] Title=["序号","标签","公司名称","优势航线","联系人","账期","级别","群组"];
		
		String fileName = sdf1.format(new Date())+"供应商.xls"
		try {
		 OutputStream os = response.getOutputStream();
		 response.reset();
		 response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("GB2312"),"ISO8859-1"));
		 // 设定输出文件头
		 response.setContentType("application/msexcel");
		 
		
		 WritableWorkbook workbook = Workbook.createWorkbook(os);
		 WritableSheet sheet = workbook.createSheet("供应商", 0);
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
			 StringBuffer  supplierPersons = new StringBuffer("")
			 result[k].supplierPersons?.collect{
				 supplierPersons.append(it.personName+",")
			 }
			 
			 
			 StringBuffer  routes = new StringBuffer("")
			 result[k].routes?.collect{
				 routes.append(it.routeName+",")
			 }
			 
			 
			 if(result[k].supplierTag){
				 def tag =  result[k].supplierTag.tagName
				 
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
			 sheet.addCell(new Label(1, k+1,result[k].supplierTag?"":"-",wcf_left1))
			 sheet.addCell(new Label(2, k+1,result[k].companyName?"":"-",wcf_left))
			 sheet.addCell(new Label(3, k+1,routes.toString(),wcf_left))
			 sheet.addCell(new Label(4, k+1,supplierPersons.toString(), wcf_left))
			 sheet.addCell(new Label(5, k+1,result[k].supplierAccount?.accountName?:'-', wcf_left))
			 sheet.addCell(new Label(6, k+1,result[k].supplierLevel?.levelName?:"-", wcf_left))
			 sheet.addCell(new Label(7, k+1,result[k].supplierGroup?.groupName?:"-", wcf_left))
			 
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
	
	
	
	
	def getList(){
		
		def cps =  CRUDService.list(SupplierPerson,params){
			like "personName", params.serachKey
		}
		
		//def s = [1 as long,2 as long]
		List<Long> ll = new ArrayList<Long>()
		cps.list?.collect{
			ll << it.SupplierManager.id
		}
		
		return  CRUDService.list(SupplierManager,params){
			eq "delTag" , 0
			if(params.serachKey) {
				or {
					//like "contactPersons", ContactPerson.findByPersonName(params.serachKey)
					//like "contactPersons",aa
					like "companyName", "%"+params.serachKey+"%"
					like "email", "%"+params.serachKey+"%"
					like "phone", "%"+params.serachKey+"%"
					'in'("id" , ll)
				}
			}
			if(params.tagName && "rgb(255, 255, 255)" != params.tagName && "transparent" != params.tagName){
				and {
						eq "supplierTag", SupplierTag.findByTagName(params.tagName)
					}
			}
			if(params.accountId && "全部" != params.accountId){
				and {
					eq "supplierAccount", SupplierAccount.get(params.accountId as long)
				}
			}
			if(params.levelId && "全部" != params.levelId ){
				and {
					eq "supplierLevel", SupplierLevel.get(params.levelId as long)
				}
			}
			if(params.groupId && "全部" != params.groupId){
				and {
					eq "supplierGroup", SupplierGroup.get(params.groupId as long)
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
