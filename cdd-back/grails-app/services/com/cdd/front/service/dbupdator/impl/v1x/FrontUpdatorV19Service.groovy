package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV19Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
	
		sqls << """
			ALTER TABLE `front_user` CHANGE COLUMN `company_name` `company_name` varchar(50) NOT NULL;
		"""
		
		sqls << """
			ALTER TABLE `orders` CHANGE COLUMN `company_name` `company_name` varchar(50) NOT NULL;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `company_name` `company_name` varchar(50) NOT NULL;
		"""
		
		
		sqls << """
			ALTER TABLE cargo_ship_item_score DROP FOREIGN KEY `FK_aho96yhb5wtk9x5nbhtpfvax3`
		"""
		
		sqls << """
			ALTER TABLE cargo_ship_item_score DROP COLUMN `agent_id`;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_item_score` ADD COLUMN `company_name` varchar(50) NOT NULL;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_item_score` ADD KEY `UK_abcetfbn95aa2213ghlpwofgh` (`company_name`);
		"""
		
		
		sqls << """
			ALTER TABLE cargo_ship_score DROP FOREIGN KEY `FK_sm89tugbuwtk9x5nbhtpwo4mq`
		"""
		
		sqls << """
			ALTER TABLE cargo_ship_score DROP COLUMN `agent_id`;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_score` ADD COLUMN `company_name` varchar(50) NOT NULL;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_score` ADD UNIQUE KEY `UK_6ysstfbn95bv8943ghlpwonlj` (`company_name`);
		"""
		
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 19;
	}
}
