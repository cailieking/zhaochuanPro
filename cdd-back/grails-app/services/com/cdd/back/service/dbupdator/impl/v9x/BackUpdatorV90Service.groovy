package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV90Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls=[]
		sqls << """
			CREATE TABLE `booking_so` (
				  `id` bigint(20) NOT NULL AUTO_INCREMENT,
				  `so_number` varchar(50) DEFAULT NULL,
				  `ship_company` varchar(50) DEFAULT NULL,
				  `ship_name` varchar(50) DEFAULT NULL,
				  `voyage_no` varchar(50) DEFAULT NULL,
				  `start_port` varchar(50) DEFAULT NULL,
				  `end_port` varchar(50) DEFAULT NULL,
				  `gp20num` int(10) DEFAULT NULL,
				  `gp40num` int(10) DEFAULT NULL,
				  `hq40num` int(10) DEFAULT NULL,
				  `end_date` datetime DEFAULT NULL,
				  `start_ship_date` datetime DEFAULT NULL,
				  `so_file_path` varchar(255) DEFAULT NULL,
				  `remark` varchar(500) DEFAULT NULL,
				  PRIMARY KEY (`id`)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		"""
			
		sqls << """
					
				CREATE TABLE `booking` (
				  `id` bigint(20) NOT NULL AUTO_INCREMENT,
				  `create_by` varchar(255) NOT NULL,
				  `update_by` varchar(255) NOT NULL,
				  `last_updated` datetime NOT NULL,
				  `date_created` datetime DEFAULT NULL,
				  `booking_name` varchar(255) DEFAULT NULL,
				  `booking_email` varchar(255) DEFAULT NULL,
				  `booking_contact` varchar(255) DEFAULT NULL,
				  `booking_phone` varchar(20) DEFAULT NULL,
				  `shipper_name` varchar(255) DEFAULT NULL,
				  `shipper_email` varchar(255) DEFAULT NULL,
				  `shipper_contact` varchar(255) DEFAULT NULL,
				  `shipper_phone` varchar(20) DEFAULT NULL,
				  `consignee_name` varchar(255) DEFAULT NULL,
				  `consignee_email` varchar(255) DEFAULT NULL,
				  `consignee_contact` varchar(255) DEFAULT NULL,
				  `consignee_phone` varchar(20) DEFAULT NULL,
				  `notify_party_name` varchar(255) DEFAULT NULL,
				  `notify_party_email` varchar(255) DEFAULT NULL,
				  `notify_party_contact` varchar(255) DEFAULT NULL,
				  `notify_party_phone` varchar(20) DEFAULT NULL,
				  `place_receipt` varchar(50) DEFAULT NULL,
				  `port_loading` varchar(50) DEFAULT NULL,
				  `port_discharge` varchar(50) DEFAULT NULL,
				  `place_delivery` varchar(50) DEFAULT NULL,
				  `voyage_no` varchar(50) DEFAULT NULL,
				  `pre_carriage_by` varchar(50) DEFAULT NULL,
				  `service_origin` varchar(50) DEFAULT NULL,
				  `service_destination` varchar(50) DEFAULT NULL,
				  `etd` datetime DEFAULT NULL,
				  `final_destination` varchar(50) DEFAULT NULL,
				  `gp20num` varchar(20) DEFAULT NULL,
				  `gp20quantity` varchar(20) DEFAULT NULL,
				  `gp20weight` varchar(20) DEFAULT NULL,
				  `gp20volume` varchar(20) DEFAULT NULL,
				  `gp40num` varchar(20) DEFAULT NULL,
				  `gp40quantity` varchar(20) DEFAULT NULL,
				  `gp40weight` varchar(20) DEFAULT NULL,
				  `gp40volume` varchar(20) DEFAULT NULL,
				  `hq40num` varchar(20) DEFAULT NULL,
				  `hq40quantity` varchar(20) DEFAULT NULL,
				  `hq40weight` varchar(20) DEFAULT NULL,
				  `hq40volume` varchar(20) DEFAULT NULL,
				  `commodity` varchar(500) DEFAULT NULL,
				  `booking_remark` varchar(255) DEFAULT NULL,
				  `person_in_charge` varchar(50) DEFAULT NULL,
				  `charge_tel` varchar(20) DEFAULT NULL,
				  `charge_email` varchar(50) DEFAULT NULL,
				  `fail_reason` varchar(500) DEFAULT NULL,
				  `remark` varchar(500) DEFAULT NULL,
				  `info_id` bigint(20) DEFAULT NULL,
				  `so_id` bigint(20) DEFAULT NULL,
				  `status` varchar(50) DEFAULT NULL,
				  PRIMARY KEY (`id`),
				  KEY `info_id` (`info_id`),
				  KEY `so_id` (`so_id`),
				  CONSTRAINT `info_id` FOREIGN KEY (`info_id`) REFERENCES `cargo_ship_information` (`id`),
				  CONSTRAINT `so_id` FOREIGN KEY (`so_id`) REFERENCES `booking_so` (`id`)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8;

		"""
		
		 return sqls
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username 
		Menu menu_system = new Menu(name: '在线订舱管理', icon: 'users', createBy: systemUser, updateBy: systemUser).save();
		
					 menuHelper.createMenu([authority: 'AUTH_BOOKING_LIST',
											 url: '/booking/list/**',
											 description: '订单管理'],
											 [name: '订单管理', icon: ''], menu_system);
										 
										 	
		[
			[url: '/booking/data/**', description: '订舱信息', authority: "AUTH_BOOKING_DATA"],
			[url: '/booking/delete/**', description: '删除订舱', authority: "AUTH_BOOKING_DELETE"],
			[url: '/booking/operate/**', description: '审核订单', authority: "AUTH_BOOKING_OPERATE"],
			[url: '/booking/finish/**', description: '订单结单', authority: "AUTH_BOOKING_FINISH"],
			[url: '/booking/save/**', description: '保存订单', authority: "AUTH_BOOKING_SAVE"],
			[url: '/booking/importBooking/**', description: '导出订单', authority: "AUTH_BOOKING_IMPORTBOOKING"],
			[url: '/booking/importSo/**', description: '导出SO', authority: "AUTH_BOOKING_IMPORTSO"],
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
		return 90
	}
}