package com.cdd.front.service.dbupdator.impl.v2x

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV26Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		
		return null
	}
	
	@Override
	def updateData() {
		DecimalFormat df = new DecimalFormat('000')
		SimpleDateFormat sdf = new SimpleDateFormat('yyMMdd')
		SimpleDateFormat sdf2 = new SimpleDateFormat('yyyy-MM-dd')
		def map = [:]
		Order.all?.each { Order data ->
			Integer count = map[sdf2.format(data.dateCreated)]
			if(count != null) {
				count++
			} else {
				count = 0
			}
			map[sdf2.format(data.dateCreated)] = count
			data.number = sdf.format(data.dateCreated) + df.format(count)
			data.save()
		}
		return null
	}


	@Override
	public int getOrder() {
		return 26
	}
}
