package com.cdd.base.service.dbupdator

import grails.transaction.Transactional

import org.springframework.core.Ordered

import com.cdd.base.service.dbupdator.core.DatabaseUpdatorService;


@Transactional
abstract class AbstractDatabaseUpdator implements Ordered {
	DatabaseUpdatorService databaseUpdatorService
	
	/**
	 * update database schema
	 * can handle by self or return DDL SQLs
	 * if handle by self then no need return
	 * @return
	 */
	def abstract updateSchema()
	
	/**
	 * update data, this will execution after updateSchema
	 * can handle by self or return DML SQLs
	 * @return
	 */
	def abstract updateData()
	
	/**
	 * return the model for the updator
	 * @return
	 */
	abstract String getModule()
	
	public void update() throws Exception {
		databaseUpdatorService.update(this)
	}
	
	abstract int getModuleOrder()
}
