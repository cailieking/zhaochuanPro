package com.cdd.front.controller



import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.Random;

import org.hibernate.SessionFactory;

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.BackUser;
import com.cdd.base.domain.CargoShipInformation;
import com.cdd.base.domain.EndPort;
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.InqueryPrice
import com.cdd.base.domain.Order
import com.cdd.base.domain.ShippingPrices;
import com.cdd.base.domain.StartPort;
import com.cdd.base.domain.User;
import com.cdd.base.enums.CargoBoxType;
import com.cdd.base.enums.InqueryPriceStatus;
import com.cdd.base.enums.OrderStatus;
import com.cdd.base.enums.Status;
import com.cdd.base.enums.TransportationType
import com.cdd.base.service.OrderService;
import com.cdd.base.service.common.CRUDService
import com.cdd.front.constant.Constant;


class InqueryPriceController implements ExceptionHandler{

	CRUDService CRUDService
	Date date=new Date()
	SpringSecurityService springSecurityService
	SessionFactory sessionFactory
	def index() {
	}

	//询价管理信息保存	@Secured('ROLE_CLIENT')	def saveinquery(){
		SimpleDateFormat dateFormat = new SimpleDateFormat("ddHHmmss")
		Date date=new Date()
		def datesize= dateFormat.format( date )
		def number="7"+datesize
		InqueryPrice inqueryprice=new InqueryPrice(params)
		FrontUser user = springSecurityService.currentUser
	    CargoShipInformation ship = CargoShipInformation.get(params.infoId as Long);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
		def endDate = formatter.format(ship.endDate)
		def startDate = formatter.format(ship.startDate)
		inqueryprice.createBy = user.username
		inqueryprice.updateBy = user.username
		inqueryprice.dateCreated = date
		inqueryprice.lastUpdated = date
		inqueryprice.contactMan = params.userName
		inqueryprice.companyName = params.companyName
		inqueryprice.mobile = params.mobile
		inqueryprice.qq = params.qq
		inqueryprice.status = InqueryPriceStatus.NotAccepted
		inqueryprice.orderDescript = params.remark?params.remark:"" 
		inqueryprice.number = number
		//CargoShipInformation info=CargoShipInformation.get(params.infoId as Long)
	
		inqueryprice.info= CargoShipInformation.get(params.infoId as Long)
		
