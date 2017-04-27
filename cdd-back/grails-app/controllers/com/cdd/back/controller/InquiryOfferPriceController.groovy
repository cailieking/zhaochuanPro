package com.cdd.back.controller
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.EndPort
import com.cdd.base.domain.InquiryOfferPrice
import com.cdd.base.domain.ShowInquiry
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.Intercepter;

import grails.converters.JSON

import java.awt.TexturePaintContext.Int;
import java.text.SimpleDateFormat

import org.hibernate.SQLQuery
class InquiryOfferPriceController extends BaseController {
	def model ="inquiryOfferPrice"
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
	SimpleDateFormat sdf2 = new SimpleDateFormat('MMddHHmmss')
	SimpleDateFormat sdf3 = new SimpleDateFormat('HH:mm')
	//询盘管理
	def inquiry(){
		Calendar cl = Calendar.getInstance()
		int year = cl.get(Calendar.YEAR)
		int month = cl.get(Calendar.MONTH)
		int date = cl.get(Calendar.DATE)
		cl.clear()
		cl.set(Calendar.YEAR, year)
		cl.set(Calendar.MONTH, month)
		cl.set(Calendar.DATE, date)
		def currentUser =springSecurityService.currentUser.username
		def result=CRUDService.list(InquiryOfferPrice, params){
			le "dateCreated",cl.getTime()+1
			ge "dateCreated",cl.getTime()
			eq "createBy",currentUser
			if(params.companyName){
				and{
					like "companyName","%"+params.companyName+"%"
				}
			}
			if(params.status){
				and{
					eq "inquiryStatus",params.status
				}
			}
		}
		def start = cl.getTime()
		def end = cl.getTime()+1
		println start
		println end
		def result2=CRUDService.list(ShowInquiry, params)
		
		SQLQuery sqlNewInquiry = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='新询盘' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		
		
		def  newInquiryTotal =  sqlNewInquiry.uniqueResult();
		
		
		
		SQLQuery sqlAddInquiry = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='补充询盘' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  addInquiryTotal =  sqlAddInquiry.uniqueResult();
		
		SQLQuery sqlOfferedInquiry = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='已应价' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  offereddInquiryTotal =  sqlOfferedInquiry.uniqueResult();
		
		SQLQuery sqlBooking = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='订舱' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  bookingTotal =  sqlBooking.uniqueResult();
		
		SQLQuery sqlcancel = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='终止' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  cancleTotal =  sqlcancel.uniqueResult();
		
	
		render view: "/${model}/inquiry",model:[result:result,result2:result2,newInquiryTotal:newInquiryTotal,addInquiryTotal:addInquiryTotal,offereddInquiryTotal:offereddInquiryTotal,bookingTotal:bookingTotal,cancleTotal:cancleTotal]
	}
	//对话栏信息获取
	def getShow(){
		ShowInquiry showInquiry = ShowInquiry.findByNumber(params.number)
		
		def data =[:]
		data.status="ok"
		data.showInquiry = showInquiry
		render data as JSON
	}
	//询盘应价详情
	def getDetails(){
		
		InquiryOfferPrice inquiryPrice = InquiryOfferPrice.findByNumber(params.number)
		BackUser user = BackUser.findByFirstname(inquiryPrice.businessMan)
		BackUser sales = BackUser.findByUsername(inquiryPrice.createBy)
		println sales
		def data =[:]
		data.inquiryPrice = inquiryPrice
		data.businessManOnline = user?.isOnline
		data.salesOnline = sales?.isOnline
		render data as JSON
	}
	//补充询盘
	def updateInquiry(){
		println params
		if(params.transBusinessMan){
			InquiryOfferPrice inquiryPrice = InquiryOfferPrice.findByNumber(params.number)
			inquiryPrice.businessMan = params.transBusinessMan
			inquiryPrice.save()
			redirect uri:"/inquiryOfferPrice/offerPrice"
		}else{
		InquiryOfferPrice inquiryPrice = InquiryOfferPrice.findByNumber(params.number)
		ShowInquiry showInquiry = ShowInquiry.findByNumber(params.number)
		println inquiryPrice
		StringBuffer text3 = new StringBuffer("")
		Date now = new Date()
		text3.append(sdf3.format(now)+"^"+inquiryPrice.createBy+";")
		if(params.GP20){
			inquiryPrice.gp20 = Integer.parseInt(params.GP20)
		}
		if(params.GP40){
			inquiryPrice.gp40 = Integer.parseInt(params.GP40)
		}
		if(params.HQ40){
			inquiryPrice.hq40 = Integer.parseInt(params.HQ40)
		}
		if(params.HQ45){
			inquiryPrice.hq45 = Integer.parseInt(params.HQ45)
		}
		if(params.companys){
			inquiryPrice.shipCompany = params.companys
			text3.append("船公司^"+inquiryPrice.shipCompany+";")
		}	
		if(params.itemType){
			inquiryPrice.ordersType = params.itemType
			text3.append("货物类型^"+inquiryPrice.ordersType+";")
		}
		if(params.ordesName){
			inquiryPrice.ordersName = params.ordersName
			text3.append("品名^"+inquiryPrice.ordersName+";")
		}
		if(params.weight){
			inquiryPrice.weight = params.weight
			text3.append("货重^"+inquiryPrice.weight+";")
		}
		if(params.ordersStatus){
			inquiryPrice.ordersStatus = params.ordersStatus
			text3.append("货物状态^"+inquiryPrice.ordersStatus+";")
		}
		if(params.sendTime){
			inquiryPrice.sendTime = sdf.parse(params.sendTime)
			text3.append("出货时间^"+inquiryPrice.sendTime+";")
		}
		if(params.needSpecial){
			inquiryPrice.specialContainer = params.needSpecial
			text3.append("特种柜^"+inquiryPrice.specialContainer+";")
		}
		if(params.freeDemurrage){
			inquiryPrice.freeDemurrage = params.freeDemurrage
			if(inquiryPrice.freeDemurrage.size()>2){
				text3.append("免柜期^"+inquiryPrice.freeDemurrage+";")
			}
			
		}
		if(params.shipper){
			inquiryPrice.shipper = params.shipper
			text3.append("shipper^"+inquiryPrice.shipper+";")
		}
		if(params.remarks){
			inquiryPrice.remarks = params.remarks
			text3.append("说明^"+inquiryPrice.remarks+";")
		}
		inquiryPrice.inquiryStatus = "补充询盘"
		
		showInquiry.textarea3= text3
		showInquiry.save();
		inquiryPrice.save();
		
		
		def data =[:]
		data.status ="ok";
		render data as JSON
		}
	}

