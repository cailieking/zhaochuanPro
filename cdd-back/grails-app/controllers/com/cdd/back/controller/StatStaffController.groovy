package com.cdd.back.controller

import com.cdd.back.domain.StatStaff

class StatStaffController extends BaseController {

	def model = 'statStaff'

	def list() {
		def searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		render getList(model: model, domainClass: StatStaff, excludeFields: ['user'], queryHandler: {
			if(searchKey) {
				user {
					like "firstname", searchKey
				}
			}
		}) { item, map ->
			map.firstname = item.user.firstname
		}
	}

}