		inqueryprice.deleteStatus = "0"
			if(!inqueryprice.save(flash:true))
			{
				inqueryprice.errors.each{
					println "a:>====="+it
				}
		}
		render model :['ok'];
		//redirect ( url: '/list.gsp')
        
	}
	//运价信息修改
	@Secured('ROLE_CLIENT')
	def updateInquery(){
		//InqueryPrice newData = new InqueryPrice(params)
		InqueryPrice data = InqueryPrice.get(params.id as Long)
		if(data.contactMan.equals(params.contactMan)||data.companyName.equals(params.companyName)
			||data.mobile.equals(params.mobile)||data.qq.equals(params.qq)
			||data.remark.equals(params.remark)){
			
			data.contactMan = params.contactMan
			data.companyName = params.companyName
			data.mobile = params.mobile
			data.qq = params.qq
			data.remark = params.remark
			data.save()
			}else{
			data.contactMan = params.contactMan
			data.companyName = params.companyName
			data.mobile = params.mobile
			data.qq = params.qq
			data.remark = params.remark
			data.status = "NotAccepted"
			data.save()
		}
	}
	
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def update(){
		def infoid=(params.infoId as Long)
		//println infoid
		def contactMan = params.userName
		def companyName = params.companyName
		def mobile = params.mobile
		def qq = params.qq
		def hql="update InqueryPrice a set a.contactMan=:contactMan,a.companyName=:companyName,"+
		"a.mobile=:mobile,a.qq=:qq where a.info.id=:infoid"
		def hql1=[contactMan:contactMan,companyName:companyName,mobile:mobile,qq:qq,infoid:infoid]
				if(!InqueryPrice.executeUpdate(hql,hql1))
						{
							InqueryPrice.errors.each{
								println "a:>====="+it
							}
					    }
		render view: '/list.gsp'
	}
	
    //自动生成的一个标号
	def createNumber() {
		DecimalFormat df = new DecimalFormat('000')
		SimpleDateFormat sdf = new SimpleDateFormat('yyMMdd')
		String numberPrefix = sdf.format(new Date())
		def maxNumber = sessionFactory.currentSession.createSQLQuery("""
				select number from orders where number like '${numberPrefix}%' order by number desc limit 0,1 for update
				""").uniqueResult()
		if(!maxNumber) {
			maxNumber = 0
		} else {
			maxNumber = df.parse(maxNumber.replace(numberPrefix, '')) + 1
		}
		return numberPrefix + df.format(maxNumber)
	}
	
	//客戶发布的货盘信息保存
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def saveorder(){
		Order order=new Order(params)
		//SpringSecurityService springSecurityService
		FrontUser user = springSecurityService.currentUser
		def username
		if(user!=null){
			username=user.username
		}
		
		order.createBy = username
		order.updateBy = username
		order.dateCreated = date
		//order.lastUpdated = date
		//起始港中文名称(不能在起始港中找到默认为null)
		order.startPort = params.startPort
		order.endPort = params.endPort
		
		order.orderType = params.orderType
		//println user.companyName
		order.companyName = user.companyName//公司名称  companyName  
		//order.service = BackUser.get("10" as Long )
		//新增的两个字段
		order.shipCompany=params.shipCompany//船公司名称
		//order.deleteStatus="0"//用户删除状态
		order.deleted=0
		
		order.cargoName = params.cargoName
		
		if(params.box20GP==""||params.box20GP==null){
			params.box20GP=0
		}
		if(params.box40GP==""||params.box40GP==null){
			params.box40GP=0
		}
		if(params.box40HQ==""||params.box40HQ==null){
			params.box40HQ=0
		}
		if(params.box45HQ==""||params.box45HQ==null){
			params.box45HQ=0
		}
		order.cargoBoxNums =(params.box20GP+","+params.box40GP+","+params.box40HQ+","+params.box45HQ)
		order.number=createNumber()
		order.transType = params.transType
		order.info=CargoShipInformation.get(params.infoId as Long)
		//order.deleted = "0"
		//println CargoShipInformation.get(params.infoId as Long)
		order.orderStatus=OrderStatus.UnTrade
		order.status = Status.UnVerify
		order.orderCome = "F"
		order.phone = user.phone?user.phone:"--"
		order.contactName = user.firstname
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = sdf.parse(params.endDate);
		order.endDate = date1
		order.cargoBoxType = ("20GP"+","+"40GP"+","+"40HQ"+","+"45HQ")
		order.cargoWeight = new Double(params.cargoWeight)
		order.cargoCube = new Double(params.cargoCube)
		order.cargoNums = new Double(params.cargoNums)
		order.remark = params.orderDescript
		
			if(!order.save(flash:true))
			{
					order.errors.each{
						println "a:>====="+it
					}
			  }
        render view: '/member/cargolist'
//			}
	}
	
	
	
	//询价查询
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def list(){


		def queryHandler={
			FrontUser user = springSecurityService.currentUser
			def userName=user.username
			eq "createBy",userName
			if (!params.sort) {
				params.sort = "lastUpdated";
				params.order = "desc";
			}

			if (params.status) {
				if(params.status=="NotAccepted"){
					eq "status",params.status
				}else if(params.status=="Acceptance"){
					eq "status",params.status
				}else if(params.status=="Accepted"){
					eq "status",params.status
				}
				//				switch(params.status) {
				//					case InqueryPriceStatus.NotAccepted.: eq "status", InqueryPriceStatus.NotAccepted; break;
				//					case InqueryPriceStatus.Acceptance: eq "status", InqueryPriceStatus.Acceptance; break;
				//					case InqueryPriceStatus.Accepted: eq "status", InqueryPriceStatus.Accepted; break;
				//
				//				}
			}
			//println params.serach
			if(params.serach) {
				//println (CargoShipInformation.get(params.serach))
				or {
					info {
						like "startPort", "%"+params.serach.toUpperCase()+"%"
					}
					info {
						like "endPort", "%"+params.serach.toUpperCase()+"%"
					}
					info {
						like "startPortCn", "%"+params.serach.toUpperCase()+"%"
					}
					info {
						like "endPortCn", "%"+params.serach.toUpperCase()+"%"
					}
					 eq "number",params.serach
					
				}
			}
			if(params.shippingDays){
				or{info{ eq "shippingDays",Integer.parseInt(params.shippingDays)}}
			}
			if(params.shipCompany){
				or{info{ eq "shipCompany",params.shipCompany }}
			}
			if(params.validityStratDate||params.validityEndDate){
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf5.parse(params.validityStratDate);
				def date2=sdf5.parse(params.validityEndDate)+1;
				and{
					info{
						between ("startDate", date1,date2)}
				}
			}
			if(params.endDate){
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd");
				def endDate=sdf5.parse(params.endDate);
				or{info{ eq "endDate",endDate}}
			}
			

		}


		def result= CRUDService.list(InqueryPrice,params,queryHandler)
//		
		def list = result?.list.collect {
			//def info=(() as Long)
			//println it.info.id
			def csi=CargoShipInformation.get(it.info.id)
			//def csi1=CargoShipInformation.get(info)
			def order=Order.findByInfo(csi)
			//println order as JSON 
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
			def dateCreated = formatter.format(it.dateCreated)
			def startDate = formatter.format(csi.startDate)
			def endDate = formatter.format(csi.endDate)

			def status
			//println it.status
			if(it.status=="Accepted"){
				status="已完成"
			}else if(it.status=="Acceptance"){
				status="受理中"
			}else if(it.status=="NotAccepted"){
				status="未受理"
			}else if(it.status=="Revoked"){
			    status="已撤销"
			}
			//println status

			def data = [:]
			data.id=it.id
			data.number=it.number
			data.info=order
			data.dateCreated=dateCreated
			data.transType=csi.transType.text
			data.startPort=csi.startPort
			data.startPortCn=csi.startPortCn
			data.endPort=csi.endPort
			data.endPortCn=csi.endPortCn
			data.middlePort=csi.middlePort
			data.middlePortCn=csi.middlePortCn
			data.infoid=it.info.id
			data.shippingDay=csi.shippingDay
			data.shippingDays=csi.shippingDays
			data.gp20=csi.prices.gp20
			data.gp40=csi.prices.gp40
			data.hq40=csi.prices.hq40
			data.startDate=startDate
			data.endDate=endDate
			data.status=status
			data.deleteStatus=it.deleteStatus
			//data.number=it.info.id
			return data
			
		}
//		def statu
//		if(list!=""||list!=null){
//			statu="1"
//		}else{
//			statu="0"
//		}
		//println list as JSON
		//println list as JSON
		//println 111111111
		//println res as JSON
		render([result:list] as JSON)

		
		//render(view:'/list.html',[result:list])
	}
	
    //通过询价id查看询价和运价内容
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def cargo(){
		
		
		//FrontUser user = springSecurityService.currentUser
		//def infoId=params.infoId
		def inquerprice = InqueryPrice.get(params.id as Long)
		CargoShipInformation cargoInfo = inquerprice.info
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
				def endDate = formatter.format(cargoInfo.endDate)
				def startDate = formatter.format(cargoInfo.startDate)
				
				
				render view: '/EditInquery.gsp', model: [cargoInfo:cargoInfo,inquerprice: inquerprice,endDate:endDate,startDate:startDate]

	
	}
		
	
	
     //询价删除
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def deletecargo(){
		def deleteStatus="1"
		def infoid=params.infoid
		println infoid
		def hql="update InqueryPrice a set a.deleteStatus=:deleteStatus where a.id=:infoid"
		def hql1=[:]
		def sta="deleteStatus"
		def st=deleteStatus
		def sta1="infoid"

		def st1=new Long(infoid)
		hql1.put(sta,st)
		hql1.put(sta1,st1)
		//println hql
		//println hql1
		InqueryPrice.executeUpdate(hql,hql1)
		redirect(url: "/list.gsp")

	}
	
	//询价撤销
	@Secured('ROLE_CLIENT')
	def updateStatus(){
		
	
		
		def status="Revoked"
		def infoid=params.infoid
		def hql="update InqueryPrice a set a.status=:status where a.info.id=:infoid"
		def hql1=[:]
		def sta="status"
		def st=status
		def sta1="infoid"

		def st1=new Long(infoid)
		hql1.put(sta,st)
		hql1.put(sta1,st1)
		//println hql
		//println hql1
		if(!InqueryPrice.executeUpdate(hql,hql1))
		{
			InqueryPrice.errors.each{
				println "a:>====="+it
			}
	}
		
		
		
		redirect(url: "/list.gsp",params:["state":"Success"])
	}
	
	

	
	//货盘修改
