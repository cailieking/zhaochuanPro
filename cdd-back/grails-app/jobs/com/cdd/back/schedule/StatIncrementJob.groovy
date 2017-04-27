package com.cdd.back.schedule

import com.cdd.back.domain.StatIncrement
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.User
import com.cdd.base.enums.FrontUserType
import com.cdd.base.service.common.CRUDService

class StatIncrementJob {
	static triggers = {
		cron name: 'StatIncrementTrigger', cronExpression: "0 0 1 ? * 2"
//		cron name: 'StatIncrementTrigger', cronExpression: "0 * * * * ?"
	}
	
	CRUDService CRUDService

	def execute() {
		Calendar thisMonday = Calendar.getInstance()
		thisMonday.clearTime()
		Calendar lastSunday = Calendar.getInstance()
		lastSunday.clearTime()
		lastSunday.add(Calendar.DATE, -1)
		Calendar lastMonday = Calendar.getInstance()
		lastMonday.clearTime()
		lastMonday.add(Calendar.DATE, -7)
		Calendar mondayBeforeLastMonday = Calendar.getInstance()
		mondayBeforeLastMonday.clearTime()
		mondayBeforeLastMonday.add(Calendar.DATE, -14)
		
		int newCargo = countUser(FrontUserType.Cargo, lastMonday, thisMonday)
		int newAgent = countUser(FrontUserType.Agent, lastMonday, thisMonday)
		int totalNewUser = newCargo + newAgent
		int totalCargo = FrontUser.countByType(FrontUserType.Cargo)
		int totalAgent = FrontUser.countByType(FrontUserType.Agent)
		int total = totalCargo + totalAgent
//		int newCargoBefore = countUser(FrontUserType.Cargo, mondayBeforeLastMonday, lastMonday)
//		int newAgentBefore = countUser(FrontUserType.Cargo, mondayBeforeLastMonday, lastMonday)
//		int totalNewUserBefore = newCargoBefore + newAgentBefore
		int newOrder = countOrder(lastMonday, thisMonday)
		int totalOrder = Order.countByDeleted(false)
//		int newOrderBefore = countOrder(mondayBeforeLastMonday, lastMonday)
		
		def c = StatIncrement.createCriteria()
		StatIncrement data = c.get {
			eq 'startDate', lastMonday.getTime()
			eq 'endDate', lastSunday.getTime()
		}
		if(!data) {
			data = new StatIncrement()
			data.startDate = lastMonday.getTime()
			data.endDate = lastSunday.getTime()
			data.createBy = User.SYSTEM.username
		}
		data.newCargoRate = calRate(totalCargo, newCargo)
		data.newAgentRate = calRate(totalAgent, newAgent)
		data.newTotalUserRate = calRate(total, totalNewUser)
		data.newOrderRate = calRate(totalOrder, newOrder)
		data.updateBy = User.SYSTEM.username
		data.save(flush: true)
	} 
	
	private int countUser(type, start, end) {
		def c = FrontUser.createCriteria()
		return c.get {
			projections {
				count("id")
			}
			eq "type", type
			ge 'dateCreated', start.getTime()
			lt 'dateCreated', end.getTime()
		}
	} 
	
	private int countOrder(start, end) {
		def c = Order.createCriteria()
		return c.get {
			projections {
				count("id")
			}
			ge 'dateCreated', start.getTime()
			lt 'dateCreated', end.getTime()
			eq 'deleted', false
		}
	}
	
	private double calRate(total, delta) {
//		return (lastDelta > 0 ? (delta - lastDelta) / lastDelta : delta) * 100 
		return delta / total * 100d
	}
}
