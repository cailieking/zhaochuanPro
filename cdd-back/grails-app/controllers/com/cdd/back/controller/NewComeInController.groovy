package com.cdd.back.controller


import org.apache.poi.hssf.usermodel.HSSFRow

import com.cdd.base.domain.NewComeIn
import com.cdd.base.domain.Route
import com.cdd.base.enums.RouteType


class NewComeInController extends BaseController {

	def model = 'newComeIn'

	def data() {
		NewComeIn data = CRUDService.getFirst(NewComeIn, [f_manual: true])
		if(!data) {
			data = new NewComeIn()
		}
		render view: "/${model}/data", model: [data: data, settings: getSettings(menuService.findMenu("/$model/data"))]
	}

	def save() {
		NewComeIn data = new NewComeIn(params)
		if(params.id) {
			data.id = params.id as Long
		}
		save(data, model, "/$model/data")
	}
}
