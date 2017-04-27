package com.cdd.back.controller

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService;

import java.text.SimpleDateFormat

import grails.plugin.springsecurity.annotation.Secured

import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontUser;
import com.cdd.base.domain.SearchLog
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.enums.FrontUserType;
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.sun.jndi.toolkit.ctx.Continuation;
import com.cdd.base.util.CommonUtils
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.JsonParser

class ShipInfoController extends BaseController {
	SpringSecurityService springSecurityService
	
	def model = 'shipInfo'
	def limit = 10
	def offset = 0
	def state = false
	SimpleDateFormat sdf1 = new SimpleDateFormat('yyyy-MM-dd')
	
	def findStratEnd() {
		String start
		String end
		if(params.start){
			start=params.start
		}
		if(params.end){
			end=params.end
		}
		def result = CRUDService.list(CargoShipInformation, params) {
			if(start){
				and {
					like "startPort", start
				}
			}
			if(end){
				and {
					like "endPort", end
				}
			}
			eq 'deleted', false
		}

		def map = [rows: [], total: result.totalCount]
		result.list.each { CargoShipInformation info ->
			def data = [:]
			data.id = info.id
			data.routeName = info.routeName
			data.companyName = info.companyName
			data.contactName = info.contactName
			data.city = info.city
			data.startPort = info.startPort
			data.endPort = info.endPort
			data.service = info.service
			map.rows << data
		}
//		println map
		render (view:'list',model:map)
	}

