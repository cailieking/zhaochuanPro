package com.cdd.back.controller

import com.cdd.base.domain.WeekRanking;
import grails.converters.JSON
import java.text.SimpleDateFormat

class SearchManageController extends BaseController {
	def list(){
		//WeekRanking weekrank = new WeekRanking()
		def weekrank = WeekRanking.list(sort: "id", order: "desc",max:"1")?.collect{
			def data = [:]
			data.startTime = new SimpleDateFormat('yyyy-MM-dd').format(it.startTime)
			data.endTime = new SimpleDateFormat('yyyy-MM-dd').format(it.endTime)
			data.startPort = it.startPort
			data.endPort = it.endPort
			data.shipCompany = it.shipCompany
			return data
		}
		render view:"/searchManage/list",model:[data:weekrank]
	}
	
	def doSearch(){
		if(params.weeks != "all"){
		def weekrank = WeekRanking.list(sort: "id", order: "desc",max:params.weeks)?.collect{
			def data = [:]
			data.startTime = new SimpleDateFormat('yyyy-MM-dd').format(it.startTime)
			data.endTime = new SimpleDateFormat('yyyy-MM-dd').format(it.endTime)
			if(params.type=="startPort"){
			data.rankData = it.startPort
			}
			if(params.type=="endPort"){
			data.rankData = it.endPort
			}
			if(params.type=="shipCompany"){
			data.rankData = it.shipCompany
			}
			data.type = params.type
			return data
		}
		render view:"/searchManage/moreList",model:[data:weekrank,weeks:params.weeks]
		}else{
		def weekrank = WeekRanking.list(sort: "id", order: "desc")?.collect{
			def data = [:]
			data.startTime = new SimpleDateFormat('yyyy-MM-dd').format(it.startTime)
			data.endTime = new SimpleDateFormat('yyyy-MM-dd').format(it.endTime)
			if(params.type=="startPort"){
			data.rankData = it.startPort
			}
			if(params.type=="endPort"){
			data.rankData = it.endPort
			}
			if(params.type=="shipCompany"){
			data.rankData = it.shipCompany
			}
			data.type = params.type
			return data
		}
		render view:"/searchManage/moreList",model:[data:weekrank,weeks:params.weeks]
		}
	}
}
