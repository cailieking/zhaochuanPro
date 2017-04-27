package com.cdd.front.controller

import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.FrontUser;
import com.cdd.base.domain.Order;
import com.cdd.base.enums.OrderStatus;
import com.cdd.base.enums.Status;
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.CityService

class ProcessController implements ExceptionHandler {
	
	SpringSecurityService springSecurityService
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def data() {
		Order order = Order.findByNumber(params.number.trim())
		String result = "";
		String resultId = "";
		String number = "";
		if (order != null) {
			if (order.orderStatus) {
				switch(order.orderStatus) {
					case OrderStatus.UnTrade.name(): resultId =  "s2"; result=OrderStatus.UnTrade.text; break;
					case OrderStatus.InTrade.name(): resultId = "s2"; result=OrderStatus.InTrade.text; break;
					case OrderStatus.TradeSuccess.name(): resultId =  "s3"; result=OrderStatus.TradeSuccess.text; break;
					case OrderStatus.CertUploaded.name(): resultId =  "s4"; result=OrderStatus.CertUploaded.text; break;
					case OrderStatus.CertInVerify.name(): resultId =  "s4"; result=OrderStatus.CertInVerify.text; break;
					case OrderStatus.CertPassed.name(): resultId = "s5"; result=OrderStatus.CertPassed.text; break;
				}
			} else if (order.status) {
				switch(order.status) {
					case Status.UnVerify.name(): resultId = "s1"; result=Status.UnVerify.text; break;
					case Status.InVerify.name(): resultId = "s1"; result=Status.InVerify.text; break;
					case Status.VerifyPassed.name(): resultId = "s2"; result=Status.VerifyPassed.text; break;
					case Status.VerifyFailed.name():resultId = "s2"; result=Status.VerifyFailed.text; break;
				}
			}
			number = order.number;
		}
		
		def flow = "";
		
		if (result == Status.VerifyFailed.text) {
			flow = [s1 : "待审核", s2 : "审核不通过（流程结束）"]
		} else {
			flow = [s1 : "待审核", s2 : "审核通过", s3 : "交易撮合成功", s4 : "凭证上传完毕", s5 : "凭证审核通过（交易完成）"]
		}
		
		return [data: [number: number, resultId: resultId, flow : flow]]
	}
	
}
