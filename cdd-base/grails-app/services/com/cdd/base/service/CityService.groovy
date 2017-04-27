package com.cdd.base.service

import com.cdd.base.domain.City
import com.cdd.base.service.common.CRUDService

class CityService {
	CRUDService CRUDService
	
	def getCities(int pcode) {
		CRUDService.list(City, [offset: 0, sort: 'code', order: 'asc', 'f_pcode': pcode])
	}
}
