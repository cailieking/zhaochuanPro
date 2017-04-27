package com.cdd.back.controller

import grails.converters.JSON

import java.text.SimpleDateFormat

import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Order
import com.cdd.base.domain.RecommendedShipInfo
import com.cdd.base.domain.Requestmap
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.Status
import com.cdd.base.util.CommonUtils




class RecommendAgentController extends BaseController {

	def model = 'recommendAgent'

	def list() {
		def viewUrl = "/${model}/list"
		Order order = Order.get(params.id as Long)

		if(params.dataType != 'json') {
			String msg = order.owner ? '推送信息' : '撮合信息'
			render view: viewUrl, model: [data: order, settings: getSettings(getMenu(msg, "/orderTrade/list"))]
			return
		}

		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		def result = CRUDService.list(CargoShipInformation, params) {
			eq "deleted", false
			eq "startPort", order.startPort
			eq "endPort", order.endPort
			eq "status", Status.VerifyPassed
			if(params.search) {
				def searchKey = "%${params.search}%"
				or {
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
		}
		def list = result?.list.collect {
			def map = CommonUtils.tranferToMap(it, ['prices', 'orders', 'wantedOrder', 'service'], [])
			map.startDate = sdf.format(map.startDate)
			map.endDate = sdf.format(map.endDate)
			return map
		}
		def total = result.totalCount
		render ([total: total, rows: list] as JSON)
	}

	//	def data() {
	//		CargoShipInformation data = CargoShipInformation.get(params.id as Long)
	//		Menu listMenu = new Menu()
	//		listMenu.parent = menuService.findMenu("/orderTrade/list")
	//		listMenu.map = new Requestmap()
	//		listMenu.map.url = "/$model/list/${params.orderId}"
	//		listMenu.name = '推送信息'
	//		Menu menu = new Menu()
	//		menu.parent = listMenu
	//		menu.name = '航线信息'
	//		render view: '/shipInfo/data', model: [data: data, settings: getSettings(menu)]
	//	}

	def send() {
		Order order = Order.get(params.id as Long)
		if(order) {
			def ids = params.ids?.split(',(\\s)*')
			if(order.owner) {
				ids?.each {
					RecommendedShipInfo data = new RecommendedShipInfo()
					data.order = order
					data.info = CargoShipInformation.get(it as Long)
					RecommendedShipInfo oldData = RecommendedShipInfo.findByOrderAndInfo(data.order, data.info)
					if(!oldData) {
						data.save()
						if(data.hasErrors()) {
							flash.errors = data.errors
							redirect uri: "/$model/list/${params.id}"
							return
						}
					}
				}
				order.orderStatus = OrderStatus.InTrade
				flash.msgs = ['推送成功']
			} else {
				if(ids.length > 1) {
					flash.errors = [:]
					flash.errors.msgs = ['只能选择一条航线进行撮合']
					redirect uri: "/$model/list/${params.id}"
					return
				}
				if(ids.length == 0) {
					flash.errors = [:]
					flash.errors.msgs = ['请选择一条航线进行撮合']
					redirect uri: "/$model/list/${params.id}"
					return
				}
				order.info = CargoShipInformation.get(ids[0] as Long)
				order.orderStatus = OrderStatus.TradeSuccess
				order.save()
				flash.msgs = ['撮合成功']
			}
			redirect uri: "/orderTrade/list"
		}
	}
}