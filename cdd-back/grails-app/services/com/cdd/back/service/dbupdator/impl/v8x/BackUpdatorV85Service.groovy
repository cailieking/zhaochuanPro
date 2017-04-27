package com.cdd.back.service.dbupdator.impl.v8x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV85Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls=[]
		
			
		sqls << """
					
			CREATE TABLE IF NOT EXISTS `enterprise_directory`(
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `create_by` varchar(50) NOT NULL,
			  `update_by` varchar(50) NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `company_name` varchar(500) DEFAULT NULL,
			  `company_english` varchar(500) DEFAULT NULL,
			  `city` varchar(50) DEFAULT NULL,
			  `address` varchar(500) DEFAULT NULL,
			  `email` varchar(50) DEFAULT NULL,
			  `mobile` varchar(50) DEFAULT NULL,
			  `contact_name` varchar(50) DEFAULT NULL,
			  `telephone` varchar(50) DEFAULT NULL,
			  `qq` varchar(50) DEFAULT NULL,
				`show_on_index` bit(1) NOT NULL  DEFAULT b'1',
			  `remark1` varchar(500) DEFAULT NULL,
			  `remark2` varchar(500) DEFAULT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8;




		"""
		
				 
		 return sqls
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username 
		Menu menu_system = new Menu(name: '企业名录管理', icon: 'users', createBy: systemUser, updateBy: systemUser).save();
		
					 menuHelper.createMenu([authority: 'AUTH_ENTERPRISE_DIRECTORY_LIST',
											 url: '/enterpriseDirectory/list/**',
											 description: '企业名录'],
											 [name: '企业名录', icon: ''], menu_system);
										 
										 	
		[
			[url: '/enterpriseDirectory/edit/**', description: '修改企业名录', authority: "AUTH_ENTERPRISE_DIRECTORY_EDIT"],
			[url: '/enterpriseDirectory/data/**', description: '查看企业名录', authority: "AUTH_ENTERPRISE_DIRECTORY_DATA"],
			[url: '/enterpriseDirectory/delete/**', description: '删除企业名录', authority: "AUTH_ENTERPRISE_DIRECTORY_DELETE"],
			[url: '/enterpriseDirectory/importData/**', description: '导入企业名录', authority: "AUTH_ENTERPRISE_DIRECTORY_IMPORTDATA"],
			[url: '/enterpriseDirectory/downloadExample/**', description: '下载企业名录模板', authority: "AUTH_ENTERPRISE_DIRECTORY_DOENLOADEXAMPLE"],
			[url: '/enterpriseDirectory/save/**', description: '保存企业名录', authority: "AUTH_ENTERPRISE_DIRECTORY_SAVE"],
			[url: '/enterpriseDirectory/showOnIndex/**', description: '前端显示', authority: "AUTH_ENTERPRISE_DIRECTORY_SHOWONINDEX"],
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
		return 85
	}
}