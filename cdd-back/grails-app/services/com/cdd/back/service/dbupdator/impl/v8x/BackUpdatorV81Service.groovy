package com.cdd.back.service.dbupdator.impl.v8x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu;
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.enums.AgentType;

class BackUpdatorV81Service extends AbstractBackDatabaseUpdator {
  MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		return null
	}

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		Menu menu_system = new Menu(name: '订舱咨询', icon: '', createBy: systemUser, updateBy: systemUser).save();
		
					 menuHelper.createMenu([authority: 'AUTH_INQUERY_PRICE_LIST',
											 url: '/inqueryPrice/list/**',
											 description: '运价咨询'],
											 [name: '运价咨询', icon: ''], menu_system);
										 
					 menuHelper.createMenu([authority: 'AUTH_ORDER_PRICE_LIST',
											 url: '/orderPrice/list/**',
											 description: '货盘咨询'],
											 [name: '货盘咨询', icon: ''], menu_system);
		[
			[url: '/inqueryPrice/delete/**', description: '删除询价信息', authority: "AUTH_INQUERY_PRICE_DELETE"],
			[url: '/inqueryPrice/operate/**',description: '受理询价信息', authority: "AUTH_INQUERY_PRICE_OPERATE"],
			[url: '/inqueryPrice/finish/**',description:  '结单询价信息', authority: "AUTH_INQUERY_PRICE_FINISH"],
			[url: '/inqueryPrice/update/**',description:  '修改询价信息', authority: "AUTH_INQUERY_PRICE_UPDATE"],
			[url: '/inqueryPrice/view/**',description:  '查看询价信息', authority: "AUTH_INQUERY_PRICE_VIEW"],
			[url: '/inqueryPrice/save/**',description: '保存询价信息', authority: "AUTH_INQUERY_PRICE_SAVE"],
			[url: '/inqueryPrice/finished/**',description: '结单询价信息', authority: "AUTH_INQUERY_PRICE_FINISHED"],
			[url: '/inqueryPrice/finished/**',description: '结单询价信息', authority: "AUTH_INQUERY_PRICE_FINISHED"],
			
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
		return 81
	}
}
