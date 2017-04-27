package com.cdd.back.service.dbupdator.impl.v5x

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator

class BackUpdatorV52Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			ALTER TABLE `fake_front_user` CHANGE COLUMN `type` `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin;
		"""
		return sqls
	}

	V52Service v52Service
	
	@Override
	def updateData() {
		def count = 1
		while(count > 0) {
			v52Service.update()
			count = v52Service.count()
			log.info "Transfer data from FrontUser to FakeFrontUser, current count: ${count}"
		}
		return null
	}

	@Override
	public int getOrder() {
		return 52
	}
}
