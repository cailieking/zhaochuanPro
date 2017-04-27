package com.cdd.base.service

import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.enums.Status
import com.cdd.base.service.common.CRUDService

class CargoShipInformationService {
	CRUDService CRUDService
	
	def getVerifyPassedList() {
		CRUDService.list(CargoShipInformation, ["f_status": Status.VerifyPassed, "f_ge_endDate": new Date()])
	}
}
