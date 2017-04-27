package com.cdd.back.service.dbupdator.impl.v4x

import org.hibernate.SessionFactory

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.BackUser

class BackUpdatorV42Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	SessionFactory sessionFactory
	
	@Override
	def updateData() {
		def superior = BackUser.get(11)
		if(superior) {
			sessionFactory.currentSession.createSQLQuery("update orders set service_id=${superior.id} where service_id=4").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update orders set sales_id=${superior.id} where sales_id=4").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set service_id=${superior.id} where service_id=4").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update front_user set create_by='${superior.username}' where create_by='pengliya'").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update orders set create_by='${superior.username}' where create_by='pengliya'").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set create_by='${superior.username}' where create_by='pengliya'").executeUpdate()
		}
		return null
	}

	@Override
	public int getOrder() {
		return 42;
	}
}
