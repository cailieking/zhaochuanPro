package com.cdd.back.controller

import org.codehaus.groovy.grails.commons.GrailsApplication

import com.cdd.base.domain.ImageInformation
import com.cdd.base.service.OssService
import grails.converters.JSON
import java.text.SimpleDateFormat

class ImageInfoController extends BaseController {
	def model = 'imageInfo'
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
	def list() {
		/*if(params.search) {
			params.f_like_image = "%${params.search}%"
		}

		render getList(model: model, domainClass: ImageInformation)*/
		def result = CRUDService.list(ImageInformation, params)
		def list = result?.list.collect {
			def data = [:]
			data.id = it.id
			data.createBy=it.createBy
			data.dateCreated =sdf.format(it.dateCreated)
			data.lastUpdated = sdf.format(it.lastUpdated)
			data.updateBy = it.updateBy
			data.content = it.content
			data.image = it.image
			data.order = it.order
			data.state = it.state
			data.endDate = sdf.format(it.endDate)
			data.title = it.title
			data.alt = it.alt
			data.href = it.href
			return data
			}
		def total = result.totalCount
		render view:"/imageInfo/list",model:[total: total, rows: list]

		}
	def data() {
		ImageInformation data
		if(params.id) {
			data = ImageInformation.get(params.id as Long)
		}
		render data as JSON
		//render data(model: model, menuName: '图片广告', domainClass: ImageInformation)
	}

	int maxSize = 1024 * 1024 * 10

	GrailsApplication grailsApplication
	
	OssService ossService

	def save() {
		ImageInformation data
		if(params.id) {
			data = ImageInformation.get(params.id as Long)
		} else {
			data = new ImageInformation()
		}
		data.content = "remark"//params.content
		data.order = params.order as int
		data.title = params.title
		data.alt = params.alt
		data.href = params.href
		if(params.endDate){
		data.endDate = sdf.parse(params.endDate)
		}

		def f = request.getFile('file')
		if(f.size <= 0 && !data.image) {
			flash.errors = [:]
			flash.errors.msgs = ['请上传一张图片']
			redirect uri: "/${model}/list"
			return
		}
		if(f.size > maxSize) {
			flash.errors = [:]	
			flash.errors.msgs = ['图片不能超过10MB']
			redirect uri: "/${model}/list"
			return
		}
		if(f.size > 0) {
			String fileName = "files/adv/imageInfo/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			//now transfer file
//			File fileDest = new File("${grailsApplication.config.appInfo.rootPath}${fileName}")
//			fileDest.mkdirs()
//			f.transferTo(fileDest)
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket, 
				"files/adv/imageInfo/" + f.fileItem.fileName)
			data.image = fileName
		}
		data.save()
		if(data.hasErrors()) {
			flash.errors = data.errors
			flash.data = data
			redirect uri: "/${model}/list"
		} else {
			
			flash.msgs = ['保存成功']
			redirect uri: "/${model}/list"
		}
		//redirect uri: "/${model}/list"
		//save(data, model)
	}

	def delete() {

		delete(ImageInformation, model)
	}
	
	def changeState(){
		ImageInformation data = ImageInformation.get(params.id as Long)
		if(data.state==1){
			data.state = 0
		}else{
			data.state = 1
		}
		data.save()
		redirect uri: "/${model}/list"
	}
	
	def deleteOssImage(){
		ImageInformation data = ImageInformation.get(params.id as Long)
		ossService.ossClient.deleteObject(grailsApplication.config.oss.publicbucket, data.image)
		def state=[state:""]
		state.state="1"
		render state as JSON
		//redirect uri: "/${model}/list"
	}
}
