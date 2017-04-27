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
import com.cdd.base.domain.StartPort
import com.cdd.base.domain.EndPort
import grails.converters.JSON
import java.text.DecimalFormat
//长帆数据接口获取数据保存
@Slf4j
class FanyaPriceJob {
	RestTemplate client = new RestTemplate()
	SessionFactory sessionFactory
	def grailsApplication
	static triggers = {
		cron name: 'FanyaPriceTrigger', cronExpression: "0 0 1 * * ?"
		//cron name: 'FanyaPriceTrigger', cronExpression: "0 52 10 * * ?"
	}
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def execute(){
		InetAddress addr = InetAddress.getLocalHost();
		def ip=addr.getHostAddress();//获得本机IP
		if(ip =="10.116.49.232"){//指定一台服务器运行112.74.81.205
					SQLQuery query1 = sessionFactory.currentSession.createSQLQuery("""
						DELETE FROM ship_prices WHERE info_id IN (SELECT id FROM cargo_ship_information WHERE cargo_ship_information.company_name = "泛亚航运" and create_by = "cailie")
						""")
					query1.executeUpdate();

					SQLQuery query2 = sessionFactory.currentSession.createSQLQuery("""
						DELETE FROM cargo_ship_information where id not in (select info_id from booking) and cargo_ship_information.company_name = "泛亚航运"	and create_by = "cailie"		
						""")
					

query2.executeUpdate();
		 Map map = [:]
		 RestTemplate client = new RestTemplate()
		 String countUrl ="http://www.epanasia.com/fanyagz/services/ForeignTradeProduct/findCount"
		 def count = Integer.parseInt(client.getForObject(countUrl, String.class, map))
		 int page = count/15-1
		 println page
		 
		for(int j = 1;j<=page;j++) {
			println "---"
			println j
			println "---"
			def b = (j-1)*15+1
			def a = j*15
			String url = "http://www.epanasia.com/fanyagz/services/ForeignTradeProduct/find?pageIndex="+j+"&startRowIndex="+b+"&endRowIndex="+a+"&fromLoc=&toLoc=&etd=&supportedPayFlag=false&userEid=0&_=1482226756520"
			//String url = "http://www.epanasia.com/fanyagz/services/ForeignTradeProduct/find?pageIndex=2&startRowIndex=16&endRowIndex=30&fromLoc=&toLoc=&etd=&supportedPayFlag=false&userEid=0&_=1482310786633"
			def json = client.getForObject(url, String.class, map)
			String result = new String(json.getBytes("ISO-8859-1"), "utf-8");
			def data = JSON.parse(result)
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			for(int i = 0;i<data.size();i++) {
			CargoShipInformation ship = new CargoShipInformation()
			def sPort = StartPort.findByPortName(data[i].getAt("firstPOLName"))?.portEnglishName
			def ePort = EndPort.findByPortName(data[i].getAt("lastPODName"))?.portEnglishName
			if(!sPort||!ePort) {
				continue;
			}
			Date date = new Date(new Long(data[i].getAt("priceStartDate")));
			def startDate = simpleDateFormat.parse(simpleDateFormat.format(date));
			Date date2 = new Date(new Long(data[i].getAt("priceEndDate")));
			def endDate = simpleDateFormat.parse(simpleDateFormat.format(date2));
			Date date3 = new Date(new Long(data[i].getAt("etd")));
			def etd = simpleDateFormat.format(date3);
			Date date4 = new Date(new Long(data[i].getAt("eta")));
			def eta = simpleDateFormat.format(date4);
			
			ship.startPort = sPort
			ship.endPort = ePort
			ship.startDate = startDate
			ship.endDate =endDate
			ship.shippingDays = data[i].getAt("ttlTransTime")
			
			ship.shippingDay =etd +"开船；"+eta+"到港"
			println ship.shippingDays
			ship.status = "VerifyPassed"
			ship.transType = "Whole"
			ship.companyName = "泛亚航运"
			ship.releaseNum = "P6666"
			ship.shipCompany = "COSCO"
			ship.createBy = "cailie"
			ship.updateBy = "cailie"
			ship.fromBy ="后台"
			
			ShippingPrices newPrices = new ShippingPrices()
			ship.prices = newPrices
			
			ship.prices.gp20 = data[i].getAt("items")[0].getAt("actualPrice").toBigDecimal()
			ship.prices.gp40 = data[i].getAt("items")[1].getAt("actualPrice").toBigDecimal()
			ship.prices.hq40 = data[i].getAt("items")[2].getAt("actualPrice").toBigDecimal()
			ship.prices.createBy = "cailie"
			ship.prices.updateBy = "cailie"
			ship.prices.extra = "详情请咨询客服！"
			if( !ship.save() ) {   ship.errors.each {        println it   }}
			ship.save(flush:true);
			}
			
			}
		}
	}
}
