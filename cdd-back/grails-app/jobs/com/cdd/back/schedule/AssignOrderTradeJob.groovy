package com.cdd.back.schedule

import com.cdd.back.cache.JobCache
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.Role
import com.cdd.base.enums.Status
import com.cdd.base.service.common.CRUDService

class AssignOrderTradeJob {
	static triggers = {
//		cron name: 'AssignOrderTradeTrigger', cronExpression: "0 * * * * ?"
	}

	CRUDService CRUDService
	
	def execute(){
		int offset = 0
		def list = [0]
		Role role = Role.findByName('业务员')
		def c = BackUser.createCriteria()
		def staffs = c.list { eq "role", role }
		if(!JobCache.map.assignOrderTradeJob_pos) {
			JobCache.map.assignOrderTradeJob_pos = 0
		}
		int pos = JobCache.map.assignOrderTradeJob_pos
		if(staffs) {
			while(list) {
				list = CRUDService.list(Order, [offset: offset, max: staffs.size(), "f_isNull_sales": null, "f_status": Status.VerifyPassed]).list
				list.eachWithIndex { data, index ->
					if(pos == staffs.size()) {
						pos = 0
					}
					data.sales = staffs[pos++]
				}
				Order.saveAll(list)
				offset += staffs.size()
			}
		}
		JobCache.map.assignOrderTradeJob_pos = pos
	}
}
