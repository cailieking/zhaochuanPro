package com.cdd.base.domain

class Booking extends BaseDomain{
	String bookingName
	String bookingEmail
	String bookingContact
	String bookingPhone
	String shipperName
	String shipperEmail
	String shipperContact
	String shipperPhone
	String consigneeName
	String consigneeEmail
	String consigneeContact
	String consigneePhone
	String notifyPartyName
	String notifyPartyEmail
	String notifyPartyContact
	String notifyPartyPhone
	String placeReceipt
	String portLoading
	String placeDelivery
	String voyageNo
	String preCarriageBy
	String serviceOrigin
	String serviceDestination
	Date etd 
	String finalDestination
	String gp20Num
	String gp20Quantity
	String gp20Weight
	String gp20Volume
	
	String gp40Num
	String gp40Quantity
	String gp40Weight
	String gp40Volume
	String hq40Num
	String hq40Quantity
	String hq40Weight
	String hq40Volume
	String commodity
	String bookingRemark
	String personInCharge
	String chargeTel
	String chargeEmail
	String failReason
	String remark
	CargoShipInformation info
	BookingSo so
	String status
	
	String operateBy
	String finishedBy
	String portDischarge
	
	String ofMoney
	String localMoney
	static mapping = {
		table 'booking'
	}
	
	
	static constraints = {
		 bookingName nullable:true
		 bookingEmail nullable:true
		 bookingContact nullable:true
		 bookingPhone nullable:true
		 shipperName nullable:true
		 shipperEmail nullable:true
		 shipperContact nullable:true
		 shipperPhone nullable:true
		 consigneeName nullable:true
		 consigneeEmail nullable:true
		 consigneeContact nullable:true
		 consigneePhone nullable:true
		 notifyPartyName nullable:true
		 notifyPartyEmail nullable:true
		 notifyPartyContact nullable:true
		 notifyPartyPhone nullable:true
		 placeReceipt nullable:true
		 portLoading nullable:true
		 placeDelivery nullable:true
		 voyageNo nullable:true
		 preCarriageBy nullable:true
		 serviceOrigin nullable:true
		 serviceDestination nullable:true
		 etd nullable:true
		 finalDestination nullable:true
		 gp20Num nullable:true
		 gp20Quantity nullable:true
		 gp20Weight nullable:true
		 gp20Volume nullable:true
		
		 gp40Num nullable:true
		 gp40Quantity nullable:true
		 gp40Weight nullable:true
		 gp40Volume nullable:true
		 hq40Num nullable:true
		 hq40Quantity nullable:true
		 hq40Weight nullable:true
		 hq40Volume nullable:true
		 commodity nullable:true
		 bookingRemark nullable:true
		 personInCharge nullable:true
		 chargeTel nullable:true
		 chargeEmail nullable:true
		 failReason nullable:true
		 remark nullable:true
		 info nullable:true
		 so nullable:true
		 status nullable:false
		
		 operateBy nullable:true
		 finishedBy nullable:true
		 portDischarge nullable:true
		 ofMoney nullable:true
		 localMoney nullable:true
		
	}
}
