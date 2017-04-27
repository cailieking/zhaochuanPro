package com.cdd.back.controller

import grails.converters.JSON
import java.text.SimpleDateFormat

import com.cdd.base.domain.City
import com.cdd.base.domain.Order
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType;
import com.cdd.base.service.SmsService


class OrderAuditController extends BaseController {

	def model = 'orderAudit'

	def list() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
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

			eq "service", springSecurityService.currentUser
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
			if(params.orderstarttime){
				
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
			data.service=order.service
			data.sales=order.sales
			data.createBy=order.createBy
			data.dateCreated=sdf.format(order.dateCreated)
			map.rows << data
		}

		render map as JSON
	}

	def data() {
		//render data(model: model, menuName: '货代审核信息', domainClass: Order)
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
	render view: "/${model}/data", model: [data: newData, settings: getSettings(getMenu('修改订单审核信息', "/${model}/list"))]
	}

	def view() {
		Order data = Order.get(params.id as Long)
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
		if(data && data.service == springSecurityService.currentUser) {
			if(data.status == Status.UnVerify) {
				data.save()
			}
			render view: "/${model}/view", model: [data: newData, settings: getSettings(getMenu('订单审核信息', "/${model}/list"))]
			return
		}
		redirect uri: "/${model}/list"
	}
	
	//通过
	def pass(){
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				Order data = Order.get(id as Long)
				if(data){
					data.status="VerifyPassed"
				}
				data.save(flush:true)
			}
		}
		flash.msgs = ['pass操作成功']
		redirect uri: "/${model}/list"
	}
	
	//不通过
	
		def nopass(){
			String[] ids = params.ids.split(',(\\s)*')
	//		println ids
			if(ids) {
				def objs = []
				for(def id in ids) {
					Order data = Order.get(id as Long)
					if(data){
						data.status="VerifyFailed"
					}
					data.save(flush:true)
				}
			}
			flash.msgs = ['nopass操作成功']
			redirect uri: "/${model}/list"
		}

	SmsService smsService

	def update() {
		Order data = Order.get(params.id as Long)
		if(data) {
			if(data.service == springSecurityService.currentUser) {
				if(data.status != Status.VerifyPassed) {
					Order newData = new Order(params)
					data.companyName=newData.companyName
					data.contactName=newData.contactName
					data.phone=newData.phone
					data.startPort = newData.startPort
					data.endPort = newData.endPort
					data.startPortCn = newData.startPortCn
					data.endPortCn = newData.endPortCn
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
					data.remark = newData.remark
					data.startDate = newData.startDate
					data.status = newData.status
					if(newData.status == Status.VerifyPassed) {
						data.orderStatus = OrderStatus.UnTrade
					}
					if(params.cityId) {
						data.city = City.get(params.cityId as Long)
					} else {
						data.city = null
					}
					save(data, model, null) {
						if(data.status == Status.VerifyPassed) {
							String msg = "您的委托已受理，受理单号为$data.number"
							smsService.sendMsg(data.phone, msg)
						}
					}
					return
				} else {
					flash.errors = [:]
					flash.errors.msgs = ['订单已审核通过，不能再修改']
				}
			} else {
				flash.errors = [:]
				flash.errors.msgs = ['权限不足，不能修改订单']
			}
		}
		redirect uri: "/${model}/list"
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
}
