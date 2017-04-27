package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV74Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls=[]
		sqls<<"""\
			CREATE TABLE IF NOT EXISTS `new_route` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,
				
				`route_name` varchar(100) NOT NULL,
				`english_name` varchar(100) ,
				`remark` varchar(100),
				
				PRIMARY KEY (`id`)
			)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""
		
		sqls << """\

			CREATE TABLE IF NOT EXISTS `start_port` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,

				`port_name` varchar(100) NOT NULL,
				`port_english_name` varchar(100) ,
				`country_ch` varchar(50),
				`country_en` varchar(50),
				`code` varchar(50),
				`code_simple` varchar(50),
				`remark` varchar(100),
 
				PRIMARY KEY (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
				
		sqls << """\

			CREATE TABLE IF NOT EXISTS `end_port` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,

				`port_name` varchar(100) NOT NULL,
				`port_english_name` varchar(100) ,
				`country_ch` varchar(50),
				`country_en` varchar(50),
				`code` varchar(50),
				`code_simple` varchar(50),
				`route_id`  bigint(20) ,
				`remark` varchar(100),
 
				PRIMARY KEY (`id`),
				KEY `FK_route_id` (`route_id`),
			  	CONSTRAINT `FK_route_id` FOREIGN KEY (`route_id`) REFERENCES `new_route` (`id`)
			) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
		
				 
		 return sqls
	}

	@Override
	def updateData() {
			def systemUser = User.SYSTEM.username
					Menu menu_system = new Menu(name: '港口管理', icon: 'cogs', createBy: systemUser, updateBy: systemUser).save();
				
							 menuHelper.createMenu([authority: 'AUTH_STARTPORT_LIST',
													 url: '/startPort/list/**',
													 description: '起始港'],
													 [name: '起始港', icon: 'bookmark-o'], menu_system);
												 
							 menuHelper.createMenu([authority: 'AUTH_ENDPORT_LIST',
													 url: '/endPort/list/**',
													 description: '目的港'],
													 [name: '目的港', icon: 'bookmark-o'], menu_system);
								 /***********添加权限路径的数据*******/
							 [
								 [url: '/startPort/data/**', description: '查看起始港信息', authority: "AUTH_STARTPORT_DATA"],
								 [url: '/startPort/save/**', description: '保存起始港信息', authority: "AUTH_STARTPORT_SAVE_DATA"],
								 [url: '/startPort/addNew/**', description: '添加起始港', authority: "AUTH_STARTPORT_ADDNEW_DATA"],
								 [url: '/startPort/delete/**', description: '起始港删除  ', authority: "AUTH_STARTPORT_DELETE_DATA"],
								 
								  [url: '/endPort/data/**', description: '查看目的港信息', authority: "AUTH_ENDPORT_DATA"],
								  [url: '/endPort/save/**', description: '保存目的港信息', authority: "AUTH_ENDPORT_SAVE_DATA"],
								  [url: '/endPort/addNew/**', description: '添加目的港', authority: "AUTH_ENDPORT_ADDNEW_DATA"],
								  [url: '/endPort/delete/**', description: '目的港删除  ', authority: "AUTH_ENDPORT_DELETE_DATA"],
								  [url: '/startPort/edit/**', description: '起始港编辑  ', authority: "AUTH_STARTPORT_EDIT"],
								  [url: '/endPort/edit/**', description: '目的港编辑 ', authority: "AUTH_ENDPORT_EDIT"],
								 
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
		return 74
	}
}