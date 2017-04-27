package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.Date;
import java.util.Random;

import org.hibernate.SessionFactory;

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.BackUser;
import com.cdd.base.domain.Booking
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
class BookingController implements ExceptionHandler{
	CRUDService CRUDService
	Date date=new Date()
	SpringSecurityService springSecurityService
	SessionFactory sessionFactory
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
	@Secured('ROLE_CLIENT')
	def saveBooking(){
		Booking booking = new Booking()
		
		booking.bookingName=params.bookingName
		booking.bookingContact=params.bookingContact
		booking.bookingEmail=params.bookingEmail
		booking.bookingPhone=params.bookingPhone
		booking.shipperName=params.shipperName
		booking.shipperContact=params.shipperContact
		booking.shipperEmail=params.shipperEmail
		booking.shipperPhone=params.shipperPhone
		booking.consigneeName=params.consigneeName
		booking.consigneeContact=params.consigneeContact
		booking.consigneeEmail=params.consigneeEmail
		booking.consigneePhone=params.consigneePhone
		booking.notifyPartyName=params.notifyPartyName
		booking.notifyPartyContact=params.notifyPartyContact
		booking.notifyPartyEmail=params.notifyPartyEmail
		booking.notifyPartyPhone=params.notifyPartyPhone
		booking.portLoading=params.portLoading
		booking.placeReceipt=params.placeReceipt
		booking.serviceOrigin=params.serviceOrigin
		booking.portDischarge=params.portDischarge
		booking.placeDelivery=params.placeDelivery
		booking.serviceDestination=params.serviceDestination
		booking.voyageNo=params.voyageNo
		if(params.etd){
		booking.etd=sdf.parse(params.etd)}
		booking.finalDestination=params.finalDestination
		booking.gp20Num=params.gp20Num
		booking.gp20Quantity=params.gp20Quantity
		booking.gp20Volume=params.gp20Volume
		booking.gp20Weight=params.gp20Weight
		booking.commodity=params.commodity
		booking.gp40Num=params.gp40Num
		booking.gp40Quantity=params.gp40Quantity
		booking.gp40Volume=params.gp40Volume
		booking.gp40Weight=params.gp40Weight
		booking.hq40Num=params.hq40Num
		booking.hq40Quantity=params.hq40Quantity
		booking.hq40Volume=params.hq40Volume
		booking.hq40Weight=params.hq40Weight
		booking.bookingRemark=params.bookingRemark
		booking.personInCharge=params.personInCharge
		booking.chargeTel=params.chargeTel
		booking.chargeEmail=params.chargeEmail
		booking.status = "UnCheck"
		if(params.of_money){
		booking.ofMoney =params.of_money
		}
		if(params.local_money){
			booking.localMoney =params.local_money
			}
		CargoShipInformation info = CargoShipInformation.get(params.infoId as Long)
		booking.info = info
		if( !booking.save() ) {   booking.errors.each {        println it   }}
		booking.save()
		redirect ( url: '/bookingManage.gsp')
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
			if(params.orderId){
				eq "id",params.orderId as Long
			}
			if (params.status) {
				if(params.status=="UnCheck"){
					eq "status",params.status
				}else if(params.status=="InBooking"){
					eq "status",params.status
				}else if(params.status=="FailBooking"){
					eq "status",params.status
				}else if(params.status=="ShippingSpaced"){
					eq "status",params.status
				}else if(params.status=="NoPass"){
					eq "status",params.status
				}
			}
			if(params.startPort){
				info {
						like "startPort", "%"+params.startPort+"%"
					}
			}
			if(params.endPort){
				info {
						like "endPort", "%"+params.endPort+"%"
					}
			}
			if(params.companyName){
				info {
						like "shipCompany", "%"+params.companyName.toUpperCase()+"%"
					}
			}
			if(params.orderTime){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf.parse(params.orderTime);
				def date2=sdf.parse(params.orderTime)+1;
					and{
					 between ("dateCreated" , date1,date2)
			           }
			}
			if(params.startDate||params.endDate){
				info {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				def startDate=sdf.parse(params.startDate);
				def startDates=sdf.parse(params.startDate)+1;
				def endDate=sdf.parse(params.endDate);
				def endDates=sdf.parse(params.endDate)+1;
					and{
					 between ("startDate" , startDate,startDates)
					   }
					and{
						between ("endDate" , endDate,endDates)
						  }
			}
			}
			
		}

		def result= CRUDService.list(Booking,params,queryHandler)
//
		def list = result?.list.collect {
			def csi=CargoShipInformation.get(it.info.id)
			def order=Order.findByInfo(csi)
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
			def dateCreated = formatter.format(it.dateCreated)
			def startDate = formatter.format(csi.startDate)
			def endDate = formatter.format(csi.endDate)
			def status
			if(it.status=="UnCheck"){
				status="审核中"
			}else if(it.status=="InBooking"){
				status="订舱中"
			}else if(it.status=="NoPass"){
				status="审核不通过"
			}else if(it.status=="ShippingSpaced"){
				status="已放舱"
			}else if(it.status=="FailBooking"){
				status="订舱失败"
			}
			def data = [:]
			data.id=it.id
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
			data.startDate=startDate
			data.endDate=endDate
			data.status=status
			data.shipCompany=csi.shipCompany
			data.gp20Num = it.gp20Num
			data.gp40Num = it.gp40Num
			data.hq40Num = it.hq40Num
			if(it.so){
			data.soFilePath = it.so.soFilePath
			}else{
			data.soFilePath = "--"
			}
			return data
		}
		render([result:list] as JSON)

		
	}
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def view(){
		def data = Booking.get(params.id as Long)
		
		CargoShipInformation cargoInfo = data.info
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
		
		def etd = formatter.format(data.etd)
		def startDate = formatter.format(cargoInfo.startDate)
		//println cargoInfo
		render view: '/bookingView.gsp',model:[data:data,cargoInfo:cargoInfo,etd:etd,startDate:startDate]
	}

}
