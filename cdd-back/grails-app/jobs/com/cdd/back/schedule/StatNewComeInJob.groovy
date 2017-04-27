package com.cdd.back.schedule

import groovy.util.logging.Slf4j

import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.NewComeIn
import com.cdd.base.domain.Order
import com.cdd.base.domain.User
import com.cdd.base.enums.FrontUserType
import com.cdd.base.service.common.CRUDService


@Slf4j
class StatNewComeInJob {
	static triggers = {
		cron name: 'StatNewComeInTrigger', cronExpression: "0 * * * * ?"
	}

	CRUDService CRUDService

	def execute(){
		Calendar cl = Calendar.getInstance()
		int year = cl.get(Calendar.YEAR)
		int month = cl.get(Calendar.MONTH)
		int date = cl.get(Calendar.DATE)
		cl.clear()
		cl.set(Calendar.YEAR, year)
		cl.set(Calendar.MONTH, month)
		cl.set(Calendar.DATE, date)
		cl.set(Calendar.HOUR, 19)
		Calendar now = Calendar.getInstance()
		if(now.compareTo(cl) >= 0) {
			cl.add(Calendar.DATE, 1)
		}
		Date endDate = cl.getTime()
		cl.add(Calendar.DATE, -1)
		Date startDate = cl.getTime()

		NewComeIn data = CRUDService.getFirst(NewComeIn, [f_manual: false])
		if(!data) {
			data = new NewComeIn()
		}

		def c = FrontUser.createCriteria()
		def totalOwner = c.get {
			projections {
				count('id')
			}
			ge 'dateCreated', startDate
			lt 'dateCreated', endDate
//			eq 'type', FrontUserType.Agent
			eq 'type', FrontUserType.Cargo
		}
		if(!totalOwner) {
			totalOwner = 0
		}
		data.agent = totalOwner
		
//		c = Order.createCriteria()
//		def possibleNewOwners = c.list {
//			projections {
//				distinct('companyName')
//			}
//			ge 'dateCreated', startDate
//			lt 'dateCreated', endDate
//		}
//		possibleNewOwners?.each {
//			FrontUser user = FrontUser.findByCompanyName(it)
//			if(!user) {
//				totalOwner++
//			}
//		}
//		if(totalOwner > 0) {
//			data.agent = totalOwner
//		}
		
		c = Order.createCriteria()
		def totalOrder = c.get {
			projections {
				count('id')
			}
			ge 'dateCreated', startDate
			lt 'dateCreated', endDate
		}
		if(!totalOrder) {
			totalOrder = 0
		}
		if(totalOrder> 0) {
			data.orders = totalOrder
		}
		data.createBy = User.SYSTEM.username
		data.updateBy = User.SYSTEM.username
		
		if(data.orders > 0 || data.agent > 0) {
			data.save(flush: true, failOnError: true)
		}
	}
}
