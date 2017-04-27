package com.cdd.back.controller

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.base.domain.AdvCorporation
import com.cdd.base.enums.AdvertisementType
import com.cdd.base.service.OssService

class AdvCorpController extends BaseController {
	def model = 'advCorp'

	def list() {
		if(params.search) {
			params.f_like_image = "%${params.search}%"
		}

		render getList(model: model, domainClass: AdvCorporation) { item, map ->
			map.type = item.type.text
		}
	}

	def data() {
		render data(model: model, menuName: '合作厂商信息', domainClass: AdvCorporation)
	}

	int maxSize = 1024 * 1024 * 10
	
	GrailsApplication grailsApplication
	
	OssService ossService

	def save() {
		AdvCorporation data
		if(params.id) {
			data = AdvCorporation.get(params.id as Long)
		} else {
			data = new AdvCorporation()
		}
		try {
			data.type = AdvertisementType.valueOf(params.type) 
		} catch(e) {
		}
		data.content = params.content
		data.order = params.order as int

		CommonsMultipartFile f = request.getFile('file')
		if(f.size <= 0 && !data.image) {
			flash.errors = [:]
			flash.errors.msgs = ['请上传一张图片']
			redirect uri: "/${model}/data/${data.id ?: 'new'}"
			return
		}
		if(f.size > maxSize) {
			flash.errors = [:]
			flash.errors.msgs = ['图片不能超过10MB']
			redirect uri: "/${model}/data/${data.id ?: 'new'}"
			return
		}
		if(f.size > 0) {
			String fileName = "files/adv/corporation/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			//now transfer file
//			File fileDest = new File("${grailsApplication.config.appInfo.rootPath}${fileName}")
//			fileDest.mkdirs()
//			f.transferTo(fileDest)
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket, 
				"files/adv/corporation/" + f.fileItem.fileName)
			data.image = fileName
		}
		save(data, model)
	}

	def delete() {
		delete(AdvCorporation, model)
	}
	
}
