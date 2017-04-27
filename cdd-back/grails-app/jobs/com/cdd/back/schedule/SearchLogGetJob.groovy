package com.cdd.back.schedule

import com.cdd.base.domain.WeekRanking
import com.cdd.base.service.common.CRUDService

import java.text.SimpleDateFormat

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory;

class SearchLogGetJob {
	static triggers = {
		//cron name: 'SearchLogGetTrigger', cronExpression: "0 42 15 * * ?"
		cron name: 'SearchLogGetTrigger', cronExpression: "0 0 9 ? * MON"
	}
	SessionFactory sessionFactory
	CRUDService CRUDService

	def execute() {
		println "kaishi"
		InetAddress addr = InetAddress.getLocalHost();
		def ip=addr.getHostAddress();//获得本机IP
		if(ip =="10.116.49.232"){//指定一台服务器运行112.74.81.205
			def start = ""
			def end =""
			def ship =""
			Date now=new Date()
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			def dateBegain = sdf1.format(new Date(now.getTime() - 6 * 24 * 60 * 60 * 1000))
			def dateEnd = sdf1.format(new Date(now.getTime()+ 1 * 24 * 60 * 60 * 1000))
			println dateBegain
			println dateEnd
			SQLQuery sqlStartPort = sessionFactory.getCurrentSession().createSQLQuery("SELECT DISTINCT  start_port, count(*) AS count FROM search_log where start_port!='' and date_created between '"+dateBegain+"' and '"+dateEnd+"' GROUP BY start_port HAVING count>=1 ORDER BY count desc LIMIT 10")
			SQLQuery sqlEndPort = sessionFactory.getCurrentSession().createSQLQuery("SELECT DISTINCT  end_port, count(*) AS count FROM search_log where end_port!='' and date_created between '"+dateBegain+"' and '"+dateEnd+"' GROUP BY end_port HAVING count>=1 ORDER BY count desc LIMIT 10")
			SQLQuery sqlShipCompany = sessionFactory.getCurrentSession().createSQLQuery("SELECT DISTINCT  ship_company, count(*) AS count FROM search_log where ship_company!='' and date_created between '"+dateBegain+"' and '"+dateEnd+"' GROUP BY ship_company HAVING count>=1 ORDER BY count desc LIMIT 10")
			
			println sqlStartPort.list()
			def list1 = sqlStartPort.list()?.collect{
				start +=it[0]+","
			}
			
			def list2 = sqlEndPort.list()?.collect{
				end +=it[0]+","
			}
			
			def list3 = sqlShipCompany.list()?.collect{
				ship +=it[0]+","
			}
			WeekRanking weekrank = new WeekRanking()
			weekrank.startPort = start
			weekrank.endPort = end
			weekrank.shipCompany = ship
			weekrank.createBy = "cailie"
			weekrank.updateBy = "caile"
			weekrank.startTime = sdf1.parse(dateBegain)
			weekrank.endTime = sdf1.parse(dateEnd)
			
			if( !weekrank.save() ) {   weekrank.errors.each {        println it   }}
			weekrank.save(flush:true)
		}
	} 
}
