package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV113Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			update  `back_department` set `p_id` = 0 where `p_id` is null
		
		"""
		
		sqls << """	
			alter table `back_department` modify column `p_id` BIGINT(20) default 0
		"""
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
//			Menu menu_system = new Menu(name: '机构管理', icon: 'rss-square', createBy: systemUser, updateBy: systemUser).save()
//			
//			menuHelper.createMenu([authority: 'AUTH_POSITION_LIST',
//				url: '/position/list/**',
//				description: '职位管理'],
//			[name: '职位管理', icon: 'picture-o', orders: 0], menu_system)
//			
//			menuHelper.createMenu([authority: 'AUTH_FRAMEWORK_LIST',
//				url: '/framework/list/**',
//				description: '组织架构'],
//			[name: '组织架构', icon: 'picture-o', orders: 1], menu_system)
			
			
			
			[
				[url: '/department/initDepartmentData/**', description: '初始化部门数据', authority: "AUTH_INIT_DEPARTMENT"]
				
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
		return 113
	}
}