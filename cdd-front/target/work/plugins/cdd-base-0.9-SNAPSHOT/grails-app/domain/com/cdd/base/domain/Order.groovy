package com.cdd.base.domain

import com.cdd.base.domain.BaseDomain
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.OrderType
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType

class Order extends BaseDomain {
	String startPort
	String startPortCn
	String endPort
	String endPortCn
	Date biteEndDate
	TransportationType transType
	Status status
	String remark // 用户备注
	String number
	String orderType
	City city
	BigDecimal dealPrice
	OrderStatus orderStatus
	Date startDate
	Date endDate
	String cargoBoxType
	String cargoBoxNums
	Integer cargoNums
	Double cargoWeight
	Double cargoCube
	Double cargoWidth
	Double cargoHeight
	Double cargoLength
	String cargoName
	String companyName
	String phone
	String memo // 员工备注
	String contactName
	String certFilePath
	String isoFilePath
	String bookingFilePath
	
	BackUser service
	BackUser sales
	FrontUser owner
	String orderCome
	
	//新增的两个字段   2015/11/17
	String shipCompany
	
	//String deleteStatus
	
//	FrontUser agent
	CargoShipInformation info
	
	String closeReason
	
	static hasMany = [recommendedInfos: RecommendedShipInfo]
	
	boolean deleted
	
	static mapping = {
		table 'orders'
	}
	
	static constraints = {
		biteEndDate nullable: true
		startDate nullable: true
		endDate nullable: true
		cargoName nullable: true, unique: false, blank: false, maxSize: 255
		status nullable: false, unique: false, blank: false, maxSize: 50
		remark nullable: true, unique: false, blank: false, maxSize: 500
		memo nullable: true, unique: false, blank: false, maxSize: 500
		number nullable: true, unique: true, blank: false, maxSize: 50
		orderType nullable: true, unique: false, blank: false, maxSize: 50
		city nullable: true
		startPort nullable: true, blank: false, unique: false, maxSize: 255
		startPortCn nullable: true, blank: false, unique: false, maxSize: 255
		endPort nullable: true, blank: false, unique: false, maxSize: 255
		endPortCn nullable: true, blank: false, unique: false, maxSize: 255
		transType nullable: true, blank: false, unique: false, maxSize: 50
		orderStatus nullable:true, blank: false, unique: false, maxSize: 50
		cargoBoxType nullable:true, blank: false, unique: false, maxSize: 255
		companyName nullable: true, blank: false, unique: false, maxSize: 255
		phone nullable: false, blank: false, unique: false, maxSize: 50
		contactName nullable: false, blank: false, unique: false, maxSize: 50
		certFilePath nullable: true, blank: false, unique: false, maxSize: 255
		owner nullable: true
//		agent nullable: true
		info nullable: true
		sales nullable: true
		service nullable: true
		cargoBoxNums nullable: true
		cargoNums nullable: true
		cargoWeight nullable: true
		cargoCube nullable: true
		cargoWidth nullable: true
		cargoHeight nullable: true
		cargoLength nullable: true
		dealPrice nullable: true
		orderCome nullable: true
		deleted nullable: false
		isoFilePath nullable: true, blank: false, unique: false, maxSize: 255
		bookingFilePath nullable: true, blank: false, unique: false, maxSize: 255
		shipCompany nullable:true
		closeReason nullable:true
	}
}
