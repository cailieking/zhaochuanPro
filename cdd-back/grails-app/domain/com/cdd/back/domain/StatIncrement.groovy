package com.cdd.back.domain

import com.cdd.base.domain.BaseDomain

class StatIncrement extends BaseDomain {
	double newAgentRate
	double newCargoRate
	double newTotalUserRate
	double newOrderRate
	Date startDate
	Date endDate
	
	static mapping = {
		table 'stat_increment'
	}
}
