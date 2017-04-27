package com.cdd.back.controller

import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.HSSFRow
import com.cdd.base.domain.EnterpriseDirectory;

class EnterpriseDirectoryController  extends BaseController{
	def excludeFields = ['salt', 'password']
	def model = 'enterpriseDirectory'
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')

	def list() {
		def searchKey;
		if(params.search){
			searchKey="%${params.search}%"
		}
		render getList(model: model, domainClass: EnterpriseDirectory,excludeFields: excludeFields, isConjunction: true, queryHandler:{
			if(searchKey) {
				or {
					like "companyName", searchKey
					like "contactName",searchKey
					like "mobile",searchKey
				}
			}
			if(params.status){
				or{
					eq "showOnIndex", Boolean.parseBoolean(params.status)
				}
			}
		}){ item, map ->
			
			 map.dateCreated = sdf.format(item.dateCreated)
			
			  
		}
	}
	
	def data() {
		render data(model: model, menuName: '企业名录信息', domainClass: EnterpriseDirectory, excludeFields: excludeFields)
	}
	
	def edit() {
		def data
		if(params.id != 'new') {
			data = EnterpriseDirectory.get(params.id as Long)
		} else {
			data = flash.data ?: new EnterpriseDirectory()
		}
		render view: "/${model}/edit", model: [data: data, settings: getSettings(getMenu('企业名录信息', "/${model}/list"))]
	}
	def save(){
		EnterpriseDirectory data
		if(params.id){
			data = EnterpriseDirectory.get(params.id as Long)
			data.properties=params
		}else{
			data = new EnterpriseDirectory(params)
		}
		params.uri="/enterpriseDirectory/list"
		save(data,'enterpriseDirectory',params.uri)
	}
	
	/********删除*******/
	def delete={
		request.view = "/$model/list"
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				EnterpriseDirectory	 enterpriseDirectory = EnterpriseDirectory.get(id as Long)
				enterpriseDirectory.delete(flush:true);
			}
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}
	
	def showOnIndex(){
		EnterpriseDirectory enterpriseDirectory = EnterpriseDirectory.get(params.id as Long)
		if(enterpriseDirectory) {
			enterpriseDirectory.showOnIndex = Boolean.valueOf(params.showOnIndex)
			enterpriseDirectory.save()
			if(enterpriseDirectory.hasErrors()) {
				flash.errors = enterpriseDirectory.errors
			} else {
				def showOnIndex = enterpriseDirectory.showOnIndex ? '打开' : '关闭';
				flash.msgs = [
					"${enterpriseDirectory.contactName}${showOnIndex}成功"
				]
			}
		}
		redirect url: "/${model}/list"
	}
	
	def downloadExample() {
				downloadExampleWithInfo(fileName: '企业名录上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/enterpriseDirectory.xls')
			}
	def importData(){
		importDataWithHandler() {
		HSSFRow row ->
		EnterpriseDirectory data = new EnterpriseDirectory()
		
		data.companyName = row.getCell(0)?.stringCellValue?.trim() ?: null
		data.companyEnglish = row.getCell(1)?.stringCellValue?.trim() ?: null
		data.city = row.getCell(2)?.stringCellValue?.trim() ?: null
		data.address = row.getCell(3)?.stringCellValue?.trim() ?: null
		data.email = row.getCell(4)?.stringCellValue?.trim() ?: null
		try {
				data.mobile = row.getCell(5)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.mobile = row.getCell(5)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(5).numericCellValue).longValue()) : null
			}
		data.contactName = row.getCell(6)?.stringCellValue?.trim() ?: null
		try {
				data.telephone = row.getCell(7)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.telephone = row.getCell(7)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(7).numericCellValue).longValue()) : null
			}
		try {
				data.qq = row.getCell(8)?.stringCellValue?.trim() ?: null
			} catch(e) {
				data.qq = row.getCell(8)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(8).numericCellValue).longValue()) : null
			}
		data.remark1 = row.getCell(9)?.stringCellValue?.trim() ?: null
		data.showOnIndex = true
		return data
		}
	}
}


