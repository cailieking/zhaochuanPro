package com.cdd.back.controller

import grails.converters.JSON
import java.text.SimpleDateFormat

import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType


class ShipAuditController extends BaseController {
	def model = 'shipAudit'

	def list() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}
		String start
		String end
		String middle
		def transType
		if(params.start){
			start=params.start.toUpperCase()
			print start+"---------start"
		}
		if(params.middle){
			middle=params.middle.toUpperCase()
		}
		if(params.end){
			end=params.end.toUpperCase()
		}
		
		if(params.transType){
			//print params.transType
			switch(params.transType){
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

		def result = CRUDService.list(CargoShipInformation, params) {
			if(params.status) {
				eq "status", Status.valueOf(params.status)
			}
			eq "service", springSecurityService.currentUser
			if(searchKey) {
				or {
					like "routeName", searchKey
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
			if(params.yjnumber){
				or {
					like "id", params.yjnumber as Long
				}
			}
			if(params.submitman){
				and{
					like "createBy", "%${params.submitman}%"
				}
				
			}
			if(params.submittime){
				and{
					SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
					def date1=sdf5.parse(params.submittime)
					def date2=sdf5.parse(params.submittime)+1
					between ("dateCreated", date1,date2)
				}
			}
			if(params.hx){
				and{
					like "routeName",params.hx+"%"
				}
			}
			if(params.company){
				and{
					like "companyName","%${params.company}%"
				}
			}
			if(params.chuancompany){
				and{
					like "shipCompany","%${params.chuancompany}%"
				}
			}
			if(start){
				and{
					like "startPort", start+"%"
				}
			}
			if(middle){
				and{
					like "middlePort",middle+"%"
				}
			}
			if(end){
				and {
					like "endPort", end+"%"
				}
			}
			if(transType){
				and{
					eq "transType", transType
				}
			}
			if(params.hc){
				and{
					eq "shippingDays",params.hc as int
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
			if(params.starttime||params.endtime){
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf5.parse(params.starttime);
				def date2=sdf5.parse(params.endtime);
				and{
					between("startDate",date1,date2)
				}
			}

			eq 'deleted', false
		}

		def map = [rows: [], total: result.totalCount]
		result.list.each { CargoShipInformation info ->
			def data = [:]
			//			data.id = info.id
			//			data.routeName = info.routeName
			//			data.companyName = info.companyName
			//			data.contactName = info.contactName
			//			data.city = info.city
			//			data.startPort = info.startPort
			//			data.endPort = info.endPort
			//			data.showOnIndex = info.showOnIndex
			//修改后
			data.id = info.id
			data.startPort = info.startPort
			data.startPortCn = info.startPortCn
			data.endPort = info.endPort
			data.endPortCn = info.endPortCn
			data.middlePort = info.middlePort
			data.middlePortCn = info.middlePortCn
			data.startDate = info.startDate //有效期开始日期-
			data.transType= info.transType?.getText()
			data.shipCompany = info.shipCompany
			data.status = info.status
			data.city = info.city
			data.routeName = info.routeName
			data.endDate = info.endDate //有效期结束日期
			data.shippingDay = info.shippingDay
			data.remark = info.remark
			data.shippingDays = info.shippingDays
			data.companyName = info.companyName
			data.phone = info.phone
			data.contactName = info.contactName
			data.memo = info.memo
			data.service = info.service
			data.showOnIndex = info.showOnIndex
			data.address = info.address
			data.wantedOrder = info.wantedOrder
			data.weightLimit = info.weightLimit
			data.pinServiceType = info.pinServiceType
			data.createBy=info.createBy
			data.dateCreated=sdf.format(info.dateCreated)
			//关联相关字段
			data.gp20=info.prices?.gp20
			data.gp40=info.prices?.gp40
			data.hp40=info.prices?.hq40
			data.hq45=info.prices?.hq45
			data.extra=info.prices?.extra
			data.cbm=info.prices?.cbm
			data.lowestCost=info.prices?.lowestCost

			map.rows << data
		}

		render map as JSON
	}

	def data() {
		render data(model: model, menuName: '运价审核信息', domainClass: CargoShipInformation)
	}
	
	def view() {
		CargoShipInformation data = CargoShipInformation.get(params.id as Long)
		if(data && data.service == springSecurityService.currentUser) {
			if(data.status == Status.UnVerify) {
				data.save()
			}
			render view: "/${model}/view", model: [data: data, settings: getSettings(getMenu('货代审核信息', "/${model}/list"))]
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
				CargoShipInformation data = CargoShipInformation.get(id as Long)
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
				CargoShipInformation data = CargoShipInformation.get(id as Long)
				if(data){
					data.status="VerifyFailed"
				}
				data.save(flush:true)
			}
		}
		flash.msgs = ['nopass操作成功']
		redirect uri: "/${model}/list"
	}
	def update() {
		CargoShipInformation data = CargoShipInformation.get(params.id as Long)
		if(data) {
			if(data.service == springSecurityService.currentUser) {
				if(data.status != Status.VerifyPassed) {
					CargoShipInformation newData = new CargoShipInformation(params)
					data.companyName=newData.companyName
					data.contactName=newData.contactName
					data.phone=newData.phone
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
					data.remark=newData.remark
					data.memo = newData.memo
					data.startPortCn = newData.startPortCn
					data.endPortCn = newData.endPortCn
					data.middlePortCn = newData.middlePortCn
					data.weightLimit = newData.weightLimit
					data.status = newData.status
					data.pinServiceType = newData.pinServiceType
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
								data.prices.gp40 = newPrices.gp40
								data.prices.hq40 = newPrices.hq40
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

						save(data, model)
					} else {
						flash.errors = newPrices.errors
						flash.data = data
						redirect uri: "/${model}/data/" + (data.id ?: 'new')
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
}
