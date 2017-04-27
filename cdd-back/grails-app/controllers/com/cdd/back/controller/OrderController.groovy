package com.cdd.back.controller

import grails.converters.JSON

import java.text.SimpleDateFormat

import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.web.multipart.commons.CommonsMultipartFile

import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontUser;
import com.cdd.base.domain.Order
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.cdd.base.service.OrderService

class OrderController extends BaseController {

	def model = 'order'

	def excludeFields = ['password', 'salt', 'role']

	def list() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}
		String start
		String end
		def transType
		if(params.start){
			start=params.start.toUpperCase()
			print start+"---------start"
		}
		if(params.end){
			end=params.end.toUpperCase()
		}
		if(params.transstatus){
			print params.transstatus
			switch(params.transstatus){
				case "Whole":
				transType=TransportationType.Whole;
				break;
				case "Together":
				transType=TransportationType.Together;
				break;
			}
		}
		String searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}

		def result = CRUDService.list(Order, params) {
			//print params.status
			def statusField
			def status

			switch(params.status) {
				case Status.UnVerify.name():
				case Status.InVerify.name():
				case Status.VerifyPassed.name():
				case Status.VerifyFailed.name():
				case Status.Expired.name():
				case Status.Revoked.name():
				case Status.Closed.name():
				statusField = "status"
				status = Status.valueOf(params.status)
				break
				case OrderStatus.UnTrade.name():
				case OrderStatus.InTrade.name():
				case OrderStatus.TradeSuccess.name():
				case OrderStatus.CertUploaded.name():
				case OrderStatus.CertInVerify.name():
				case OrderStatus.CertPassed.name():
					statusField = "orderStatus"
					status = OrderStatus.valueOf(params.status)
					break
			}
			if(statusField) {
				eq statusField, status
			}
			
			//eq "service", springSecurityService.currentUser
			if(searchKey) {
				or {
					like "number", searchKey
					like "cargoName", searchKey
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
			if(params.ordernumber){
				or{
					like "number",params.ordernumber
				}
			}
			if(params.createman){
				and{
					like "createBy","%${params.createman}%"
				}
			}
			if(params.createtime){
				
					SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
					def date1=sdf5.parse(params.createtime)
					def date2=sdf5.parse(params.createtime)+1
				and{
					between ("dateCreated", date1,date2)
				}
			}
			if(params.hw){
				and{
					like "cargoName",params.hw+"%"
				}
			}
			if(params.company){
				and{
					like "companyName","%${params.company}%"
				}
			}
			if(params.shipCompany){
				and{
					like "shipCompany","%${params.shipCompany}%"
				}
			}
			if(start){
				and {
					like "startPort", start+"%"
				}
			}
			if(end){
				and {
					like "endPort", end+"%"
				}
			}
			if(transType){
				and {
					eq "transType", transType
				}
			}
			if(params.cityId){
				and{
					eq "city", City.get(params.cityId as Long) //params.cityId
				}
			}
			if(params.contact){
				and{
					like "contactName", "%${params.contact}%"
				}
			}
			/*if(params.orderstarttime){
				
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
				def date1=sdf5.parse(params.orderstarttime)
				def date2=sdf5.parse(params.orderstarttime)+1
				and{
					between("endDate",date1,date2)
				}
			}
			if(params.starttime||params.endtime){
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf5.parse(params.starttime);
				def date2=sdf5.parse(params.endtime);
				and{
					between("startDate",date1,date2)
				}
			}*/
			
			if(params.startTime){
				
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
				def date1=sdf5.parse(params.startTime)
				def date2=sdf5.parse(params.startTime)+1
				and{
					between("startDate",date1,date2)
				}
			}
			if(params.orderstatus){
				print params.orderstatus
				and{
					eq "orderCome",params.orderstatus
				}
			}
			
			eq 'deleted', false
		}

		def map = [rows: [], total: result.totalCount]
		result.list.each { Order order ->
			def data = [:]
			if(order.status == Status.UnVerify){
				data.status = "未审核"
			}
			if(order.status == Status.InVerify){
				data.status = "审核中"
			}
			if(order.status == Status.Closed){
				data.status = "已关闭"
			}
			data.id = order.id
			data.number = order.number
			data.cargoName = order.cargoName
			data.companyName = order.companyName
			data.contactName = order.contactName
			data.city = order.city
			data.startPort = order.startPort
			data.endPort = order.endPort
			data.service = order.service
			data.sales = order.sales
			data.createBy=order.createBy
			data.dateCreated=sdf.format(order.dateCreated)
			map.rows << data
		}

		render map as JSON
	}

	def data() {
		//def modelAndView = data(model: model, menuName: '订单信息', domainClass: Order, excludeFields: excludeFields)
		/*if(modelAndView.model) {
			modelAndView.model.shipInfos = CargoShipInformation.findAllByWantedOrder(modelAndView.model.data)
		}*/
		//render modelAndView
				Order data=Order.get(params.id as Long)
				def newData=[:]
				String str=data.cargoBoxType
				if(str!=null && str.indexOf(",")>=0){
				String[] aa=str.split(",")
				newData.GP20=aa[0]
				newData.GP40=aa[1]
				newData.HQ40=aa[2]
				newData.HQ45=aa[3]
				String c=data.cargoBoxNums
				String[] bb=c.split(",")
				newData.GP20CargoBoxNums=bb[0]
				newData.GP40CargoBoxNums=bb[1]
				newData.HQ40CargoBoxNums=bb[2]
				newData.HQ45CargoBoxNums=bb[3]
				newData.data=data
				newData.str="str"
			}else{
				newData.data=data
				newData.str=null
			}
		render view: "/${model}/data", model: [data: newData, settings: getSettings(getMenu('查看', "/${model}/list"))]
	}

	def edit() {
		def data
		def newData=[:]
		if(params.id != 'new') {
				data = Order.get(params.id as Long)
				String str=data.cargoBoxType
				if(str!=null && str.indexOf(",")>=0){
				String[] aa=str.split(",")
				newData.GP20=aa[0]
				newData.GP40=aa[1]
				newData.HQ40=aa[2]
				newData.HQ45=aa[3]
				String c=data.cargoBoxNums
				String[] bb=c.split(",")
				newData.GP20CargoBoxNums=bb[0]
				newData.GP40CargoBoxNums=bb[1]
				newData.HQ40CargoBoxNums=bb[2]
				newData.HQ45CargoBoxNums=bb[3]
				newData.data=data
				newData.str="str"
			}else{
				newData.data=data
				newData.str=null
				print data.transType
			}
		} else {
			data = flash.data ?: new Order()
			newData.data=data
		}
		render view: "/${model}/edit", model: [data: newData, settings: getSettings(getMenu('货盘信息', "/${model}/list"))]
	}
	
	def close(){
			Order data=Order.get(params.id as Long)
			def newData=[:]
			String str=data.cargoBoxType
			if(str!=null && str.indexOf(",")>=0){
			String[] aa=str.split(",")
			newData.GP20=aa[0]
			newData.GP40=aa[1]
			newData.HQ40=aa[2]
			newData.HQ45=aa[3]
			String c=data.cargoBoxNums
			String[] bb=c.split(",")
			newData.GP20CargoBoxNums=bb[0]
			newData.GP40CargoBoxNums=bb[1]
			newData.HQ40CargoBoxNums=bb[2]
			newData.HQ45CargoBoxNums=bb[3]
			newData.data=data
			newData.str="str"
		}else{
			newData.data=data
			newData.str=null
		}
		render view: "/${model}/close", model: [data: newData, settings: getSettings(getMenu('修改订单信息', "/${model}/list"))]
	}
	
	def sureClosed(){
		def data
		if(params.id){
			data = Order.get(params.id as Long)
			Order newData=new Order(params)
			data.status="Closed"
			data.closeReason=newData.closeReason
		}
		
		data.save(flush:true)
		flash.msgs = ['操作成功']
		redirect uri: "/${model}/list"
		
	}

	OrderService orderService

	def save() {
		Order data
		if(params.id) {
			data = Order.get(params.id as Long)
			Order newData = new Order(params)
			data.companyName=newData.companyName
			data.startPort = newData.startPort
			data.endPort = newData.endPort
			data.orderType = newData.orderType
			data.biteEndDate = newData.biteEndDate
			data.transType = newData.transType
			if(TransportationType.Whole == data.transType) {
				data.cargoBoxNums = newData.cargoBoxNums
				data.cargoBoxType = "GP20,GP40,HQ40,HQ45"
				data.cargoNums = null
				data.cargoCube = null
				data.cargoHeight = null
				data.cargoLength = null
				data.cargoWeight = null
				data.cargoWidth = null
			} else {
				data.cargoBoxNums = null
				data.cargoBoxType = null
				data.cargoNums = newData.cargoNums
				data.cargoCube = newData.cargoCube
				data.cargoHeight = newData.cargoHeight
				data.cargoLength = newData.cargoLength
				data.cargoWeight = newData.cargoWeight
				data.cargoWidth = newData.cargoWidth
			}
			data.cargoName = newData.cargoName
			data.endDate = newData.endDate
			data.memo = newData.memo
			data.startDate = newData.startDate
			data.remark = newData.remark
			data.contactName = newData.contactName
			data.phone = newData.phone
			data.startPortCn = newData.startPortCn
			data.endPortCn = newData.endPortCn
			if(params.serviceId) {
				data.service = BackUser.get(params.serviceId as Long)
			}
			if(params.salesId) {
				data.sales = BackUser.get(params.salesId as Long)
			}
		} else {
			data = new Order(params)
			data.status = Status.InVerify
			def createBy=springSecurityService.currentUser.username
			//新建货盘时将货盘来源默认为导入
			data.orderCome='D'
			//print createBy
			//根据用户名判断订单类型是导入还是发布，手机号码是前台发布，其他是后台导入
			//def reg='^[1][358][0-9]{9}$'
			//def matcher4 = (createBy =~ reg);
			//print matcher4.matches()
			//if(matcher4.matches()){
				//data.orderCome='F'
			//}else{
				//data.orderCome='D'
			//}
			if(springSecurityService.currentUser.sales) {
				data.sales = springSecurityService.currentUser
				data.status = Status.VerifyPassed
				data.orderStatus = OrderStatus.UnTrade
			}
		}
		if(params.cityId) {
			data.city = City.get(params.cityId as Long)
		} else {
			data.city = null
		}
		if(data.id) {
			data.save()
		} else {
			orderService.insert(data)
		}
		if(data.hasErrors()) {
			flash.errors = data.errors
			flash.data = data
			redirect uri: "/${model}/edit/" + (data.id ?: 'new')
		} else {
			flash.msgs = ['保存成功']
			redirect uri: "/${model}/list"
		}
	}
	
	/***
	 * 批量发布货盘
	 * @return
	 */
	
	int maxSize = 1024 * 1024 * 1 // 1MB maximum
	
	@Secured('ROLE_CLIENT')
	def importData() {
		CommonsMultipartFile file = request.getFile('file')
		if(file.size > maxSize) {
			render(text: "<script>alert('文件不能超过1MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		
		String name = file.fileItem.fileName
		
		if (!name){
			render(text: "<script>alert('请选择文件');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		
		else if(!name.endsWith('.xls')) {
			render(text: "<script>alert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		
		HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
		HSSFSheet sheet = wb.getSheetAt(0)
		int rowCount = sheet.physicalNumberOfRows
		if(rowCount < 1) {
			render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		} else {
			def datas = []

			String msg           //公共字段
			
			String sumCount           //总记录数
			
			String cargoNameSize = " "   //货物名称 大小
			
			String cargoNameFormat = " "   //货物格式
			
			String startPortNon = " "     //起始港
			
			String startPortSize = " "     //起始港
			
			String startPortFormat = " "    //起始港
			
			String endPortNon = " "     // 目的港
			
			String endPortSize = " "
			 
			String endPortFormat = " "
			
			String transTypeNon = " "     //运输类别
			
			String transTypeContent = " "    //运输类别 内容
			
			String transTypeFormat = " "    //运输类别 格式
			
			String orderTypeFormat = " "     //货物类型
			
			String startDateNon = " "     //走货开始日期
			
			String startDateFormat = " "     //走货开始日期
			
			String endDateNon = " "     //走货截止日期/或走货结束日期
			
			String endDateFormat = " "   //走货结束日期
			
			String biteEndDateNon = " "  //报价截止日期 非空 //2个判断
			
			String biteEndDateFormat = " "    //报价截止日期
			
			String remarkSize = " "    // 备注
			
			String remarkFormat = " "
			
			String cargoBoxTypeNon = " "   //箱型
			
			String cargoBoxTypeContent = " "   //箱型内容
			
			String cargoBoxTypeFormat = " "   //箱型文本格式
			
			String cargoBoxNumsNon = " "     //箱个数
			
			String cargoBoxNumsFormat = " "    //箱个数
			
			String cargoNumsNon  = " "      //数量/件数
			
			String  cargoNumsFormat = " "     //数量/件数 格式
			
			String  cargoWeightNon = " "      //毛重  非空
			
			String  cargoWeightFormat = " "    //毛重
			
			String cargoCubeNon = " "         //体积
			
			String cargoCubeFormat = " "      //体积
			
			String cargoLengthFormat = " "    //长度
			
			String cargoWidthFormat = " "      //宽度
			
			String  cargoHeightFormat = " "   //高度
			
			String 	startPortCnNon = " "     //起始港(中文名
					
			String startPortCnSize = " "     //起始港(中文名)
					
			String	startPortCnFormat = " "
					
			String endPortCnNon = " "      //目的港(中文名)
			
			String endPortCnSize = " "
			
			String endPortCnFormat = " "
			
			String CompanyNameNon = " "        //货主公司名称
			
			String  companyNameSize = " "      //货主公司名称
			
			String companyNameForamt = " "     //货代公司名称
			
			
			String contactNameNon = " "      //联系人
			
			String  contactNameSize = " " 
			
			String contactNameFormat = " " 
			
			
			String phoneNon = " "      //电话号码
			
			String phonesFormat = " " 

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")

			for (int i=0; i<rowCount-1; i++) {

				Order data = new Order()
				int pos = i + 1
				HSSFRow row = sheet.getRow(pos)

				try {
					String cargoName = row.getCell(0)?.stringCellValue?:null
					if(cargoName.length() > 255) {
						msg = "第${pos+1}行[货物名称]不能超过255个字符 "
						cargoNameSize = msg
					}
					data.cargoName = cargoName
				} catch(e) {
					msg = "第${pos+1}行[货物名称]单元格格式有误，请使用文本格式 "
					cargoNameFormat = msg
				}

				try {
					String startPort = row.getCell(1)?.stringCellValue.toString().toUpperCase()?:null
					if(!startPort) {
						msg = "第${pos+1}行[起始港]不能为空 "
						startPortNon=msg
					} else if(startPort.length() > 255) {
						msg = "第${pos+1}行[起始港]不能超过255个字符 "
						startPortSize = msg
					}
					data.startPort = startPort
				} catch(e) {
					msg ="第${pos+1}行[起始港]单元格格式有误，请使用文本格式"
					startPortFormat = msg
				}

				try {
					String endPort = row.getCell(2)?.stringCellValue.toString().toUpperCase()?:null
					if(!endPort) {
						msg  = "第${pos+1}行[目的港]不能为空"
						endPortNon= msg
					} else if(endPort.length() > 255) {
						msg = "第${pos+1}行[目的港]不能超过255个字符"
						endPortSize = msg
					}
					data.endPort = endPort
				} catch(e) {
					msg = "第${pos+1}行[目的港]单元格格式有误，请使用文本格式"
					endPortFormat = msg
				}

				try {
					String transType = row.getCell(3)?.stringCellValue?:null;
					if(!transType) {
						msg = "第${pos+1}行[运输类别]不能为空"
						transTypeNon = msg
					}
					try {
						data.transType = TransportationType.getCodeByText(transType)
						if(!data.transType) {
							throw new RuntimeException()
						}
					} catch(e) {
						msg = "第${pos+1}行[运输类别]内容有误，请使用有效文本：整箱 | 拼箱"
						transTypeContent = msg
					}
				} catch(e) {
					msg = "第${pos+1}行[运输类别]单元格格式有误，请使用文本格式"
					transTypeFormat = msg
				}

				try {
					String orderType = row.getCell(4)?.stringCellValue?:null;
					data.orderType = orderType
				} catch(e) {
					msg = "第${pos+1}行[货物类型]单元格格式有误，请使用文本格式"
					orderTypeFormat = msg
				}

				Date startDate
				try {
					startDate = row.getCell(5)?.dateCellValue ?: null
					if(!startDate) {
						msg = "第${pos+1}行[走货开始日期]不能为空"
						startDateNon = msg
					}
				} catch(e) {
					try {
						startDate = row.getCell(5)?.stringCellValue ? sdf.parse(row.getCell(5).stringCellValue): null
					} catch(e1) {
						msg = " 第${pos+1}行[走货开始日期]格式有误，有效格式：2015-01-01 "
						startDateFormat = msg
					}
					if(!startDate) {
						msg = "第${pos+1}行[走货开始日期]不能为空"
						startDateNon = msg
					}
				}
				data.startDate = startDate

				Date endDate
				try {
					endDate = row.getCell(6)?.dateCellValue ?: null
					if(!endDate) {
						msg = "第${pos+1}行[走货结束日期]不能为空"
						endDateNon = msg
					}
				} catch(e) {
					try {
						endDate = row.getCell(6)?.stringCellValue ? sdf.parse(row.getCell(6).stringCellValue): null
					} catch(e1) {
						msg = "第${pos+1}行[走货结束日期]格式有误，有效格式：2016-01-01"
						endDateFormat = msg
					}
					if(!endDate) {
						msg = "第${pos+1}行[走货结束日期]不能为空"
						endDateNon=msg
					}
				}
				data.endDate = endDate

				Date biteEndDate
				try {
					biteEndDate = row.getCell(7)?.dateCellValue ?: null
					if(!biteEndDate) {
						msg = "第${pos+1}行[报价截止日期]不能为空"
						biteEndDateNon = msg
					}
				} catch(e) {
					try {
						biteEndDate = row.getCell(7)?.stringCellValue ? sdf.parse(row.getCell(7).stringCellValue): null
					} catch(e1) {
						 msg = "第${pos+1}行[报价截止日期]格式有误，有效格式：2016-01-01"
						 biteEndDateFormat = msg
					}
					if(!biteEndDate) {
						msg = "第${pos+1}行[报价截止日期]不能为空"
						biteEndDateNon = msg
					}
				}
				data.biteEndDate = biteEndDate

				try {
					String remark = row.getCell(8)?.stringCellValue?:null;
					if(remark?.length() > 500) {
						msg = "第${pos+1}行[备注]不能超过500个字符"
						remarkSize = msg
					}
					data.remark = remark
				} catch(e) {
					msg = "第${pos+1}行[备注]单元格格式有误，请使用文本格式"
					remarkFormat = msg
				}

				if(data.transType == TransportationType.Whole) {
					try {
						String cargoBoxType = row.getCell(9)?.stringCellValue?:null;
						if(!cargoBoxType) {
							msg = "第${pos+1}行[箱型]不能为空"
							cargoBoxTypeNon = msg
						}
						try {
							data.cargoBoxType = CargoBoxType.getCodeByText(cargoBoxType)
							if(!data.cargoBoxType) {
								throw new RuntimeException()
							}
						} catch(e) {
							msg = "第${pos+1}行[箱型]内容有误，请使用有效文本：20GP | 40GP | 40HQ | 45HQ"
							cargoBoxTypeContent = msg
						}
					} catch(e) {
						msg = "第${pos+1}行[箱型]单元格格式有误，请使用文本格式"
						cargoBoxTypeFormat = msg
					}

					Integer cargoBoxNums
					try {
						cargoBoxNums = row.getCell(10)?.numericCellValue ?: null;
						if(!cargoBoxNums) {
							msg = "第${pos+1}行[箱个数]不能为空"
							cargoBoxNumsNon = msg
						}
					} catch(e) {
						try {
							cargoBoxNums = row.getCell(10)?.stringCellValue ? Integer.valueOf(row.getCell(10).stringCellValue) : null
							if(!cargoBoxNums) {
								msg = "第${pos+1}行[箱个数]不能为空"
								cargoBoxNumsNon=msg
							}
						} catch(e1) {
							msg = "第${pos+1}行[箱个数]单元格格式有误，请使用文本格式或数字格式"
							cargoBoxNumsFormat = msg
						}
					}
					data.cargoBoxNums = cargoBoxNums
				} else {
					Integer cargoNums
					try {
						cargoNums = row.getCell(11)?.numericCellValue ?: null;
						if(!cargoNums) {
							 msg = "第${pos+1}行[数量/件数]不能为空"
							 cargoNumsNon = msg
						}
					} catch(e) {
						try {
							cargoNums = row.getCell(11)?.stringCellValue ? Integer.valueOf(row.getCell(11).stringCellValue) : null
							if(!cargoNums) {
								msg = "第${pos+1}行[数量/件数]不能为空"
								cargoNumsNon = msg
							}
						} catch(e1) {
							msg = "第${pos+1}行[数量/件数]单元格格式有误，请使用文本格式或数字格式"
							cargoNumsFormat = msg
						}
					}
					data.cargoNums = cargoNums

					Double cargoWeight
					try {
						cargoWeight = row.getCell(12)?.numericCellValue ?: null;
						if(!cargoWeight) {
							msg = "第${pos+1}行[毛重]不能为空"
							cargoWeightNon = msg
						}
					} catch(e) {
						try {
							cargoWeight = row.getCell(12)?.stringCellValue ? Double.valueOf(row.getCell(12).stringCellValue) : null
							if(!cargoWeight) {
								msg = "第${pos+1}行[毛重]不能为空"
								cargoWeightNon = msg
							}
						} catch(e1) {
							msg = "第${pos+1}行[毛重]单元格格式有误，请使用文本格式或数字格式"
							cargoWeightFormat = msg
						}
					}
					data.cargoWeight = cargoWeight

					Double cargoCube
					try {
						cargoCube = row.getCell(13)?.numericCellValue ?: null;
						if(!cargoCube) {
							msg = "第${pos+1}行[体积]不能为空"
							cargoCubeNon = msg
						}
					} catch(e) {
						try {
							cargoCube = row.getCell(13)?.stringCellValue ? Double.valueOf(row.getCell(13).stringCellValue) : null
							if(!cargoCube) {
								msg = "第${pos+1}行[体积]不能为空"
								cargoCubeNon = msg
							}
						} catch(e1) {
							msg = "第${pos+1}行[体积]单元格格式有误，请使用文本格式或数字格式"
							cargoCubeFormat = msg
						}
					}
					data.cargoCube = cargoCube
				}

				Double cargoLength
				try {
					cargoLength = row.getCell(14)?.numericCellValue ?: null;
				} catch(e) {
					try {
						cargoLength = row.getCell(14)?.stringCellValue ? Double.valueOf(row.getCell(14).stringCellValue) : null
					} catch(e1) {
						msg = "第${pos+1}行[长度]单元格格式有误，请使用文本格式或数字格式"
						cargoLengthFormat = msg
					}
				}
				data.cargoLength = cargoLength

				Double cargoWidth
				try {
					cargoWidth = row.getCell(15)?.numericCellValue ?: null;
				} catch(e) {
					try {
						cargoWidth = row.getCell(15)?.stringCellValue ? Double.valueOf(row.getCell(15).stringCellValue) : null
					} catch(e1) {
						msg = "第${pos+1}行[宽度]单元格格式有误，请使用文本格式或数字格式"
						cargoWidthFormat = msg
					}
				}
				data.cargoWidth = cargoWidth

				Double cargoHeight
				try {
					cargoHeight = row.getCell(16)?.numericCellValue ?: null;
				} catch(e) {
					try {
						cargoHeight = row.getCell(16)?.stringCellValue ? Double.valueOf(row.getCell(16).stringCellValue) : null
					} catch(e1) {
						msg = "第${pos+1}行[高度]单元格格式有误，请使用文本格式或数字格式"
						cargoHeightFormat = msg
					}
				}
				data.cargoHeight = cargoHeight
				
				try {
					String startPortCn = row.getCell(17)?.stringCellValue.trim() ?:null;
					if(!startPortCn) {
						msg = "第${pos+1}行[起始港(中文名)]不能为空"
						startPortCnNon = msg
					}
					 else if(startPortCn.length() > 255) {
						 msg = "第${pos+1}行[起始港(中文名)]不能超过255个字符 "
						 startPortCnSize = msg
					}
					data.startPortCn = startPortCn
				} catch(e) {
					msg = "第${num+1}行[起始港(中文名)]单元格格式有误，请使用文本格式"
					startPortCnFormat = msg
				}
				
				
				try {
					String endPortCn = row.getCell(18)?.stringCellValue?.trim()?:null
					if(!endPortCn) {
						msg = "第${pos+1}行[目的港(中文名)]不能为空"
						endPortCnNon = msg
					}
					 else if(endPortCn.length() > 255) {
						 msg = "第${pos+1}行[目的港(中文名)]不能超过255个字符"
						 endPortCnSize=msg
					}
					data.endPortCn = endPortCn
				} catch(e) {
					 msg = "第${pos+1}行[目的港(中文名)]单元格格式有误，请使用文本格式"
					 endPortCnFormat = msg
				}
				
				try {
					String companyName = row.getCell(19)?.stringCellValue.trim()?:null;
					if(!companyName){
						msg = "第${pos+1}行[货主公司名称]不能为空"
						CompanyNameNon=msg
					}
					else if(companyName?.length() > 255 ){
						msg = "第${pos+1}行[货主公司名称]不能超过255个字符 "
						companyNameSize=msg
					}
					data.companyName = companyName
					
				} catch (e) {
					msg = "第${pos+1}行[货代公司名称]单元格格式有误,请使用本格式"
					companyNameForamt=msg
				}
				
				try {
					String contactName = row.getCell(20)?.stringCellValue.trim()?:null;
					if(!contactName){
						msg = "第${pos+1}行[联系人]不能为空"
						contactNameNon = msg
					}
					else if(contactName?.length() > 50){
						msg = "第${pos+1}行[联系人]不能超过50个字符 "
						contactNameSize = msg 
					}
					data.contactName = contactName
						
				} catch (e) {
					msg = "第${pos+1}行[联系人]单元格格式有误,请使用本格式 "
					contactNameFormat=msg
				}
				
				String phone
				try {
					 phone = row.getCell(21)?.stringCellValue?.trim() ?: null
					 if(!phone){
						 msg = "第${pos+1}行[电话号码]不能为空" 
						 phoneNon=msg
					 }
				} catch(e) {
					try{
						phone = row.getCell(21)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(21).numericCellValue).longValue()) : null
						break
					}catch(e1){
						msg = "第${pos+1}行[电话号码]格式有误"
						phonesFormat=msg
					}
				}
				data.phone = phone
				data.status = Status.VerifyPassed
				data.orderStatus = OrderStatus.UnTrade
				
				////导入货盘时将货盘来源默认为D
				data.orderCome='D'
				
				if(springSecurityService.currentUser.sales) {
					data.sales = springSecurityService.currentUser
				}
				
				datas << data
			
			}

			if(msg) {
				
				sumCount = "${cargoNameSize}  " + "${cargoNameFormat}  " + "${startPortNon}  " + "${startPortSize}" + "${startPortFormat}  "+
				"${endPortNon}  " + "${endPortSize}  " + "${endPortFormat}  " + "${transTypeNon}  " + "${transTypeContent}  " + "${transTypeFormat}  "+
				"${orderTypeFormat}  " + "${startDateNon}  " + "${startDateFormat}  " + "${endDateNon}  " + "${endDateFormat}  " + "${biteEndDateNon}   "+
				"${biteEndDateFormat}  " + "${remarkSize}  " + "${remarkFormat}  " + "${cargoBoxTypeNon}  " + "${cargoBoxTypeContent}" + "${cargoBoxTypeFormat}  "+
				"${cargoBoxNumsNon}  " + "${cargoBoxNumsFormat}  " + "${cargoNumsNon}  " + "${cargoNumsFormat}  " + "${cargoWeightNon}  " + "${cargoWeightFormat}  "+
				"${cargoCubeNon}  " + "${cargoCubeFormat}  " + "${cargoLengthFormat}  " + "${cargoWidthFormat}  " + "${cargoHeightFormat}" + "${startPortCnNon}  " +
				"${startPortCnSize}  " + "${startPortCnFormat}  " + "${endPortCnNon}  " + "${endPortCnSize}  " + "${endPortCnFormat}  " + "${CompanyNameNon}  " +
				"${companyNameSize}  " + "${companyNameForamt}  " + "${contactNameNon}  " + "${contactNameSize}  " + "${contactNameFormat}  " + "${phoneNon}  " + 
				"${phonesFormat}"
				render(text: "<script>alert('${sumCount}')</script>", contentType:"text/html",encoding:"UTF-8")
				return
			}

			if (datas.size == 0) {
				render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}

			boolean hasError = false
			def savedDatas = []
			datas.each {
				orderService.insert(it)
				hasError = it.hasErrors()
				if(!hasError) {
					savedDatas << it
				}
				return hasError
			}
			if(hasError) {
				Order.deleteAll(savedDatas)
				render(text: "<script>alert('"+g.message(code: it.errors.allErrors[0].codes[0])+"');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}
			Order.saveAll(datas)

			render (text: "<script>alert('上传成功, 共"+datas.size+"条记录！');</script>", contentType: "text/html", encoding: "UTF-8")
			
			return;
		}
		
	}

	def downloadExample() {
		downloadExampleWithInfo(fileName: '货主数据上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/cargo.xls')
	}

	def delete() {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				Order data = Order.get(id as Long)
				data.deleted = true
				objs << data
			}
			Order.saveAll(objs)
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}
}
