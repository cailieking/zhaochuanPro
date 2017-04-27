package com.cdd.back.controller

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService

import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.hibernate.SQLQuery
import org.hibernate.SessionFactory
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.back.service.MenuService
import com.cdd.base.domain.Menu
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.common.CRUDService
import com.cdd.base.util.CommonUtils
import com.cdd.base.constant.CommonArguments

class BaseController {
	CRUDService CRUDService

	SpringSecurityService springSecurityService

	MenuService menuService

	JsonConverterFactory jsonConverterFactory
	
	SessionFactory sessionFactory

	protected def data(args) {
		args.menu = getMenu(args.menuName, "/${args.model}/list")
		return getData(args)
	}

	protected def getMenu(menuName, parentMenuUri) {
		Menu parentMenu = menuService.findMenu(parentMenuUri)
		return new Menu(parent: parentMenu, name: menuName)
	}

	protected def getData(args) {
		def data
		if(params.id != 'new') {
			data = args.domainClass.get(params.id as Long)
		} else {
			data = flash.data ?: args.domainClass.newInstance()
		}
		if(params.dataType == 'json') {
			return (CommonUtils.tranferToMap(data, args.excludeFields ?: [], args.includeTypes ?: []) as JSON)
		} else {
			return [view: "/${args.model}/data", model: [data: data, settings: getSettings(args.menu)]]
		}
	}

	protected def getList(args, processResultItem = null) {
		def viewUrl = "/${args.model}/list"
		
		if(params.dataType != 'json') {
			return [view: viewUrl, model: [settings: getSettings(menuService.findMenu(viewUrl))]]
		}

		def result = CRUDService.list(args.domainClass, params, args.queryHandler)
		def list = result?.list.collect {
			def map = CommonUtils.tranferToMap(it, args.excludeFields ?: [], args.includeTypes ?: [])
			if(processResultItem) {
				processResultItem(it, map)
			}
			return map
		}
		def total = result.totalCount
		return ([total: total, rows: list] as JSON)
	}

	protected def getSettings(menu) {
		def settings = [:]
		def menuStack = [menu]
		while(menu.parent) {
			menu = menu.parent
			menuStack << menu
		}
		settings.menuStack = menuStack.reverse()
		return settings
	}

	protected def save(data, model, uri = null, successHandler = null) {
		data.save()
		if(data.hasErrors()) {
			flash.errors = data.errors
			flash.data = data
			redirect uri: "/${model}/data/" + (data.id ?: 'new')
		} else {
			if(successHandler) {
				successHandler()
			}
			flash.msgs = ['保存成功']
			def targetUri = uri ?: "/${model}/list"
			redirect uri: targetUri
		}
	}

	protected def delete(domainClass, model, successHandler = null) {
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				objs << domainClass.get(id as Long)
			}
			domainClass.deleteAll(objs)
			if(successHandler) {
				successHandler()
			}
			flash.msgs = ['删除成功']
		}
		redirect uri: "/${model}/list"
	}

	int maxSize = 1024 * 1024 * 10 // 10MB maximum

	def importDataWithHandler(handler, saveHandler = null) {
		CommonsMultipartFile file = request.getFile('file')
		if(file.size > maxSize) {
			render(text: "<script>alert('文件不能超过10MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		String name = file.fileItem.fileName
		if(!name.endsWith('.xls')) {
			render(text: "<script>alert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}

		try {
			HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
			HSSFSheet sheet = wb.getSheetAt(0)
			int rowCount = sheet.physicalNumberOfRows
			if(rowCount > 1) {
				def datas = []

				(rowCount-1).times { index ->
					def data
					try {
						data = handler(sheet.getRow(index + 1))
						if(data) {
							if(saveHandler) {
								saveHandler(data)
							} else {
								data.save()
							}
						}
					} catch(e) {
						def msg = "第${index+2}行出错, ${e.message}"
						log.error e.message, e
						throw new RuntimeException(msg)
					}
					if(data && data.hasErrors()) {
						def msg = g.message(code: data.errors.allErrors[0].codes[0])
						msg = "第${index+2}行出错, $msg"
						log.error msg
						throw new RuntimeException(msg)
					}
				}

			}
			render(text: "<script>alert('上传成功');window.parent.finishUpload();</script>", contentType: "text/html", encoding: "UTF-8")
		} catch(e) {
			render(text: "<script>alert('上传失败, ${e.message}');</script>", contentType: "text/html", encoding: "UTF-8")
		}
	}



	def importDataWithHandlerAndNativeSQL(hql, handler) {
		CommonsMultipartFile file = request.getFile('file')
		if(file.size > maxSize) {
			render(text: "<script>alert('文件不能超过10MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		String name = file.fileItem.fileName
		if(!name.endsWith('.xls')) {
			render(text: "<script>alert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}

		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(hql)

		try {
			HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
			HSSFSheet sheet = wb.getSheetAt(0)
			int rowCount = sheet.physicalNumberOfRows
			if(rowCount > 1) {
				(rowCount-1).times { index ->
					try {
						def argsArr = handler(sheet.getRow(index + 1))
						argsArr.eachWithIndex { args, idx ->
							args.eachWithIndex { arg, pos ->
								query.setParameter(pos, arg)
							}
							query.executeUpdate()
						}
					} catch(e) {
						def msg = "第${index+2}行出错, ${e.message}"
						log.error e.message, e
						throw new RuntimeException(msg)
					}
				}

			}
			render(text: "<script>alert('上传成功');window.parent.finishUpload();</script>", contentType: "text/html", encoding: "UTF-8")
		} catch(e) {
			render(text: "<script>alert('上传失败, ${e.message}');</script>", contentType: "text/html", encoding: "UTF-8")
		}
	}

	def downloadExampleWithInfo(info) {
		String fname = new String(info.fileName.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.${info.suffix}")
		response.outputStream << getClass().getResourceAsStream(info.filePath)
	}
	
	Random r = new Random()
	
	def handleException(Exception e) {
		def refid = r.nextInt(999999)
		log.info "Refid=${refid}", e
		render view: '/error', model: [refid: refid]
	}
	
	
	
	def initFrontName(String bSn){
		def frontName;
		if(bSn == CommonArguments.LOCAL_DEVELOPMENT){
			frontName = "localhost:8080"
		}else if(bSn == CommonArguments.PROGRAM_DEVELOPMENT){
			frontName = "120.25.103.111:7070"
		}else {
			frontName = CommonArguments.PRODUCT_DEVELOPMENT
		}
		return frontName
		
//		else (bSn == CommonArguments.PRODUCT_DEVELOPMENT){
//			frontName == CommonArguments.PRODUCT_DEVELOPMENT
//		}
//		else if(bSn == CommonArguments.PRODUCT_DEVELOPMENT_ONE){
//			frontName == CommonArguments.PRODUCT_DEVELOPMENT+":8080"
//		}else if(bSn == CommonArguments.PRODUCT_DEVELOPMENT_TWO){
//			frontName == CommonArguments.PRODUCT_DEVELOPMENT+":8080"
//		}
	}
}
