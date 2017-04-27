package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV94Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		
		
		return null
	}

	@Override
	def updateData() {
			def systemUser = User.SYSTEM.username 
		/*Menu menu_system = new Menu(name: '邮件管理', icon: 'users', createBy: systemUser, updateBy: systemUser).save();
		
					 menuHelper.createMenu([authority: 'AUTH_MAIL_MANAGER_SEND',
											 url: '/mailManager/send/**',
											 description: '发送邮件'],
											 [name: '邮件发送', icon: ''], menu_system);
										 */
										 	
		[
			[url: '/frontUser/sendSms/**', description: '发送短信', authority: "AUTH_FRONT_USER_SEND_SMS"],
			
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
		return 94
	}
}