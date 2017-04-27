package com.cdd.back.controller

import com.cdd.back.service.MenuService
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import grails.converters.JSON


class MenuController extends BaseController  {
	MenuService menuService
	def list() {
		/*if(params.search) {
			def searchKey = "%${params.search}%"
			params.f_like_name = searchKey
		}
		def data = getList(model: 'menu', domainClass: Menu)
		render data*/
		//redirect url:"menu/menuData/1"
	}

	def data() {
		/*String menuName = '菜单信息'
		def modelAndView = data(model: 'menu', menuName: menuName, domainClass: Menu)
		if(modelAndView.model) {
			if(modelAndView.model.data.id) {
				modelAndView.model.parentCandidates = Menu.findAllByNameNotEqualAndMapIsNull(modelAndView.model.data.name)
			} else {
				modelAndView.model.parentCandidates = Menu.findAllByMapIsNull()
			}
		}
		println modelAndView
		render modelAndView*/
		
	}

	def save() {
		Menu data = new Menu(params)
		if(params.id) {
			Menu oldData = Menu.get(params.id as Long)
			oldData.name = data.name
			oldData.icon = data.icon
			oldData.orders = data.orders
			data = oldData
		}
		if(params.parentId) {
			data.parent = Menu.get(params.parentId as Long)
		} else {
			data.parent = null
		}
		if(params.mapId) {
			data.map = Requestmap.get(params.mapId as Long)
		} else {
			data.map = null
		}
		//save(data, 'menu')
		if(!data.save(flash:true))
		{
			data.errors.each{
				println "a:>====="+it
			}
	}
		data.save(flash:true)
		def map = [:]
		map.status="1"
		render map as JSON
	}

	def delete() {
		delete(Menu, 'menu')
	}
	
	def menuData(){
		/*def map = [:]
		 map.fatherIds = menuService.menus.id
		 map.fatherNames = menuService.menus.name
		 map.childrenIds = menuService.menus.children.id
		 map.childrenNames = menuService.menus.children.name
		 render map as JSON*/
		def map =[:]
		Menu clickedMenu =  Menu.get(params.id as Long)
		
		map.clickedMenu = clickedMenu
		
		map.childrenMenu = Menu.findAllByParent(clickedMenu)
		
		render view:"/menu/list" ,model:[map:map]
	}
	
	def show(){
		Menu menu =  Menu.get(params.id as Long)
		if(params.status=="0"){
			menu.isHide = true
			menu.save(flash:true)
		}else{
			menu.isHide = false
			menu.save(flash:true)
		}
		render view:"/menu/list"
	}
}