	def list() {
		def nowDate = new Date()
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		params.dataType = 'json'
		if(params.offset == null && params.limit == null){
			params.offset = offset
			params.limit = limit
		}
		
	println params
		//params.order = "desc"
//		if(params.dataType != 'json') {
//			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
//			return
//		} 
//		String start
//		String end
		//String middle
		//String box
//		def transType
//		if(params.start){
//			startPort=params.start.toUpperCase()
//		}
//		if(params.end){
//			end=params.end.toUpperCase()
//		}
//		if(params.middle){
//			middle=params.middle.toUpperCase()
//		}
		/*if(params.box){
			box=params.box.toLowerCase()
			switch(box){
				case "z":
				transType=TransportationType.Whole;
				break;
				case "p":
				transType=TransportationType.Together;
				break;
			}
			print box+":box"
		}*/
//		if(params.transType){
//			//print params.transType
//			switch(params.transType){
//				case "Whole":
//				transType=TransportationType.Whole;
//				break;
//				case "Together":
//				transType=TransportationType.Together;
//				break;
//			}
//		}
//		String searchKey
//		if(params.search) {
//			searchKey = "%${params.search}%"
//		}
		switch(params.sort) {
			case 'gp20': params.sort = "prices.gp20"
				break
			case 'gp40': params.sort = "prices.gp40"
				break
			case 'hq40': params.sort = "prices.hq40"
				break
			case 'hq45': params.sort = "prices.hq45"
				break
			case 'time': params.sort = "endDate"
		}

		def result = CRUDService.list(CargoShipInformation, params) {
//			if(params.status) {
//				print params.status
//				eq "status", Status.valueOf(params.status)
//			}
			//eq "service", springSecurityService.currentUser
//			if(searchKey) {
//				or {
//					like "routeName", searchKey
//					like "companyName", searchKey
//					like "contactName", searchKey
//				}
//			}
//			if(params.yjnumber){
//				or {
//					eq "id", params.yjnumber as Long
//				}
//			}
//			if(params.createman){
//				and{
//					like "createBy", "%${params.createman}%"
//				}
//			}
//			if(params.createtime){
//				and{
//					SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
//					def date1=sdf5.parse(params.createtime)
//					def date2=sdf5.parse(params.createtime)+1
//					between ("dateCreated", date1,date2)
//				}
//			}
//			if(params.hx){
//				and{
//					like "routeName",params.hx+"%"
//				}
//			}
			ge 'endDate', nowDate
//			if(params.companyName){
//				and{
//					like "companyName","%"+params.companyName+"%"
//				}
//			}
			if(params.shipCompany){
				and{
					like "shipCompany","%"+params.shipCompany+"%"
				}
			}
			
			if(params.startPort){
				and {
					like "startPort", "%"+params.startPort.toUpperCase()+"%"
				}
			}
			
			if(params.endPort){
				and {
					like "endPort", "%"+params.endPort.toUpperCase()+"%"
				}
			}
//			if(middle){
//				//print middle
//				and{
//					like "middlePort",middle+"%"
//				}
//			}
//			if(end){
//				and {
//					like "endPort", end+"%"
//				}
//			}
//			if(transType){
//				and {
//					eq "transType", transType
//				}
//			}
//			if(params.hc){
//				and{
//					eq "shippingDays",params.hc as int
//				}
//			}
//			if(params.cityId){
//				and{
//					eq "city", City.get(params.cityId as Long) //params.cityId
//				}
//			}
//			if(params.contact){
//				and{
//					like "contactName", "%${params.contact}%"
//				}
//			}
			if(params.startDate && params.endDate){
				def date1=sdf1.parse(params.startDate)
				def date2=sdf1.parse(params.endDate)
				and {
				   le "startDate", date1
				   and{
					   ge "endDate", date2
				   }
				}
				or {
					ge "startDate", date1
					and{
						le "endDate", date2
					}
				}
			}else if(params.startDate){
				def date = sdf1.parse(params.startDate)
				and {
					le "startDate", date
					and{
						ge "endDate", date
					}
				}
			}else if(params.endDate){
				def date=sdf1.parse(params.endDate)
					and {
						le "startDate", date
						and{
							ge "endDate", date
						}
				}
			}else{
			
			}
			eq 'deleted', false
			
			if(params.priceType=="forInner"){
				and{
					eq 'fromBy',"商务"
				}
			}
			
			if(params.priceType=="forFront"){
				and{
					notEqual 'fromBy',"商务"
				}
			}
		}

		def map = [rows: [], total: result.totalCount,user:[:]]
		result.list.each { CargoShipInformation info ->
			def data = [:]
			data.id = info.id
			data.routeName = info.routeName
			data.companyName = info.companyName
			data.contactName = info.contactName
			data.city = info.city
			data.startPort = info.startPort
			data.endPort = info.endPort
			data.service = info.service
			data.shipCompany = info.shipCompany
			data.createBy=info.createBy
			data.fromBy = info.fromBy
			data.startDate = sdf.format(info.startDate)
			data.endDate = sdf.format(info.endDate)
			data.dateCreated=sdf.format(info.dateCreated)
			data.shippingDay = info.shippingDay
			if (info.prices) {
				if (info.prices.gp20) {
					data.gp20 = info.prices.gp20
				}
				if (info.prices.gp20Vip) {
					data.gp20Vip = info.prices.gp20Vip
				}
				if (info.prices.gp40) {
					data.gp40 = info.prices.gp40
				}
				if (info.prices.gp40Vip) {
					data.gp40Vip = info.prices.gp40Vip
				}
				if (info.prices.hq40) {
					data.hq40 = info.prices.hq40
				}
				if (info.prices.hq40Vip) {
					data.hq40Vip = info.prices.hq40Vip
				}
				if (info.prices.extra) {
					data.extra = info.prices.extra
				}
			}
			
			map.rows << data
		}
		def user = springSecurityService.currentUser
		map.user.role= user.role.name
		map.user.name= user.firstname
		map.user.mobile = user.mobile
		map.user.email = user.email
		
		if(!params.state){
			render view:"/${model}/list" ,model:[map:map]
		}else{

			render map as JSON
		}
		
	}
	
	def saveInfoConsuming(){
		if((params.startPort != null && params.startPort.trim() != "") || (params.endPort != null && params.endPort.trim() != "") ||(params.shipCompany != null && params.shipCompany.trim() != "")){
			saveSearchLog(params)
		}
		render null
	}

	private saveSearchLog(Map params) {
		def user = springSecurityService.currentUser
		SearchLog sl = new SearchLog();
		sl.startPort = params.startPort
		sl.endPort = params.endPort
		sl.shipCompany = params.shipCompany?params.shipCompany:"-"
		sl.resultCount = params.resultCount as int
		sl.searchUser = user.username
		sl.deleted = false
		sl.searchTime = new Date()
		sl.searchSource = "后台"
		sl.consuming = params.consuming+"s";
		sl.save();
		if(sl.hasErrors()) {
			log.info "ERROE: "+sl.errors
		} else {
			log.info "SUCCESS: save this Record"
		}
	}
	
	
	def data() {
		def data
		params.dataType = 'json'
		if(params.id != 'new') {
			data = CargoShipInformation.get(params.id as Long)
		} else {
			data = flash.data ?: CargoShipInformation.newInstance()
		}
		if(params.dataType == 'json') {
			//render (CommonUtils.tranferToMap(data) as JSON)
			Map map = [:]
			render ([cargo:data,prices:data.prices] as JSON) 
			
		} else {
		
		}
	}

