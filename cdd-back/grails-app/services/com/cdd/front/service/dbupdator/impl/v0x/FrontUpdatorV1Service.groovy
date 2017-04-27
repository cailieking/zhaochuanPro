package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.base.domain.FrontAuthority
import com.cdd.base.domain.User
import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator


class FrontUpdatorV1Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			CREATE TABLE `advertisement` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `image` varchar(500) COLLATE utf8_bin NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `orders` int(11) NOT NULL,
			  `type` varchar(255) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `url` varchar(500) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `article_information` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `article_type` varchar(255) COLLATE utf8_bin NOT NULL,
			  `content` longtext COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `is_image` bit(1) NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `orders` int(11) NOT NULL,
			  `title` varchar(500) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `url` varchar(500) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `front_user` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `account_expiry_date` datetime DEFAULT NULL,
			  `account_locked_count` int(11) NOT NULL,
			  `address` varchar(500) COLLATE utf8_bin NOT NULL,
			  `birth` datetime DEFAULT NULL,
			  `city` varchar(50) COLLATE utf8_bin NOT NULL,
			  `company_name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `email` varchar(255) COLLATE utf8_bin NOT NULL,
			  `enabled` bit(1) NOT NULL,
			  `firstname` varchar(255) COLLATE utf8_bin NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `lastname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `login_time` datetime DEFAULT NULL,
			  `middlename` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `mobile` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `password` varchar(255) COLLATE utf8_bin NOT NULL,
			  `password_expiry_date` datetime DEFAULT NULL,
			  `phone` varchar(50) COLLATE utf8_bin DEFAULT NULL,
			  `qq` varchar(50) COLLATE utf8_bin DEFAULT NULL,
			  `salt` varchar(20) COLLATE utf8_bin NOT NULL,
			  `sex` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `username` varchar(255) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_bkjpnwyb8gvgh006dwjnvjyxi` (`email`),
			  UNIQUE KEY `UK_ntucmjl5ng9re1ctkgl0i15w8` (`username`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `cargo_ship_information` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `city` varchar(50) COLLATE utf8_bin NOT NULL,
			  `company_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `contact_name` varchar(50) COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date` datetime DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `days` int(11) NOT NULL,
			  `end_date` datetime DEFAULT NULL,
			  `end_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `memo` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `middle_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `phone` varchar(50) COLLATE utf8_bin NOT NULL,
			  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `route_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `ship_company` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `shipping_day` varchar(20) COLLATE utf8_bin DEFAULT NULL,
			  `shipping_days` int(11) NOT NULL,
			  `start_date` datetime DEFAULT NULL,
			  `start_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `status` varchar(255) COLLATE utf8_bin NOT NULL,
			  `trans_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `user_id` bigint(20) NOT NULL,
			  PRIMARY KEY (`id`),
			  KEY `FK_n8gb8qfh0dfpyk2qvjo4j09lh` (`user_id`),
			  CONSTRAINT `FK_n8gb8qfh0dfpyk2qvjo4j09lh` FOREIGN KEY (`user_id`) REFERENCES `front_user` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `front_authority` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `authority` varchar(255) COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `front_authority_users` (
			  `front_user_id` bigint(20) NOT NULL,
			  `authority_id` bigint(20) NOT NULL,
			  PRIMARY KEY (`authority_id`,`front_user_id`),
			  KEY `FK_9kcv5ind3aq9yqhqbh1ton125` (`front_user_id`),
			  CONSTRAINT `FK_7tms7wylj24oqp5mahon4pc0h` FOREIGN KEY (`authority_id`) REFERENCES `front_authority` (`id`),
			  CONSTRAINT `FK_9kcv5ind3aq9yqhqbh1ton125` FOREIGN KEY (`front_user_id`) REFERENCES `front_user` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `image_information` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `orders` int(11) NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `url` varchar(500) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `orders` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `agent_id` bigint(20) NOT NULL,
			  `bite_end_date` datetime DEFAULT NULL,
			  `cargo_box_nums` int(11) NOT NULL,
			  `cargo_box_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `cargo_cube` double NOT NULL,
			  `cargo_height` double NOT NULL,
			  `cargo_length` double NOT NULL,
			  `cargo_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `cargo_nums` int(11) NOT NULL,
			  `cargo_weight` double NOT NULL,
			  `cargo_width` double NOT NULL,
			  `city` varchar(50) COLLATE utf8_bin NOT NULL,
			  `company_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `contact_name` varchar(50) COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `deal_price` decimal(19,2) NOT NULL,
			  `end_date` datetime DEFAULT NULL,
			  `end_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `info_id` bigint(20) NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `memo` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `number` varchar(50) COLLATE utf8_bin DEFAULT NULL,
			  `order_status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `order_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `owner_id` bigint(20) NOT NULL,
			  `phone` varchar(50) COLLATE utf8_bin NOT NULL,
			  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `start_date` datetime DEFAULT NULL,
			  `start_port` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `status` varchar(255) COLLATE utf8_bin NOT NULL,
			  `trans_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_sft0o3ihy2jyuq8rth4o136j7` (`number`),
			  KEY `FK_ic9f3nv6s4r99gdo3xrbmj57s` (`agent_id`),
			  KEY `FK_oglhfdrr1s2lauuq6kjcgxhkq` (`info_id`),
			  KEY `FK_iy415fsyvymv9u2qj1tsuliv2` (`owner_id`),
			  CONSTRAINT `FK_ic9f3nv6s4r99gdo3xrbmj57s` FOREIGN KEY (`agent_id`) REFERENCES `front_user` (`id`),
			  CONSTRAINT `FK_iy415fsyvymv9u2qj1tsuliv2` FOREIGN KEY (`owner_id`) REFERENCES `front_user` (`id`),
			  CONSTRAINT `FK_oglhfdrr1s2lauuq6kjcgxhkq` FOREIGN KEY (`info_id`) REFERENCES `cargo_ship_information` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		sqls << """
			CREATE TABLE `ship_prices` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `extra` decimal(19,2) NOT NULL,
			  `gp20` decimal(19,2) DEFAULT NULL,
			  `gp40` decimal(19,2) DEFAULT NULL,
			  `hq40` decimal(19,2) DEFAULT NULL,
			  `hq45` decimal(19,2) DEFAULT NULL,
			  `info_id` bigint(20) NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_h5sstugbu5du77fbbhtpwo4mq` (`info_id`),
			  CONSTRAINT `FK_h5sstugbu5du77fbbhtpwo4mq` FOREIGN KEY (`info_id`) REFERENCES `cargo_ship_information` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""

		return sqls
	}

	@Override
	def updateData() {
		[
			'ROLE_CLIENT',
			'ROLE_CARGO_OWNER',
			'ROLE_SHIP_AGENT',
		].each {
			FrontAuthority auth = new FrontAuthority(authority: it, createBy: User.SYSTEM.username, updateBy: User.SYSTEM.username)
			auth.save()
		}
		return null
	}

	@Override
	public int getOrder() {
		return 1;
	}
}