	//新建询盘
	def saveInquiry(){
		println params
		InquiryOfferPrice inquiryOfferPrice = new InquiryOfferPrice()
		Date now = new Date()
		
		
		inquiryOfferPrice.number = "XP"+sdf2.format(now)
		if(params.gp20){
		inquiryOfferPrice.gp20 = Integer.parseInt(params.gp20)}
		if(params.gp40){
		inquiryOfferPrice.gp40 = Integer.parseInt(params.gp40)}
		if(params.hq40){
		inquiryOfferPrice.hq40 = Integer.parseInt(params.hq40)}
		if(params.hq45){
		inquiryOfferPrice.hq45 = Integer.parseInt(params.hq45)}
		inquiryOfferPrice.startPort = params.startPort
		inquiryOfferPrice.endPort = params.endPort
		inquiryOfferPrice.remarks = params.remarks
		if(params.businessMan){
			inquiryOfferPrice.businessMan = params.businessMan
		}else{
			inquiryOfferPrice.businessMan = params.sysBusinessMan
		}
		
		inquiryOfferPrice.shipCompany = params.shipCompany
		if(params.specialOrders){
			inquiryOfferPrice.ordersType = params.specialOrders
		}else{
			inquiryOfferPrice.ordersType = params.itemType
		}
		inquiryOfferPrice.ordersName = params.ordersName
		inquiryOfferPrice.weight = params.weight
		inquiryOfferPrice.ordersStatus = params.itemStatus
		if(params.sendTime){
		inquiryOfferPrice.sendTime = sdf.parse(params.sendTime)}
		inquiryOfferPrice.specialContainer = params.specialContainer
		inquiryOfferPrice.freeDemurrage = params.freeDemurrageStart+","+params.freeDemurrageEnd
		inquiryOfferPrice.otherRemarks = params.otherRemarks
		inquiryOfferPrice.shipper = params.shipper
		inquiryOfferPrice.companyName = params.companyName
		inquiryOfferPrice.customName = params.customName
		inquiryOfferPrice.phone = params.phone
		inquiryOfferPrice.qq = params.qq
		inquiryOfferPrice.email = params.email
		inquiryOfferPrice.inquirySales = springSecurityService.currentUser.username
		inquiryOfferPrice.inquiryStatus ="新询盘"
		/*if(!inquiryOfferPrice.save()){
			inquiryOfferPrice.errors.each {
				println it
			}
		}*/
		//inquiryOfferPrice.save()
		
		println sdf3.format(now)
		ShowInquiry showInquiry = new ShowInquiry()
		showInquiry.number =inquiryOfferPrice.number
		StringBuffer text1 = new StringBuffer("")
		text1.append(sdf3.format(now)+";"+inquiryOfferPrice.startPort+";"+inquiryOfferPrice.endPort+";")
		text1.append(inquiryOfferPrice.remarks+";")
		
		if(inquiryOfferPrice.gp20>0){
			text1.append("20GP*"+inquiryOfferPrice.gp20+";")
		}
		if(inquiryOfferPrice.gp40>0){
			text1.append("40GP*"+inquiryOfferPrice.gp40+";")
		}
		if(inquiryOfferPrice.hq40>0){
			text1.append("40HQ*"+inquiryOfferPrice.hq40+";")
		}
		if(inquiryOfferPrice.hq45>0){
			text1.append("45HQ*"+inquiryOfferPrice.hq45+";")
		}
		
		showInquiry.textarea1 = text1
		inquiryOfferPrice.save()
		showInquiry.save()
		redirect uri: "/${model}/inquiry"
	}
	
	
	
	
	//应价管理
	def offerPrice(){
		Calendar cl = Calendar.getInstance()
		int year = cl.get(Calendar.YEAR)
		int month = cl.get(Calendar.MONTH)
		int date = cl.get(Calendar.DATE)
		cl.clear()
		cl.set(Calendar.YEAR, year)
		cl.set(Calendar.MONTH, month)
		cl.set(Calendar.DATE, date)
		def currentUser = springSecurityService.currentUser.firstname
		def result=CRUDService.list(InquiryOfferPrice, params){
			le "dateCreated",cl.getTime()+1
			ge "dateCreated",cl.getTime()
			if(params.status){
				and{
					eq "inquiryStatus",params.status
				}
			}
			if(params.myself){
				and{
					like "businessMan","%"+currentUser+"%"
				}
			}
			if(params.businessMan){
			if(params.businessMan!="全部"){
				println "111111111"
				and{
					eq "businessMan",params.businessMan
				}
			}
			}
			if(params.salesMan){
				and{
					like "inquirySales","%"+params.salesMan+"%"
				}
			}
		}
		
		def start =cl.getTime()
		def end = cl.getTime()+1
		def result2=CRUDService.list(ShowInquiry, params)
		
		SQLQuery sqlNewInquiry = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='新询盘' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  newInquiryTotal =  sqlNewInquiry.uniqueResult();
		
		SQLQuery sqlAddInquiry = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='补充询盘' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  addInquiryTotal =  sqlAddInquiry.uniqueResult();
		
		SQLQuery sqlOfferedInquiry = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='已应价' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  offereddInquiryTotal =  sqlOfferedInquiry.uniqueResult();
		
		SQLQuery sqlBooking = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='订舱' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  bookingTotal =  sqlBooking.uniqueResult();
		
		SQLQuery sqlcancel = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM inquiry_offer_price WHERE inquiry_status='终止' and DATE_FORMAT(date_created, '%Y-%m-%d') >= '"+sdf.format(start)+"' and  DATE_FORMAT(date_created, '%Y-%m-%d') <= '"+sdf.format(end)+"';")
		def  cancleTotal =  sqlcancel.uniqueResult();
		
		
		render view: "/${model}/offerPrice",model:[result:result,result2:result2,newInquiryTotal:newInquiryTotal,addInquiryTotal:addInquiryTotal,offereddInquiryTotal:offereddInquiryTotal,bookingTotal:bookingTotal,cancleTotal:cancleTotal]
	}
	