//	@Secured('ROLE_CLIENT')
//	def update(){
// 
//		FrontUser user = springSecurityService.currentUser
//		def infoid=new Long(params.infoId)
//		def startPort=params.startPort
//		def endPort=params.endPort
//		def orderType=params.orderType
//		def companyName=params.shipCompany
//		def cargoName=params.cargoName
//		def updateBy=user.username
//		Date lastUpdated=date
//		//TransportationType transType=(TransportationType)Enum.Parse(typeof(TransportationType),"text")
//		if(params.transType){
//			//print params.transType
//			switch(params.transType){
//				case "Whole":
//				def transType=TransportationType.Whole;
//				break;
//				case "Together":
//				def transType=TransportationType.Together;
//				break;
//			}
//		}
//
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		Date date1 = sdf.parse(params.endDate);
//		def endDate=date1
//		def cargoBoxNums=(params.cargoBoxType20GP+","+params.cargoBoxType40GP+","+params.cargoBoxType40HQ+","+params.cargoBoxType45HQ).toString()
//		def cargoWeight=new Double(params.cargoWeight)
//		def cargoCube=new Double(params.cargoCube)
//		def cargoNums= Integer.parseInt(params.cargoNums)
//		def remark=params.orderDescript
//
//		def hql="update Order a set a.startPort=:startPort,a.endPort=:endPort,a.endPort=:endPort,a.endPort=:endPort,"+
//		"a.orderType=:orderType,a.companyName=:companyName,a.cargoName=:cargoName,a.endDate=:endDate,"+
//		"a.cargoBoxNums=:cargoBoxNums,a.cargoWeight=:cargoWeight,a.cargoCube=:cargoCube,a.cargoNums=:cargoNums,a.remark=:remark,"+
//		"updateBy=:updateBy,lastUpdated=:lastUpdated  where a.info.id=:infoid"
//		def hql1=[startPort:startPort,endPort:endPort,orderType:orderType,
//			companyName:companyName,cargoName:cargoName,
//			endDate:endDate,cargoBoxNums:cargoBoxNums,cargoWeight:cargoWeight,
//			cargoCube:cargoCube,cargoNums:cargoNums,remark:remark,updateBy:updateBy,lastUpdated:lastUpdated,infoid:infoid]
//		//println hql
//		//println hql1
//		//InqueryPrice.executeUpdate(hql,hql1)
//		if(!InqueryPrice.executeUpdate(hql,hql1))
//		{
//			InqueryPrice.errors.each{
//				println "a:>====="+it
//			}
//		}
//		redirect(url: "/list.gsp",params:["state":"Success"])
//	}
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def view(){
		def number=params.number
		def inquerprice = InqueryPrice.findByNumber(params.number as Long)
		
		CargoShipInformation cargoInfo = inquerprice.info
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
		
		//println inquerprice as JSON
		//println inquerprice.info.shipCompany
		def endDate = formatter.format(cargoInfo.endDate)
		def startDate = formatter.format(cargoInfo.startDate)
		//println cargoInfo
		render view: '/ShowInquery.gsp',model:[inquerprice:inquerprice,cargoInfo:cargoInfo,endDate:endDate,startDate:startDate]
	}
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def editInquery(){
		//println params.id
		InqueryPrice inqueryPrice = InqueryPrice.get(params.id as Long)
		inqueryPrice.contactMan =params.contactMan
		inqueryPrice.companyName =params.companyName
		inqueryPrice.mobile =params.mobile
		inqueryPrice.qq =params.qq
		inqueryPrice.remark =params.remark
		inqueryPrice.status = "NotAccepted"
		render view: '/list.gsp'
	}
	
}
