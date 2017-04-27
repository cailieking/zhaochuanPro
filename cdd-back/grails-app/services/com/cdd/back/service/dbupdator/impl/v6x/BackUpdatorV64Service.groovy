package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV64Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			CREATE TABLE IF NOT EXISTS `company_certificate` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,
				`image` varchar(500) NOT NULL,
				`company_id` bigint(20) NOT NULL,
				PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
		 
		return sqls
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
		 [url: '/company/certificate/**', description: '公司三证查看', authority: "AUTH_COMPANY_CERTIFICATE_PASS"],
			[url: '/company/recognized/**', description: '公司一键认证', authority: "AUTH_COMPANY_RECOGNIZED_PASS"],
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		return null
	}

	@Override
	public int getOrder() {
		return 64
	}
}
