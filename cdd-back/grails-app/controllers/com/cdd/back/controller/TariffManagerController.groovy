package com.cdd.back.controller

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService;

import java.text.SimpleDateFormat

import org.apache.poi.hssf.usermodel.HSSFRow  
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.web.multipart.commons.CommonsMultipartFile
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontUser;
import com.cdd.base.domain.ShippingPrices


import com.cdd.base.enums.FrontUserType;
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType


import grails.converters.JSON
import grails.plugin.mail.MailService;
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import java.math.BigDecimal;
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.Date;

import javassist.bytecode.stackmap.BasicBlock.Catch;
import net.sf.ehcache.search.expression.Between;

import org.apache.jasper.compiler.Node.ParamsAction;
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.hibernate.Query
import org.hibernate.SQLQuery
import org.hibernate.SessionFactory;
import org.hibernate.sql.JoinType

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.CargoShipScore
import com.cdd.base.domain.City
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.SearchLog
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.domain.User
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.OrderType
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.common.CRUDService 
import com.cdd.base.domain.BackUser

import grails.plugin.mail.MailService;


@SuppressWarnings("unused")
class TariffManagerController extends BaseController {

	JsonConverterFactory jsonConverterFactory
	SpringSecurityService springSecurityService
	CRUDService CRUDService
	MailService mailService
	def grailsApplication
	SessionFactory sessionFactory

