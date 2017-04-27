package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV104Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			alter table `adv_corporation` modify `end_date` TIMESTAMP
		"""
		
		sqls << """
			alter table  cargo_ship_information add column `from_by` varchar(4) default null
	
       """
	   
	   sqls << """
	   	    delete a from back_menu a where a.name = '运价查询'
	   
	   """
	   
	   sqls << """
	   		DELETE a.* FROM back_role_authority a LEFT JOIN back_requestmap b ON a.`map_id`=b.`id` WHERE b.url = '/shipInfo/list/**'
	   """
	   
	   sqls << """
	   		delete back_requestmap FROM back_requestmap where url='/shipInfo/list/**'
	   
	   """
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
//			
//			
			Menu menu_system = Menu.findByName('运价管理')
			
			//Menu menu_system = new Menu(name: '搜索管理', icon: 'calendar-o', createBy: systemUser, updateBy: systemUser).save()
		
			menuHelper.createMenu([authority: 'AUTH_BACK_SEARCH_SHIP',
				url: '/shipInfo/list/**',
				description: '运价搜索'],
			[name: '运价搜索', icon: 'file-text-o',orders: 0], menu_system)
			return null
	}

	@Override
	public int getOrder() {
		return 104
	}
}