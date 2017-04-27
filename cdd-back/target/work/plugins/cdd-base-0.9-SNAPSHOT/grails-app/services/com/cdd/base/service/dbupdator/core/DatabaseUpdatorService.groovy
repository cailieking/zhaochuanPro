package com.cdd.base.service.dbupdator.core

import grails.transaction.Transactional

import org.hibernate.Session
import org.hibernate.SessionFactory
import org.springframework.beans.factory.InitializingBean

import com.cdd.base.constant.DatabaseConstant
import com.cdd.base.domain.DatabaseUpdate
import com.cdd.base.domain.User
import com.cdd.base.service.dbupdator.AbstractDatabaseUpdator;

class DatabaseUpdatorService implements InitializingBean {
	SessionFactory sessionFactory

	@Transactional
	def update(AbstractDatabaseUpdator updator) {
		int max = 0
		def latestUpdate = DatabaseUpdate.findByModule(updator.module, [sort: "ver", order: DatabaseConstant.ORDER_BY_DESC, max: 1])
		if(latestUpdate) {
			max = latestUpdate.ver
		}
		if (updator.order > max) {
			log.info "Start to update database in module [${updator.module}], version [${updator.order}] ......"
			def ops = [
				"updateSchema",
				"updateData"
			]
			Session session = sessionFactory.currentSession
			for(op in ops) {
				updator."$op"()?.each { sql ->
					session.createSQLQuery(sql).executeUpdate()
				}
			}
			DatabaseUpdate dbupdate = new DatabaseUpdate(module: updator.module, ver: updator.order)
			dbupdate.createBy = User.SYSTEM.username
			dbupdate.updateBy = User.SYSTEM.username
			dbupdate.save()
		}
	}
	
	@Override
	public void afterPropertiesSet() throws Exception {
		Session session = sessionFactory.currentSession
		session.createSQLQuery("""\
			CREATE TABLE IF NOT EXISTS `database_update` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `module` varchar(255) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `ver` int(11) NOT NULL,
			  PRIMARY KEY (`id`),
			  KEY `index_module` (`module`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		""").executeUpdate()
	}
	
}
