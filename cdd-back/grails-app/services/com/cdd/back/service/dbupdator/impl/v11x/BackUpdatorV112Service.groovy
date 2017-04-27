package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV112Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
		
			CREATE TABLE `back_department` (
		  	  `id` bigint(20) NOT NULL,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  `last_updated` datetime NOT NULL,
			  `name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
              `p_id` bigint(20) COLLATE utf8_bin default null,
			  `is_parent` BIT(1) default false,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_name` (`name`)
			) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""
		
		sqls << """
			ALTER TABLE `back_department` MODIFY id BIGINT  AUTO_INCREMENT 
		
		"""
	
		sqls << """
			ALTER TABLE `back_department` AUTO_INCREMENT=10000
			
		"""
	
		sqls << """
				
              insert into `back_department`(id,create_by,date_created,description,last_updated,name,update_by,p_id,is_parent) 
			
					values(0,'admin3',NOW(),NULL,NOW(),'深圳市找船网络科技有限公司','admin3',null,true) 
			
		"""
		
		
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			Menu menu_system = new Menu(name: '机构管理', icon: 'rss-square', createBy: systemUser, updateBy: systemUser,orders: 150).save()
			
			menuHelper.createMenu([authority: 'AUTH_POSITION_LIST',
				url: '/position/list/**',
				description: '职位管理'],
			[name: '职位管理', icon: 'picture-o', orders: 0], menu_system)
			
			menuHelper.createMenu([authority: 'AUTH_DEPARTMENT_LIST',
				url: '/department/list/**',
				description: '组织架构'],
			[name: '组织架构', icon: 'picture-o', orders: 1], menu_system)
			
		/*	
			
			[
				[url: '/route/port/**', description: '港口初始化', authority: "AUTH_SEARCH_PORT"]
				
			].each { params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				Requestmap map = new Requestmap(params)
				map.save()
			}*/
			
			return null
	}

	@Override
	public int getOrder() {
		return 112
	}
}