package com.cdd.back.util

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User


class MenuHelper {
	public def createMenu(mapParams, menuParams, Menu parent) {
		def systemUser = User.SYSTEM.username
		
		mapParams.put 'createBy', systemUser
		mapParams.put 'updateBy', systemUser
		
		Requestmap map = new Requestmap(mapParams)
		map.save()
		
		menuParams.put 'createBy', systemUser
		menuParams.put 'updateBy', systemUser
		menuParams.put 'map', map
		menuParams.put 'parent', parent
		
		new Menu(menuParams).save(failOnError: true)
	}
}
