package com.cdd.back.service.dbupdator.impl.v4x

import org.hibernate.SessionFactory

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV45Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			update front_user set create_by=username, update_by=username where create_by='system';
		"""
		
		sqls << """
			CREATE TABLE `fake_front_user` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `account_expiry_date` datetime DEFAULT NULL,
			  `account_locked_count` int(11) NOT NULL,
			  `address` varchar(500) COLLATE utf8_bin DEFAULT NULL,
			  `birth` datetime DEFAULT NULL,
			  `city_id` bigint(20) NOT NULL,
			  `company_name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `date_created` datetime NOT NULL,
			  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
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
				`type` varchar(50) COLLATE utf8_bin NOT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_bkjpnwyb8gvgh006dwjnvjyxi` (`email`),
			  UNIQUE KEY `UK_ntucmjl5ng9re1ctkgl0i15w8` (`username`)
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
		return 45;
	}
}
