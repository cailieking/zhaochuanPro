package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.BackDepartment
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV119Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """

			insert into `back_department` (`create_by`,`date_created`,`description`,`last_updated`,`name`,`update_by`,`p_id`,`manager`)
			
			values('admin3',NOW(),NULL,NOW(),'其它','admin3',10000,'戴斌')

		"""
		
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			BackDepartment dp = BackDepartment.findByName("其它")
			
			def bUsers = BackUser.list()
			bUsers.collect{
				BackUser u = it
				u.department =  dp
				u.save()
				if(u.hasErrors()){
					println u.errors
					
				}
			}
			
			Menu jt = Menu.findByName("机构管理")
			Menu jt1 = Menu.findByName("职位管理")
			Menu jt2 = Menu.findByName("组织架构")
			
			jt1.parent = jt
			jt1.save()
			jt2.parent = jt
			jt2.save()
			
			[
				[url: '/department/enable/**', description: '禁用启用员工', authority: "AUTH_ENABLE"],
				[url: '/Position/initPosition/**', description: '初始化职位', authority: "AUTH_LIST"],
				[url: '/Position/isExists/**', description: '职位是否存在', authority: "AUTH_IS_EXISTS"]
				
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
		return 119
	}
}