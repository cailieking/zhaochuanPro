package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator


class FrontUpdatorV16Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `orders` ADD COLUMN `sales_id` bigint(20) AFTER `update_by`, 
			ADD COLUMN `service_id` bigint(20) AFTER `sales_id`;
		"""
		
		sqls << """
			ALTER TABLE `orders` CHANGE COLUMN `cargo_box_nums` `cargo_box_nums` int(11), 
				CHANGE COLUMN `cargo_cube` `cargo_cube` double, 
				CHANGE COLUMN `cargo_height` `cargo_height` double, 
				CHANGE COLUMN `cargo_length` `cargo_length` double, 
				CHANGE COLUMN `cargo_nums` `cargo_nums` int(11), 
				CHANGE COLUMN `cargo_weight` `cargo_weight` double, 
				CHANGE COLUMN `cargo_width` `cargo_width` double; 
		"""
		
		sqls << """
			ALTER TABLE `orders` ADD COLUMN `cert_file_path` varchar(255) AFTER `service_id`;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_information` 
			CHANGE COLUMN `user_id` `owner_id` bigint(20) DEFAULT NULL, 
			ADD COLUMN `service_id` bigint(20) AFTER `owner_id`;
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `city_id` `city_id` bigint(20);
		"""
		
		sqls << """
			ALTER TABLE `cargo_ship_information` 
				CHANGE COLUMN `city_id` `city_id` bigint(20), 
				CHANGE COLUMN `contact_name` `contact_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin, 
				CHANGE COLUMN `phone` `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin;
		"""
		
		return sqls
	}


	@Override
	def updateData() {

		return null
	}

	@Override
	public int getOrder() {
		return 16;
	}
}