	def edit() {
		def data
		if(params.id != 'new') {
			data = CargoShipInformation.get(params.id as Long)
		} else {
			data = flash.data ?: new CargoShipInformation()
		}
		render view: "/${model}/edit", model: [data: data, settings: getSettings(getMenu('货代信息', "/${model}/list"))]
	}

	def save() {
		CargoShipInformation data
		if(params.id) {
			data = CargoShipInformation.get(params.id as Long)
			CargoShipInformation newData = new CargoShipInformation(params)
			data.companyName=newData.companyName
			data.startPort = newData.startPort
			data.endPort = newData.endPort
			data.middlePort = newData.middlePort
			data.transType = newData.transType
			data.routeName = newData.routeName
			data.endDate = newData.endDate
			data.startDate = newData.startDate
			data.shipCompany = newData.shipCompany
			data.shippingDay = newData.shippingDay
			data.shippingDays = newData.shippingDays
			data.memo = newData.memo
			data.remark = newData.remark
			data.address = newData.address
			data.routeName = newData.routeName
			data.contactName = newData.contactName
			data.phone = newData.phone
			data.startPortCn = newData.startPortCn
			data.endPortCn = newData.endPortCn
			data.middlePortCn = newData.middlePortCn
			data.weightLimit = newData.weightLimit
			data.showOnIndex = newData.showOnIndex
			data.pinServiceType = newData.pinServiceType
			if(params.serviceId) {
				data.service = BackUser.get(params.serviceId as Long)
			}
		} else {
			data = new CargoShipInformation(params)
			data.status = Status.VerifyPassed
		}
		if(params.cityId) {
			data.city = City.get(params.cityId as Long)
		} else {
			data.city = null
		}
		ShippingPrices newPrices = new ShippingPrices(params)
		if(!newPrices.hasErrors()) {
			if(data.id) {
				data.prices = ShippingPrices.findByInfo(data)
				if(data.prices) {
					data.prices.gp20 = newPrices.gp20
					data.prices.gp20Vip = newPrices.gp20Vip
					data.prices.gp40 = newPrices.gp40
					data.prices.gp40Vip = newPrices.gp40Vip
					data.prices.hq40 = newPrices.hq40
					data.prices.hq40Vip = newPrices.hq40Vip
					data.prices.hq45 = newPrices.hq45
					data.prices.extra = newPrices.extra
					data.prices.cbm = newPrices.cbm
					data.prices.lowestCost = newPrices.lowestCost
				} else {
					data.prices = newPrices
				}
			} else {
				data.prices = newPrices
			}

			data.save()
			if(data.hasErrors()) {
				flash.errors = data.errors
				flash.data = data
				redirect uri: "/${model}/edit/" + (data.id ?: 'new')
			} else {
				flash.msgs = ['保存成功']
				redirect uri: "/${model}/list"
			}
		} else {
			flash.errors = newPrices.errors
			flash.data = data
			redirect uri: "/${model}/edit/" + (data.id ?: 'new')
		}
	}

	/***
	 * 批量运价导入
	 * @return
	 */
	
	int maxSize = 1024 * 1024 * 10 // 1MB maximum

