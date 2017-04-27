package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV118Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
				 ALTER TABLE `back_user` ADD COLUMN (`job_num` VARCHAR(20) DEFAULT NULL , `qq` VARCHAR(20) DEFAULT NULL,
				
				`ext_num` VARCHAR(20) DEFAULT NULL,  `en_name` varchar(20) DEFAULT NULL,`invite_code` VARCHAR(20) DEFAULT NULL,
				
				`delete_tag` BIT(1) NOT NULL default false)
				
		""" 
		
		sqls << """

			
			CREATE TABLE `back_user_routes` (
			  `back_user_id` bigint(20) NOT NULL,
			  `new_route_id` bigint(20) NOT NULL,
			  PRIMARY KEY (`back_user_id`,`new_route_id`),
			  FOREIGN KEY (`back_user_id`) REFERENCES `back_user` (`id`),
			  FOREIGN KEY (`new_route_id`) REFERENCES `new_route` (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
		

		"""	
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			[
				[url: '/user/isAccount/**', description: '账号是否存在', authority: "AUTH_IS_ACCOUNT"],
				[url: '/user/isAccountEmail/**', description: '邮箱是否存在', authority: "AUTH_IS_ACCOUNT_EMAIL"],
				
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
		return 118
	}
}