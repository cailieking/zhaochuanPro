package com.cdd.back.controller

import java.text.SimpleDateFormat

import com.cdd.back.domain.StatIncrement


class StatIncrementController extends BaseController {

	def model = 'statIncrement'

	def list() {
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		render getList(model: model, domainClass: StatIncrement) { item, map ->
			map.startDate = sdf.format(item.startDate)
			map.endDate = sdf.format(item.endDate)
		}
	}

}
