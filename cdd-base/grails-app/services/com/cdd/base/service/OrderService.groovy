package com.cdd.base.service

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import org.hibernate.SessionFactory

import com.cdd.base.domain.Order

class OrderService {
	SessionFactory sessionFactory

	def createNumber() {
		DecimalFormat df = new DecimalFormat('000')
		SimpleDateFormat sdf = new SimpleDateFormat('yyMMdd')
		String numberPrefix = sdf.format(new Date())
		def maxNumber = sessionFactory.currentSession.createSQLQuery("""
				select number from orders where number like '${numberPrefix}%' order by number desc limit 0,1 for update
				""").uniqueResult()
		if(!maxNumber) {
			maxNumber = 0
		} else {
			maxNumber = df.parse(maxNumber.replace(numberPrefix, '')) + 1
		}
		return numberPrefix + df.format(maxNumber)
	}

	def insert(Order data) {
		data.number = createNumber()
		data.save()
	}
}

