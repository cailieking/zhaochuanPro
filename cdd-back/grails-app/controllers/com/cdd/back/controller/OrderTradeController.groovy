package com.cdd.back.controller

import grails.converters.JSON

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.Order
import com.cdd.base.enums.OrderStatus
import com.cdd.base.service.OssService


class OrderTradeController extends BaseController {

	def model = 'orderTrade'

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
			if(params.status) {
				eq "orderStatus", OrderStatus.valueOf(params.status)
			}

			eq "sales", springSecurityService.currentUser
			if(searchKey) {
				or {
					like "number", searchKey
					like "cargoName", searchKey
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
			
			eq 'deleted', false
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
			data.orderStatus = order.orderStatus?.name()
			data.certFilePath = order.certFilePath
			data.bookingFilePath = order.bookingFilePath
			data.isoFilePath = order.isoFilePath
			data.owner = order.owner?.id
			map.rows << data
		}

		render map as JSON

	}

	def data() {
		Order data = Order.get(params.id as Long)
		if(data && data.sales == springSecurityService.currentUser) {
			if(data.orderStatus == OrderStatus.CertUploaded) {
				data.orderStatus = OrderStatus.CertInVerify
				data.save()
			}
			def shipInfos = CargoShipInformation.findAllByWantedOrder(data)
			render view: "/${model}/data", model: [shipInfos: shipInfos, data: data, settings: getSettings(getMenu('订单交易信息', "/${model}/list"))]
			return
		}
		redirect uri: "/${model}/list"
	}

	GrailsApplication grailsApplication
	
	OssService ossService

	def update() {
		Order data = Order.get(params.id as Long)
		if(data) {
			if(springSecurityService.currentUser == data.sales) {
				if(data.orderStatus != OrderStatus.CertPassed) {
					CommonsMultipartFile f = request.getFile('file')
					if(f?.size > 0) {
						if(f.size > maxSize) {
							flash.errors = [:]
							flash.errors.msgs = ['凭证不能超过10MB']
							flash.data = data
							redirect uri: "/${model}/data/${data.id}"
							return
						}
						String prefix = "files/order/${data.id}/cert/"
						ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
							prefix + f.fileItem.fileName)
						String fileName = prefix + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
						data.certFilePath = fileName
					}

					Order order = new Order(params)

					switch(order.orderStatus) {
						case OrderStatus.CertUploaded:
						case OrderStatus.CertInVerify:
						case OrderStatus.CertPassed:
							if(!data.certFilePath) {
								flash.errors = [:]
								flash.errors.msgs = ['请先上传凭证']
								flash.data = data
								redirect uri: "/${model}/data/${data.id}"
								return
							}
					}

					if(params.infoId) {
						data.info = CargoShipInformation.get(params.infoId as Long)
					}
					switch(order.orderStatus) {
						case OrderStatus.TradeSuccess:
						case OrderStatus.CertUploaded:
						case OrderStatus.CertInVerify:
						case OrderStatus.CertPassed:
							if(!data.info) {
								flash.errors = [:]
								flash.errors.msgs = ['货代信息不能为空']
								flash.data = data
								redirect uri: "/${model}/data/${data.id}"
								return
							}
					}

					data.startPort = order.startPort
					data.endPort = order.endPort
					data.startPortCn = order.startPortCn
					data.endPortCn = order.endPortCn
					data.orderType = order.orderType
					data.biteEndDate = order.biteEndDate
					data.transType = order.transType
					if(TransportationType.Whole == data.transType) {
						data.cargoBoxNums = order.cargoBoxNums
						data.cargoBoxType = order.cargoBoxType
						data.cargoNums = null
						data.cargoCube = null
						data.cargoHeight = null
						data.cargoLength = null
						data.cargoWeight = null
						data.cargoWidth = null
					} else {
						data.cargoBoxNums = null
						data.cargoBoxType = null
						data.cargoNums = order.cargoNums
						data.cargoCube = order.cargoCube
						data.cargoHeight = order.cargoHeight
						data.cargoLength = order.cargoLength
						data.cargoWeight = order.cargoWeight
						data.cargoWidth = order.cargoWidth
					}
					data.cargoName = order.cargoName
					data.endDate = order.endDate
					data.memo = order.memo
					data.remark = order.remark
					data.startDate = order.startDate
					if(params.cityId) {
						data.city = City.get(params.cityId as Long)
					} else {
						data.city = null
					}
					if(order.dealPrice) {
						data.dealPrice = order.dealPrice
					} else {
						data.dealPrice = BigDecimal.ZERO
					}
					data.orderStatus = order.orderStatus
					save(data, model)
					return
				} else {
					flash.errors = [:]
					flash.errors.msgs = ['订单已交易完毕，不能再修改']
				}
			} else {
				flash.errors = [:]
				flash.errors.msgs = ['权限不足，不能修改订单']
			}
		}
		redirect uri: "/${model}/list"
	}

}
