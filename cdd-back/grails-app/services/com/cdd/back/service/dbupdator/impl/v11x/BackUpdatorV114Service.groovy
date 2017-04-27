package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV114Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		
		sqls << """	
			alter table `back_department` add column `manager` varchar(32) default null
		"""
		
		sqls << """
				
              alter table `back_user` add  column `department_id` BIGINT(20) default null
			
		"""



		sqls << """
				
              alter table `back_user` add  foreign  key (`department_id`) REFERENCES `back_department`(`id`) 
			
		"""
		
		
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			[
				[url: '/department/saveDepartment/**', description: '保存部门', authority: "AUTH_SAVE_DEPARTMENT"],
				[url: '/department/deleteDepartment/**', description: '删除部门', authority: "AUTH_DEL_DEPARTMENT"]
				
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
		return 114
	}
}