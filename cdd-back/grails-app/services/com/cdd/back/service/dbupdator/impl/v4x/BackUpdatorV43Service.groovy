package com.cdd.back.service.dbupdator.impl.v4x

import org.hibernate.SessionFactory

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.BackUser

class BackUpdatorV43Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	SessionFactory sessionFactory
	
	@Override
	def updateData() {
		def superior = BackUser.get(11)
		if(superior) {
			sessionFactory.currentSession.createSQLQuery("update front_user set update_by='${superior.username}' where update_by='pengliya'").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update orders set update_by='${superior.username}' where update_by='pengliya'").executeUpdate()
			sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set update_by='${superior.username}' where update_by='pengliya'").executeUpdate()
		}
		return null
	}

	@Override
	public int getOrder() {
		return 43;
	}
}
