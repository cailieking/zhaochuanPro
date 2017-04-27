package com.cdd.front.service.dbupdator.impl.v2x

import com.cdd.base.enums.OrderType
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator


class FrontUpdatorV22Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}
	
	@Override
	def updateData() {
		def sqls = []
		
		sqls << """
			delete from orders where order_type is null;
		"""
		
		sqls << """
			update orders set order_type='${OrderType.Furniture.text}' where order_type='${OrderType.Furniture.name()}';
		"""
		
		sqls << """
			update orders set order_type='${OrderType.Building.text}' where order_type='${OrderType.Building.name()}';
		"""
		
		sqls << """
			update orders set order_type='${OrderType.Clothing.text}' where order_type='${OrderType.Clothing.name()}';
		"""
		
		return sqls
	}


	@Override
	public int getOrder() {
		return 22;
	}
}
