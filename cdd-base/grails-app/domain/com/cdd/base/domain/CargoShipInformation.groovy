package com.cdd.base.domain

import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType

class CargoShipInformation extends BaseDomain {
	String startPort
	String startPortCn
	String endPort
	String endPortCn
	String middlePort
	String middlePortCn
	Date startDate //有效期开始日期
	TransportationType transType
	String shipCompany
	Status status
	City city
	String routeName
	Date endDate //有效期结束日期
	String shippingDay
	String remark
	Integer shippingDays
	String companyName
	String phone
	String contactName
	String memo
	BackUser service
	boolean showOnIndex
	String address
	Order wantedOrder
	String weightLimit
	String pinServiceType
	int sendState;
	
	String releaseNum;
	String fromBy
	
	FrontUser owner
	static hasOne = [prices: ShippingPrices]
	static hasMany = [orders: Order]
	
	boolean deleted
	
	static mapping = {
		table 'cargo_ship_information'
	}
	
	static constraints = {
		status nullable: false, blank: false, unique: false, maxSize: 50
		city nullable: true
		phone nullable: true, blank: false, unique: false, maxSize: 50
		contactName nullable: true, blank: false, unique: false, maxSize: 50
		routeName nullable: true, blank: false, unique: false, maxSize: 255
		startPort nullable: true, blank: false, unique: false, maxSize: 255
		startPortCn nullable: true, blank: false, unique: false, maxSize: 255
		endPort nullable: true, blank: false, unique: false, maxSize: 255
		endPortCn nullable: true, blank: false, unique: false, maxSize: 255
		middlePort nullable: true, blank: false, unique: false, maxSize: 255
		middlePortCn nullable: true, blank: false, unique: false, maxSize: 255
		transType nullable: true, blank: false, unique: false, maxSize: 50
		shipCompany nullable: true, blank: false, unique: false, maxSize: 255
		companyName nullable: false, blank: false, unique: false, maxSize: 255
		remark nullable: true, blank: false, unique: false, maxSize: 500
		memo nullable: true, blank: false, unique: false, maxSize: 500
		shippingDay nullable: true, blank: false, unique: false, maxSize: 255
		startDate nullable: true
		endDate nullable: true
		wantedOrder nullable: true
		owner nullable: true
		prices nullable: true
		orders nullable: true
		shippingDays nullable: true
		service nullable: true
		address nullable: true, blank: false, unique: false, maxSize: 255
		weightLimit nullable: true, blank: false, unique: false, maxSize: 500
		deleted nullable: false
		pinServiceType nullable: true, maxSize: 50
		releaseNum nullable:true,maxSize:64
	}
}
