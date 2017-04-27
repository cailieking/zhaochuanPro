package com.cdd.back.service.dbupdator.impl.v13x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV130Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
//		sqls << """
//
//			CREATE TABLE  IF NOT EXISTS `inquiry_offer_price` (
//				  `id` bigint(20) NOT NULL AUTO_INCREMENT,
//				  `number` varchar(50) NOT NULL,
//				  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//				  `date_created` datetime NOT NULL,
//				  `last_updated` datetime NOT NULL,
//				  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//	 
//				  `start_port` varchar(50) DEFAULT NULL,
//				  `end_port` varchar(50) DEFAULT NULL,
//				  `gp20` int(50) DEFAULT NULL,
//				  `gp40` int(50) DEFAULT NULL,
//				  `hq40` int(50) DEFAULT NULL,
//				  `hq45` int(50) DEFAULT NULL,
//				  `remarks` varchar(255) DEFAULT NULL,
//				  `business_man` varchar(50) DEFAULT NULL,
//				  `ship_company` varchar(255) DEFAULT NULL,
//				  `orders_type` varchar(255) DEFAULT NULL,
//				  `orders_name` varchar(50) DEFAULT NULL,
//				  `weight` varchar(50) DEFAULT NULL,
//				  `orders_status` varchar(50) DEFAULT NULL,
//				  `send_time` datetime DEFAULT NULL,
//				  `special_container` varchar(50) DEFAULT NULL,
//				  `free_demurrage` varchar(255) DEFAULT NULL,
//				  `other_remarks` varchar(255) DEFAULT NULL,
//				  `shipper` varchar(50) DEFAULT NULL,
//				  `company_name` varchar(50) DEFAULT NULL,
//				  `custom_name` varchar(50) DEFAULT NULL,
//				  `phone` varchar(50) DEFAULT NULL,
//				  `qq` varchar(50) DEFAULT NULL,
//				  `email` varchar(50) DEFAULT NULL,
//				  `inquiry_sales` varchar(50) DEFAULT NULL,
//				  `inquiry_status` varchar(50) DEFAULT NULL,
//				  `price_gp20` decimal(19,2) DEFAULT NULL,
//				  `price_gp40` decimal(19,2) DEFAULT NULL,
//				  `price_hq40` decimal(19,2) DEFAULT NULL,
//				  `price_hq45` decimal(19,2) DEFAULT NULL,
//				  `new_gp20` decimal(19,2) DEFAULT NULL,
//				  `new_gp40` decimal(19,2) DEFAULT NULL,
//				  `new_hq40` decimal(19,2) DEFAULT NULL,
//				  `new_hq45` decimal(19,2) DEFAULT NULL,
//				  `ship_company_business` varchar(255) DEFAULT NULL,
//				  `shipping_day_business` varchar(50) DEFAULT NULL,
//				  `shippingdays` varchar(50) DEFAULT NULL,
//				  `weight_limit` varchar(50) DEFAULT NULL,
//				  `supplier` varchar(255) DEFAULT NULL,
//				  `free_demurrage_business` varchar(50) DEFAULT NULL,
//				  `price_remarks` varchar(255) DEFAULT NULL,
//				  PRIMARY KEY (`id`)
//				) ENGINE=InnoDB DEFAULT CHARSET=utf8;
//		
//
//		"""	
//		sqls << """
//					CREATE TABLE IF NOT EXISTS `show_inquiry`(
//					  `id` bigint(20) NOT NULL AUTO_INCREMENT,
//					  `number` varchar(50) DEFAULT NULL,
//					  `create_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//				  	  `date_created` datetime NOT NULL,
//					  `last_updated` datetime NOT NULL,
//					  `update_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
//					  `textarea1` varchar(500) DEFAULT NULL,
//					  `textarea2` varchar(500) DEFAULT NULL,
//					  `textarea3` varchar(500) DEFAULT NULL,
//					  `textarea4` varchar(500) DEFAULT NULL,
//					  PRIMARY KEY (`id`)
//					) ENGINE=InnoDB DEFAULT CHARSET=utf8;
//
//		"""	
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			Menu menu_system1 = Menu.findByName("询盘管理")
			
			menuHelper.createMenu([authority: 'AUTH_DEPARTMENT_INQUIRY',
				url: '/departmentInquiry/list/**',
				description: '部门询盘'],
			[name: '部门询盘', icon: 'file-text-o',orders:1], menu_system1);
			
			menuHelper.createMenu([authority: 'AUTH_HISTORY_INQUIRY',
				url: '/historyInquiry/list/**',
				description: '历史询盘'],
			[name: '历史询盘', icon: 'file-text-o',orders:2], menu_system1);
		
			menuHelper.createMenu([authority: 'AUTH_ALL_INQUIRY',
				url: '/allInquiry/list/**',
				description: '全部询盘'],
			[name: '全部询盘', icon: 'file-text-o',orders:3], menu_system1);

		
				
			Menu menu_system2 = Menu.findByName("应价管理")
			menuHelper.createMenu([authority: 'AUTH_DEPARTMENT_PRICE',
				url: '/departmentPrice/list/**',
				description: '部门应价'],
			[name: '部门应价', icon: 'file-text-o',orders:1], menu_system2);
		
			menuHelper.createMenu([authority: 'AUTH_HISTORY_PRICE',
				url: '/historyPrice/list/**',
				description: '历史应价'],
			[name: '历史应价', icon: 'file-text-o',orders:2], menu_system2);
	
			menuHelper.createMenu([authority: 'AUTH_ALL_PRICE',
				url: '/allPrice/list/**',
				description: '全部应价'],
			[name: '全部应价', icon: 'file-text-o',orders:3], menu_system2);
			
//			[
//				[url: '/inquiryOfferPrice/inquiry/**', description: '今日询盘', authority: "AUTH_INQUIRYOFFERPRICE_INQUIRY"],
//				[url: '/inquiryOfferPrice/offerPrice/**', description: '今日应价', authority: "AUTH_INQUIRYOFFERPRICE_OFFERPRICE"],
//				
//			].each { params ->
//				params.createBy = systemUser
//				params.updateBy = systemUser
//				Requestmap map = new Requestmap(params)
//				map.save()
//			}
			return null
			
	}

	@Override
	public int getOrder() {
		return 130
	}
}