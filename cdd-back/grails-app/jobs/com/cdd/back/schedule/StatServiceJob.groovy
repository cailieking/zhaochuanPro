package com.cdd.back.schedule

import com.cdd.back.domain.FakeFrontUser
import com.cdd.back.domain.StatStaff
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.User
import com.cdd.base.enums.FrontUserType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.Status

class StatServiceJob {
	static triggers = {
		cron name: 'StatServiceTrigger', cronExpression: "0 0 * * * ?"
	}

	def execute() {
//		def query = BackUser.createCriteria()
//		def users = query.list {
//			role {
//				or {
//					eq "name", Position.Sales.text
//					eq "name", Position.Service.text
//				}
//			}
//		}
		BackUser.all.each { BackUser user ->
			StatStaff stat = StatStaff.findByUser(user)
			if(!stat) {
				stat = new StatStaff()
				stat.user = user
			}

			def counts = [
				FrontUserType.Agent,
				FrontUserType.Cargo
			].collect { FrontUserType type ->
				def c = FrontUser.createCriteria()
				return c.get {
					projections { count "id" }
					eq "createBy", user.username
					eq "type", type
				}
			}
			stat.importAgentUsers = counts[0]
			stat.importCargoUsers = counts[1]
			
			counts = [
				FrontUserType.Agent,
				FrontUserType.Cargo
			].collect { FrontUserType type ->
				def c = FakeFrontUser.createCriteria()
				return c.get {
					projections { count "id" }
					eq "createBy", user.username
					eq "type", type
				}
			}
			stat.importAgentUsers += counts[0]
			stat.importCargoUsers += counts[1]

			counts = [
				Order,
				CargoShipInformation
			].collect { clazz ->
				def c = clazz.createCriteria()
				return c.get {
					projections { count "id" }
					eq "createBy", user.username
				}
				if(clazz != FrontUser) {
					eq "deleted", false
				}
			}
			stat.importOrders = counts[0]
			stat.importShipInfos = counts[1]

			counts = [Order, CargoShipInformation].collect { clazz ->
				def c = clazz.createCriteria()
				return c.get {
					projections { count "id" }
					or {
						eq "service", user
						if(clazz == Order) {
							eq "sales", user
						}
					}
					eq "status", Status.VerifyPassed
					eq "deleted", false
				}
			}
			stat.orderPassed = counts[0]
			stat.shipPassed = counts[1]

			counts = [
				OrderStatus.TradeSuccess,
				OrderStatus.CertPassed
			].collect { orderStatus ->
				def c = Order.createCriteria()
				return c.get {
					projections { count "id" }
					eq "sales", user
					eq "orderStatus", orderStatus
					eq "deleted", false
				}
			}
			stat.tradeSuccess = counts[0]
			stat.certPassed = counts [1]

			stat.createBy = User.SYSTEM.username
			stat.updateBy = User.SYSTEM.username

			stat.save(flush: true)
		}
	}
}
