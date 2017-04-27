package com.cdd.back.schedule

import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.enums.RouteCategory
import com.cdd.base.service.common.CRUDService;

import groovy.util.logging.Slf4j;

import java.text.SimpleDateFormat
import java.util.HashMap.Entry

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory;

import com.cdd.base.constant.SpringSecurityConstant

import grails.plugin.mail.MailService;
import grails.plugin.springsecurity.annotation.Secured

@Slf4j
class SendShipMonitorJob {
	SessionFactory sessionFactory
	MailService mailService
	def grailsApplication
	CargoShipInformation c;
	RouteCategory category;
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd 00:00:00')
	def today = sdf.format(new Date())
	
	static triggers = {
		cron name: 'SendShipMonitorTrigger', cronExpression: "0 0 9,15 * * ?"
		//cron name: 'SendShipMonitorTrigger', cronExpression: "0 */3 * * * ?"
	}
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def execute(){
		SQLQuery query = sessionFactory.currentSession.createSQLQuery("""
					select ship.id, ship.start_port, ship.end_port, ship.middle_port,
					ship.shipping_days, ship.shipping_day, ship.start_date, ship.end_date,ship.trans_type, front_user.company_name, front_user.firstname, front_user.mobile, front_user.verified,route.route_name
					from cargo_ship_information ship left join front_user on ship.owner_id=front_user.id, new_route route, end_port endPort
					where ship.end_port=endPort.port_english_name
					and route.id = endPort.route_id
					and ship.send_state = 0
					and ship.status='VerifyPassed'
					and ship.deleted=0
					and ship.end_date>=?
				""")
		
		query.setString(0, today)
		List shipList = getShips(query)
		if(shipList.size() > 0){
			Map m = getRouteMap(shipList)
			
			SQLQuery query1 = sessionFactory.currentSession.createSQLQuery("""
					select route.id , route.category, user.id userId, user.email from recommended_route route,test_user user where route.user_id = user.id
				""")
			
			Map m2 = queryUserRoutes(query1)
			
			sendMails(m2, m)
		}
		
		
//		for(Map.Entry e : m.entrySet()){
//			query1.list()?.collect{
//				RouteCategory category = it[1]
//				if(category.text.equals(e.getKey())){
//					List sList = e.getValue();
//					def email = it[3]
//					StringBuffer  str = new StringBuffer();
//					str.append("<html><body><table width='200' border='1' cellpadding='0' cellspacing='0' bordercolor='#FF9966' frame=void>"+ 
//										"<tr>" +
//											"<td>航线</td>"+
//											"<td>起始港</td>"+ 
//											"<td>航程</td>"+ 
//											"<td>中转港 </td>"+ 
//											"<td>船期</td>"+
//											"<td>运输类型</td>"+
//											"<td>目的港</td>"+
//											"<td>有效期</td>"+
//										"</tr>");
//					for(HashMap m4:sList){
//						str.append("<tr>"+
//											"<td>" + m4.routeName + "</td>" +
//											"<td>" + m4.startPort + "</td>" +
//											"<td>" + m4.shippingDays + "</td>" +
//											"<td>" + m4.middlePort + "</td>" +
//											"<td>" + m4.shippingDay + "</td>" +
//											"<td>" + m4.transType + "</td>" +
//											"<td>" + m4.endPort + "</td>" +
//											"<td>" + m4.startPort + "——" + m4.endPort + "</td>" +
//										"</tr>")
//									
//					}
//					str.append("</table></body></html>")
//					mailService.sendMail {
//						async true
//						to  "${email}"
//						from grailsApplication.config.grails.mail.username
//						subject "新运价通知"
//						html str
//					}
//				}
//			}
//		}
	}

	private sendMails(Map m2, Map m) {
		for(Map.Entry e1 : m2.entrySet()){
			boolean result = false ;
			List routes = e1.getValue();
			StringBuffer  str = new StringBuffer();
			str.append("<html><body><table width='800' border='1' cellpadding='0' cellspacing='0' bordercolor='#FF9966' frame=void>"+
					"<tr>" +
					"<td>航线</td>"+
					"<td>起始港</td>"+
					"<td>航程</td>"+
					"<td>中转港 </td>"+
					"<td>船期</td>"+
					"<td>运输类型</td>"+
					"<td>目的港</td>"+
					"<td>有效期</td>"+
					"</tr>");
			routes.collect{
				category = it[1]
				for(Map.Entry e : m.entrySet()){
					if(category.text.equals(e.getKey())){
						result = true
						for(HashMap m4:e.getValue()){
							str.append("<tr>"+
									"<td>" + m4.routeName + "</td>" +
									"<td>" + (m4.startPort ? m4.startPort : "") + "</td>" +
									"<td>" + (m4.shippingDays ? m4.shippingDays : "") + "</td>" +
									"<td>" + (m4.middlePort ? m4.middlePort : "") + "</td>" +
									"<td>" + (m4.shippingDay ? m4.shippingDay : "")  + "</td>" +
									"<td>" + (m4.transType ? m4.transType : "") + "</td>" +
									"<td>" + (m4.endPort ? m4.endPort : "") + "</td>" +
									"<td>" + (m4.startDate ? m4.startDate : "")  + "——" + (m4.endDate ? m4.endDate : "~~") + "</td>" +
									"</tr>");
						}
						break ;
					}
				}
			}
			str.append("<table>");
			if(result){
				mailService.sendMail {
					async true
					to  e1.getKey()
					from grailsApplication.config.grails.mail.username
					subject "新运价通知"
					html str
				}
			}
		}
	}

	private Map queryUserRoutes(SQLQuery query1) {
		Map m2 = new HashMap();
		query1.list()?.collect{
			if(it[3] != null){
				if(!m2.containsKey(it[3])){
					List l = new ArrayList();
					l.add(it)
					m2.put(it[3],l)
				}else{
					List l2 = m2.get(it[3]);
					l2.add(it);
				}
			}
		}
		return m2
	}

	private Map getRouteMap(List shipList) {
		Map m = new HashMap();
		shipList.collect{
			def routeName = it.routeName;
			if(!m.containsKey(routeName)){
				List ll = new ArrayList();
				ll.add(it)
				m.put(routeName,ll)

			}else {
				List l1 = m.get(routeName);
				if(l1.size() > 3){
					l1.add(it);
				}
			}
		}
		return m
	}

	private List getShips(SQLQuery query) {
		List l = new ArrayList();
		
		query.list()?.collect{
			def map = [:]
			map.id = it[0]
			map.startPort = it[1]
			map.endPort = it[2]
			map.middlePort = it[3]
			map.shippingDays = it[4]
			map.shippingDay = it[5]
			map.startDate = it[6]
			map.startDate = it[7]
			map.transType = it[8]
			//map.category = category.text
			if (it[11]) {
				map.companyName = it[9]
				map.firstname = it[10]
				map.mobile = it[11]
				map.verified = it[12]
			}
			map.routeName = it[13]
			l.add(map);
			
//			c = CargoShipInformation.get(it[0]);
//			c.sendState = 1;
			SQLQuery sql = sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set send_state= 1 where id=?")
			sql.setBigInteger(0, it[0])
			sql.executeUpdate();
			
		}
		return l;
	}
}
