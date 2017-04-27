package com.cdd.back.service.dbupdator.impl.v6x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV63Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls=[]
		sqls << """

			CREATE TABLE IF NOT EXISTS `company` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`create_by` varchar(50) NOT NULL,
				`update_by` varchar(50) NOT NULL,
				`date_created` datetime NOT NULL,
				`last_updated` datetime NOT NULL,

				`company_name` varchar(100) NOT NULL,
				`address` varchar(100) NOT NULL,
				`city` varchar(10) ,
				`special_service` varchar(100) ,
				`verified` bit(1) ,
				`honest` bit(1) ,
				`safety` bit(1) ,
				`introduce` varchar(2000) ,
				`workers` varchar(50) ,
				`scale` varchar(50) ,
				`website` varchar(50) ,
				`mailbox` varchar(50) ,
				`telephone` varchar(20) ,
				`business_range` varchar(100) ,
				`type` varchar(50) ,
				`price_info` varchar(100) ,
				`remark` varchar(500) ,
				`bulid_time` varchar(50) ,
				`reg_capital` varchar(50) ,

				`english_name` varchar(50) ,
				`advanced_route` varchar(50) ,

 
				PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		"""
				
				sqls<< """

           ALTER TABLE `front_user` ADD COLUMN `company_id` bigint(20)   AFTER `verified`;

        """
				 
		 return sqls
	}

	@Override
	def updateData() {
			def systemUser = User.SYSTEM.username
					Menu menu_system = new Menu(name: '公司认证管理', icon: 'bookmark-o', createBy: systemUser, updateBy: systemUser).save();
				
							 menuHelper.createMenu([authority: 'AUTH_COMPANY_LIST',
													 url: '/company/list/**',
													 description: '公司一览'],
													 [name: '公司一览', icon: 'bookmark-o'], menu_system);
								 /***********添加权限路径的数据*******/
							 [
								 [url: '/company/data/**', description: '公司信息', authority: "AUTH_COMPANY_DATA"],
								 [url: '/company/save/**', description: '公司信息保存', authority: "AUTH_COMPANY_SAVE"],
								 [url: '/company/downloadExample/**', description: '公司下载模板', authority: "AUTH_COMPANY_DOWNLOAD_EXAMPLE"],
								 [url: '/company/importData/**', description: '公司导入信息  ', authority: "AUTH_COMPANY_IMPORT_DATA"],
								 [url: '/company/delete/**', description: '公司信息删除  ', authority: "AUTH_COMPANY_DELETE_DATA"],
								 [url: '/company/addmanager/**', description: '公司添加经理  ', authority: "AUTH_COMPANY_ADDMANAGER_DATA"],
								 [url: '/company/findmanager/**', description: '公司查找经理  ', authority: "AUTH_COMPANY_FINDMANAGER_DATA"],
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
		return 63
	}
}
