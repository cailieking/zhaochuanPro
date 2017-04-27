package com.cdd.front.service.dbupdator

import com.cdd.base.service.dbupdator.AbstractDatabaseUpdator


abstract class AbstractFrontDatabaseUpdator extends AbstractDatabaseUpdator {

	String getModule() {
		return 'front'	
	}
	
	int getModuleOrder() {
		return 0
	}
	
}
