package com.cdd.base.service.dbupdator

import com.cdd.base.constant.DatabaseConstant


abstract class AbstractBaseModuleDatabaseUpdator extends AbstractDatabaseUpdator {
	
	/**
	 * return the default module name
	 * @return
	 */
	String getModule() {
		DatabaseConstant.DEFAULT_MODULE
	}
	
	
}