	//应价保存
	def offerPriceSave(){
		println params
		InquiryOfferPrice inquiryPrice = InquiryOfferPrice.findByNumber(params.number)		
		ShowInquiry showInquiry = ShowInquiry.findByNumber(params.number)
		
		if(params.GP20){
		inquiryPrice.priceGp20 = Integer.parseInt(params.GP20)
		
		}
		if(params.GP40){
		inquiryPrice.priceGp40 = Integer.parseInt(params.GP40)}
		if(params.HQ40){
		inquiryPrice.priceHq40 = Integer.parseInt(params.HQ40)}
		if(params.HQ45){
		inquiryPrice.priceHq45 = Integer.parseInt(params.HQ45)}
		if(params.newGP20){
		inquiryPrice.newGp20 = Integer.parseInt(params.newGP20)}
		if(params.newGP40){
		inquiryPrice.newGp40 = Integer.parseInt(params.newGP40)}
		if(params.newHQ40){
		inquiryPrice.newHq40 = Integer.parseInt(params.newHQ40)}
		if(params.newHQ45){
		inquiryPrice.newHq45 = Integer.parseInt(params.newHQ45)}
		
		if(params.companys){
		inquiryPrice.shipCompanyBusiness = params.companys}
		if(params.shipDay){
		inquiryPrice.shippingDayBusiness = params.shipDay}
		if(params.dayLength){
		inquiryPrice.shippingdays = params.dayLength}
		if(params.maxWeight){
		inquiryPrice.weightLimit = params.maxWeight}
		if(params.supplys){
		inquiryPrice.supplier = params.supplys}
		
		if(params.remark){
		inquiryPrice.priceRemarks = params.remark}
		if(params.freeDemurrage){
			inquiryPrice.freeDemurrageBusiness = params.freeDemurrage}
		
		if(!showInquiry.textarea2){
				StringBuffer text2 = new StringBuffer("")
				StringBuffer price = new StringBuffer("报价^")
				if(inquiryPrice.newGp20>0||inquiryPrice.newGp40>0||inquiryPrice.newHq40>0||inquiryPrice.newHq45>0){
					if(inquiryPrice.newGp20){
						price.append("20GP-"+inquiryPrice.newGp20+" ")
					}
					if(inquiryPrice.newGp40){
						price.append("40GP-"+inquiryPrice.newGp40+" ")
					}
					if(inquiryPrice.newHq40){
						price.append("40HQ-"+inquiryPrice.newHq40+" ")
					}
					if(inquiryPrice.newHq45){
						price.append("45HQ-"+inquiryPrice.newHq45+" ")
					}
					//price.append("报价^20GP-"+inquiryPrice.newGp20+"\b"+"40GP-"+inquiryPrice.newGp40+"\b"+"40HQ-"+inquiryPrice.newHq40+"\b"+"45HQ-"+inquiryPrice.newHq45)
				}else{
				
						if(inquiryPrice.priceGp20){
							price.append("20GP-"+inquiryPrice.priceGp20+" ")
						}
						if(inquiryPrice.priceGp40){
							price.append("40GP-"+inquiryPrice.priceGp40+" ")
						}
						if(inquiryPrice.priceHq40){
							price.append("40HQ-"+inquiryPrice.priceHq40+" ")
						}
						if(inquiryPrice.priceHq45){
							price.append("45HQ-"+inquiryPrice.priceHq45+" ")
						}
					//price.append("报价^20GP-"+inquiryPrice.priceGp20+"\b"+"40GP-"+inquiryPrice.priceGp40+"\b"+"40HQ-"+inquiryPrice.priceHq40+"\b"+"45HQ-"+inquiryPrice.priceHq45+";")
				
				}
				Date now = new Date()
				text2.append(sdf3.format(now)+"^"+inquiryPrice.businessMan+";"+price+";")
				if(inquiryPrice.shipCompanyBusiness){
					text2.append("船公司^"+inquiryPrice.shipCompanyBusiness+";")
				}
				if(inquiryPrice.shippingDayBusiness){
					text2.append("船期^"+inquiryPrice.shippingDayBusiness+";")
				}
				if(inquiryPrice.shippingdays){
					text2.append("航程^"+inquiryPrice.shippingdays+";")
				}
				if(inquiryPrice.weightLimit){
					text2.append("限重^"+inquiryPrice.weightLimit+";")
				}
				if(inquiryPrice.supplier){
					text2.append("供应商^"+inquiryPrice.supplier+";")
				}
				if(inquiryPrice.freeDemurrageBusiness.size()>2){
					text2.append("免柜期^"+inquiryPrice.freeDemurrageBusiness+";")
				}
				if(params.needOffer){
					text2.append("需提供^"+params.needOffer+";")
				}
				if(inquiryPrice.priceRemarks){
					text2.append("说明^"+inquiryPrice.priceRemarks+";")
				}
				showInquiry.textarea2 = text2
		}else{
				StringBuffer text4 = new StringBuffer("")
				StringBuffer price = new StringBuffer("报价^")
				if(inquiryPrice.newGp20>0||inquiryPrice.newGp40>0||inquiryPrice.newHq40>0||inquiryPrice.newHq45>0){
					if(inquiryPrice.newGp20){
						price.append("20GP-"+inquiryPrice.newGp20+" ")
					}
					if(inquiryPrice.newGp40){
						price.append("40GP-"+inquiryPrice.newGp40+" ")
					}
					if(inquiryPrice.newHq40){
						price.append("40HQ-"+inquiryPrice.newHq40+" ")
					}
					if(inquiryPrice.newHq45){
						price.append("45HQ-"+inquiryPrice.newHq45+" ")
					}
					//price.append("报价^20GP-"+inquiryPrice.newGp20+"\b"+"40GP-"+inquiryPrice.newGp40+"\b"+"40HQ-"+inquiryPrice.newHq40+"\b"+"45HQ-"+inquiryPrice.newHq45)
				}else{
					if(inquiryPrice.priceGp20){
						price.append("20GP-"+inquiryPrice.priceGp20+" ")
					}
					if(inquiryPrice.priceGp40){
						price.append("40GP-"+inquiryPrice.priceGp40+" ")
					}
					if(inquiryPrice.priceHq40){
						price.append("40HQ-"+inquiryPrice.priceHq40+" ")
					}
					if(inquiryPrice.priceHq45){
						price.append("45HQ-"+inquiryPrice.priceHq45+" ")
					}
					//price.append("报价^20GP-"+inquiryPrice.priceGp20+"\b"+"40GP-"+inquiryPrice.priceGp40+"\b"+"40HQ-"+inquiryPrice.priceHq40+"\b"+"45HQ-"+inquiryPrice.priceHq45+";")
				
				}
				Date now = new Date()
				text4.append(sdf3.format(now)+"^"+inquiryPrice.businessMan+";"+price+";")
				if(inquiryPrice.shipCompanyBusiness){
					text4.append("船公司^"+inquiryPrice.shipCompanyBusiness+";")
				}
				if(inquiryPrice.shippingDayBusiness){
					text4.append("船期^"+inquiryPrice.shippingDayBusiness+";")
				}
				if(inquiryPrice.shippingdays){
					text4.append("航程^"+inquiryPrice.shippingdays+";")
				}
				if(inquiryPrice.weightLimit){
					text4.append("限重^"+inquiryPrice.weightLimit+";")
				}
				if(inquiryPrice.supplier){
					text4.append("供应商^"+inquiryPrice.supplier+";")
				}
				if(inquiryPrice.freeDemurrageBusiness.size()>2){
					text4.append("免柜期^"+inquiryPrice.freeDemurrageBusiness+";")
				}
				if(params.needOffer){
					text4.append("需提供^"+params.needOffer+";")
				}
				if(inquiryPrice.priceRemarks){
					text4.append("说明^"+inquiryPrice.priceRemarks+";")
				}
				showInquiry.textarea4 = text4
		}
		inquiryPrice.inquiryStatus = "已应价"
		showInquiry.save()
		inquiryPrice.save()
		def data = [:]
		data.status="ok"
		render data as JSON
	}
	//终止操作
	def finishInquiry(){
		println params
		InquiryOfferPrice inquiryPrice = InquiryOfferPrice.findByNumber(params.number)
		if(params.success){
			inquiryPrice.inquiryStatus = "订舱"
		}else{
			
		inquiryPrice.finalReason= params.reason+params.otherReason
		inquiryPrice.inquiryStatus = "终止"
		}
		def data = [:]
		data.status="ok"
		render data as JSON
	}
	
	def getBusinessList(){
		def sql = sessionFactory.getCurrentSession().createSQLQuery("SELECT firstname FROM back_user WHERE  enabled = '1' AND role_id = '15' OR role_id = '17'");
		def list = sql.list()
		println list
		def online = []
		for(def i=0;i<list.size();i++){
			BackUser business = BackUser.findByFirstname(list[i])
			online.add(business.isOnline)
		}
		println online
		def data = [:]
		data.list = list
		data.online = online
		render data as JSON
	}
	
	
	
	def setBusiness(){
		println params.endPort
		EndPort endPort = EndPort.findByPortEnglishName(params.endPort)
		def business
		if(endPort){
			println endPort.route.users
			def list = endPort.route.users
			if(list.size()>0){
				
				int r = (int)(Math.random()*list.size())
				 business = endPort.route.users[r].firstname
			}else{
				 business = ""
			}
		}
		def data = [:]
		data.status="ok"
		data.business = business
		render data as JSON
	}
}
