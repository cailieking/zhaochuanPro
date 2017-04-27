package com.cdd.back.controller

import grails.converters.JSON

import java.text.SimpleDateFormat

import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType


class ShipInfoTrashController extends BaseController {
	def model = 'shipInfoTrash'

	def list() {
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}
		
		String searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}

		def result = CRUDService.list(CargoShipInformation, params) {
			if(params.status) {
				eq "status", Status.valueOf(params.status)
			}

			if(searchKey) {
				or {
					like "routeName", searchKey
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
			
			eq 'deleted', true
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

		render map as JSON

	}

	def data() {
		render data(model: model, menuName: '垃圾货代信息', domainClass: CargoShipInformation)
	}

	def delete() {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				CargoShipInformation data = CargoShipInformation.get(id as Long)
				data.deleted = false
				objs << data
			}
			CargoShipInformation.saveAll(objs)
		}
		flash.msgs = ['还原成功']
		redirect uri: "/${model}/list"
	}
}
