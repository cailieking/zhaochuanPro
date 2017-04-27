package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.User

class BackUpdatorV62Service extends AbstractBackDatabaseUpdator {
 @Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE `stat_increment` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`new_cargo_rate` decimal(19,2) NOT NULL,
				`new_agent_rate` decimal(19,2) NOT NULL,
				`new_total_user_rate` decimal(19,2) NOT NULL,
				`new_order_rate` decimal(19,2) NOT NULL,
				`start_date` date NOT NULL,
				`end_date` date NOT NULL,
				`last_updated` datetime NOT NULL,
				`date_created` datetime NOT NULL,
				`update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				`create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
				PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		return sqls
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username

		Menu menu_system = Menu.findByName('数据统计')

		menuHelper.createMenu([authority: 'AUTH_STAT_INCREMENT_LIST',
			url: '/statIncrement/list/**',
			description: '新增率统计'],
		[name: '新增率统计', icon: 'bar-chart'], menu_system)

		return null
	}

	@Override
	public int getOrder() {
		return 62
	}
}
