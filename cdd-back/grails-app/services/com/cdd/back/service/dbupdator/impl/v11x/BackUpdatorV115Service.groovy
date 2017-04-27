package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV115Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			update  `back_user` set `department_id` = 10000 where `department_id` is null
		
		"""
		
		sqls << """
		
			CREATE TABLE `back_job_title` (
		  	  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `jt_name` varchar(255) COLLATE utf8_bin NOT NULL,
			  `p_id` bigint(11) COLLATE utf8_bin default null,
			  `create_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `date_created` datetime NOT NULL,
			  `last_updated` datetime NOT NULL,
			  `update_by` varchar(255) COLLATE utf8_bin NOT NULL,
			  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `UK_name` (`jt_name`)
			) ENGINE=InnoDB  AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

		"""
		
		
		
		sqls << """	
			alter table `back_department` drop column `is_parent`
		"""
		
		sqls << """
			ALTER TABLE `back_user` add column `job_title_id` bigint(20)  default NULL
		
		"""
		
		sqls << """
			update `back_department` set  manager='戴斌'  where manager is null
		
		"""
		
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('CEO','admin3',NOW(),'admin3',NOW(),NULL)
			
		"""

		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('VP',1,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('副总经理',1,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('产品总监',1,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('运营总监',1,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('商务总监',2,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('交易总监',2,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		sqls << """
				
              insert into `back_job_title`(`jt_name`,`p_id`,`create_by`,`date_created`,`update_by`,`last_updated`,`description`) 
					values('客服主管',2,'admin3',NOW(),'admin3',NOW(),NULL)
			
		"""
		
		
		sqls << """
				
              alter table `back_user` add  foreign  key (`job_title_id`) REFERENCES `back_job_title`(`id`) 
			
		"""
		
		
		
		
		
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			[
				[url: '/position/saveJobTitle/**', description: '添加职位', authority: "AUTH_SAVE_JT"],
				[url: '/position/deleteJobTilte/**', description: '删除职位', authority: "AUTH_DEL_JT"],
				[url: '/position/editJobTilte/**', description: '编辑职位', authority: "AUTH_EDIT_JT"]
				
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
		return 115
	}
}