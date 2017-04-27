package com.cdd.back.schedule

import groovy.util.logging.Slf4j;

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory;
import org.springframework.web.client.RestTemplate;

import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.domain.EndPortMapping
import grails.converters.JSON
import java.text.DecimalFormat
//长帆数据接口获取数据保存
@Slf4j
class ShipPriceGetJob {
	RestTemplate client = new RestTemplate()
	SessionFactory sessionFactory
	def grailsApplication
	static triggers = {
		cron name: 'ShipPriceGetTrigger', cronExpression: "0 0 3 * * ?"
		//cron name: 'ShipPriceGetTrigger', cronExpression: "0 59 11 * * ?"
	}
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def execute(){
		println "ok!"
		InetAddress addr = InetAddress.getLocalHost();
		def ip=addr.getHostAddress();//获得本机IP
		if(ip =="10.116.49.232"){//指定一台服务器运行112.74.81.205
			SQLQuery query1 = sessionFactory.currentSession.createSQLQuery("""
						DELETE FROM ship_prices WHERE info_id IN (SELECT id FROM cargo_ship_information WHERE cargo_ship_information.company_name = "深圳市长帆国际物流有限公司" and create_by = "cailie")
					""")
			query1.executeUpdate();
	
			SQLQuery query2 = sessionFactory.currentSession.createSQLQuery("""
						DELETE FROM cargo_ship_information where id not in (select info_id from booking) and cargo_ship_information.company_name = "深圳市长帆国际物流有限公司"	and create_by = "cailie"		
					""")
	
			query2.executeUpdate();
	
	
			String url3 = "http://218.18.53.97:8100/sbToTracking/ToTrancking.ashx?tenantid=9856C38FFB5F4D8A"
			def json2 = client.postForObject(url3, null, String.class)
			def data2 = JSON.parse(json2)
			def total = data2.getAt("total")
			int maxPage = total/200
			println maxPage
			def data
			for(int PageId = 1;PageId<=maxPage;PageId++){
				println "页数"+PageId
				try{
					String url = "http://218.18.53.97:8100/sbToTracking/ToTrancking.ashx?tenantid=9856C38FFB5F4D8A&PageId="+PageId
					def json = client.postForObject(url, null, String.class)
					data = JSON.parse(json)
				}catch(Exception e){
					println e
					continue;
				}
				for(int i = 0;i<data.getAt("rows").size();i++){
					CargoShipInformation ship = new CargoShipInformation()
					try{
						ship.startPort = data.getAt("rows")[i].getAt("QiYunGang")
						def endPort = data.getAt("rows")[i].getAt("MuDiGang")
						
						def portMapping = EndPortMapping.findByChangfanPort(endPort)
						if(portMapping){
							ship.endPort = portMapping.endPort.portEnglishName
						}else{
							ship.endPort = endPort
						}
						
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd")
						if(data.getAt("rows")[i].getAt("StartTime").size()>8) {
							continue
						}
						ship.startDate = sdf2.parse(data.getAt("rows")[i].getAt("StartTime"))
						if(data.getAt("rows")[i].getAt("ZhongZhuanGang")){
							ship.middlePort = data.getAt("rows")[i].getAt("ZhongZhuanGang")}
						ship.routeName = data.getAt("rows")[i].getAt("HangXian")
						ship.shippingDay = data.getAt("rows")[i].getAt("HangQi")
						if(data.getAt("rows")[i].getAt("EndTime").size()>8) {
							continue
						}
						ship.endDate = sdf2.parse(data.getAt("rows")[i].getAt("EndTime"))
						ship.shipCompany = data.getAt("rows")[i].getAt("ChuanDong")
						ship.remark = data.getAt("rows")[i].getAt("ChengYunBeiZhu")?:"null"
						ship.status = "VerifyPassed"
						ship.transType = "Whole"
						ship.companyName = "深圳市长帆国际物流有限公司"
						ship.createBy = "cailie"
						ship.updateBy = "cailie"
						ship.fromBy ="后台"
						ship.releaseNum = "P8888"
						ShippingPrices newPrices = new ShippingPrices()
						ship.prices = newPrices
						
						/*ship.prices.gp20 = data.getAt("rows")[i].getAt("t1").toBigDecimal()
						ship.prices.gp40 = data.getAt("rows")[i].getAt("t2").toBigDecimal()
						ship.prices.hq40 = data.getAt("rows")[i].getAt("t3").toBigDecimal()*/
						if(data.getAt("rows")[i].getAt("t1").toBigDecimal()=="0"){
							ship.prices.gp20 = data.getAt("rows")[i].getAt("t1").toBigDecimal()
						}else if(data.getAt("rows")[i].getAt("t1").toBigDecimal()=="100"){
						ship.prices.gp20 = data.getAt("rows")[i].getAt("t1").toBigDecimal()-99
						}
						else{
						ship.prices.gp20 = data.getAt("rows")[i].getAt("t1").toBigDecimal()-100
						}
						if(data.getAt("rows")[i].getAt("t2").toBigDecimal()=="0"){
							ship.prices.gp40 = data.getAt("rows")[i].getAt("t2").toBigDecimal()
						}else if(data.getAt("rows")[i].getAt("t2").toBigDecimal()=="100"){
						ship.prices.gp40 = data.getAt("rows")[i].getAt("t2").toBigDecimal()-99
						}
						else{
						ship.prices.gp40 = data.getAt("rows")[i].getAt("t2").toBigDecimal()-100
						}
						if(data.getAt("rows")[i].getAt("t3").toBigDecimal()=="0"){
							ship.prices.hq40 = data.getAt("rows")[i].getAt("t3").toBigDecimal()
						}else if(data.getAt("rows")[i].getAt("t3").toBigDecimal()=="100"){
						ship.prices.hq40 = data.getAt("rows")[i].getAt("t3").toBigDecimal()-99
						}
						else{
						ship.prices.hq40 = data.getAt("rows")[i].getAt("t3").toBigDecimal()-100
						}
						ship.prices.createBy = "cailie"
						ship.prices.updateBy = "cailie"
					}catch(Exception e){
						//println data.getAt("rows")[i].getAt("StartTime");
						//println data.getAt("rows")[i].getAt("EndTime")
						continue;
					}
					try{
						String url2 = "http://218.18.53.97:8100/sbToTracking/ToTrancking.ashx?tenantid=9856C38FFB5F4D8A&atype=GetFuInfo&hx="+ship.routeName+"&cd="+ship.shipCompany+"&qy="+ship.startPort+"&md="+ship.middlePort+"&fu="+data.getAt("rows")[i].getAt("FuJiaFei")
						def fujiafei = JSON.parse(client.postForObject(url2, null, String.class))
	
						def extras = ""
						if(fujiafei){
							for(int j=0;j<fujiafei.getAt("fujiafei")?.size();j++){
								StringBuilder extra = new StringBuilder();
								extra = extra.append(fujiafei.getAt("fujiafei")[j].getAt("name"))
								if(fujiafei.getAt("fujiafei")[j].getAt("fee")==""){
									extra.append("-box-").append(fujiafei.getAt("fujiafei")[j].getAt("20gp")+"-")
											.append(fujiafei.getAt("fujiafei")[j].getAt("40gp")+"-")
											.append(fujiafei.getAt("fujiafei")[j].getAt("40hq")+"-"+"0"+"-")
											.append(fujiafei.getAt("fujiafei")[j].getAt("bibie")+";")
								}else{
									extra.append("-piece-0-0-0-").append(fujiafei.getAt("fujiafei")[j].getAt("fee")+"-")
											.append(fujiafei.getAt("fujiafei")[j].getAt("bibie")+";")
	
								}
								extras+=extra
							}
						}
						if(extras!=""){
							ship.prices.extra = extras
						}else{
							ship.prices.extra = "详情请咨询客服！"
						}
	
						if( !ship.save() ) {   ship.errors.each {        println it   }}
						ship.save(flush:true);
					}catch(Exception e){
						println e
						continue;
					}
				}

		 }
		}
	}
}
