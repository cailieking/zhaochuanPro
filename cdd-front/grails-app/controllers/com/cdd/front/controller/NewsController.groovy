package com.cdd.front.controller
import grails.converters.JSON

import java.text.SimpleDateFormat

import com.cdd.base.domain.ArticleInformation;
import com.cdd.base.enums.ArticleType
import com.cdd.base.enums.ArticleState
import com.cdd.base.service.common.CRUDService;
import com.cdd.base.util.CommonUtils;
class NewsController {
	CRUDService CRUDService
	def articleList1(){
		int pagesize=10 ;
		def curPage
		if(!params.curPage&&params.curPage<0){
			curPage=0
		}else{
			curPage=Integer.parseInt(params.curPage)
		}
		def map = [:]
		map.list=[]
		def type=params.type
		def types
		if ("ftlist".equals(type)){
			types=ArticleType.ForeignTrade
		}
		if ("tplist".equals(type)){
			types=ArticleType.Transportation
		}
		if ("comlist".equals(type)){
			types=ArticleType.Company
		}
		//def list = CRUDService.list(ArticleInformation, [sort: 'lastUpdate', order: 'desc', 'f_articleType': types]){
		def list = CRUDService.list(ArticleInformation, [sort: 'issueDate', order: 'desc']){
				and {
					eq 'articleType' , types
				}
				and {
					eq 'articleState' , ArticleState.valueOf("Issue")
				}
		}
		
		def total=list.size()
		 
		def start=curPage*pagesize
		def end=(curPage+1)*pagesize<(total-1)?(curPage+1)*pagesize:(total-1)

		def maptotal=['total':total]
		def maptype=['articleType':types]
		def mappagesize=['pagesize':pagesize]
		def mappage=['curPage':curPage]
		def mapstart=['start':start]
		def mapend=['end':end]
		list?.each { data ->
			def maps=[:]
			maps.id=data.id
			maps.title=data.title
			maps.category = data.articleCategory
			maps.comes =data.comes
			maps.content = data.content
			maps.image = data.image
			maps.newsUrl = data.newsUrl
			maps["dateCreatedStr"] =  data.issueDate ? new SimpleDateFormat('yyyy-MM-dd').format(data.issueDate) : (data.issueDate ? new SimpleDateFormat('yyyy-MM-dd').format(data.issueDate): "");
			map.list<<maps
		}
		
		map<<maptotal
		map<<maptype
		map<<mappage
		map<<mappagesize
		map<<mapstart
		map<<mapend
		render map as JSON//(view:'index',model:[map:map])
	}
}
