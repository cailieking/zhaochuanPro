package com.cdd.front.controller

import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.FrontUser;
import com.cdd.base.domain.Order;

import grails.converters.JSON;

import com.cdd.base.domain.CargoShipScore;
import com.cdd.base.domain.CargoShipItemScore;
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.CityService
import com.cdd.front.constant.Constant;

class CargoShipScoreController implements ExceptionHandler {

	
	SpringSecurityService springSecurityService

	@Secured(['ROLE_CARGO_OWNER'])
	def saveCargoShipItemScore() {
		FrontUser user = springSecurityService.currentUser
		Order order = Order.get(params.orderId);
		if (order.owner && order.info) {
			if (order.owner.id == user.id) {
				CargoShipItemScore score = CargoShipItemScore.findByOrder(order);
				if (score == null) {
					CargoShipItemScore cargoShipItemScore = new CargoShipItemScore(params);
					
					//验证参数
					if ((!cargoShipItemScore.shipInTime) || (!cargoShipItemScore.docInTime) || (!cargoShipItemScore.infoInTime) || (!cargoShipItemScore.serviceQuality) || (!cargoShipItemScore.serviceContent)
						|| cargoShipItemScore.shipInTime > 5 || cargoShipItemScore.shipInTime < 1 || cargoShipItemScore.docInTime > 5 || cargoShipItemScore.docInTime < 1
						|| cargoShipItemScore.infoInTime > 5 || cargoShipItemScore.infoInTime < 1 || cargoShipItemScore.serviceQuality > 5 || cargoShipItemScore.serviceQuality < 1
						|| cargoShipItemScore.serviceContent > 5 || cargoShipItemScore.serviceContent < 1
					) {
						render ([msg: "非法参数", status: Constant.STATUS_FAILED] as JSON)
						return;
					}
					
					def calcCompanyName = "";
					if (order.info.owner) {
						calcCompanyName = order.info.owner.companyName;
					} else {
						calcCompanyName = order.info.companyName;
					}
					
					cargoShipItemScore.order = order;
					
					cargoShipItemScore.companyName = calcCompanyName;

					cargoShipItemScore.save(flush: true)
					
					def criteria = CargoShipItemScore.createCriteria()
					def cargoShipOwnerCount = criteria.get {
						eq("companyName", calcCompanyName)
						projections {
							avg "shipInTime"
							avg "docInTime"
							avg "infoInTime"
							avg "serviceQuality"
							avg "serviceContent"
						}
					}
					
					CargoShipScore cargoShipScore = CargoShipScore.findByCompanyName(calcCompanyName);
					if(cargoShipScore == null) {
						cargoShipScore = new CargoShipScore();
						cargoShipScore.companyName = calcCompanyName;
					}
					cargoShipScore.shipInTime = cargoShipOwnerCount[0];
					cargoShipScore.docInTime = cargoShipOwnerCount[1];
					cargoShipScore.infoInTime = cargoShipOwnerCount[2];
					cargoShipScore.serviceQuality = cargoShipOwnerCount[3];
					cargoShipScore.serviceContent = cargoShipOwnerCount[4];
					cargoShipScore.save(flush: true)
				}
			}
		}
		render ([status: Constant.STATUS_SUCCESS] as JSON)
	}
	
}
