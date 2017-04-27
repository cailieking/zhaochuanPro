package com.cdd.back.service

import grails.plugin.springsecurity.SpringSecurityService

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.JobTitle
import com.cdd.base.domain.NewRoute
class MenuService {
	SpringSecurityService springSecurityService
	
	List<Menu> getMenus() {
		return getMenusByParent(null)
	}

	private List<Menu> getMenusByParent(parent) {
		def auths = springSecurityService.currentUser.role.authorities
		Menu.findAllByParent(parent)?.collect { parentMenu ->
			parentMenu.children = getMenusByParent(parentMenu)
			return parentMenu
		}?.findAll { menu ->
			auths.any { auth ->
				menu.map == null || auth.map.id == menu.map.id
			}
		}?.sort { a, b ->
			return a.orders.compareTo(b.orders)
		}
	}

	def findMenu(String url) {
		Requestmap map = Requestmap.findByUrlLike("%${url}%")
		if(map) {
			return Menu.findByMap(map)
		}
		return null
	}
	
	
	def getDeals(){
		def deals = JobTitle.findByName("商务专员").users
		return deals
	}
	
	def getRoutes(){
		def routes = NewRoute.list()
		return routes
	}
	
	
}