	@Secured('ROLE_SHIP_AGENT')
	def importData() {
		
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
				def releaseNum = sdf1.format(new Date())
			
			def fUser = FrontUser.findByMobile(params.mobile as String)
			if (!fUser || fUser.type != FrontUserType.Agent) {
				CargoShipInformation data = new CargoShipInformation();
				data.status = Status.VerifyFailed;
				render(text: "<script>alert('上传失败, 请输入正确用户名或货代用户 ');</script>", contentType: "text/html", encoding: "UTF-8")
				return data 
			}
			CommonsMultipartFile file = request.getFile('file')
	
			if(file.size > maxSize) {
				render(text: "<script>alert('文件不能超过10MB');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}
			
			String name = file.fileItem.fileName
			if(!name){
				render(text: "<script>alert('请选择文件');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}
			if(!name.endsWith('.xls')) {
				render(text: "<script>alert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}
			
			HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
			HSSFSheet sheet = wb.getSheetAt(0)
			int rowCount = sheet.physicalNumberOfRows
			
			List<String>  errorInfo = new ArrayList<String>();
			
			if(rowCount < 1){
				render(text: "<script>alert('没有符合规则记录上传')</script>", contentType:"text/html" , encoding:"UTF-8")
				return
			}else{
				def datas = []
				
				String msg  //公共字段
				
				String sumCount     //总和
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
				
				for(int i=0;i<rowCount-1;i++){
					
					CargoShipInformation data = new CargoShipInformation()
					
					int num = i + 1;
					
					HSSFRow  row = sheet.getRow(num)
					
					try {
						String routeName = row.getCell(0)?.stringCellValue?:null
						if (routeName?.length() > 255){
							msg = "第${num+1}行[航线名称]不能超过255个字符"
							errorInfo.add(msg);
							//routeNameSize = msg
						}
						data.routeName = routeName
					} catch (e) {
						msg = "第${num+1}行[航线名称]单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
						//routeNameFormat=msg
					}
					try{
						String startPort = row.getCell(1)?.stringCellValue.toString().toUpperCase()?:null 
						if(!startPort){
							  msg = "第${num+1}行[起始港]不能为空!"
							  errorInfo.add(msg);
							  //portone=msg
						}
						else if(startPort?.length() > 255){
							msg = "第${num+1}行[起始港]不能超过255个字符 "
							errorInfo.add(msg);
							//startPortSize=msg
						}
						data.startPort = startPort
					}catch(e){
						msg = "第${num+1}行[起始港]单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
						//startPortFormat=msg
					}
					
					try{
						String endPort = row.getCell(2)?.stringCellValue.toString().toUpperCase()?:null
						if(!endPort){
							msg = "第${num+1}行[目的港]不能为空!" 
							errorInfo.add(msg);
							//porttwo=msg
						} 
						else if(endPort?.length() > 255){
							msg = "<script>alert('第${num+1}行[目的港]不能超过255个字符')</script>"
							errorInfo.add(msg);
							//endPortSize=msg
						}
						data.endPort = endPort
					}catch(e){
						msg = "第${num+1}行[目的港]单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
						//endPortFormat=msg
					}
					
					try {
						String middlePort = row.getCell(3)?.stringCellValue.toString().toUpperCase()?:null
						if(middlePort?.length() > 255) {
							msg = "第${num+1}行[中转港]不能超过255个字符 "
							errorInfo.add(msg);
							//middlePortSize=msg
						}
						data.middlePort = middlePort
					} catch(e) {
						//msg = "<script>alert('第${num+1}行[中转港]单元格格式有误，请使用文本格式');</script>"
						  msg ="第${num+1}行[中转港]单元格格式有误，请使用文本格式"
						  errorInfo.add(msg);
						  //middlePortFormat=msg
					}
					
					try {
						String shipCompany = row.getCell(4)?.stringCellValue?:null;
						if(!shipCompany){
							msg = "第${num+1}行[船公司]不能为空"
							errorInfo.add(msg);
							//porttherr = msg
						} 
						else if(shipCompany?.length() > 255) {
							msg = "第${num+1}行[船公司]不能超过255个字符"
							errorInfo.add(msg);
							//shipCompanySize=msg
						}
						data.shipCompany = shipCompany
					} catch(e) {
						msg = "第${num+1}行[船公司]单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
						//shipCompanyFormat=msg
					}
					
					try {
						String shippingDay
						try {
							shippingDay = row.getCell(5)?.stringCellValue?:null;
						} catch(e) {
							shippingDay = row.getCell(5)?.dateCellValue ? sdf.format(row.getCell(5).dateCellValue) : null
						}
						if(!shippingDay) {
							msg = "第${num+1}行[船期]不能为空"
							errorInfo.add(msg);
							//portfour=msg
						}
						 else if(shippingDay.length() > 255) {
							msg = "第${num+1}行[船期]不能超过255个字符 "
							errorInfo.add(msg);
							//shippingDaySize=msg
						}
						data.shippingDay = shippingDay
					} catch(e) {
						msg = "第${num+1}行[船期]单元格格式有误，请使用文本格式或日期格式 "
						errorInfo.add(msg);
						//shippingDayFormat=msg
						
					}
	
					data.owner = fUser;
					
					Double shippingDays
					try {
						shippingDays = row.getCell(6)?.numericCellValue ?: null;
					} catch(e) {
						try {
							shippingDays = row.getCell(6)?.stringCellValue ? Double.valueOf(row.getCell(6).stringCellValue) : null
						} catch(e1) {
							msg = "第${num+1}行[航程]单元格格式有误，请使用文本格式或数字格式 "
							errorInfo.add(msg);
							//shippingDaysForamt=msg
						}
					}
					data.shippingDays = shippingDays
					
					try {
						String transType = row.getCell(7)?.stringCellValue?:null;
						if(!transType) {
							msg = "第${num+1}行[运输类别]不能为空 "
							errorInfo.add(msg);
							//portfive=msg
						}
						try {
							data.transType = TransportationType.getCodeByText(transType)
							if(!data.transType) {
								throw new RuntimeException()
							}
						} catch(e) {
							msg = "第${num+1}行[运输类别]内容有误，请使用有效文本：整箱 | 拼箱 " 
							//transTypecontent=msg
							errorInfo.add(msg);
						}
					} catch(e) {
						msg = "<script>alert('第${num+1}行[运输类别]单元格格式有误，请使用文本格式');</script>"
						//transTypeFormat=msg
						errorInfo.add(msg);
					}
					
					Date startDate
					try {
						startDate = row.getCell(8)?.dateCellValue ?: null
						if(!startDate) {
							msg = "第${num+1}行[有效期开始日期]不能为空 "
							errorInfo.add(msg);
							//portsix = msg
						}
					} catch(e) {
						try {
							startDate = row.getCell(8)?.stringCellValue ? sdf.parse(row.getCell(8).stringCellValue): null
						} catch(e1) {
							  msg = "第${num+1}行[有效期开始日期]格式有误，有效格式：2016-01-01"
							  errorInfo.add(msg);
							  //startDateFormat=msg
						}
						if(!startDate) {
							msg = "第${num+1}行[有效期开始日期]不能为空"
							errorInfo.add(msg);
							//portsix=msg
						}
					}
					data.startDate = startDate
	
					Date endDate
					try {
						endDate = row.getCell(9)?.dateCellValue ?: null
						if(!endDate) {
							msg = "第${num+1}行[有效期结束日期]不能为空"
							errorInfo.add(msg);
							//portseven=msg
						}
					} catch(e) {
						try {
							endDate = row.getCell(9)?.stringCellValue ? sdf.parse(row.getCell(9).stringCellValue): null
						} catch(e1) {
							msg = "第${num+1}行[有效期结束日期]格式有误，有效格式：2016-01-01"
							errorInfo.add(msg);
							//endDateFormat=msg
							
						}
						if(!endDate) {
							msg = "第${num+1}行[有效期结束日期]不能为空 "
							errorInfo.add(msg);
							//portseven=msg
						}
					}
					data.endDate = endDate
					
					try {
						String remark = row.getCell(10)?.stringCellValue?:null;
						if(remark?.length() > 500) {
							msg = "第${num+1}行[备注]不能超过500个字符 "
							errorInfo.add(msg);
							//remarkSize=msg
						}
						data.remark = remark
					} catch(e) {
						msg = "第${num+1}行[备注]单元格格式有误，请使用文本格式')"
						errorInfo.add(msg);
						//remarkFormat=msg
					}
	
					
					def priceParams = [:]
					
						if(TransportationType.Whole == data.transType) {
							BigDecimal gp20
							try {
								gp20 = row.getCell(11)?.numericCellValue ? new BigDecimal(row.getCell(11).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行[USD/20GP]单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
								//gp20Foramt=msg
							}
							if(gp20) {
								priceParams.gp20 = gp20
							}
							
							BigDecimal gp20Vip
							try {
								gp20Vip = row.getCell(12)?.numericCellValue ? new BigDecimal(row.getCell(12).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行[USD/20GPVIP]单元格格式有误，请使用文本格式 "
								errorInfo.add(msg);
								//gp20VipFormat=msg
							}
							if(gp20Vip) {
								priceParams.gp20Vip = gp20Vip
							}
							BigDecimal gp40
							try {
								gp40 = row.getCell(13)?.numericCellValue ? new BigDecimal(row.getCell(13).numericCellValue) : null;
							} catch(e) {
								 msg = "第${num+1}行[USD/40GP]单元格格式有误，请使用文本格式 "
								 errorInfo.add(msg);
								 //gp40Format=msg
							}
							if(gp40) {
								priceParams.gp40 = gp40
							}
							
							BigDecimal gp40Vip
							try {
								gp40Vip = row.getCell(14)?.numericCellValue ? new BigDecimal(row.getCell(14).numericCellValue) : null;
							} catch(e) {
								 msg = "第${num+1}行[USD/40GPVIP]单元格格式有误，请使用文本格式 "
								 errorInfo.add(msg);
								 //gp40VipFormat=msg
							}
							if(gp40Vip) {
								priceParams.gp40Vip = gp40Vip
							}
							
							BigDecimal hq40
							try {
								hq40 = row.getCell(15)?.numericCellValue ? new BigDecimal(row.getCell(15).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行[USD/40HQ]单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
								//hq40Foramt=msg
							}
							if(hq40) {
								priceParams.hq40 = hq40
							}
							
							BigDecimal hq40Vip
							try {
								hq40Vip = row.getCell(16)?.numericCellValue ? new BigDecimal(row.getCell(16).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行[USD/40HQVIP]单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
								//hq40VipFormat=msg
								
							}
							if(hq40Vip) {
								priceParams.hq40Vip = hq40Vip
							}
						}
						
						try {
							String extra = row.getCell(17)?.stringCellValue?:null;
							
							if(extra?.length() > 1000) {
								msg = "第${num+1}行[附加费]不能超过1000个字符"
								errorInfo.add(msg);
								//extraSize=msg
							}
								priceParams.extra = extra
						} catch(e) {
							 msg = "第${num+1}行[附加费]单元格格式有误，请使用文本格式 "
							 errorInfo.add(msg);
							 //extraFormat=msg
						}
							
						if(TransportationType.Whole == data.transType) {
							try {
								String weightLimit = row.getCell(18)?.stringCellValue?:null;
								data.weightLimit = weightLimit
							} catch(e) {
								msg = "第${num+1}行[限重]单元格格式有误，请使用文本格式 "
								errorInfo.add(msg);
								//weightLimitFormat=msg
							}
						}
						
						try {
							String startPortCn = row.getCell(19)?.stringCellValue?:null;
							  if(startPortCn?.length() > 255) {
								 msg = "第${num+1}行[起始港(中文名)]不能超过255个字符 "
								 errorInfo.add(msg);
								 //startPortCnSize=msg
							}
							data.startPortCn = startPortCn
						} catch(e) {
							msg = "第${num+1}行[起始港(中文名)]单元格格式有误，请使用文本格式"
							errorInfo.add(msg);
							//startPortCnFormat=msg
						}
						try {
							String endPortCn = row.getCell(20)?.stringCellValue?:null;
							  if(endPortCn?.length() > 255) {
								 msg = "第${num+1}行[目的港(中文名)]不能超过255个字符"
								 errorInfo.add(msg);
								 //endPortCnSize=msg
							}
							data.endPortCn = endPortCn
						} catch(e) {
							 msg = "第${num+1}行[目的港(中文名)]单元格格式有误，请使用文本格式"
							 errorInfo.add(msg);
							 //endPortCnFormat=msg
						}
						
						try {
							String middlePortCn = row.getCell(21)?.stringCellValue?:null;
							if(middlePortCn?.length() > 255) {
								msg = "第${num+1}行[中转港(中文名)]不能超过255个字符"
								errorInfo.add(msg);
								//middlePortCnSize=msg
							}
							data.middlePortCn = middlePortCn
						} catch(e) {
							msg = "第${num+1}行[中转港(中文名)]单元格格式有误，请使用文本格式"
							errorInfo.add(msg);
							//middlePortCnFormat=msg
						}
						
						try {
							String companyName = row.getCell(22)?.stringCellValue?:null;
							if(!companyName){
								msg = "第${num+1}行[货代公司名称]不能为空"
								errorInfo.add(msg);
								//portten=msg
							}
							else if(companyName?.length() > 255 ){
								msg = "第${num+1}行[货代公司名称]不能超过255个字符 "
								errorInfo.add(msg);
								//companyNameSize=msg
							}
							data.companyName = companyName
							
						} catch (e) {
							msg = "第${num+1}行[货代公司名称]单元格格式有误,请使用本格式"
							errorInfo.add(msg);
							//companyNameForamt=msg
						}
						
						try {
							String contactName = row.getCell(23)?.stringCellValue?:null;
							if(!contactName){
								msg = "第${num+1}行[联系人]不能为空"
								errorInfo.add(msg);
								//person= msg
							}
							else if(contactName?.length() > 50){
								msg = "第${num+1}行[联系人]不能超过50个字符 "
								errorInfo.add(msg);
								//contactNameSize=msg 
							}
							data.contactName = contactName
								
						} catch (e) {
							msg = "第${num+1}行[联系人]单元格格式有误,请使用本格式 "
							errorInfo.add(msg);
							//contactNameFormat=msg
						}
						
						String phone
						try {
							 phone = row.getCell(24)?.stringCellValue?.trim() ?: null
							 if(!phone){
								 msg = "第${num+1}行[电话号码]不能为空" 
								 errorInfo.add(msg);
								 //phonedh=msg
							 }
						} catch(e) {
							try{
								phone = row.getCell(24)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(22).numericCellValue).longValue()) : null
								break
							}catch(e1){
								msg = "第${num+1}行[电话号码]格式有误"
								errorInfo.add(msg);
								//phonesFormat=msg
							}
						}
						
						data.phone = phone
										
						if(TransportationType.Together == data.transType) {
							try {
								String pinServiceType = row.getCell(25)?.stringCellValue?:null;
								data.pinServiceType = pinServiceType
							} catch(e) {
								msg ="第${num+1}行[服务类型]单元格格式有误，请使用文本格式 "
								errorInfo.add(msg);
								//pinServiceTypeFormat=msg
							}
							
							BigDecimal cbm
							try {
								cbm = row.getCell(26)?.stringCellValue ? new BigDecimal(row.getCell(26).stringCellValue) : null;
							} catch(e) {
								msg ="第${num+1}行[USD/cbm]单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
								//cbmForamt=msg
							}
							if(cbm) {
								priceParams.cbm = cbm
							}
		
							try {
								String lowestCost = row.getCell(27)?.stringCellValue?:null;
								priceParams.lowestCost = lowestCost
							} catch(e) {
								msg ="第${num+1}行[USD/rt]单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
								//lowestCostFormat=msg
							}
						}
					
						if(priceParams.size() > 0) {
							data.prices = new ShippingPrices(priceParams)
						}
						
						data.status = Status.VerifyPassed;
						data.releaseNum = releaseNum
						datas << data
				}
	
				if (datas.size == 0) {
					render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
					return
				}
				
				
			if(errorInfo.size() > 0 ){
				render(text: "<script>alert('${errorInfo}');</script>", contentType: "text/html", encoding: "UTF-8")
				render errorInfo;
				return;
			}else {
				boolean hasError = false
						def savedDatas = []
						int num = 1
						datas.each {
							it.save()
							hasError = it.hasErrors()
							if(!hasError) {
								savedDatas << it
								num++
							}
							return hasError
							}
								if(hasError) {
									CargoShipInformation.deleteAll(savedDatas)
									render(text: "<script>alert('第${num}行保存失败');</script>", contentType: "text/html", encoding: "UTF-8")
									//return;
								}
		
				 render (text: "<script>alert('上传成功, 共"+datas.size+"条记录！');</script>", contentType: "text/html", encoding: "UTF-8")
				 //return;
			}
		}
	}
	
	

	/***
	 *  下载模板
	 * @return
	 */
	
	def downloadExample() {
		downloadExampleWithInfo(fileName: '货代公司数据上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/ship.xls')
	}
	
	def delete() {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				CargoShipInformation data = CargoShipInformation.get(id as Long)
				data.deleted = true
				objs << data
			}
			CargoShipInformation.saveAll(objs)
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}
}
