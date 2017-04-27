package com.cdd.back.controller

import com.cdd.base.domain.BackUser;
import com.cdd.base.domain.InquiryOfferPrice
import com.cdd.base.domain.ShowInquiry
import grails.converters.JSON
import java.text.SimpleDateFormat
import com.cdd.base.domain.JobTitle
import com.cdd.base.domain.BackDepartment

class HistoryPriceController extends BaseController{

    def model = "/historyPrice"
	
	def list() {
		render view:"${model}/list"
	}
	
	def listPrice(){
		StringBuffer sb = new StringBuffer()
		def map = [:]
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		Date d = new Date();
		Calendar calendar = new GregorianCalendar();
		def totalCount
		
		sb.append("SELECT count(*) FROM inquiry_offer_price AS a LEFT JOIN back_user AS b "+
			" ON a.create_by = b.username LEFT JOIN end_port AS c ON a.end_port=c.port_english_name "+ 
			" LEFT JOIN new_route AS d ON c.route_id  = d.id WHERE 1+1 and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" +sdf.format(d)+"' ")
		
			if(params.timeSlot){
				switch(params.timeSlot){
//					case "今天" : sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') = '" + sdf.format(d) +"' ")
//						 break;
					case "昨天" :calendar.setTime(d)
				         calendar.add(calendar.DATE,-1)
						 Date yt = calendar.getTime()
						 sb.append("and DATE_FORMAT(a.date_created, '%Y-%m-%d') = '" + sdf.format(yt) +"' ")
						 break;
					case "本周" : calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
						 Date date3 = calendar.getTime()
					     def wd = sdf.format(date3)
				         def wd1 = sdf.format(new Date())
						 sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') >= '" + wd +"' and  DATE_FORMAT(a.date_created, '%Y-%m-%d') <= '" + wd1+"' ")
						 break;
					case "本月" :  calendar.add(Calendar.MONTH, 0);
						 calendar.set(Calendar.DAY_OF_MONTH,1)
						 Date monthDate = calendar.getTime()
						 def month = sdf.format(monthDate)
						 sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') >= '" + month +"' and  DATE_FORMAT(a.date_created, '%Y-%m-%d') <= '" + sdf.format(new Date()) +"' ")
						 break;
				    default: break;
							
			}
		}
	
		
		if(params.searchKey){
			
			sb.append(" and  a.number like '" + params.searchKey + "' or a.company_name like '" +params.searchKey +"' " )
		}
		
		if(params.startDate != "" && params.endDate != ""){
			sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') > '" + params.startDate + "' and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" +params.endDate + "'")
		
		}else if(params.startDate != "" &&  params.endDate == ""){
			sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" + params.startDate  + "'")
		
		}else if(params.startDate == "" &&  params.endDate != ""){
			sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" + params.endDate + "'")
		}else{
			
		}
		
		
		if(params.state){
			sb.append(" and a.inquiry_status = '" + params.state +"'")
		}
		
		def pId = JobTitle.findByName("交易专员").pId
		def user = springSecurityService.currentUser
		
//		if(user.jobTitle.id == JobTitle.findByName("交易专员").id){
//			if(BackDepartment.findByManager(user.firstname)!=null){
//				sb.append(" and b.department_id="+user.department.id )
//			}else{
//				sb.append(" and a.create_by="+user.username )
//			}
//		}else if(isBusiness(user.jobTitle.id,pId)){
//
//		 }else {
//				sb = null
//		}
		//sb.append(" limit "+params.pageOffSet+","+params.resultCount)
		def count = sessionFactory.currentSession.createSQLQuery(sb.toString()).uniqueResult()
		map.count = count
		if(count!=0){
			StringBuffer sb1 = new StringBuffer()
			sb1.append("SELECT a.number,a.start_port,a.end_port,d.route_name,a.company_name,a.inquiry_status,b.firstname,a.business_man,a.date_created FROM "+
				
								" inquiry_offer_price AS a LEFT JOIN back_user AS b ON a.create_by = b.username LEFT JOIN end_port AS c ON a.end_port=c.port_english_name LEFT JOIN new_route AS d ON c.route_id  = d.id WHERE 1+1 "+
								" and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" +sdf.format(d)+"' ")
						
//						def pId = JobTitle.findByName("交易专员").pId
//						def user = springSecurityService.currentUser
						
//						if(user.jobTitle.id == JobTitle.findByName("交易专员").id){
//							if(BackDepartment.findByManager(user.firstname)!=null){
//								sb1.append(" and b.department_id="+user.department.id )
//							}else{
//								sb1.append(" and a.create_by="+user.username )
//							}
//						}else if(isBusiness(user.jobTitle.id,pId)){
//				
//						 }else {
//								sb1 = null
//						}
						 
							if(params.timeSlot){
								switch(params.timeSlot){
//						case "今天" : sb.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') = '" + sdf.format(d) +"' ")
//						 break;
									case "昨天" :calendar.setTime(d)
										calendar.add(calendar.DATE,-1)
										Date yt = calendar.getTime()
										sb1.append("and DATE_FORMAT(a.date_created, '%Y-%m-%d') = '" + sdf.format(yt) +"' ")
										break;
									case "本周" : calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
										Date date3 = calendar.getTime()
										def wd = sdf.format(date3)
										def wd1 = sdf.format(new Date())
										sb1.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') >= '" + wd +"' and  DATE_FORMAT(a.date_created, '%Y-%m-%d') <= '" + wd1+"' ")
										break;
									case "本月" :  calendar.add(Calendar.MONTH, 0);
										calendar.set(Calendar.DAY_OF_MONTH,1)
										Date monthDate = calendar.getTime()
										def month = sdf.format(monthDate)
										sb1.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') >= '" + month +"' and  DATE_FORMAT(a.date_created, '%Y-%m-%d') <= '" + sdf.format(new Date()) +"' ")
										break;
										default: break;
								}
							}
						 
						 
						 if(params.searchKey){
							 
							 sb1.append(" and  a.number like '" + params.searchKey + "' or a.company_name like '" +params.searchKey +"'")
						 }
						 
						 
						 if(params.startDate != "" && params.endDate != ""){
							 sb1.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') > '" + params.startDate + "' and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" +params.endDate + "'")
						 
						 }else if(params.startDate != "" &&  params.endDate == ""){
							 sb1.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" + params.startDate  + "'")
						 
						 }else if(params.startDate == "" &&  params.endDate != ""){
							 sb1.append(" and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" + params.endDate + "'")
						 }else{
							 
						 }

						 
						if(params.state){
								sb1.append(" and a.inquiry_status = '" + params.state +"'")
						}
						 
						sb1.append(" limit "+params.pageOffSet+","+params.resultCount)
						if(sb1 != null){
							def query = sessionFactory.currentSession.createSQLQuery(sb1.toString())
							def result =  query.list()
							map.rows = result
						}
		}
		
		def data = countByStatus(pId,user)
		map.stateCounts = data
		render map as JSON
	}
	
