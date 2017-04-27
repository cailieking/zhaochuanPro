package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV75Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls=[]
		sqls<<"""\
		CREATE TABLE IF NOT EXISTS `matchmaking` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,
				
				`saler` varchar(100) NOT NULL,
				`commit_date` datetime ,
				`start_ship_date` datetime ,
				
		`booking_no` varchar(100),
		`bl_no` varchar(100),
		`ship_company` varchar(100),
		`cargo_name` varchar(100),
		`offer_name` varchar(100),
		`area` varchar(100),
		`company_scale` varchar(100),
		`gp20` varchar(100),
		`gp40` varchar(100),
		`hq40` varchar(100),
		`product_name` varchar(100),
		`start_port` varchar(100),
		`end_port` varchar(100),
		`route` varchar(100),
		`of_usd` varchar(100),
		`isps_usd` varchar(100),
		`thc_rmb` varchar(100),
		`doc_rmb` varchar(100),
		`seal_rmb` varchar(100),
		`eir_rmb` varchar(100),
		`other_rmb` varchar(100),
		`remark` varchar(100),
		
				
				PRIMARY KEY (`id`)
			)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		
		
		"""
		
		 
		return sqls
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		Menu menu_system = Menu.findByName('数据统计') 
		
		menuHelper.createMenu([authority: 'AUTH_MATCHMAKING_LIST',
			url: '/matchmaking/list/**',
			description: '撮合交易列表'],
		[name: '撮合交易列表', icon: 'bookmark-o'], menu_system);
		
		[
			[url: '/matchmaking/data/**', description: '查看撮合交易信息', authority: "AUTH_MATCHMAKING_DATA"],
			[url: '/matchmaking/importData/**', description: '导入撮合交易信息', authority: "AUTH_MATCHMAKING_IMPORTDATA"],
			[url: '/matchmaking/downloadExample/**', description: '撮合交易模板下载', authority: "AUTH_MATCHMAKING_DOENLOADEXAMPLE"],
			
			
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
		return 75
	}
}
