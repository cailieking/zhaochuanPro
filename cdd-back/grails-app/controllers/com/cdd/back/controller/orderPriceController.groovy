package com.cdd.back.controller

import grails.converters.JSON
import java.text.SimpleDateFormat;

import com.cdd.base.domain.OrderPrice;
import com.cdd.base.enums.InqueryPriceStatus;

class orderPriceController extends BaseController{
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	def model='orderPrice'
	
	def list(){
		
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}
		String searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		def result=CRUDService.list(OrderPrice, params){
			if(searchKey) {
				or {
					like "companyName", searchKey
					like "number", searchKey
					like "mobile",searchKey
				}
			}
			if(params.number){
				and{
					like "number",params.number
				}
			}
			if(params.contactman){
				and{
					like "contactMan","%${params.contactman}%"
				}
			}
			if(params.createtime){
				def date1=sdf.parse(params.createtime)
				def date2=sdf.parse(params.createtime)+1
				and{
					between ("dateCreated", date1,date2)
				}
			}
			if(params.operateBy){
				and{
					like "operateBy","%${params.operateBy}%"
				}
			}
			if(params.operateTime){
				def date1=sdf.parse(params.operateTime)
				def date2=sdf.parse(params.operateTime)+1
				and{
					between ("operateTime", date1,date2)
				}
			}
			if(params.finishBy){
				and{
					like "finishBy","%${params.finishBy}%"
				}
			}
			if(params.lastUpdated){
				def date1=sdf.parse(params.lastUpdated)
				def date2=sdf.parse(params.lastUpdated)+1
				and{
					between ("lastUpdated", date1,date2)
				}
			}
			if(params.status){
				and {
					eq "status", params.status
				}
			}
			
			ne "deleteStatus", "2"
		}
		def map=[rows:[],total:result.totalCount]
		result.list.each { OrderPrice orderPrice ->
			def data=[:]
			switch(orderPrice.status){
				case InqueryPriceStatus.NotAccepted.name():
					data.status="未受理"
				break
				case InqueryPriceStatus.Acceptance.name():
					data.status="受理中"
				break
				case InqueryPriceStatus.Accepted.name():
					data.status="已完成"
				break
			}
			data.id=orderPrice.id
			data.number=orderPrice.number
			data.order=orderPrice.order
			data.companyName=orderPrice.companyName
			data.contactMan=orderPrice.contactMan
			data.mobile=orderPrice.mobile
			data.orderDescript=orderPrice.orderDescript
			data.dateCreated=sdf.format(orderPrice.dateCreated)
			data.operateBy=orderPrice.operateBy
			if(orderPrice.operateTime!=null){
				data.operateTime=sdf.format(orderPrice.operateTime)
			}else{
				data.operateTime=orderPrice.operateTime
			}
			if(orderPrice.deleteStatus==null){
				
			}
			if(orderPrice.deleteStatus=="1"){
				data.deleteStatus="用户已删除"
			}
			if(orderPrice.deleteStatus=="0"){
				data.deleteStatus=null
			}
			
			data.finishedBy=orderPrice.finishBy
			if(orderPrice.lastUpdated!=null || orderPrice.status!="Accepted"){
				data.lastUpdate=sdf.format(orderPrice.lastUpdated)
			}else{
				data.lastUpdate=orderPrice.lastUpdated
			}
			map.rows << data
		}
		
