package com.cdd.back.service.dbupdator

import com.cdd.base.service.dbupdator.AbstractDatabaseUpdator


abstract class AbstractBackDatabaseUpdator extends AbstractDatabaseUpdator {

	String getModule() {
		return 'back'	
	}
	
	int getModuleOrder() {
		return 1
	}
}
