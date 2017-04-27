package com.cdd.back.service.dbupdator.impl.v11x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV116Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
				 ALTER TABLE `back_job_title` CHANGE COLUMN `jt_name` `name` VARCHAR(64)

		""" 
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			def jt = JobTitle.findByName("商务总监")
			
			[
				[name:'商务主管', pId:jt.id, description:null]	
			].each{params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				JobTitle j = new JobTitle(params)
				j.save()
				
			}
			jt = JobTitle.findByName("商务主管")
			
			[
				[name:'商务专员', pId:jt.id, description:null]
			].each{params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				JobTitle j = new JobTitle(params)
				j.save()
			}
			
			jt = JobTitle.findByName("交易总监")
			
			[
				[name:'交易专员', pId:jt.id, description:null]
			].each{params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				JobTitle j = new JobTitle(params)
				j.save()
			}
			
			
			jt = JobTitle.findByName("客服主管")
			
			[
				[name:'客服专员', pId:jt.id, description:null]
			].each{params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				JobTitle j = new JobTitle(params)
				j.save()
			}
			
			
			jt = JobTitle.findByName("运营总监")
			
			[
				[name:'运营主管', pId:jt.id, description:null]
			].each{params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				JobTitle j = new JobTitle(params)
				j.save()
			}
			
			jt = JobTitle.findByName("运营主管")
			
			[
				[name:'运营专员', pId:jt.id, description:null]
			].each{params ->
				params.createBy = systemUser
				params.updateBy = systemUser
				JobTitle j = new JobTitle(params)
				j.save()
			}
			
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
		return 116
	}
}