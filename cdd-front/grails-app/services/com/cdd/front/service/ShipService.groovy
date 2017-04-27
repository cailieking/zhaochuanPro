package com.cdd.front.service

import java.text.DecimalFormat
import java.text.SimpleDateFormat

import org.hibernate.SessionFactory

class ShipService {
	SessionFactory sessionFactory
	
	def list(String searchKey) {
		StringWriter sql = new StringWriter()
		sql << """
			select * from cargo_ship_information where 1=1
		"""
		if(searchKey) {
			sql << """
				and company_name like '%${searchKey}%'
			"""
		}
		sql << """
		limit 0, 10
		"""
		log.info sql
		
		def query = sessionFactory.currentSession.createSQLQuery(sql.toString())
		
		return query.list()
	}
}

