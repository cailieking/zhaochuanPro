package com.cdd.back.service.dbupdator.impl.v7x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV70Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		
		
		 
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		[
			[url: '/companyCertificate/list/**', description: '公司认证列表', authority: "AUTH_COMPANY_CERTIFICATE"],
			[url: '/companyCertificate/data/**', description: '公司认证修改', authority: "AUTH_COMPANY_CERTIFICATE_DATA"],
			[url: '/company/getQueryCompanyList/**', description: '模糊查询公司名', authority: "AUTH_COMPANY_GETQUERYCOMPANYLIST"],
			[url: '/company/getCompanyDetail/**', description: '公司详情', authority: "AUTH_COMPANY_GETCOMPANYDETAIL"],
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
		return 70
	}
}
