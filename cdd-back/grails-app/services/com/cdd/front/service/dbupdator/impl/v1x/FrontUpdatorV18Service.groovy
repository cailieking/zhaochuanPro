package com.cdd.front.service.dbupdator.impl.v1x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV18Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			CREATE TABLE `cargo_ship_item_score` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `ship_in_time` int(11) COLLATE utf8_bin NOT NULL,
			  `doc_in_time` int(11) COLLATE utf8_bin NOT NULL,
			  `info_in_time` int(11) COLLATE utf8_bin NOT NULL,
			  `service_quality` int(11) COLLATE utf8_bin NOT NULL,
			  `order_id` bigint(20) NOT NULL,
			  `agent_id` bigint(20) NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_h5sstugbu5bv89fbbhtpwonlj` (`order_id`),
			  CONSTRAINT `FK_sm89tugbu5du77bnbhtpwo4mq` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
			  CONSTRAINT `FK_aho96yhb5wtk9x5nbhtpfvax3` FOREIGN KEY (`agent_id`) REFERENCES `front_user` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `cargo_ship_score` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `ship_in_time` double NOT NULL,
			  `doc_in_time` double NOT NULL,
			  `info_in_time` double NOT NULL,
			  `service_quality` double NOT NULL,
			  `agent_id` bigint(20) NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_h5fhl90bu5bv89fbbhtpwo7lj` (`agent_id`),
			  CONSTRAINT `FK_sm89tugbuwtk9x5nbhtpwo4mq` FOREIGN KEY (`agent_id`) REFERENCES `front_user` (`id`)
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
		return 18;
	}
}
