package com.cdd.back.controller


import com.cdd.base.domain.CargoShipScore


class ShipScoreController extends BaseController {

	def model = 'shipScore'

	def list() {
		if(params.search) {
			params.f_like_companyName = "%${params.search}%"
		}

		render getList(model: model, domainClass: CargoShipScore) { item, map ->
			map.shipInTime = item.shipInTime
			map.docInTime = item.docInTime
			map.infoInTime = item.infoInTime
			map.serviceQuality = item.serviceQuality
			map.serviceContent = item.serviceContent
		}
	}

	def data() {
		render data(model: model, menuName: '货代评分信息', domainClass: CargoShipScore)
	}

	def save() {
		CargoShipScore newData = new CargoShipScore(params)
		if(params.id) {
			CargoShipScore data = CargoShipScore.get(params.id as Long)
			if(data) {
				data.hornest = newData.hornest
				data.safety = newData.safety
				data.verified = newData.verified
				save(data, model)
			}
		}
	}
}
