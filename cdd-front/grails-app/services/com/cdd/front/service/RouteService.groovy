package com.cdd.front.service

import java.text.SimpleDateFormat

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory

import com.cdd.base.domain.FrontUser
import com.cdd.base.enums.FrontUserType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.RouteType
import com.cdd.base.enums.Status

class RouteService {

	SessionFactory sessionFactory

	def group() {
		StringWriter sql = new StringWriter()
		String status =Status.VerifyPassed.name();
		Date today = new Date();
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		final SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')

		String endDateStr = sdf.format(cal.getTime())

		sql << """
			select start_port, end_port, group_concat(distinct ship_company) as shipCompany, group_concat(distinct shipping_day) as shippingDay, min(shipping_days) as minShippingDays, max(shipping_days) as maxShippingDays, 
			min(start_date) as minStartDate, max(end_date) as maxEndDate, min(gp20) as minGp20, max(gp20) as maxGp20, min(gp40) as minGp40, max(gp40) as maxGp40, min(hq40) as minHq40, max(hq40) as maxHq40
			from cargo_ship_information a, ship_prices b where a.id=b.info_id and status='${status}' and show_on_index=1 and end_date >= str_to_date('${endDateStr}','%Y-%m-%d') group by start_port, end_port limit 0, 15
		"""

		log.info sql

		def query = sessionFactory.currentSession.createSQLQuery(sql.toString())

		return query.list()
	}

	def findRecommendedPort(FrontUser user, String category) {
		Random r = new Random()
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd 00:00:00')
		def today = sdf.format(new Date())
		if(user.type == FrontUserType.Cargo) {
			SQLQuery countQuery = sessionFactory.currentSession.createSQLQuery("""
				select count(*) from cargo_ship_information ship left join front_user on ship.owner_id=front_user.id, new_route route, end_port endPort
				where ship.end_port = endPort.port_english_name
				and route.id = endPort.route_id
				and route.route_english_name = ?
				and ship.status='${Status.VerifyPassed.name()}'
				and ship.deleted=0
				and ship.end_date>=?
			""")
//			 countQuery = sessionFactory.currentSession.createSQLQuery("""
//				select count(*) from cargo_ship_information ship left join front_user on ship.owner_id=front_user.id, route 
//				where ship.end_port=route.port 
//				and route.type='${RouteType.End.name()}'
//				and route.category=?
//				and ship.status='${Status.VerifyPassed.name()}'
//				and ship.deleted=0
//				and ship.end_date>=?
//			""")
			//and route.type='${RouteType.End.name()}'  and route.category=?
			countQuery.setString(0, category)
			countQuery.setString(1, today)
			int total = countQuery.uniqueResult()
			if(total > 0) {
				SQLQuery query = sessionFactory.currentSession.createSQLQuery("""
					select ship.id, ship.start_port, ship.end_port, ship.middle_port,
					ship.shipping_days, ship.shipping_day, ship.start_date, ship.trans_type, front_user.company_name, front_user.firstname, front_user.mobile, front_user.verified, route.route_name
					from cargo_ship_information ship left join front_user on ship.owner_id=front_user.id, new_route route, end_port endPort
					where ship.end_port=endPort.port_english_name
					and route.id = endPort.route_id
					and route.route_english_name = ?
					and ship.status='${Status.VerifyPassed.name()}'
					and ship.deleted=0
					and ship.end_date>=?
					limit ?, 1
				""")
				//
				query.setString(0, category)
				query.setString(1, today)
				int pos = r.nextInt(total) 
				query.setInteger(2, pos > 0 ? pos - 1 : pos)
				
				def list = new ArrayList();
				
				query.list().collect{
					def map = [:]
					map.id = it[0]
					map.startPort = it[1]
					map.endPort = it[2]
					map.middlePort = it[3]
					map.shippingDays = it[4]
					map.shippingDay = it[5]
					map.startDate = it[6]
					map.transType = it[7]
					map.category = it[12]
					if (it[11]) {
						map.companyName = it[8]
						map.firstname = it[9]
						map.mobile = it[10]
						map.verified = it[11]
					}
					list.add(map);
				}
				return list
			}
		} else {
			SQLQuery countQuery = sessionFactory.currentSession.createSQLQuery("""
				select count(*) from orders left join front_user on orders.owner_id=front_user.id ,new_route route, end_port endPort
				where orders.end_port=endPort.port_english_name
				and route.id = endPort.route_id
				and route.route_english_name=?
				and orders.status='${Status.VerifyPassed.name()}'
				and orders.deleted=0
				and (orders.order_status='${OrderStatus.UnTrade.name()}'
				or orders.order_status='${OrderStatus.InTrade.name()}')
			""")//and route.type='${RouteType.End.name()}'
			countQuery.setString(0, category)
			int total = countQuery.uniqueResult()
			println total
			if(total > 0) {
				SQLQuery query = sessionFactory.currentSession.createSQLQuery("""
					select orders.id, orders.start_port, orders.end_port,
					orders.bite_end_date, orders.trans_type, orders.order_type, orders.deal_price,
					orders.start_date, orders.end_date, front_user.company_name, front_user.firstname, front_user.mobile, front_user.verified,route.route_name
					from orders left join front_user on orders.owner_id=front_user.id, new_route route, end_port endPort
					where orders.end_port=endPort.port_english_name
					and route.id = endPort.route_id
					and route.route_english_name=?
					and orders.status='${Status.VerifyPassed.name()}'
					and orders.deleted=0
					and (orders.order_status='${OrderStatus.UnTrade.name()}'
					or orders.order_status='${OrderStatus.InTrade.name()}')
					limit ?, 1
				""")//and route.type='${RouteType.End.name()}' limit ?, 1
				query.setString(0, category)
				int pos = r.nextInt(total)
				query.setInteger(1, pos > 0 ? pos - 1 : pos)
				def list = new ArrayList();
			    query.list().collect{ result ->
					def map = [:]
					map.id = result[0]
					map.startPort = result[1]
					map.endPort = result[2]
					map.biteEndDate = result[3]
					map.transType = result[4]
					map.orderType = result[5]
					map.dealPrice = result[6]
					map.startDate = result[7]
					map.endDate = result[8]
					map.category = result[13]
					if (result[11]) {
						map.companyName = result[9]
						map.firstname = result[10]
						map.mobile = result[11]
						map.verified = result[12]
					}
					list.add(map)
				}
				return list
			}
		}
		return null
	}
}