	def model = 'tariffManager'

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	/**
	 * According to the records management
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def list(){
		def firstTime = System.currentTimeMillis()
		if(params.page){
			int page = Integer.parseInt(params.page) 
			int limit = 10
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 10
			params.offset = 0
		}

		params.dataType = 'json'

		String start
		if(params.start){
			start=params.start.toUpperCase()
		}

		String end
		if(params.end){
			end=params.end.toUpperCase()
		}

		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 审核通过
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();

		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();


		def result = CRUDService.list(CargoShipInformation, params) {
			if(params.status) {
				eq "status", Status.valueOf(params.status)
			}
			
			if(params.infoId){
				eq "id",params.infoId as Long
			}
			
			if(start){
				and {
					like "startPort", "%"+start+"%"
				}
			}

			if(end){
				and {
					like "endPort","%"+end+"%"
				}
			}

			if(params.shipCompanys){
				and{ like "shipCompany","%${params.shipCompanys}%" }
			}

			if(params.company){
				and{ like "companyName","%${params.company}%" }
			}

			if(params.createman){
				and{ like "createBy", "%${params.createman}%" }
			}

			if(params.createtimes){
				and{
					SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
					def date1=sdf5.parse(params.createtimes)
					def date2=sdf5.parse(params.createtimes)+1
					between ("dateCreated", date1,date2)
				}
			}
			eq 'deleted', false
		}

		def map = [rows: [], total: result.totalCount]
		result.list.each { CargoShipInformation info ->
			def data = [:]
			data.id = info.id

			def transType = " ";
			if(info.transType){
				switch(info.transType){
					case TransportationType.Whole.name():
						transType = TransportationType.Whole.text;
						break;
					case TransportationType.Together.name():
						transType = TransportationType.Together.text;
						break;
				}
			}
			data.transType = transType
			data.startPort = info.startPort
			data.endPort = info.endPort
			data.shippingDays = info.shippingDays
			data.shippingDay = info.shippingDay
			data.startDate = sdf.format(info.startDate)
			data.endDate = sdf.format(info.endDate)
			data.releaseNum = info.releaseNum
			def status =" "
			if(info.status){
				switch(info.status){
					case Status.UnVerify.name():
						status = Status.UnVerify.text;
						break;
					case Status.InVerify.name():
						status = Status.InVerify.text;
						break;
					case Status.VerifyPassed.name():
						status = Status.VerifyPassed.text;
						break;
					case Status.Expired.name():
						status = Status.Expired.text;
						break;
					case Status.Revoked.name():
						status = Status.Revoked.text;
						break;
				}
			}
			data.status = status
			data.shipCompany= info.shipCompany
			data.middlePort = info.middlePort
			data.routeName = info.routeName
			data.contactName = info.contactName
			data.phone = info.phone
			data.remark = info.remark
			data.companyName = info.companyName
			data.shipCompany = info.shipCompany
			data.weightLimit = info.weightLimit
			data.createBy=info.createBy
			data.dateCreated=sdf.format(info.dateCreated)
			if (info.prices) {
				if (info.prices.gp20) {
					
					data.gp20 =(int)info.prices.gp20
				}
				if (info.prices.gp20Vip) {
					data.gp20Vip = (int)info.prices.gp20Vip
				}
				if (info.prices.gp40) {
					data.gp40 = (int)info.prices.gp40
				}
				if (info.prices.gp40Vip) {
					data.gp40Vip = (int)info.prices.gp40Vip
				}
				if (info.prices.hq40) {
					data.hq40 = (int)info.prices.hq40
				}
				if (info.prices.hq40Vip) {
					data.hq40Vip =(int)info.prices.hq40Vip
				}
				if (info.prices.extra) {
					data.extra = info.prices.extra
				}
				if(info.prices.lowestCost){

					data.lowestCost = info.prices.lowestCost
				}
			}
			map.rows << data
			//map.putAt('releaseNumCount', releaseNumCount)

			map.put('releaseNumCount', releaseNumCount)
			map.put('revokedNumCount', revokedNumCount)
			map.put('expiredNumCount', expiredNumCount)

		}
		//render view:"/tariffManager/list", model:map
		int resultCount  = map.total
		saveInfoConsuming(params,resultCount,firstTime)
		render ([view: "/${model}/list", model: map])
	}

	/***
	 *  According to the batch management
	 */
	def bactchList(){
		Date today = new Date();
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 发布数量
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(distinct(release_num)) as count from cargo_ship_information where  deleted=false ")

		def totalCount = sqlTotal.uniqueResult(); // 查询总数

		if(params.page){
			int page = Integer.parseInt(params.page)
			int limit = 5
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 5
			params.offset = 0
		}

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select count(*) from (select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false  group by release_num order by date_created desc limit "+ params.offset +","+ params.limit+") as total")

		int total = sql.uniqueResult()

		if(total > params.offset || total==params.offset|| total < params.offset){
			sql = sessionFactory.getCurrentSession().createSQLQuery("select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false group by release_num order by  date_created desc limit "+params.offset  +","+params.limit)
		}else{
			sql = null
		}

		if(total > 0){

			int h = sql.list().size()

			StringBuffer s = new StringBuffer("")

			int count = 0

			List l = new ArrayList();

			List batList = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				batList=sql.list()?.collect{
					def data = [:]
					data.releaseNum = it[0]
					data.dateCreated = it[1]
					data.totalCount = it[2]
					data.companyName = it[3]
					data.createBy = it[4]
					l.add(data)

					s.append("(select  cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
							+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
							+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
							+" cago.weight_limit,cago.company_name,sps.lowest_cost,cago.create_by,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
							+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.release_num = '"+it[0]+"' and  cago.deleted = false  ")

					
					if(params.statusd!=null && params.statusd!=""){
						s.append(" and cago.status='"+Status.valueOf(params.statusd)+"' ");
						
					}
					
					if(params.starts){
						
						s.append(" and cago.start_port like '%"+params.starts+"%' ")

					}
					if(params.ends!=null && params.ends!=""){
						s.append(" and  cago.end_port like '%"+params.ends+"%' ")
					}

					if(params.shipCompanysd!=null && params.shipCompanysd!=""){
						s.append(" and  cago.ship_company like  '%"+params.shipCompanysd+"%' ")
					}

					if(params.companys!=null && params.companys!=""){
						s.append(" and cago.company_name like  '%"+params.companys+"%' ")
					}
		
					if(params.releaseNums!=null && params.releaseNums!=""){
						s.append(" and cago.release_num like '%"+params.releaseNums+"%'")	
					}

					if(params.createmans!=null && params.createmans!=""){
						s.append(" and cago.create_by like  '%"+params.companys+"%' ")
					}
					
					if(params.createtimesd!=null && params.createtimesd!=""){
					
						s.append(" and cago.date_created between '"+ params.createtimesd+"' and '"+ (params.createtimesd)+1 +"'  ")
					 }

					s.append(" limit 0,1 ) ");
					
					if(count < total-1){
						s.append(" union all ");
					}
					count++;

					return data
				}

				sql = sessionFactory.getCurrentSession().createSQLQuery(s.toString());

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?(int)it[6]:''
					data.gp40 = it[7]?(int)it[7]:''
					data.hq40 = it[8]?(int)it[8]:''
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					//data.releaseNum = it[11]

					for(Map m : l){
						if(m.releaseNum == it[11]){
							data.releaseNum = m.releaseNum
							data.totalCount = m.totalCount
							data.dateCreated = m.dateCreated
							data.companyName = m.companyName
							data.createBy = m.createBy
							//data.dateCreated = format.parse(m.dateCreated)
						}
					}

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
							case Status.Closed.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.companyName = it[19]
					data.lowestCost = it[20]
					data.createBy = it[21]
					data.gp20Vip = it[22]?(int)it[22]:''
					data.gp40Vip = it[23]?(int)it[23]:''
					data.hq40Vip = it[24]?(int)it[24]:''
					data.dateCreated = it[25]
					data.contactName = it[26]
					data.phone = it[27]

					return data
				}
			}
			render ([view: "/tariffManager/bactchList", model: [batrows:batList,rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,totalCount:totalCount]])
		}
		//render ([view: "/shipInfo/list", model: [rows: list,rows2:list2,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,totalCount:totalCount]])
		//render view:"/tariffManager/bactchList"
	}

	/**
	 * 单条运价撤销
	 * @return
	 */
	@Secured('ROLE_CLIENT')
	def repeal(){

		CargoShipInformation info = CargoShipInformation.get(params.id as Long)
		def status= Status.Revoked
		def id = info.id

		def hql="update CargoShipInformation a set a.status=:status where a.id=:id"

		def hql1=[:]
		def sta="status"
		def st=status
		def sta1="id"

		def st1=new Long(id)
		hql1.put(sta,st)
		hql1.put(sta1,st1)
		if(!CargoShipInformation.executeUpdate(hql,hql1))
		{
			CargoShipInformation.errors.each{ println "a:>====="+it }
		}
		redirect uri: "/${model}/list"
	}

	/***
	 *  单条运价删除
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def delete(){
		def deleted = true
		def id=params.ids
		id.split(",")?.collect{
			def hql1=[:]
			def sta="deleted"
			def st= true
			//def sta1="releaseNum"
			//def st1=it
			def sta2="id"
			def st2=Long.parseLong(it)
			hql1.put(sta,st)
			//hql1.put(sta1, st1)
			hql1.put(sta2,st2)
			def hql="update CargoShipInformation a set a.deleted=:deleted where a.id=:id"
			CargoShipInformation.executeUpdate(hql,hql1)
		}
		render(["allRepeal":"Success"] as JSON)
	}


	/***
	 * 查看20条运价信息
	 * @return 
	 */

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def twentyShipInfo(){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 审核通过
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as count from cargo_ship_information where  deleted=false ")
		//def totalCount = sqlTotal.uniqueResult(); // 查询总数
		def total  = sqlTotal.uniqueResult();
		StringBuffer s = new StringBuffer("")

		if(params.page){
			int page = Integer.parseInt(params.page)
			int limit = 10
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 10
			params.offset = 0
		}

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) from (select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
				+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
				+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit "+ params.offset +","+ params.limit+") as total ")

		int totalCount = sql.uniqueResult()

		if(totalCount > params.offset || totalCount==params.offset|| totalCount < params.offset){

			sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
					+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
					+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
					+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone"
					+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit 0,20 " )

		}else{
			sql = null
		}

		if(totalCount > 0){

			List l = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?(int)it[6]:''
					data.gp40 = it[7]?(int)it[7]:''
					data.hq40 = it[8]?(int)it[8]:''
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					data.releaseNum = it[11]

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.lowestCost = it[19]
					data.companyName = it[20]
					data.gp20Vip = it[21]?(int)it[21]:''
					data.gp40Vip = it[22]?(int)it[22]:''
					data.hq40Vip = it[23]?(int)it[23]:''
					data.dateCreated = it[24]?new SimpleDateFormat('yyyy-MM-dd').format(it[24]) : it[24]
					data.contactName =  it[25]
					data.phone = it[26]
					return data

				}
				render ([view: "/${model}/list", model: [rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,total:total]])
			}

		}
	}

	/***
	 * 查看50条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def fiftyShipInfo(){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 审核通过
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as count from cargo_ship_information where  deleted=false ")
		//def totalCount = sqlTotal.uniqueResult(); // 查询总数
		def total  = sqlTotal.uniqueResult();
		StringBuffer s = new StringBuffer("")

		if(params.page){
			int page = Integer.parseInt(params.page)
			int limit = 10
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 10
			params.offset = 0
		}

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) from (select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
				+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
				+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit "+ params.offset +","+ params.limit+") as total ")

		int totalCount = sql.uniqueResult()

		if(totalCount > params.offset || totalCount==params.offset|| totalCount < params.offset){

			sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
					+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
					+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
					+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
					+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit 0,50 " )

		}else{
			sql = null
		}

		if(totalCount > 0){

			List l = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?it[6]:0
					if(data.gp20!=null || data.gp20!=""){

					}
					data.gp40 = it[7]?it[7]:0
					data.hq40 = it[8]?it[8]:0
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					data.releaseNum = it[11]

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.lowestCost = it[19]
					data.companyName = it[20]
					data.gp20Vip = it[21]
					data.gp40Vip = it[22]
					data.hq40Vip = it[23]
					data.dateCreated = it[24]?new SimpleDateFormat('yyyy-MM-dd').format(it[24]) : it[24]
					data.contactName = it[25]
					data.phone = it[26]
					return data

				}
				render ([view: "/${model}/list", model: [rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,total:total]])
			}

		}
	}

	/***
	 * 查看100条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def oneHundredShipInfo(){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 审核通过
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as count from cargo_ship_information where  deleted=false ")
		//def totalCount = sqlTotal.uniqueResult(); // 查询总数
		def total  = sqlTotal.uniqueResult();
		StringBuffer s = new StringBuffer("")

		if(params.page){
			int page = Integer.parseInt(params.page)
			int limit = 10
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 10
			params.offset = 0
		}

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) from (select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
				+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
				+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit "+ params.offset +","+ params.limit+") as total ")

		int totalCount = sql.uniqueResult()

		if(totalCount > params.offset || totalCount==params.offset|| totalCount < params.offset){

			sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
					+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
					+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
					+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
					+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit 0,100 " )

		}else{
			sql = null
		}

		if(totalCount > 0){

			List l = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?it[6]:0
					if(data.gp20!=null || data.gp20!=""){

					}
					data.gp40 = it[7]?it[7]:0
					data.hq40 = it[8]?it[8]:0
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					data.releaseNum = it[11]
					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.lowestCost = it[19]
					data.companyName = it[20]
					data.gp20Vip = it[21]
					data.gp40Vip = it[22]
					data.hq40Vip = it[23]
					data.dateCreated = it[24]?new SimpleDateFormat('yyyy-MM-dd').format(it[24]) : it[24]
					data.contactName = it[25]
					data.phone = it[26]
					return data

				}
				render ([view: "/${model}/list", model: [rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,total:total]])
			}

		}
	}

	/***
	 * 查看500条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def wubaiShipInfo(){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 审核通过
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as count from cargo_ship_information where  deleted=false ")
		//def totalCount = sqlTotal.uniqueResult(); // 查询总数
		def total  = sqlTotal.uniqueResult();
		StringBuffer s = new StringBuffer("")

		if(params.page){
			int page = Integer.parseInt(params.page)
			int limit = 10
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 10
			params.offset = 0
		}

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) from (select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
				+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
				+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit "+ params.offset +","+ params.limit+") as total ")

		int totalCount = sql.uniqueResult()

		if(totalCount > params.offset || totalCount==params.offset|| totalCount < params.offset){

			sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
					+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
					+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
					+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
					+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit 0,500 " )

		}else{
			sql = null
		}

		if(totalCount > 0){

			List l = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?it[6]:0
					if(data.gp20!=null || data.gp20!=""){

					}
					data.gp40 = it[7]?it[7]:0
					data.hq40 = it[8]?it[8]:0
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					data.releaseNum = it[11]

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.lowestCost = it[19]
					data.companyName = it[20]
					data.gp20Vip = it[21]
					data.gp40Vip = it[22]
					data.hq40Vip = it[23]
					data.dateCreated = it[24]?new SimpleDateFormat('yyyy-MM-dd').format(it[24]) : it[24]
					data.contactName = it[25]
					data.phone = it[26]
					return data

				}
				render ([view: "/${model}/list", model: [rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,total:total]])
			}

		}
	}

	/***
	 * 查看1000条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def thousandShipInfo(){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 审核通过
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as count from cargo_ship_information where  deleted=false ")
		//def totalCount = sqlTotal.uniqueResult(); // 查询总数
		def total  = sqlTotal.uniqueResult();
		StringBuffer s = new StringBuffer("")

		if(params.page){
			int page = Integer.parseInt(params.page)
			int limit = 10
			int offset = (page-1)*limit
			params.limit = limit
			params.offset = offset
		}else{
			params.limit = 10
			params.offset = 0
		}

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) from (select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
				+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
				+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit "+ params.offset +","+ params.limit+") as total ")

		int totalCount = sql.uniqueResult()

		if(totalCount > params.offset || totalCount==params.offset|| totalCount < params.offset){

			sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
					+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
					+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
					+" cago.weight_limit,sps.lowest_cost,cago.company_name,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.date_created,cago.contact_name,cago.phone "
					+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.deleted = false order by  date_created desc limit 0,1000 " )

		}else{
			sql = null
		}

		if(totalCount > 0){

			List l = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?it[6]:0
					if(data.gp20!=null || data.gp20!=""){

					}
					data.gp40 = it[7]?it[7]:0
					data.hq40 = it[8]?it[8]:0
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					data.releaseNum = it[11]

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.lowestCost = it[19]
					data.companyName = it[20]
					data.gp20Vip = it[21]
					data.gp40Vip = it[22]
					data.hq40Vip = it[23]
					data.dateCreated = it[24]?new SimpleDateFormat('yyyy-MM-dd').format(it[24]) : it[24]
					data.contactName = it[25]
					data.phone = it[26]
					return data

				}
				render ([view: "/${model}/list", model: [rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,total:total]])
			}

		}
	}

	/***
	 *  批次运价撤销	
	 * @return
	 */
	def bactchRepeal(){

		CargoShipInformation info = CargoShipInformation.get(params.id as Long)
		def status= Status.Revoked
		def id = info.id

		def hql="update CargoShipInformation a set a.status=:status where a.id=:id"

		def hql1=[:]
		def sta="status"
		def st=status
		def sta1="id"

		def st1=new Long(id)
		hql1.put(sta,st)
		hql1.put(sta1,st1)
		if(!CargoShipInformation.executeUpdate(hql,hql1))
		{
			CargoShipInformation.errors.each{ println "a:>=="+it }
		}
		redirect uri: "/${model}/bactchList"
	}


	/***
	 * 批次运价撤销
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def bactchDelete(){
		CargoShipInformation info = CargoShipInformation.get(params.id as Long)
		def deleted = true
		def id = info.id
		def hql="update CargoShipInformation a set a.deleted=:deleted where a.id=:id"
		def hql1=[:]
		def sta="deleted"
		def st=deleted
		def sta1="id"

		def st1=new Long(id)
		hql1.put(sta,st)
		hql1.put(sta1,st1)
		CargoShipInformation.executeUpdate(hql,hql1)

		redirect uri: "/${model}/bactchList"
	}

	/***
	 * 根据发布批号查询 ten条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchTenPricingInfo(){
		def deleted = false;
		def releaseNum = params.releaseNum
		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
				+" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.weight_limit,cago.company_name,cago.contact_name,cago.phone,sps.cbm,sps.lowest_cost "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id "
				+" where cago.release_num = "+releaseNum+"  and cago.deleted = "+false+" limit 0,10 ");

		def list = sql.list()?.collect{
			def data = [:]
			def transType = " ";
			if(it[1]){
				switch(it[1]){
					case TransportationType.Whole.name():
						transType = TransportationType.Whole.text;
						break;
					case TransportationType.Together.name():
						transType = TransportationType.Together.text;
						break;
				}
			}

			data.id = it[0]
			data.transType = transType
			data.startPort = it[2]
			data.endPort = it[3]
			data.shippingDays = it[4]
			data.shippingDay = it[5]
			data.gp20 = it[6]?(int)it[6]:''
			data.gp40 = it[7]?(int)it[7]:''
			data.hq40 = it[8]?(int)it[8]:''
			data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
			data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]

			def status =" "

			if(it[11]){
				switch(it[11]){
					case Status.UnVerify.name():
						status = Status.UnVerify.text;
						break;
					case Status.InVerify.name():
						status = Status.InVerify.text;
						break;
					case Status.VerifyPassed.name():
						status = Status.VerifyPassed.text;
						break;
					case Status.Expired.name():
						status = Status.Expired.text;
						break;
					case Status.Revoked.name():
						status = Status.Revoked.text;
						break;
					case Status.Closed.name():
						status = Status.Closed.text;
						break;
				}
			}
			data.status = status
			data.releaseNum = it[12]
			data.shipCompany = it[13]
			data.middlePort = it[14]?it[14]:"直达"
			data.routeName = it[15]
			data.remark = it[16]?it[16]:""
			data.extra = it[17]
			data.gp20Vip = it[18]?(int)it[18]:''
			data.gp40Vip = it[19]?(int)it[19]:''
			data.hq40Vip = it[20]?(int)it[20]:''
			data.weightLimit = it[21]?it[21]:""
			data.companyName = it[22]
			data.contactName = it[23]
			data.phone = it[24]
			data.cbm = it[25]?it[25]:""
			data.lowestCost = it[26]?it[26]:""
			return data
		}
		render list as JSON
	}
	/***
	 * 根据发布批号查询 Fifty条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchFiftyPricingInfo(){
		def deleted = false;
		def releaseNum = params.releaseNum
		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
				+" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.weight_limit,cago.company_name,cago.contact_name,cago.phone,sps.cbm,sps.lowest_cost "
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id "
				+" where cago.release_num = "+releaseNum+"  and cago.deleted = "+false+" limit 0,50");

		def list = sql.list()?.collect{
			def data = [:]
			def transType = " ";
			if(it[1]){
				switch(it[1]){
					case TransportationType.Whole.name():
						transType = TransportationType.Whole.text;
						break;
					case TransportationType.Together.name():
						transType = TransportationType.Together.text;
						break;
				}
			}

			data.id = it[0]
			data.transType = transType
			data.startPort = it[2]
			data.endPort = it[3]
			data.shippingDays = it[4]
			data.shippingDay = it[5]
			data.gp20 = it[6]?(int)it[6]:''
			data.gp40 = it[7]?(int)it[7]:''
			data.hq40 = it[8]?(int)it[8]:''
			data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
			data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]

			def status =" "

			if(it[11]){
				switch(it[11]){
					case Status.UnVerify.name():
						status = Status.UnVerify.text;
						break;
					case Status.InVerify.name():
						status = Status.InVerify.text;
						break;
					case Status.VerifyPassed.name():
						status = Status.VerifyPassed.text;
						break;
					case Status.Expired.name():
						status = Status.Expired.text;
						break;
					case Status.Revoked.name():
						status = Status.Revoked.text;
						break;
					case Status.Closed.name():
						status = Status.Closed.text;
						break;
				}
			}
			data.status = status
			data.releaseNum = it[12]
			data.shipCompany = it[13]
			data.middlePort = it[14]?it[4]:"直达"
			data.routeName = it[15]
			data.remark = it[16]?it[16]:""
			data.extra = it[17]
			data.gp20Vip = it[18]?(int)it[18]:''
			data.gp40Vip = it[19]?(int)it[19]:''
			data.hq40Vip = it[20]?(int)it[20]:''
			data.weightLimit = it[21]?it[21]:""
			data.companyName = it[22]
			data.contactName = it[23]
			data.phone = it[24]
			data.cbm =  it[25]?it[25]:""
			data.lowestCost = it[26]?it[26]:""
			
			return data
		}
		render list as JSON
	}

	/***
	 * 根据发布批号查询 twoHundred条运价信息
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchTwoHundredPricingInfo(){

		def deleted = false;
		def releaseNum = params.releaseNum
		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
				+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
				+" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.weight_limit,cago.company_name,cago.contact_name,cago.phone,sps.cbm,sps.lowest_cost"
				+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id "
				+" where cago.release_num = "+releaseNum+"  and cago.deleted = "+false+" limit 0,200");

		def list = sql.list()?.collect{
			def data = [:]
			def transType = " ";
			if(it[1]){
				switch(it[1]){
					case TransportationType.Whole.name():
						transType = TransportationType.Whole.text;
						break;
					case TransportationType.Together.name():
						transType = TransportationType.Together.text;
						break;
				}
			}

			data.id = it[0]
			data.transType = transType
			data.startPort = it[2]
			data.endPort = it[3]
			data.shippingDays = it[4]
			data.shippingDay = it[5]
			data.gp20 = it[6]?(int)it[6]:''
			data.gp40 = it[7]?(int)it[7]:''
			data.hq40 = it[8]?(int)it[8]:''
			data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
			data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]

			def status =" "

			if(it[11]){
				switch(it[11]){
					case Status.UnVerify.name():
						status = Status.UnVerify.text;
						break;
					case Status.InVerify.name():
						status = Status.InVerify.text;
						break;
					case Status.VerifyPassed.name():
						status = Status.VerifyPassed.text;
						break;
					case Status.Expired.name():
						status = Status.Expired.text;
						break;
					case Status.Revoked.name():
						status = Status.Revoked.text;
						break;
					case Status.Closed.name():
						status = Status.Closed.text;
						break;
				}
			}
			data.status = status
			data.releaseNum = it[12]
			data.shipCompany = it[13]
			data.middlePort = it[14]?it[14]:"直达"
			data.routeName = it[15]
			data.remark = it[16]?it[16]:""
			data.extra = it[17]
			data.gp20Vip = it[18]?(int)it[18]:''
			data.gp40Vip = it[19]?(int)it[19]:''
			data.hq40Vip = it[20]?(int)it[20]:''
			data.weightLimit = it[21]?it[21]:""
			data.companyName = it[22]
			data.contactName = it[23]
			data.phone = it[24]
			data.cbm = it[25]?it[25]:""
			data.lowestCost = it[26]?it[26]:"" 

			return data
		}
		render list as JSON
	}

	/***
	 *  查看20条批量运价
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchTwentyTariff(){
		Date today = new Date();
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 发布数量
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(distinct(release_num)) as count from cargo_ship_information where  deleted=false ")

		def totalCount = sqlTotal.uniqueResult(); // 查询总数

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select count(*) from (select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false  group by release_num order by date_created desc limit 0,20) as total")

		int total = sql.uniqueResult()

		if(total > params.offset || total==params.offset|| total < params.offset){
			sql = sessionFactory.getCurrentSession().createSQLQuery("select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false group by release_num order by  date_created desc limit 0,20")
		}else{
			sql = null
		}

		if(total > 0){

			int h = sql.list().size()

			StringBuffer s = new StringBuffer("")

			int count = 0

			List l = new ArrayList();

			List batList = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				batList=sql.list()?.collect{
					def data = [:]
					data.releaseNum = it[0]
					data.dateCreated = it[1]
					data.totalCount = it[2]
					data.companyName = it[3]
					data.createBy = it[4]
					l.add(data)

					s.append("(select  cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
							+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
							+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
							+" cago.weight_limit,cago.company_name,sps.lowest_cost,cago.create_by,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.contact_name,cago.phone "
							+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.release_num = '"+it[0]+"' and  cago.deleted = false  ")


					if(params.serach) {
						searchKey = "%${params.serach}%"
					}

					if(searchKey){
						s.append(" and (cago.start_port like '%"+searchKey.trim()+"%'  ")
						s.append(" or cago.end_port like '%"+searchKey.trim()+"%'  ")
						s.append(" or cago.id like '%"+searchKey.trim()+"%' ) ")
					}

					if(params.status!=null && params.status!=" "){
						switch(params.status){
							case Status.Expired.name():
								s.append(" and cago.status='"+Status.Expired.name() +"' ")
								break;
							case Status.Revoked.name():
								s.append(" and cago.status='"+Status.Revoked.name() +"' ")
								break;
							case Status.VerifyPassed.name():
								s.append(" and cago.status='"+Status.VerifyPassed.name() +"' ")
								break;
							case Status.Closed.name():
								s.append(" and cago.status='"+Status.Closed.name() +"' ")
								break;
						}
					}
					s.append(" limit 0,1 ) ");
					if(count < total-1){
						s.append(" union all ");
					}
					count++;

					return data
				}

				sql = sessionFactory.getCurrentSession().createSQLQuery(s.toString());

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?(int)it[6]:''
					data.gp40 = it[7]?(int)it[7]:''
					data.hq40 = it[8]?(int)it[8]:''
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					//data.releaseNum = it[11]

					for(Map m : l){
						if(m.releaseNum == it[11]){
							data.releaseNum = m.releaseNum
							data.totalCount = m.totalCount
							data.dateCreated = m.dateCreated
							data.companyName = m.companyName
							data.createBy = m.createBy
							//data.dateCreated = format.parse(m.dateCreated)
						}
					}

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
							case Status.Closed.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]?it[14]:"直达"
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.companyName = it[19]
					data.lowestCost = it[20]
					data.createBy = it[21]
					data.gp20Vip = it[22]?(int)it[22]:''
					data.gp40Vip = it[23]?(int)it[23]:''
					data.hq40Vip = it[24]?(int)it[24]:''
					data.contactName = it[25]
					data.phone = it[26]

					return data
				}
			}
			render ([view: "/tariffManager/bactchList", model: [batrows:batList,rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,totalCount:totalCount]])
		}
	}


	/***
	 *  查看50条批量运价
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchFiftyTariff(){
		Date today = new Date();
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 发布数量
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(distinct(release_num)) as count from cargo_ship_information where  deleted=false ")

		def totalCount = sqlTotal.uniqueResult(); // 查询总数

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select count(*) from (select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false  group by release_num order by date_created desc limit 0,50) as total")

		int total = sql.uniqueResult()

		if(total > params.offset || total==params.offset|| total < params.offset){
			sql = sessionFactory.getCurrentSession().createSQLQuery("select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false group by release_num order by  date_created desc limit 0,50")
		}else{
			sql = null
		}

		if(total > 0){

			int h = sql.list().size()

			StringBuffer s = new StringBuffer("")

			int count = 0

			List l = new ArrayList();

			List batList = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				batList=sql.list()?.collect{
					def data = [:]
					data.releaseNum = it[0]
					data.dateCreated = it[1]
					data.totalCount = it[2]
					data.companyName = it[3]
					data.createBy = it[4]
					l.add(data)

					s.append("(select  cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
							+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
							+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
							+" cago.weight_limit,cago.company_name,sps.lowest_cost,cago.create_by,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.contact_name,cago.phone "
							+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.release_num = '"+it[0]+"' and  cago.deleted = false  ")


					if(params.serach) {
						searchKey = "%${params.serach}%"
					}

					if(searchKey){
						s.append(" and (cago.start_port like '%"+searchKey.trim()+"%'  ")
						s.append(" or cago.end_port like '%"+searchKey.trim()+"%'  ")
						s.append(" or cago.id like '%"+searchKey.trim()+"%' ) ")
					}

					if(params.status!=null && params.status!=" "){
						switch(params.status){
							case Status.Expired.name():
								s.append(" and cago.status='"+Status.Expired.name() +"' ")
								break;
							case Status.Revoked.name():
								s.append(" and cago.status='"+Status.Revoked.name() +"' ")
								break;
							case Status.VerifyPassed.name():
								s.append(" and cago.status='"+Status.VerifyPassed.name() +"' ")
								break;
							case Status.Closed.name():
								s.append(" and cago.status='"+Status.Closed.name() +"' ")
								break;
						}
					}
					s.append(" limit 0,1 ) ");
					if(count < total-1){
						s.append(" union all ");
					}
					count++;

					return data
				}

				sql = sessionFactory.getCurrentSession().createSQLQuery(s.toString());

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?(int)it[6]:''
					data.gp40 = it[7]?(int)it[7]:''
					data.hq40 = it[8]?(int)it[8]:''
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					//data.releaseNum = it[11]

					for(Map m : l){
						if(m.releaseNum == it[11]){
							data.releaseNum = m.releaseNum
							data.totalCount = m.totalCount
							data.dateCreated = m.dateCreated
							data.companyName = m.companyName
							data.createBy = m.createBy
							//data.dateCreated = format.parse(m.dateCreated)
						}
					}

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
							case Status.Closed.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]?it[14]:"直达"
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.companyName = it[19]
					data.lowestCost = it[20]
					data.createBy = it[21]
					data.gp20Vip = it[22]?(int)it[22]:''
					data.gp40Vip = it[23]?(int)it[23]:''
					data.hq40Vip = it[24]?(int)it[24]:''
					data.contactName = it[25]
					data.phone = it[26]

					return data
				}
			}
			render ([view: "/tariffManager/bactchList", model: [batrows:batList,rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,totalCount:totalCount]])
		}
	}


	/***
	 *  查看100条批量运价
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchOneHundredTariff(){
		Date today = new Date();
		def searchKey
		def revoked = Status.Revoked
		def rxpired = Status.Expired
		// 发布数量
		SQLQuery sqlreleaseNumTotal = sessionFactory.getCurrentSession().createSQLQuery("SELECT COUNT(*) FROM cargo_ship_information WHERE  status != '"+revoked+"'  AND status != '"+rxpired+"'  AND deleted = false;")
		def  releaseNumCount =  sqlreleaseNumTotal.uniqueResult();
		//已撤销数量
		SQLQuery sqlRevokedNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where  deleted = false  and  status = '"+revoked+"' ")
		def  revokedNumCount =  sqlRevokedNumTotal.uniqueResult();
		//已过期数量
		SQLQuery sqlExpiredNumTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(*) as releaseNum from  cargo_ship_information where   deleted = false  and  status = '"+rxpired+"' ")
		def  expiredNumCount =  sqlExpiredNumTotal.uniqueResult();

		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(distinct(release_num)) as count from cargo_ship_information where  deleted=false ")

		def totalCount = sqlTotal.uniqueResult(); // 查询总数

		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select count(*) from (select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false  group by release_num order by date_created desc limit 0,100) as total")

		int total = sql.uniqueResult()

		if(total > params.offset || total==params.offset|| total < params.offset){
			sql = sessionFactory.getCurrentSession().createSQLQuery("select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count,company_name,create_by from cargo_ship_information where  deleted=false group by release_num order by  date_created desc limit 0,100")
		}else{
			sql = null
		}

		if(total > 0){

			int h = sql.list().size()

			StringBuffer s = new StringBuffer("")

			int count = 0

			List l = new ArrayList();

			List batList = new ArrayList();

			List list = new ArrayList()

			if(sql != null ){

				batList=sql.list()?.collect{
					def data = [:]
					data.releaseNum = it[0]
					data.dateCreated = it[1]
					data.totalCount = it[2]
					data.companyName = it[3]
					data.createBy = it[4]
					l.add(data)

					s.append("(select  cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
							+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num,"
							+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra,"
							+" cago.weight_limit,cago.company_name,sps.lowest_cost,cago.create_by,sps.gp20vip,sps.gp40vip,sps.hq40vip,cago.contact_name,cago.phone"
							+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.release_num = '"+it[0]+"' and  cago.deleted = false  ")


					if(params.serach) {
						searchKey = "%${params.serach}%"
					}

					if(searchKey){
						s.append(" and (cago.start_port like '%"+searchKey.trim()+"%'  ")
						s.append(" or cago.end_port like '%"+searchKey.trim()+"%'  ")
						s.append(" or cago.id like '%"+searchKey.trim()+"%' ) ")
					}

					if(params.status!=null && params.status!=" "){
						switch(params.status){
							case Status.Expired.name():
								s.append(" and cago.status='"+Status.Expired.name() +"' ")
								break;
							case Status.Revoked.name():
								s.append(" and cago.status='"+Status.Revoked.name() +"' ")
								break;
							case Status.VerifyPassed.name():
								s.append(" and cago.status='"+Status.VerifyPassed.name() +"' ")
								break;
							case Status.Closed.name():
								s.append(" and cago.status='"+Status.Closed.name() +"' ")
								break;
						}
					}
					s.append(" limit 0,1 ) ");
					if(count < total-1){
						s.append(" union all ");
					}
					count++;

					return data
				}

				sql = sessionFactory.getCurrentSession().createSQLQuery(s.toString());

				list = sql.list()?.collect {

					def data = [:]

					def transType = " ";
					if(it[1]){
						switch(it[1]){
							case TransportationType.Whole.name():
								transType = TransportationType.Whole.text;
								break;
							case TransportationType.Together.name():
								transType = TransportationType.Together.text;
								break;
						}
					}

					data.id = it[0]
					data.transType = transType
					data.startPort = it[2]
					data.endPort = it[3]
					data.shippingDays = it[4]
					data.shippingDay = it[5]
					data.gp20 = it[6]?(int)it[6]:''
					data.gp40 = it[7]?(int)it[7]:''
					data.hq40 = it[8]?(int)it[8]:''
					data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
					data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
					//data.releaseNum = it[11]

					for(Map m : l){
						if(m.releaseNum == it[11]){
							data.releaseNum = m.releaseNum
							data.totalCount = m.totalCount
							data.dateCreated = m.dateCreated
							data.companyName = m.companyName
							data.createBy = m.createBy
							//data.dateCreated = format.parse(m.dateCreated)
						}
					}

					def status =" "

					if(it[12]){
						switch(it[12]){
							case Status.UnVerify.name():
								status = Status.UnVerify.text;
								break;
							case Status.InVerify.name():
								status = Status.InVerify.text;
								break;
							case Status.VerifyPassed.name():
								status = Status.VerifyPassed.text;
								break;
							case Status.Expired.name():
								status = Status.Expired.text;
								break;
							case Status.Revoked.name():
								status = Status.Revoked.text;
								break;
							case Status.Closed.name():
								status = Status.Revoked.text;
								break;
						}
					}
					data.status = status
					data.shipCompany = it[13]
					data.middlePort = it[14]?it[14]:"直达"
					data.routeName = it[15]
					data.remark = it[16]
					data.extra = it[17]
					data.weightLimit = it[18]
					data.companyName = it[19]
					data.lowestCost = it[20]
					data.createBy = it[21]
					data.gp20Vip = it[22]?(int)it[22]:''
					data.gp40Vip = it[23]?(int)it[23]:''
					data.hq40Vip = it[24]?(int)it[24]:''
					data.contactName= it[25]
					data.phone = it[26]

					return data
				}
			}
			render ([view: "/tariffManager/bactchList", model: [batrows:batList,rows: list,releaseNumCount:releaseNumCount,revokedNumCount:revokedNumCount,expiredNumCount:expiredNumCount,totalCount:totalCount]])
		}
	}


	/***
	 * 运价批量撤销
	 * @return
	 */
	@Secured('ROLE_CLIENT')
	def batchRepeal(){
		def status= Status.Revoked
		def id=params.ids
		id.split(",")?.collect{
			def hql1=[:]
			def sta="status"
			def st=status
			def sta1="releaseNum"
			def sta2="id"
			def st1=it
			def st2=Long.parseLong(it)
			hql1.put(sta,st)
			hql1.put(sta1,st1)
			hql1.put(sta2,st2)
			def hql="update CargoShipInformation a set a.status=:status where a.releaseNum=:releaseNum or a.id=:id"
			CargoShipInformation.executeUpdate(hql,hql1)
		}
		render (["grid4":"Success"] as JSON)
	}

	/***
	 *  批量运价删除 
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def batchDelete(){
		def deleted = true
		def id=params.ids
		id.split(",")?.collect{
			def hql1=[:]
			def sta="deleted"
			def st= true
			def sta1="releaseNum"
			def st1=it
			def sta2="id"
			def st2=Long.parseLong(it)
			hql1.put(sta,st)
			hql1.put(sta1, st1)
			hql1.put(sta2,st2)
			def hql="update CargoShipInformation a set a.deleted=:deleted where a.releaseNum=:releaseNum or a.id=:id"
			CargoShipInformation.executeUpdate(hql,hql1)
		}
		render(["allRepeal":"Success"] as JSON)
	}
	
	/***
	 * 记录管理 /运价添加
	 * @return
	 */
	def recordAdd(){
		
		render view: "/${model}/recordAdd", model: [settings: getSettings(getMenu('记录管理运价添加', "/${model}/recordAdd"))]
	}
	
	/**
	 * 记录管理运价保存
	 * @return
	 */
	def save(){
		
		//批号生成Id生成
		SimpleDateFormat sdf1 = new SimpleDateFormat("HHmmss");
		def releaseTest = sdf1.format(new Date())
		
		def releaseNum = "P" + releaseTest
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		CargoShipInformation info = new CargoShipInformation()
		
		info.releaseNum =  releaseNum
		info.status = Status.VerifyPassed
 		info.fromBy = "后台"
		/*if(params.serviceId) {
			info.service = BackUser.get(params.serviceId as Long)
		}*/
		
		info.service = BackUser.get("10" as Long)
		info.startPort = params.startPort
		info.endPort =params.endPort
		
		 
		info.companyName = params.companyName
		info.contactName = params.contactName
		info.phone = params.phone
		
		if(params.routeName){
			
			info.routeName= params.routeName
		}
		
		if(params.middlePort){
			info.middlePort = params.middlePort
		}
		info.shippingDays =Integer.parseInt(params.shippingDays)
		info.shipCompany =params.shipCompany
		
		info.transType = params.group2
		
		info.startDate = sdf.parse(params.startDate)
		
		info.endDate =sdf.parse(params.endDate)
		
		if(params.limit_weight){
			info.weightLimit =params.limit_weight
		}
		if(params.remark){
			info.remark = params.remark
		}
			
	   info.shippingDay = params.total_shipping_date
		
		
		info.prices = new ShippingPrices()
		
		if(params.gp20_common_price){
			BigDecimal gp20 = new BigDecimal(params.gp20_common_price)
			info.prices.gp20 = gp20
		}
		if(params.gp20_specical_price){ 
			BigDecimal gp20Vip = new BigDecimal(params.gp20_specical_price)
			info.prices.gp20Vip = gp20Vip
		}
		if(params.gp40_common_price){
			BigDecimal gp40 = new BigDecimal(params.gp40_common_price)
			info.prices.gp40 = gp40
		}
		if(params.gp40_specical_price){
			BigDecimal gp40Vip = new BigDecimal(params.gp40_specical_price)
			info.prices.gp40Vip = gp40Vip
		}
		if(params.hq40_common_price){
			BigDecimal hq40 = new BigDecimal(params.hq40_common_price)
			info.prices.hq40 = hq40
		}
		if(params.hq40_specical_price){
			BigDecimal hq40Vip = new BigDecimal(params.hq40_specical_price)
			info.prices.hq40Vip = hq40Vip
		}

		if(params.per_price){
			BigDecimal cbm = new BigDecimal(params.per_price)
			info.prices.cbm = cbm
		}
		
		if(params.total_shipextra_date){
			info.prices.extra = params.total_shipextra_date
		}
		
		if(params.min_charge){
			info.prices.lowestCost = params.min_charge
		}
		
		if( !info.save() ) {
			info.errors.each {
			   println it
			}
		}
		info.save()
		if(!info.hasErrors()) {
			flash.msgs = ['保存成功']
			redirect uri: "/tariffManager/list"
		} else {
			//render ([msg: g.message(code: info.errors.allErrors[0].codes[0])] as JSON)
			flash.errors = info.errors
			redirect uri: "/tariffManager/add/"
		}
	}
	
	
	/***
	 *  下载运价模板
	 * @return
	 */
	
	//@Secured('ROLE_SHIP_AGENT')
	def downloadExample() { 
		String fname = new String('商务内部运价模板'.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.xls")
		response.outputStream << getClass().getResourceAsStream("/com/cdd/back/files/businessModel.xls")
		return
	}
	
	/***
	 *  下载对外发布运价模板
	 * @return
	 */
	def downloadExampleFront() {
		String fname = new String('商务对外运价模板'.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.xls")
		response.outputStream << getClass().getResourceAsStream("/com/cdd/back/files/ship.xls")
		return
	}
	/***
	 * 批量对外运价导入
	 * @return
	 */
	
	int maxSize = 1024 * 1024 * 10 // 10MB maximum
	def importDataFront() {
		
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss")
			
			def releaseTest = sdf1.format(new Date())
			
			def releaseNum = "P" + releaseTest
			
			def fUser = FrontUser.findByMobile(params.mobile as String)
		
			if (!fUser || fUser.type != FrontUserType.Agent) {
				CargoShipInformation data = new CargoShipInformation();
				data.status = Status.VerifyFailed;
				render(text: "<script>alert('上传失败, 请输入正确的供应商用户 ');</script>", contentType: "text/html", encoding: "UTF-8")
				return data
			}
			def file = request.getFile('xls')
		
			if(file.size > maxSize) {
				render(text: "<script>alert('文件不能超过1MB');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}
			
			/*String name = file.fileItem.fileName
			if(!name){
				render(text: "<script>alert('请选择文件');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}*/
			/*if(!name.endsWith('.xls')) {
				render(text: "<script>alert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}*/
			
			HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
			HSSFSheet sheet = wb.getSheetAt(0)
			int rowCount = sheet.physicalNumberOfRows
			
			List<String>  errorInfo = new ArrayList<String>();
			
			if(rowCount < 1){
				render(text: "<script>alert('没有符合规则记录上传')</script>", contentType:"text/html" , encoding:"UTF-8")
				return
			}else{
				def datas = []
				
				String msg  //公共字段
				
				int sumCount     //总和
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
				
				for(int i=0;i<rowCount-1;i++){
					
					CargoShipInformation data = new CargoShipInformation()
					
					int num = i + 1;
					
					HSSFRow  row = sheet.getRow(num)
					
					try {
						String routeName = row.getCell(0)?.stringCellValue?:null
						if (routeName?.length() > 255){
							msg = "第${num+1}行【航线名称】不能超过255个字符"
							errorInfo.add(msg);
						}
						data.routeName = routeName
					} catch (e) {
						msg = "第${num+1}行【航线名称】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					try{
						String startPort = row.getCell(1)?.stringCellValue.toString().toUpperCase()?:null
						if(!startPort){
							  msg = "第${num+1}行【起始港】不能为空"
							  errorInfo.add(msg);
						}
						else if(startPort?.length() > 255){
							msg = "第${num+1}行【起始港】不能超过255个字符 "
							errorInfo.add(msg);
						}
						data.startPort = startPort
					}catch(e){
						msg = "第${num+1}行【起始港】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					
					try{
						String endPort = row.getCell(2)?.stringCellValue.toString().toUpperCase()?:null
						if(!endPort){
							msg = "第${num+1}行【目的港】不能为空!"
							errorInfo.add(msg);
						}
						else if(endPort?.length() > 255){
							msg = "第${num+1}行 【目的港】不能超过255个字符"
							errorInfo.add(msg);
						}
						data.endPort = endPort
					}catch(e){
						msg = "第${num+1}行【目的港】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					
					try {
						String middlePort = row.getCell(3)?.stringCellValue.toString().toUpperCase()?:null
						if(middlePort?.length() > 255) {
							msg = "第${num+1}行【中转港】不能超过255个字符 "
							errorInfo.add(msg);
						}
						data.middlePort = middlePort
					} catch(e) {
						  msg ="第${num+1}行【中转港】单元格格式有误，请使用文本格式"
						  errorInfo.add(msg);
					}
					
					try {
						String shipCompany = row.getCell(4)?.stringCellValue.toString().toUpperCase()?:null;
						if(!shipCompany){
							msg = "第${num+1}行【船公司】不能为空"
							errorInfo.add(msg);
						}
						else if(shipCompany?.length() > 255) {
							msg = "第${num+1}行【船公司】不能超过255个字符"
							errorInfo.add(msg);
						}
						data.shipCompany = shipCompany
					} catch(e) {
						msg = "第${num+1}行【船公司】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					
					try {
						String shippingDay
						try {
							shippingDay = row.getCell(5)?.stringCellValue?:null;
						} catch(e) {
							shippingDay = row.getCell(5)?.dateCellValue ? sdf.format(row.getCell(5).dateCellValue) : null
						}
						if(!shippingDay) {
							msg = "第${num+1}行【船期】不能为空"
							errorInfo.add(msg);
						}
						 else if(shippingDay.length() > 255) {
							msg = "第${num+1}行【船期】不能超过255个字符 "
							errorInfo.add(msg);
						}
						data.shippingDay = shippingDay
					} catch(e) {
						msg = "第${num+1}行【船期】单元格格式有误，请使用文本格式或日期格式 "
						errorInfo.add(msg);
					}
	
					data.owner = fUser;
					
					Double shippingDays
					try {
						shippingDays = row.getCell(6)?.numericCellValue ?: null;
					} catch(e) {
						try {
							shippingDays = row.getCell(6)?.stringCellValue ? Double.valueOf(row.getCell(6).stringCellValue) : null
						} catch(e1) {
							msg = "第${num+1}行【航程】单元格格式有误，请使用文本格式或数字格式 "
							errorInfo.add(msg);
						}
					}
					data.shippingDays = shippingDays
					
					try {
						String transType = row.getCell(7)?.stringCellValue?:null;
						if(!transType) {
							msg = "第${num+1}行【运输类别】不能为空 "
							errorInfo.add(msg);
						}
						try {
							data.transType = TransportationType.getCodeByText(transType)
							if(!data.transType) {
								throw new RuntimeException()
							}
						} catch(e) {
							msg = "第${num+1}行【运输类别】内容有误，请使用有效文本：整箱 | 拼箱 "
							errorInfo.add(msg);
						}
					} catch(e) {
						msg ="第${num+1}行【运输类别】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					
					Date startDate
					try {
						startDate = row.getCell(8)?.dateCellValue ?: null
						if(!startDate) {
							msg = "第${num+1}行【有效期开始日期】不能为空 "
							errorInfo.add(msg);
						}
					} catch(e) {
						try {
							startDate = row.getCell(8)?.stringCellValue ? sdf.parse(row.getCell(8).stringCellValue): null
						} catch(e1) {
							  msg = "第${num+1}行【有效期开始日期】格式有误，有效格式：2016-01-01"
							  errorInfo.add(msg);
						}
						if(!startDate) {
							msg = "第${num+1}行【有效期开始日期】不能为空"
							errorInfo.add(msg);
						}
					}
					data.startDate = startDate
	
					Date endDate
					try {
						endDate = row.getCell(9)?.dateCellValue ?: null
						if(!endDate) {
							msg = "第${num+1}行【有效期结束日期】不能为空"
							errorInfo.add(msg);
						}
					} catch(e) {
						try {
							endDate = row.getCell(9)?.stringCellValue ? sdf.parse(row.getCell(9).stringCellValue): null
						} catch(e1) {
							msg = "第${num+1}行【有效期结束日期】格式有误，有效格式：2016-01-01"
							errorInfo.add(msg);
							
						}
						if(!endDate) {
							msg = "第${num+1}行【有效期结束日期】不能为空 "
							errorInfo.add(msg);
						}
					}
					data.endDate = endDate
					
					try {
						String remark = row.getCell(10)?.stringCellValue?:null;
						if(remark?.length() > 500) {
							msg = "第${num+1}行【备注】不能超过500个字符 "
							errorInfo.add(msg);
						}
						data.remark = remark
					} catch(e) {
						msg = "第${num+1}行【备注】单元格格式有误，请使用文本格式')"
						errorInfo.add(msg);
					}
					
					def priceParams = [:]
					
						if(TransportationType.Whole == data.transType) {
							BigDecimal gp20
							try {
								gp20 = row.getCell(11)?.numericCellValue ? new BigDecimal(row.getCell(11).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行【USD/20GP】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
							if(gp20) {
								priceParams.gp20 = gp20
							}
							
							BigDecimal gp20Vip
							try {
								gp20Vip = row.getCell(12)?.numericCellValue ? new BigDecimal(row.getCell(12).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行【USD/20GPVIP】单元格格式有误，请使用文本格式 "
								errorInfo.add(msg);
							}
							if(gp20Vip) {
								priceParams.gp20Vip = gp20Vip
							}
							BigDecimal gp40
							try {
								gp40 = row.getCell(13)?.numericCellValue ? new BigDecimal(row.getCell(13).numericCellValue) : null;
							} catch(e) {
								 msg = "第${num+1}行【USD/40GP】单元格格式有误，请使用文本格式 "
								 errorInfo.add(msg);
							}
							if(gp40) {
								priceParams.gp40 = gp40
							}
							
							BigDecimal gp40Vip
							try {
								gp40Vip = row.getCell(14)?.numericCellValue ? new BigDecimal(row.getCell(14).numericCellValue) : null;
							} catch(e) {
								 msg = "第${num+1}行【USD/40GPVIP】单元格格式有误，请使用文本格式 "
								 errorInfo.add(msg);
							}
							if(gp40Vip) {
								priceParams.gp40Vip = gp40Vip
							}
							
							BigDecimal hq40
							try {
								hq40 = row.getCell(15)?.numericCellValue ? new BigDecimal(row.getCell(15).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行【USD/40HQ】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
							if(hq40) {
								priceParams.hq40 = hq40
							}
							
							BigDecimal hq40Vip
							try {
								hq40Vip = row.getCell(16)?.numericCellValue ? new BigDecimal(row.getCell(16).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行【USD/40HQVIP】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
							if(hq40Vip) {
								priceParams.hq40Vip = hq40Vip
							}
						}
						
						try {
							String extra = row.getCell(17)?.stringCellValue?:null;
							
							if(extra?.length() > 1000) {
								msg = "第${num+1}行【附加费】不能超过1000个字符"
								errorInfo.add(msg);
							}
								priceParams.extra = extra
						} catch(e) {
							 msg = "第${num+1}行【附加费】单元格格式有误，请使用文本格式 "
							 errorInfo.add(msg);
						}
							
						if(TransportationType.Whole == data.transType) {
							try {
								String weightLimit = row.getCell(18)?.stringCellValue?:null;
								data.weightLimit = weightLimit
							} catch(e) {
								msg = "第${num+1}行【限重】单元格格式有误，请使用文本格式 "
								errorInfo.add(msg);
							}
						}
						
						try {
							String startPortCn = row.getCell(19)?.stringCellValue?:null;
							  if(startPortCn?.length() > 255) {
								 msg = "第${num+1}行【起始港(中文名)】不能超过255个字符 "
								 errorInfo.add(msg);
							}
							data.startPortCn = startPortCn
						} catch(e) {
							msg = "第${num+1}行【起始港(中文名)】单元格格式有误，请使用文本格式"
							errorInfo.add(msg);
						}
						try {
							String endPortCn = row.getCell(20)?.stringCellValue?:null;
							  if(endPortCn?.length() > 255) {
								 msg = "第${num+1}行【目的港(中文名)】不能超过255个字符"
								 errorInfo.add(msg);
							}
							data.endPortCn = endPortCn
						} catch(e) {
							 msg = "第${num+1}行【目的港(中文名)】单元格格式有误，请使用文本格式"
							 errorInfo.add(msg);
						}
						
						try {
							String middlePortCn = row.getCell(21)?.stringCellValue?:null;
							if(middlePortCn?.length() > 255) {
								msg = "第${num+1}行【中转港(中文名)】不能超过255个字符"
								errorInfo.add(msg);
							}
							data.middlePortCn = middlePortCn
						} catch(e) {
							msg = "第${num+1}行【中转港(中文名)】单元格格式有误，请使用文本格式"
							errorInfo.add(msg);
						}
						
						try {
							String companyName = row.getCell(22)?.stringCellValue?:null;
							if(!companyName){
								msg = "第${num+1}行【货代公司名称】不能为空"
								errorInfo.add(msg);
							}
							else if(companyName?.length() > 255 ){
								msg = "第${num+1}行【货代公司名称】不能超过255个字符 "
								errorInfo.add(msg);
							}
							data.companyName = companyName
							
						} catch (e) {
							msg = "第${num+1}行【货代公司名称】单元格格式有误,请使用本格式"
							errorInfo.add(msg);
						}
						
						try {
							String contactName = row.getCell(23)?.stringCellValue?:null;
							if(!contactName){
								msg = "第${num+1}行【联系人】不能为空"
								errorInfo.add(msg);
							}
							else if(contactName?.length() > 50){
								msg = "第${num+1}行【联系人】不能超过50个字符 "
								errorInfo.add(msg);
							}
							data.contactName = contactName
								
						} catch (e) {
							msg = "第${num+1}行【联系人】单元格格式有误,请使用本格式 "
							errorInfo.add(msg);
						}
						
						String phone
						try {
							 phone = row.getCell(24)?.stringCellValue?.trim() ?: null
							 if(!phone){
								 msg = "第${num+1}行【电话号码】不能为空"
								 errorInfo.add(msg);
							 }
						} catch(e) {
							try{
								phone = row.getCell(24)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(22).numericCellValue).longValue()) : null
								break
							}catch(e1){
								msg = "第${num+1}行【电话号码】格式有误"
								errorInfo.add(msg);
							}
						}
						
						data.phone = phone
										
						if(TransportationType.Together == data.transType) {
							try {
								String pinServiceType = row.getCell(25)?.stringCellValue?:null;
								data.pinServiceType = pinServiceType
							} catch(e) {
								msg ="第${num+1}行【服务类型】单元格格式有误，请使用文本格式 "
								errorInfo.add(msg);
							}
							
							BigDecimal cbm
							try {
								cbm = row.getCell(26)?.stringCellValue ? new BigDecimal(row.getCell(26).stringCellValue) : null;
							} catch(e) {
								msg ="第${num+1}行【USD/cbm】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
							if(cbm) {
								priceParams.cbm = cbm
							}
		
							try {
								String lowestCost = row.getCell(27)?.stringCellValue?:null;
								priceParams.lowestCost = lowestCost
							} catch(e) {
								msg ="第${num+1}行【USD/rt】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
						}
					
						if(priceParams.size() > 0) {
							data.prices = new ShippingPrices(priceParams)
						}
						
						data.status = Status.VerifyPassed;
						data.releaseNum = releaseNum
						data.fromBy = "后台"
						datas << data
				}
	
				if (datas.size == 0) {
					render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
					return
				}
				
				
			 // int  countSum
			if(errorInfo.size() > 0 ){
				
				/*countSum = errorInfo.size();
				if(params.page){
					int page = Integer.parseInt(params.page)
					int limit = 10
					int offset = (page-1)*limit
					params.limit = limit
					params.offset = offset
				}else{
					params.limit = 10
					params.offset = 0
				}*/
				//render(text: "<script>alert('${errorInfo}');</script>", contentType: "text/html", encoding: "UTF-8")
				render errorInfo
				return;
			}else {
				boolean hasError = false
						def savedDatas = []
						int num = 1
						//println datas.size();
						datas.each {
							it.save()
							hasError = it.hasErrors()
							if(!hasError) {
								savedDatas << it
								num++
							}
							return hasError
							}
								if(hasError) {
									CargoShipInformation.deleteAll(savedDatas)
									render(text: "<script>alert('第${num}行保存失败');</script>", contentType: "text/html", encoding: "UTF-8")
									return;
								}
		
				 render (text: "<script>alert('上传成功, 共"+datas.size+"条记录！');</script>", contentType: "text/html", encoding: "UTF-8")
				 //return;
			}
		}
	}
	
	
	
	
	
	
	/***
	 * 批量内部运价导入
	 * @return
	 */
	
	

	@Secured('ROLE_SHIP_AGENT')
	def importData() {
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss")
			def releaseTest = sdf1.format(new Date())
			def releaseNum = "P" + releaseTest 
			def file = request.getFile('xls2')
			if(file.size > maxSize) {
				render(text: "<script>alert('文件不能超过10MB');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			}
			HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
			HSSFSheet sheet = wb.getSheetAt(0)
			int rowCount = sheet.physicalNumberOfRows
			List<String>  errorInfo = new ArrayList<String>();
			if(rowCount < 1){
				render(text: "<script>alert('没有符合规则记录上传')</script>", contentType:"text/html" , encoding:"UTF-8")
				return
			}else{
				def datas = []
				String msg  //公共字段
				int sumCount     //总和
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
				for(int i=0;i<rowCount-1;i++){
					CargoShipInformation data = new CargoShipInformation()
					int num = i + 1;
					HSSFRow  row = sheet.getRow(num)
					try {
						String routeName = row.getCell(0)?.stringCellValue?:null
						if (routeName?.length() > 255){
							msg = "第${num+1}行【航线名称】不能超过255个字符"
							errorInfo.add(msg);
						}
						data.routeName = routeName
					} catch (e) {
						msg = "第${num+1}行【航线名称】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
						
					try{
						String startPort = row.getCell(1)?.stringCellValue.toString().toUpperCase()?:null
						if(!startPort){
							  msg = "第${num+1}行【起始港】不能为空"
							  errorInfo.add(msg);
						}
						else if(startPort?.length() > 255){
							msg = "第${num+1}行【起始港】不能超过255个字符 "
							errorInfo.add(msg);
						}
						data.startPort = startPort
					}catch(e){
						msg = "第${num+1}行【起始港】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					
					try{
						String endPort = row.getCell(2)?.stringCellValue.toString().toUpperCase()?:null
						if(!endPort){
							msg = "第${num+1}行【目的港】不能为空!"
							errorInfo.add(msg);
						}
						else if(endPort?.length() > 255){
							msg = "第${num+1}行 【目的港】不能超过255个字符"
							errorInfo.add(msg);
						}
						data.endPort = endPort
					}catch(e){
						msg = "第${num+1}行【目的港】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					try {
						String shipCompany = row.getCell(3)?.stringCellValue.toString().toUpperCase()?:null;
						if(!shipCompany){
							msg = "第${num+1}行【船公司】不能为空"
							errorInfo.add(msg);
						}
						else if(shipCompany?.length() > 255) {
							msg = "第${num+1}行【船公司】不能超过255个字符"
							errorInfo.add(msg);
						}
						data.shipCompany = shipCompany
					} catch(e) {
						msg = "第${num+1}行【船公司】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					
					def priceParams = [:]
							BigDecimal gp20
							try {
								gp20 = row.getCell(4)?.numericCellValue ? new BigDecimal(row.getCell(4).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行【USD/20GP】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
							if(gp20) {
								priceParams.gp20 = gp20
							}
							BigDecimal gp40
							try {
								gp40 = row.getCell(5)?.numericCellValue ? new BigDecimal(row.getCell(5).numericCellValue) : null;
							} catch(e) {
								 msg = "第${num+1}行【USD/40GP】单元格格式有误，请使用文本格式 "
								 errorInfo.add(msg);
							}
							if(gp40) {
								priceParams.gp40 = gp40
							}
							BigDecimal hq40
							try {
								hq40 = row.getCell(6)?.numericCellValue ? new BigDecimal(row.getCell(6).numericCellValue) : null;
							} catch(e) {
								msg = "第${num+1}行【USD/40HQ】单元格格式有误，请使用文本格式"
								errorInfo.add(msg);
							}
							if(hq40) {
								priceParams.hq40 = hq40
							}
							
							
							
						
						try {
							String extra = row.getCell(8)?.stringCellValue?:null;
							
							if(extra?.length() > 1000) {
								msg = "第${num+1}行【附加费】不能超过1000个字符"
								errorInfo.add(msg);
							}
								priceParams.extra = extra
						} catch(e) {
							 msg = "第${num+1}行【附加费】单元格格式有误，请使用文本格式 "
							 errorInfo.add(msg);
						}
					
						try {
							String shippingDay
							
							shippingDay = row.getCell(9)?.stringCellValue?:null;
							
							if(!shippingDay) {
								msg = "第${num+1}行【船期】不能为空"
								errorInfo.add(msg);
							}
							 else if(shippingDay.length() > 255) {
								msg = "第${num+1}行【船期】不能超过255个字符 "
								errorInfo.add(msg);
							}
							data.shippingDay = shippingDay
						} catch(e) {
							msg = "第${num+1}行【船期】单元格格式有误，请使用文本格式或日期格式 "
							errorInfo.add(msg);
						}
					
						Double shippingDays
						try {
							shippingDays = row.getCell(10)?.numericCellValue ?: null;
						} catch(e) {
							try {
								shippingDays = row.getCell(10)?.stringCellValue ? Double.valueOf(row.getCell(10).stringCellValue) : null
							} catch(e1) {
								msg = "第${num+1}行【航程】单元格格式有误，请使用文本格式或数字格式 "
								errorInfo.add(msg);
							}
						}
						data.shippingDays = shippingDays
						
						String createBy
						try{
							createBy = row.getCell(11)?.stringCellValue?:null;
							
						}catch(e){
							msg = "第${num+1}行【商务】单元格格式有误，请使用文本格式或日期格式 "
							errorInfo.add(msg);
						}
						data.createBy = createBy
						
						
						SimpleDateFormat sdf9 = new SimpleDateFormat("yyyy.MM.dd");
						try{
							String expDate = row.getCell(12)?.stringCellValue?:null;
							if(expDate){
								def start = "2017." + expDate.split("-")[0]
								def end = "2017." + expDate.split("-")[1]
								data.startDate = sdf9.parse(start)
								data.endDate = sdf9.parse(end)
							}else{
								msg = "第${num+1}行【有效日期】不能为空，请使用文本格式或日期格式 "
								errorInfo.add(msg);
							}
							
						}catch(e){
							msg = "第${num+1}行【有效日期】单元格格式有误，请使用文本格式或日期格式 "
							errorInfo.add(msg);
						
						}
						
						
						try {
							String remark = row.getCell(13)?.stringCellValue?:null;
							if(remark?.length() > 500) {
								msg = "第${num+1}行【备注】不能超过500个字符 "
								errorInfo.add(msg);
							}
							data.remark = remark
						} catch(e) {
							msg = "第${num+1}行【备注】单元格格式有误，请使用文本格式')"
							errorInfo.add(msg);
						}
						
						priceParams.gp20Vip = ""
						priceParams.gp40Vip = ""
						priceParams.hq40Vip = ""
						priceParams.cbm = ""
						priceParams.lowestCost = ""
						if(priceParams.size() > 0) {
							data.prices = new ShippingPrices(priceParams)
						}
						data.companyName = "找船商务"
						data.status = Status.VerifyPassed;
						data.releaseNum = releaseNum
						data.fromBy = "商务"
						data.transType = "Whole"
						datas << data
				}
	
				if (datas.size == 0) {
					render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
					return
				}
			if(errorInfo.size() > 0 ){
				render errorInfo
				return;
			}else {
				boolean hasError = false
						def savedDatas = []
						int num = 1
						println datas.size();
						datas.each {
							it.save()
							hasError = it.hasErrors()
							if(!hasError) {
								savedDatas << it
								num++
							}
							return hasError
							}
								if(hasError) {
									CargoShipInformation.deleteAll(savedDatas)
									render(text: "<script>alert('第${num}行保存失败');</script>", contentType: "text/html", encoding: "UTF-8")
									return;
								}
		
				 render (text: "<script>alert('上传成功, 共"+datas.size+"条记录！');</script>", contentType: "text/html", encoding: "UTF-8")
				 //return;
			}
		}
	}
	
	
	/***
	 * 批次管理/运价添加
	 * @return
	 */
	def add(){
		render view: "/${model}/add", model: [settings: getSettings(getMenu('批次管理添加', "/${model}/add"))]
	}
	
	
	/***
	 *  批次管理/运价保存
	 * @return
	 */
	def  bactchSave(){ 
		
		//批号生成Id生成
		SimpleDateFormat sdf1 = new SimpleDateFormat("HHmmss");
		
		def releaseTest = sdf1.format(new Date())
		
		def releaseNum = "P" + releaseTest
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		CargoShipInformation info = new CargoShipInformation()
		
		info.companyName = params.companyName
		info.contactName = params.contactName
		info.phone = params.phone
		info.releaseNum =  releaseNum
		info.status = Status.VerifyPassed
		info.fromBy = "后台"
		/*if(params.serviceId) {
			info.service = BackUser.get(params.serviceId as Long)
		}*/
		
		info.service = BackUser.get("10" as Long)
		info.startPort = params.startPort
		info.endPort =params.endPort
		
		if(params.middlePort){
			info.middlePort = params.middlePort
		}
		info.shippingDays =Integer.parseInt(params.shippingDays)
		info.shipCompany =params.shipCompany
		
		info.transType = params.group2
		
		info.startDate = sdf.parse(params.startDate)
		
		info.endDate =sdf.parse(params.endDate)
		
		if(params.limit_weight){
			info.weightLimit =params.limit_weight
		}
		if(params.remark){
			info.remark = params.remark
		}
			
	   info.shippingDay = params.total_shipping_date
		
		
		info.prices = new ShippingPrices()
		
		if(params.gp20_common_price){
			BigDecimal gp20 = new BigDecimal(params.gp20_common_price)
			info.prices.gp20 = gp20
		}
		if(params.gp20_specical_price){
			BigDecimal gp20Vip = new BigDecimal(params.gp20_specical_price)
			info.prices.gp20Vip = gp20Vip
		}
		if(params.gp40_common_price){
			BigDecimal gp40 = new BigDecimal(params.gp40_common_price)
			info.prices.gp40 = gp40
		}
		if(params.gp40_specical_price){
			BigDecimal gp40Vip = new BigDecimal(params.gp40_specical_price)
			info.prices.gp40Vip = gp40Vip
		}
		if(params.hq40_common_price){
			BigDecimal hq40 = new BigDecimal(params.hq40_common_price)
			info.prices.hq40 = hq40
		}
		if(params.hq40_specical_price){
			BigDecimal hq40Vip = new BigDecimal(params.hq40_specical_price)
			info.prices.hq40Vip = hq40Vip
		}

		if(params.per_price){
			BigDecimal cbm = new BigDecimal(params.per_price)
			info.prices.cbm = cbm
		}
		
		if(params.total_shipextra_date){
			info.prices.extra = params.total_shipextra_date
		}
		
		if(params.min_charge){
			info.prices.lowestCost = params.min_charge
		}
		
		if( !info.save() ) {
			info.errors.each {
			   println it
			}
		}
		info.save()
		if(!info.hasErrors()) {
			flash.msgs = ['保存成功']
			redirect uri: "/tariffManager/bactchList"
		} else {
			//render ([msg: g.message(code: info.errors.allErrors[0].codes[0])] as JSON)
			flash.errors = info.errors
			redirect uri: "/tariffManager/add/"
		}
		
	}
	
	def saveInfoConsuming(Map params,int resultCount, long firstTime){
		println resultCount
		
		if(params.start != null && params.start.trim() != ""){
			saveSearchLog(params,resultCount,firstTime)
		}else if(params.end != null && params.end.trim() != ""){
			saveSearchLog(params,resultCount,firstTime)
		}else if(params.shipCompanys != null && params.shipCompanys.trim() != ""){
			saveSearchLog(params,resultCount,firstTime)
		}
	}
	
	private saveSearchLog(Map params,int resultCount,long firstTime) {
		println resultCount
		def user = springSecurityService.currentUser
		SearchLog sl = new SearchLog();
		sl.startPort = params.start
		sl.endPort = params.end
		sl.shipCompany = params.shipCompanys?params.shipCompanys:"-"
		sl.resultCount = resultCount
		sl.searchUser = user.username
		sl.deleted = false
		sl.searchTime = new Date()
		sl.searchSource = "后台"
		def secendTime = System.currentTimeMillis()
		sl.consuming = (secendTime - firstTime)/1000 + "s";
		sl.save();
		if(sl.hasErrors()) {
			log.info "ERROE: "+sl.errors
		} else {
			log.info "SUCCESS: save this Record"
		}
	}
	
}
