package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV7Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			ALTER TABLE `cargo_ship_information` 
			CHANGE COLUMN `city` `city_id` bigint(20) NOT NULL; 
			"""
		sqls << """
			ALTER TABLE `cargo_ship_information` 
			ADD CONSTRAINT `FK_123b8jjk0dfpsk2q37upl09l2` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);
			"""
		sqls << """
			ALTER TABLE `orders` 
			CHANGE COLUMN `city` `city_id` bigint(20) NOT NULL; 
			"""
		sqls << """
			ALTER TABLE `orders` 
			ADD CONSTRAINT `FK_583b8klj0dfpjm9q36jla06l9` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);
			"""
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 7;
	}
}
