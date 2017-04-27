package com.cdd.back.controller


import org.apache.poi.hssf.usermodel.HSSFRow
import org.springframework.security.crypto.keygen.KeyGenerators;

import com.cdd.base.domain.Company;
import com.cdd.base.domain.CompanyCertificate
import com.cdd.base.domain.FrontUser
import com.cdd.base.enums.AgentType;

import grails.converters.JSON;

import java.text.SimpleDateFormat

class CompanyCertificateController extends BaseController {
	
	def excludeFields = ['salt', 'password']
	
	def model='companyCertificate'
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
	/**********返回认证公司列表****************/
	def list={
		def searchKey;
		if(params.search){
			searchKey="%${params.search}%"
		}
		render getList(model:model,domainClass:CompanyCertificate,excludeFields: excludeFields, isConjunction: true, queryHandler:{
			if(searchKey){
				or{
					like "companyName" ,searchKey
					like "city" ,searchKey
					like "specialService" ,searchKey
				}
			}
			
		});
	}
	/***********公司详细页面**************/
	def data={
		render data(model: model, menuName: '公司认证列表', domainClass: CompanyCertificate, excludeFields: excludeFields)
	}
	
	
	
}