		render map as JSON
	}
	
	//查看页面
	def view(){
		OrderPrice data = OrderPrice.get(params.id as Long)
		def newData=[:]
		String str=data.order.cargoBoxType
		if(str!=null && str.indexOf(",")>=0){
			String[] aa=str.split(",")
			newData.GP20=aa[0]
			newData.GP40=aa[1]
			newData.HQ40=aa[2]
			String c=data.order.cargoBoxNums
			String[] bb=c.split(",")
			newData.GP20CargoBoxNums=bb[0]
			newData.GP40CargoBoxNums=bb[1]
			newData.HQ40CargoBoxNums=bb[2]
			newData.data=data
			newData.str="str"
		}else{
			newData.data=data
			newData.str=null
		}
		render view: "/${model}/view", model: [data: newData, settings: getSettings(getMenu('查看', "/${model}/list"))]
	}
	
	//删除
	def delete() {
			String[] ids = params.ids.split(',(\\s)*')
			if(ids) {
				def printStr=null;
				for(def id in ids) {
					OrderPrice data = OrderPrice.get(id as Long)
					if(data.status != "Accepted"){
						printStr="正在受理，无法删除"
					}
				
			}
			if(printStr!=null||"".equals(printStr)){
				flash.msgs = [printStr]
			}
			else{
					def objs = []
					for(def id in ids) {
						OrderPrice data = OrderPrice.get(id as Long)
						data.deleteStatus = "2"
						objs << data
					}
					OrderPrice.saveAll(objs)
					flash.msgs = ['删除成功']
				}
			}
			redirect uri: "/${model}/list"
	}
	//受理
	def operate(){
		OrderPrice data=OrderPrice.get(params.id as Long)
		OrderPrice newData=new OrderPrice(params)
		if(data){
			if(data.status != "NotAccepted"){
				if(data.status != "Acceptance"){
						flash.errors = [:]
						flash.errors.msgs = ['已结单，不能进行操作']
					}else{
						flash.errors = [:]
						flash.errors.msgs = ['正在受理中']
					}
			}else{
					data.status="Acceptance"
					data.operateBy=springSecurityService.currentUser.username
					data.operateOpinion=newData.operateOpinion
					data.remark=newData.remark
					Date operateTime=new Date()
					data.operateTime=operateTime
					data.save(flush:true)
					flash.msgs = ['受理操作成功']
			}
		}
		redirect uri: "/${model}/list"
	}
	
	//修改页面
	def update(){
			OrderPrice data = OrderPrice.get(params.id as Long)
			def newData=[:]
			String str=data.order.cargoBoxType
			if(str!=null && str.indexOf(",")>=0){
				String[] aa=str.split(",")
				newData.GP20=aa[0]
				newData.GP40=aa[1]
				newData.HQ40=aa[2]
				String c=data.order.cargoBoxNums
				String[] bb=c.split(",")
				newData.GP20CargoBoxNums=bb[0]
				newData.GP40CargoBoxNums=bb[1]
				newData.HQ40CargoBoxNums=bb[2]
				newData.data=data
				newData.str="str"
			}else{
				newData.data=data
				newData.str=null
			}
			render view: "/${model}/edit", model: [data: newData, settings: getSettings(getMenu('修改', "/${model}/list"))]
	}
	
	//结单页面
	def finish(){
		OrderPrice data=OrderPrice.get(params.id as Long)
		def newData=[:]
		String str=data.order.cargoBoxType
		if(str.indexOf(",")>=0){
			String[] aa=str.split(",")
			newData.GP20=aa[0]
			newData.GP40=aa[1]
			newData.HQ40=aa[2]
			String c=data.order.cargoBoxNums
			String[] bb=c.split(",")
			newData.GP20CargoBoxNums=bb[0]
			newData.GP40CargoBoxNums=bb[1]
			newData.HQ40CargoBoxNums=bb[2]
			newData.data=data
			newData.str="str"
		}else{
			newData.data=data
			newData.str=null
		}
		render view: "/${model}/finish", model: [data: newData, settings: getSettings(getMenu('结单', "/${model}/list"))]
		/*if(data){
			data.status="Accepted"
			data.finishBy=springSecurityService.currentUser.username
			Date lastUpdated=new Date()
			data.lastUpdated=lastUpdated
		}
		data.save(flush:true)
		flash.msgs = ['结单操作成功']
		redirect uri: "/${model}/list"*/
	}
	
	//结单操作
	def finished(){
		OrderPrice data
		if(params.id){
			data=OrderPrice.get(params.id as Long)
			OrderPrice newData=new OrderPrice(params)
			data.companyName=newData.companyName
			data.contactMan=newData.contactMan
			data.mobile=newData.mobile
			data.qq=newData.qq
			data.operateOpinion=newData.operateOpinion
			data.remark=newData.remark
			data.status="Accepted"
			data.finishBy=springSecurityService.currentUser.username
			Date lastUpdated=new Date()
			data.lastUpdated=lastUpdated
		}
		data.save(flush:true)
		flash.msgs = ['结单操作成功']
		redirect uri: "/${model}/list"
	}
	
	//修改保存
	def save(){
		OrderPrice data
		if(params.id){
			data=OrderPrice.get(params.id as Long)
			OrderPrice newData=new OrderPrice(params)
			data.companyName=newData.companyName
			data.contactMan=newData.contactMan
			data.mobile=newData.mobile
			data.qq=newData.qq
			data.operateOpinion=newData.operateOpinion
			data.remark=newData.remark
		}
		data.save()
		if(data.hasErrors()) {
			flash.errors = data.errors
			flash.data = data
			redirect uri: "/${model}/edit/" + (data.id ?: 'new')
		} else {
			flash.msgs = ['保存成功']
			redirect uri: "/${model}/list"
		}
	}

}
