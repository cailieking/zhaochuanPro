package com.cdd.back.service.dbupdator.impl.v2x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV21Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
//		sqls << """
//			ALTER TABLE `orders` 
//				ADD COLUMN `start_port_cn` varchar(255) AFTER `cert_file_path`, 
//				ADD COLUMN `end_port_cn` varchar(255) AFTER `start_port_cn`;
//		"""
		
		return sqls
	}
	
	
	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/shipInfo/downloadExample/**', description: '下载货代模板', authority: "AUTH_SHIP_DOWNLOAD_EXAMPLE"],
			[url: '/order/downloadExample/**', description: '下载订单模板', authority: "AUTH_ORDER_DOWNLOAD_EXAMPLE"],
			[url: '/order/importData/**', description: '导入订单信息', authority: "AUTH_ORDER_IMPORT_DATA"],
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
		return 21;
	}
}
