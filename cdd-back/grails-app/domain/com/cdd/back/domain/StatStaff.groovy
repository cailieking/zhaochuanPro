package com.cdd.back.domain

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.BaseDomain

class StatStaff extends BaseDomain {
	BackUser user
	int importAgentUsers
	int importCargoUsers
	int importShipInfos
	int importOrders
	int shipPassed
	int orderPassed
	int tradeSuccess
	int certPassed
	
	static mapping = {
		table 'stat_staff'
	}
}
