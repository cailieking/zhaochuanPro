package com.cdd.back.service.dbupdator.impl.v8x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV83Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
					
		[
			[url: '/orderPrice/delete/**', description: '删除货盘咨询信息', authority: "AUTH_ORDER_PRICE_DELETE"],
			[url: '/orderPrice/operate/**',description: '受理货盘咨询信息', authority: "AUTH_ORDER_PRICE_OPERATE"],
			[url: '/orderPrice/finish/**',description:  '结单货盘咨询信息', authority: "AUTH_ORDER_PRICE_FINISH"],
			[url: '/orderPrice/update/**',description:  '修改货盘咨询信息', authority: "AUTH_ORDER_PRICE_UPDATE"],
			[url: '/orderPrice/view/**',description:  '查看货盘咨询信息', authority: "AUTH_ORDER_PRICE_VIEW"],
			[url: '/orderPrice/save/**',description: '保存货盘咨询信息', authority: "AUTH_ORDER_PRICE_SAVE"],
			[url: '/orderPrice/finished/**',description: '结单货盘咨询信息', authority: "AUTH_ORDER_PRICE_FINISHED"],
			
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
		return 83
	}
}
