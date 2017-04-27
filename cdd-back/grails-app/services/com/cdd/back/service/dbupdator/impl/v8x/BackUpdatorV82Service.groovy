package com.cdd.back.service.dbupdator.impl.v8x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV82Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls=[]
		
			
		sqls << """
		
		CREATE TABLE IF NOT EXISTS `order_price` (
				  `id` bigint(20) NOT NULL AUTO_INCREMENT,
				  `create_by` varchar(50) COLLATE utf8_bin NOT NULL,
				  `update_by` varchar(50) COLLATE utf8_bin NOT NULL,
				  `date_created` datetime NOT NULL,
				  `last_updated` datetime NOT NULL,
				  `company_name` varchar(50) COLLATE utf8_bin NOT NULL,
				  `mobile` varchar(50) COLLATE utf8_bin NOT NULL,
				  `qq` varchar(50) COLLATE utf8_bin DEFAULT NULL,
				  `contact_man` varchar(50) COLLATE utf8_bin DEFAULT NULL,
					`operate_by` varchar(50) COLLATE utf8_bin DEFAULT NULL,
					`finish_by` varchar(50) COLLATE utf8_bin DEFAULT NULL,
					`operate_opinion` varchar(50) COLLATE utf8_bin DEFAULT NULL,
					`operate_time` datetime DEFAULT NULL,
					`status` varchar(50) COLLATE utf8_bin NOT NULL,
					`order_descript` varchar(50) COLLATE utf8_bin DEFAULT NULL,
				  `info_id` bigint(20) DEFAULT NULL,
				  `order_id` bigint(20) DEFAULT NULL,
				  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL,
				  `number` varchar(50) COLLATE utf8_bin NOT NULL,
				  `delete_status` varchar(50) COLLATE utf8_bin NOT NULL,
				  PRIMARY KEY (`id`),
				  KEY `FK_aaaaaa` (`info_id`),
				  KEY `FK_bbbbbb` (`order_id`),
				  CONSTRAINT `FK_aaaaaa` FOREIGN KEY (`info_id`) REFERENCES `cargo_ship_information` (`id`),
				  CONSTRAINT `FK_bbbbbb` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


		"""
		
				 
		 return sqls
	}

	@Override
	def updateData() {
			
		return null
	}

	@Override
	public int getOrder() {
		return 82
	}
}