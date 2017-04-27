package com.cdd.front.service.dbupdator.impl.v2x

import java.text.DecimalFormat

import com.cdd.base.domain.Order
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator


class FrontUpdatorV24Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			ALTER TABLE `orders` 
				ADD COLUMN `start_port_cn` varchar(255) AFTER `cert_file_path`, 
				ADD COLUMN `end_port_cn` varchar(255) AFTER `start_port_cn`;
		"""

		sqls << """
			ALTER TABLE `cargo_ship_information` 
				ADD COLUMN `start_port_cn` varchar(255) AFTER `wanted_order_id`, 
				ADD COLUMN `end_port_cn` varchar(255) AFTER `start_port_cn`, 
				ADD COLUMN `middle_port_cn` varchar(255) AFTER `end_port_cn`;
		"""

		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `weight_limit` double(20,3) AFTER `wanted_order_id`;
		"""

		sqls << """
			ALTER TABLE `orders` CHANGE COLUMN `deal_price` `deal_price` decimal(19,2);
		"""

		sqls << """
			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `weight_limit` `weight_limit` varchar(500) DEFAULT NULL;
		"""

		sqls << """
			ALTER TABLE `orders` CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""

		sqls << """
			ALTER TABLE `cargo_ship_information` CHANGE COLUMN `company_name` `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
		"""

		sqls << """
			ALTER TABLE `orders` ADD COLUMN `deleted` bit(1) NOT NULL AFTER `end_port_cn`;
		"""

		sqls << """
			ALTER TABLE `cargo_ship_information` ADD COLUMN `deleted` bit(1) NOT NULL AFTER `middle_port_cn`;
		"""

		return sqls
	}

	@Override
	def updateData() {

		DecimalFormat df = new DecimalFormat('00000000')
		int count = 0
		Order.all?.each { Order data ->
			data.number = df.format(count++)
			data.save()
		}

		return null
	}


	@Override
	public int getOrder() {
		return 24;
	}
}
