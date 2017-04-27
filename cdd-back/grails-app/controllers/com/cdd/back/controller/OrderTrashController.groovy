package com.cdd.back.controller

import grails.converters.JSON

import java.text.SimpleDateFormat

import org.apache.poi.hssf.usermodel.HSSFRow

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.Order
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.cdd.base.service.OrderService


class OrderTrashController extends BaseController {

	def model = 'orderTrash'

	def list() {
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
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
			if(searchKey) {
				or {
					like "number", searchKey
					like "cargoName", searchKey
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
			eq 'deleted', true
		}

		def map = [rows: [], total: result.totalCount]
		result.list.each { Order order ->
			def data = [:]
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
			map.rows << data
		}

		render map as JSON

	}

	def data() {
		def modelAndView = data(model: model, menuName: '垃圾订单信息', domainClass: Order, excludeFields: excludeFields)
		if(modelAndView.model) {
			modelAndView.model.shipInfos = CargoShipInformation.findAllByWantedOrder(modelAndView.model.data)
		}
		render modelAndView
	}

	def revert() {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				Order data = Order.get(id as Long)
				data.deleted = false
				objs << data
			}
			Order.saveAll(objs)
		}
		flash.msgs = ['还原成功']
		redirect uri: "/${model}/list"
	}

}
