package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV123Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
		
		[
			[url: '/clientAttrManager/getTags/**', description: '查询标签', authority: "AUTH_GET_TAG"],
			[url: '/clientAttrManager/saveTag/**', description: '保存标签', authority: "AUTH_SAVE_TAG"],
			[url: '/clientAttrManager/delTag/**', description: '删除标签', authority: "AUTH_DEL_TAG"],
			[url: '/clientAttrManager/getGroups/**', description: '查询群组', authority: "AUTH_GET_GROUP"],
			[url: '/clientAttrManager/saveGroup/**', description: '保存群组', authority: "AUTH_SAVE_GROUP"],
			[url: '/clientAttrManager/delGroup/**', description: '删除群组', authority: "AUTH_DEL_GROUP"],
			[url: '/clientAttrManager/getDemands/**', description: '查询需求', authority: "AUTH_GET_DEMAND"],
			[url: '/clientAttrManager/saveDemand/**', description: '保存需求', authority: "AUTH_SAVE_DEMAND"],
			[url: '/clientAttrManager/delDemand/**', description: '删除需求', authority: "AUTH_DEL_DEMAND"],
			[url: '/clientAttrManager/getClientTypes/**', description: '查询客户类型', authority: "AUTH_GET_CLIENT_TYPE"],
			[url: '/clientAttrManager/saveClientType/**', description: '保存客户类型', authority: "AUTH_SAVE_CLIENT_TYPE"],
			[url: '/clientAttrManager/delClientType/**', description: '删除客户类型', authority: "AUTH_DEL_CLIENT_TYPE"]
			
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
		return 123
	}
}