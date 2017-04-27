package com.cdd.base.service.common

import grails.transaction.Transactional

import com.cdd.base.domain.NewRoute


@Transactional
class CommonService {
	
	List<NewRoute>  getNewRoutes(){
		def list = NewRoute.list();
		return list
	}
	
}