	def isBusiness(userJobId,pId){
		if(userJobId == pId){
			return true
		}else{
			def id = JobTitle.get(pId).pId
			if(id != null){
				isBusiness(userJobId,id)
			}else{
				return false
			}
		}
	}
	
	
	
	def countByStatus(String pId,BackUser user){
		def counts = []
		def status = ["新询盘":0,"已应价":0,"终止":0,"订舱":0,"补充询盘":0]
		StringBuffer sb = new StringBuffer()
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		Date d = new Date();
		sb.append("select inquiry_status,count(inquiry_status)  from inquiry_offer_price as a left join back_user as b ON a.create_by = b.username  where 1+1 and DATE_FORMAT(a.date_created, '%Y-%m-%d') < '" +sdf.format(d)+"' ")
		
		
//		if(user.jobTitle.id == JobTitle.findByName("交易专员").id){
//			if(BackDepartment.findByManager(user.firstname)!=null){
//				sb.append(" and b.department_id="+user.department.id )
//			}else{
//				sb.append(" and a.create_by="+user.username )
//			}
//		}else if(isBusiness(user.jobTitle.id,pId)){
//
//		}else {
//				sb = null
//		}
		if(sb != null){
			sb.append(" group by inquiry_status")
			def query = sessionFactory.currentSession.createSQLQuery(sb.toString())
			status.collect{name,count ->
			   def sName = name
			   query.list()?.collect{st ->
				   //def data = [:]
				   //data.stateName = sName
				   if(sName == st[0]){
					   status[name] = st[1]
					   //counts << data
				   }
			   }
		   }
		}
		return status
	}
	
	
	def detailPrice(){
		InquiryOfferPrice inquiry = InquiryOfferPrice.findByNumber(params.number)
		ShowInquiry price = ShowInquiry.findByNumber(params.number)
		render(["inquiry":inquiry,"price":price] as JSON)
	}
}
