package com.cdd.back.service.dbupdator.impl.v3x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV37Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			CREATE TABLE `stat_staff` (
				`id` bigint(20) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` timestamp NOT NULL,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`import_front_users` int(11) NOT NULL,
				`import_ship_infos` int(11) NOT NULL,
				`import_orders` int(11) NOT NULL,
				`user_id` bigint(20) NOT NULL,
				`order_passed` int(11) NOT NULL,
				`ship_passed` int(11) NOT NULL,
				`trade_success` int(11) NOT NULL,
				`cert_passed` int(11) NOT NULL,
				PRIMARY KEY (`id`),
				INDEX `idx_back_user_id` (`user_id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		return sqls
	}
	

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 37;
	}
}
