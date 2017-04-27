package com.cdd.front.controller

import java.util.Map;
import java.util.regex.Matcher
import java.util.regex.Pattern

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured





//import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat
import java.text.SimpleDateFormat

import org.hibernate.SQLQuery
import org.hibernate.SessionFactory;
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import org.jsoup.Jsoup
import org.jsoup.select.Elements
import org.springframework.web.client.RestTemplate;

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.AccessLog;
import com.cdd.base.domain.AdvCorporation
import com.cdd.base.domain.ArticleInformation
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.CargoShipScore
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.ImageInformation
import com.cdd.base.domain.LoginLog;
import com.cdd.base.domain.NewComeIn
import com.cdd.base.domain.Order
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.enums.AdvertisementType
import com.cdd.base.enums.ArticleType
import com.cdd.base.enums.ArticleState
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.OrderType
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.cdd.base.json.JsonConverter;
import com.cdd.base.service.common.CRUDService
import com.cdd.base.util.CommonUtils
import com.cdd.front.util.WebServletUtil
import com.cdd.base.constant.CommonArguments
import com.cdd.front.service.RouteService;

import org.apache.commons.lang.StringUtils
@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
class IndexController implements ExceptionHandler {
	def springSecurityService
	
	CRUDService CRUDService 
	SessionFactory sessionFactory
	RouteService routeService
	
	DateFormat yearFormat = new SimpleDateFormat('yyyy');
	DateFormat engMonthFormat = new SimpleDateFormat("MMM",Locale.ENGLISH);
	DateFormat dayFormat = new SimpleDateFormat("dd");
	
	JsonConverter jsonConverter = new JsonConverter()
	
	RestTemplate client = new RestTemplate()
	
	long lastFinanceRateTime = 0;
	
	String financeRate = "";
	List <Object> bdiWeekReport = null; 
	Map <String,String> bdiDayReport = null;
	
	def index(){
		redirect url:"/"
	}
	 
	
	def advInfo() {
		def map = [data: [:]]
		
		// 图片轮询，取前4张
		def list = CRUDService.list(ImageInformation, [offset: 0, max: 10, sort: 'order', order: 'asc'])?.list
		map.data.imageInfos = []
		list?.each { data ->
			map.data.imageInfos << CommonUtils.tranferToMap(data)
		}
		map.data.article = [:]
		list = CRUDService.list(ArticleInformation, [offset: 0, max: 1, f_isNotNull_image: null])
			{
					and {
						like "articleCategory", "%特推%"
					}
					and {
						eq   "articleState" , ArticleState.valueOf("Issue")
					}
			}
		if(list.totalCount == 0){
			list = CRUDService.list(ArticleInformation, [offset: 0, max: 1, f_isNotNull_image: null]){
				and {
					eq   "articleState" , ArticleState.valueOf("Issue")
				}
			}
		}
		map.data.article.imageInfo = null
		if(list) {
			map.data.article.imageInfo = CommonUtils.tranferToMap(list[0])
		}
		
		[
			// 外贸列表
			[name: 'ftlist', type: ArticleType.ForeignTrade],
			// 运输列表
			[name: 'tplist', type: ArticleType.Transportation],
			// 公司列表
			[name: 'comlist', type: ArticleType.Company],
		].each { item ->
			map.data.article."${item.name}" = []
			list = CRUDService.list(ArticleInformation, [offset: 0, max: 6, sort: 'issueDate', order: 'desc'])
			{	
				and{
					eq "articleType" , item.type
				}
				and {
					like "articleCategory", "%置顶%"
				}
				and {
					eq   "articleState" , ArticleState.valueOf("Issue")
				}
			}?.list
			if(list.size() == 0){
				//list = CRUDService.list(ArticleInformation, [offset: 0, max: 6, sort: 'lastUpdated', order: 'desc', 'f_articleType': item.type]){
				list = CRUDService.list(ArticleInformation, [offset: 0, max: 6, sort: 'issueDate', order: 'desc'])
				{
					and{
						eq "articleType" , item.type
					}
					and {
						eq   "articleState" , ArticleState.valueOf("Issue")
					}
				}?.list
			}else if(list.size()  < 6 && list.size() > 0 ){
				def  restCount = 6 - list.size()
				//def ll = CRUDService.list(ArticleInformation, [offset: 0, max: restCount, sort: 'lastUpdated', order: 'desc', 'f_articleType': item.type]){
				def ll = CRUDService.list(ArticleInformation, [offset: 0, max: restCount, sort: 'issueDate', order: 'desc']){
					and {
						//like    "articleCategory", "%特推%"
						isNull   "articleCategory"
					}
					and{
						eq   "articleType" , item.type
					}
					and {
						eq   "articleState" , ArticleState.valueOf("Issue")
					}
				}?.list
				list.addAll(ll)
			}
			list?.each { data ->
				
				Map dataMap = CommonUtils.tranferToMap(data);
				
				dataMap["dateCreatedStr"] =  data.issueDate ? new SimpleDateFormat('MM-dd').format(data.issueDate) : (data.issueDate ? new SimpleDateFormat('MM-dd').format(data.issueDate): "");
				
				map.data.article."${item.name}" << dataMap
				
			}
		}
		render (map as JSON)
	}
	
	
	
	def dataInfo() {
		def map = [data: [:]]
		
		setCargoShip(map);
		
		setCargo(map);
		
		render (map as JSON)
	}
	
	
	def dataInfoSix(){
		def map = [data: [:]]
		
		setCargoShip(map);
		
		//setCargo(map);
		//render (view:'/special/index',model:[map:map])
		render ([map:map] as JSON)
	}
	
	
	def setCargoShip(map) {
		
		params.offset = 0
		params.max = 8
		params.sort = "dateCreated";
		params.order = "desc";
		params.f_groupProperty_startPort = null;
		params.f_groupProperty_endPort = null;
		
		Date today = new Date();
		
		//def result = routeService.group()
		
		def queryHandler =  {
//			ge 'endDate', today-1
			eq "status", Status.VerifyPassed
			eq "showOnIndex", true
		}
		
		def result = CRUDService.list(CargoShipInformation, params, queryHandler)
		def verified
		if(springSecurityService.currentUser){
		FrontUser user = springSecurityService.currentUser
		 	verified =user.verified
		}else{
			verified =false
		}
		def cargoShipList = result?.collect {
			def data = [:]
			data.infoId = it.id;
			data.startPort = it.startPort;
			data.endPort = it.endPort;
			data.shipCompany = it.shipCompany;
			data.shippingDay = it.shippingDay;
			data.shippingDays = it.shippingDays;
			data.startDate = it.startDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.startDate) : it.startDate
			data.endDate = it.endDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.endDate) : it.endDate
			data.gp20 = it.prices ? it.prices.gp20 : 0;
			data.gp20Vip = it.prices ? it.prices.gp20Vip : 0;
			data.gp40 = it.prices ? it.prices.gp40 : 0;
			data.gp40Vip = it.prices ? it.prices.gp40Vip : 0;
			data.hq40 = it.prices ? it.prices.hq40 : 0;
			data.hq40Vip = it.prices ? it.prices.hq40Vip : 0;
			return data;
		}
		

		map.data.cargoShip = [:]
		map.data.cargoShip.list = cargoShipList;
		map.data.cargoShip.verified =verified
		map.data.cargoShip.orders = [];
		def orderList = CRUDService.list(Order, [offset: 0, max: 20]) {
			eq "status", Status.VerifyPassed
			or {
				eq "orderStatus", OrderStatus.TradeSuccess
				eq "orderStatus", OrderStatus.CertUploaded
				eq "orderStatus", OrderStatus.CertInVerify
				eq "orderStatus", OrderStatus.CertPassed
				eq "orderStatus", OrderStatus.CertUnupload
				eq "orderStatus", OrderStatus.CertFailed
			}
		}?.list
		orderList?.each { it ->
			def orderData = [:]
			orderData.startPort = it.startPort
			if (it.owner) {
				orderData.contactName = it.owner.firstname
			} else {
				orderData.contactName = it.contactName
			}
			if (orderData.contactName != null && orderData.contactName.length() > 1) {
				orderData.contactName = nameTransfer(orderData.contactName);
			}
			
			orderData.startPort = it.startPort
			orderData.endPort = it.endPort
			orderData.startDate = it.startDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.startDate) : it.startDate
			orderData.endDate = it.endDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.endDate) : it.endDate
			
			// 暂时的逻辑
			Calendar c = Calendar.getInstance()
			c.setTime(it.lastUpdated)
			if(c.get(Calendar.DATE) > 24) {
				c.set(Calendar.DATE, 24)
			}
			c.set(Calendar.MONTH, Calendar.AUGUST)
			
			orderData.lastUpdated = it.lastUpdated ? new SimpleDateFormat('MM-dd').format(it.lastUpdated) : it.lastUpdated
			
			map.data.cargoShip.orders << orderData;
		}
		
		// 广告位
		def advlist = CRUDService.list(AdvCorporation, [offset: 0, max: 6, sort: 'order', order: 'asc', 'f_type': AdvertisementType.CargoShip])?.list
		map.data.cargoShip.imageInfos = []
		advlist?.each { data ->
			map.data.cargoShip.imageInfos << CommonUtils.tranferToMap(data)
		}
	}
	
	protected def getCargoShipScore(it) {
		def map = [:]
		CargoShipScore data = CargoShipScore.findByCompanyName(it)
		if (data) {
			DecimalFormat df = new DecimalFormat("0.0");
			map = [shipInTime: df.format(data.shipInTime), docInTime: df.format(data.docInTime), infoInTime: df.format(data.infoInTime), serviceQuality: df.format(data.serviceQuality), serviceContent: df.format(data.serviceContent)]
		}
		return map;
	}

	
	def setCargo(map) {
		[
			// 家具信息
			[name: 'furniture', table: Order, orderType: OrderType.Furniture, advType: AdvertisementType.Furniture],
			// 建材信息
			[name: 'building', table: Order, orderType: OrderType.Building, advType: AdvertisementType.Building],
			// 服装信息
			[name: 'clothing', table: Order, orderType: OrderType.Clothing, advType: AdvertisementType.Clothing],
			// 拼箱信息
			[name: 'pinxiang', table: Order, orderType: OrderType.Other, advType: AdvertisementType.Other],
		].each { item ->
			// 列表
			map.data."${item.name}" = [:]
			
			Date today = new Date();
			
			
			def queryHandler =  {
				eq "status", Status.VerifyPassed
				if(OrderType.Other != item.orderType) {
					eq "orderType", item.orderType.text
				} else {
					eq "transType", TransportationType.Together
				}
				
				//or {
					//ge 'biteEndDate', today-1
					//isNull 'biteEndDate'
				//}
				
				or {
					isNull "orderStatus"
					eq "orderStatus", OrderStatus.UnTrade
					eq "orderStatus", OrderStatus.InTrade
				}
			}
			
			map.data."${item.name}".list = []
			def list = CRUDService.list(item.table, [offset: 0, max: 6, sort: 'dateCreated',
				order: 'desc'], queryHandler)?.list
			list?.each { it ->
				
				
				
				def orderData = [:]
				orderData.orderId = it.id;
				orderData.startPort = it.startPort
				orderData.endPort = it.endPort
				
				if (it.startDate && it.endDate && yearFormat.format(it.startDate).equals(yearFormat.format(it.endDate))) {
					orderData.startDate = it.startDate ? new SimpleDateFormat('MM.dd').format(it.startDate) : it.startDate
					orderData.endDate = it.endDate ? new SimpleDateFormat('MM.dd').format(it.endDate) : it.endDate
				} else {
					orderData.startDate = it.startDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.startDate) : it.startDate
					orderData.endDate = it.endDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.endDate) : it.endDate
				}
				
				orderData.cargoName = it.cargoName;
				orderData.cargoNums = it.cargoNums
				orderData.cargoWeight = it.cargoWeight
				orderData.cargoCube = it.cargoCube
				orderData.cargoWidth = it.cargoWidth
				orderData.cargoHeight = it.cargoHeight
				orderData.cargoLength = it.cargoLength
				
				def transType = "";
				if (it.transType) {
					switch(it.transType) {
						case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
						case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
					}
				}
				orderData.transType = transType;
				
				
				def cargoBoxType = "";
				if (it.cargoBoxType) {
					switch(it.cargoBoxType) {
						case CargoBoxType.GP20.name() : cargoBoxType = CargoBoxType.GP20.text; break;
						case CargoBoxType.GP40.name() : cargoBoxType = CargoBoxType.GP40.text; break;
						case CargoBoxType.HQ40.name() : cargoBoxType = CargoBoxType.HQ40.text; break;
						case CargoBoxType.HQ45.name() : cargoBoxType = CargoBoxType.HQ45.text; break;
					}
				}
				orderData.cargoBoxType = cargoBoxType;
				orderData.cargoBoxNums = it.cargoBoxNums;
				
				map.data."${item.name}".list << orderData
			}
			
			
			// 订单动态
			map.data."${item.name}".orders = []
			if(OrderType.Other != item.orderType) {
				list = CRUDService.list(Order, [offset: 0, max: 20, sort: 'lastUpdated', order: 'desc', f_status:Status.VerifyPassed, f_orderType:item.orderType.text])?.list
			} else {
				list = CRUDService.list(Order, [offset: 0, max: 20, sort: 'lastUpdated', order: 'desc', f_status:Status.VerifyPassed, f_transType:TransportationType.Together])?.list
			}
			list?.each { it ->
				
				def orderData = [:]
				orderData.startPort = it.startPort
				if (it.owner) {
					orderData.contactName = it.owner.firstname
				} else {
					orderData.contactName = it.contactName
				}
				if (orderData.contactName != null && orderData.contactName.length() > 1) {
						orderData.contactName = nameTransfer(orderData.contactName);
				}
				orderData.startPort = it.startPort
				orderData.endPort = it.endPort
				orderData.startDate = it.startDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.startDate) : it.startDate
				orderData.endDate = it.endDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.endDate) : it.endDate
				orderData.lastUpdated = it.lastUpdated ? new SimpleDateFormat('MM-dd').format(it.lastUpdated) : it.lastUpdated
				
				orderData.orderStatus = it.orderStatus
				
				map.data."${item.name}".orders << orderData;
				
				
			}
			// 广告位
			def advlist = CRUDService.list(AdvCorporation, [offset: 0, max: 6, sort: 'order', order: 'asc', 'f_type': item.advType])?.list
			map.data."${item.name}".imageInfos = []
			advlist?.each { data ->
				map.data."${item.name}".imageInfos << CommonUtils.tranferToMap(data)
			}
		}
	}
	
	def newComeIn() {
		NewComeIn manualData = CRUDService.getFirst(NewComeIn, [f_manual: true])
		NewComeIn data = CRUDService.getFirst(NewComeIn, [f_manual: false])
		if(manualData && data && manualData.lastUpdated.compareTo(data.lastUpdated) > 0) {
			data = manualData
		}
		def map = [:]
		Date date = new Date();
		map.day = dayFormat.format(date);
		map.month = engMonthFormat.format(date);
		if(data) {
			map.agent = data.agent
			map.orders = data.orders
		} else {
			map.agent = 0
			map.orders = 0
		}
		
		getCurrency();
		
		map.rate = financeRate;
		map.BIDWeek = bdiWeekReport;
		map.BIDDay = bdiDayReport;
		render map as JSON
	}
	String nameTransfer(String contactName) {
		if( contactName.startsWith("M")){
			String[] split =  contactName.split("\\s+");
			 contactName=split[split.length-1]+"**";
		}else if( contactName.matches("[a-zA-Z]*")){
			 contactName= contactName+"**";
		}else {
			 contactName= contactName.substring(0, 1)+"**";
		}
		return contactName
	}
	def getCurrency() {
		//15分钟读一次
		long currentTimeMillis = System.currentTimeMillis();
		if (currentTimeMillis - lastFinanceRateTime > 60 * 60 * 1000) {
			lastFinanceRateTime = currentTimeMillis;
			bdiWeekReport = client.getForObject("http://www.cnss.com.cn/caches/task/exponent/bdi/week.json?v=1444633254907", List.class);
			bdiDayReport = client.getForObject("http://www.cnss.com.cn/caches/task/exponent/bdi/day.json?v=1444890675955", Map.class);
			String response = client.getForObject("http://api.k780.com:88/?app=finance.rate&scur=USD&tcur=CNY&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4", String.class);
			if (response) {		
				if(log.debugEnabled) {
					log.debug response
				}			
				Map<String, Object> map = jsonConverter.toMap(response);
				if (map && map.result && map.result.rate) {
					financeRate = map.result.rate;
				}
			}
		}
		
		
	}
	
	//ship   list  借口
	
	def shipList() {
		
				if (!params.sort) {
					params.sort = "dateCreated";
					params.order = "desc";
				}
				switch(params.sort) {
					case 'gp20': params.sort = "prices.gp20"
						break
					case 'gp40': params.sort = "prices.gp40"
						break
					case 'hq40': params.sort = "prices.hq40"
						break
					case 'hq45': params.sort = "prices.hq45"
						break
				}
				SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		
				Date today = new Date();
		
				def queryHandler =  {
					
				}
				
				
				def result = CRUDService.list(CargoShipInformation, params, queryHandler)
				def total = result.totalCount;
				def list = result?.list.collect {
					def data = [:]
					data.infoId = it.id
					data.startPort = it.startPort
					data.endPort = it.endPort
					data.startPortCn = it.startPortCn
					data.endPortCn = it.endPortCn
					data.startDate = it.startDate ? new SimpleDateFormat('yyyy.MM.dd').format(it.startDate) : it.startDate
					data.endDate = it.endDate ? new SimpleDateFormat('yyyy.MM.dd').format(it.endDate) : it.endDate
					data.issueDaysAgo = new Date().date - it.dateCreated.date
					data.shipCompany = it.shipCompany
					data.shippingDay = it.shippingDay
					data.shippingDays = it.shippingDays
					data.middlePort = it.middlePort
					data.middlePortCn = it.middlePortCn
		
					data.pinServiceType = it.pinServiceType;
		
					data.gp20 = it.prices ? it.prices.gp20 : 0;
					data.gp20Vip = it.prices ? it.prices.gp20Vip : 0;
					data.gp40 = it.prices ? it.prices.gp40 : 0;
					data.gp40Vip = it.prices ? it.prices.gp40Vip : 0;
					data.hq40 = it.prices ? it.prices.hq40 : 0;
					data.hq40Vip = it.prices ? it.prices.hq40Vip : 0;
					data.cbm = it.prices ? it.prices.cbm : 0;
					data.lowestCost = it.prices ? it.prices.lowestCost : '';
		/*
					def transType1 = "";
					if (it.transType) {
						switch(it.transType) {
							case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
							case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
						}
					}
					data.transType = transType;*/
						//报错：No row with the given identifier exists（应该是数据错误）
					/*if (it.owner) {
						data.companyName = it.owner.companyName
					} else {
						data.companyName = it.companyName
					}*/
		
					/*if (it.owner) {
						data.contactName = it.owner.firstname
					} else {
						data.contactName = it.contactName
					}*/
					if (data.contactName != null && data.contactName.length() > 1) {
						data.contactName = data.contactName.substring(0, 1)+"**";
					}
		
					data.companyFullName = data.companyName
					if (data.companyName != null && data.companyName.length() > 11) {
						data.companyName = data.companyName.substring(0, 11)+"...";
					}
		
					if (data.companyName) {
						data.score =  getCargoShipScoreInfo(it.owner, data.companyName);
					}
		
					//屏蔽公司名称
					data.companyName = "**公司"
					data.companyFullName = "**公司"
		
					return data
				}
		
				render ([total: total, rows: list] as JSON)
		
		
			}
	
	def shipList2(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		/*if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}*/
		String start
		String end
		String middle
		//String box
		def transType
		if(params.start){
			start=params.start.toUpperCase()
			print start+"---------start"
		}
		if(params.end){
			end=params.end.toUpperCase()
		}
		if(params.middle){
			middle=params.middle.toUpperCase()
		}
		if(params.transType){
			//print params.transType
			switch(params.transType){
				case "Whole":
				transType=TransportationType.Whole;
				break;
				case "Together":
				transType=TransportationType.Together;
				break;
			}
		}
		String searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		

		def result = CRUDService.list(CargoShipInformation, params) {
			if(params.status) {
				print params.status
				eq "status", Status.valueOf(params.status)
			}
			//eq "service", springSecurityService.currentUser
			if(searchKey) {
				or {
					like "routeName", searchKey
					like "companyName", searchKey
					like "contactName", searchKey
				}
			}
			if(params.yjnumber){
				or {
					eq "id", params.yjnumber as Long
				}
			}
			if(params.createman){
				and{
					like "createBy", "%${params.createman}%"
				}
				
			}
			if(params.createtime){
				and{
					SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd")
					def date1=sdf5.parse(params.createtime)
					def date2=sdf5.parse(params.createtime)+1
					between ("dateCreated", date1,date2)
				}
			}
			if(params.hx){
				and{
					like "routeName",params.hx+"%"
				}
			}
			if(params.company){
				and{
					like "companyName","%${params.company}%"
				}
			}
			if(params.chuancompany){
				and{
					like "shipCompany","%${params.chuancompany}%"
				}
			}
			
			if(start){
				and {
					like "startPort", start+"%"
				}
			}
			if(middle){
				//print middle
				and{
					like "middlePort",middle+"%"
				}
			}
			if(end){
				and {
					like "endPort", end+"%"
				}
			}
			if(transType){
				and {
					eq "transType", transType
				}
			}
			if(params.hc){
				and{
					eq "shippingDays",params.hc as int
				}
			}
			if(params.cityId){
				and{
					eq "city", City.get(params.cityId as Long) //params.cityId
				}
			}
			if(params.contact){
				and{
					like "contactName", "%${params.contact}%"
				}
			}
			if(params.starttime||params.endtime){
				SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf5.parse(params.starttime);
				def date2=sdf5.parse(params.endtime);
				and{
					between("startDate",date1,date2)
				}
			}
			eq 'deleted', false
		}

		def map = [rows: [], total: result.totalCount]
		result.list.each { 
			def data = [:]
					data.infoId = it.id
					data.startPort = it.startPort
					data.endPort = it.endPort
					data.startPortCn = it.startPortCn
					data.endPortCn = it.endPortCn
					data.startDate = it.startDate ? new SimpleDateFormat('yyyy.MM.dd').format(it.startDate) : it.startDate
					data.endDate = it.endDate ? new SimpleDateFormat('yyyy.MM.dd').format(it.endDate) : it.endDate
					data.issueDaysAgo = new Date().date - it.dateCreated.date
					data.shipCompany = it.shipCompany
					data.shippingDay = it.shippingDay
					data.shippingDays = it.shippingDays
					data.middlePort = it.middlePort
					data.middlePortCn = it.middlePortCn
		
					data.pinServiceType = it.pinServiceType;
		
					data.gp20 = it.prices ? it.prices.gp20 : 0;
					data.gp20Vip = it.prices ? it.prices.gp20Vip : 0;
					data.gp40 = it.prices ? it.prices.gp40 : 0;
					data.gp40Vip = it.prices ? it.prices.gp40Vip : 0;
					data.hq40 = it.prices ? it.prices.hq40 : 0;
					data.hq40Vip = it.prices ? it.prices.hq40Vip : 0;
					data.cbm = it.prices ? it.prices.cbm : 0;
					data.lowestCost = it.prices ? it.prices.lowestCost : '';
					data.extra = it.prices ? it.prices.extra : '';
		
					//def transType = "";
					if (it.transType) {
						switch(it.transType) {
							case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
							case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
						}
					}
					data.transType = transType;
			map.rows << data
		}
//		 println box+"box"
//		 println map.total
		render map as JSON
	}
	
	def ossDomains(){
		def ossDomain = "${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}/"
		render ([ossDomain:ossDomain] as JSON)
	}
	
	
	def execute(){
		SQLQuery query1 = sessionFactory.currentSession.createSQLQuery("""
					DELETE FROM ship_prices WHERE info_id IN (SELECT id FROM cargo_ship_information WHERE cargo_ship_information.company_name = "深圳市长帆国际物流有限公司")
				""")
		println "price ok!"
		query1.executeUpdate();
		
		SQLQuery query2 = sessionFactory.currentSession.createSQLQuery("""
					DELETE FROM cargo_ship_information where cargo_ship_information.company_name = "深圳市长帆国际物流有限公司"			
				""")

		query2.executeUpdate();
		println "ship ok!"
		
		
		String url3 = "http://218.18.53.97:8100/sbToTracking/ToTrancking.ashx?tenantid=9856C38FFB5F4D8A"
		def json2 = client.postForObject(url3, null, String.class)
		def data2 = JSON.parse(json2)
		def total = data2.getAt("total")
		int maxPage = total/200
		println maxPage
		
		for(int PageId = 1;PageId<=maxPage;PageId++){
			println "页数"+PageId
		String url = "http://218.18.53.97:8100/sbToTracking/ToTrancking.ashx?tenantid=9856C38FFB5F4D8A&PageId="+PageId
		def json = client.postForObject(url, null, String.class)
		def data = JSON.parse(json)
		println data.getAt("rows").size()
		for(int i = 0;i<data.getAt("rows").size();i++){
			CargoShipInformation ship = new CargoShipInformation()
			try{
				ship.startPort = data.getAt("rows")[i].getAt("QiYunGang")
				ship.endPort = data.getAt("rows")[i].getAt("MuDiGang")
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd")
				ship.startDate = sdf2.parse(data.getAt("rows")[i].getAt("StartTime"))
				if(data.getAt("rows")[i].getAt("ZhongZhuanGang")){
				ship.middlePort = data.getAt("rows")[i].getAt("ZhongZhuanGang")}
				ship.routeName = data.getAt("rows")[i].getAt("HangXian")
				ship.shippingDay = data.getAt("rows")[i].getAt("HangQi")
				ship.endDate = sdf2.parse(data.getAt("rows")[i].getAt("EndTime"))
				ship.shipCompany = data.getAt("rows")[i].getAt("ChuanDong")
				ship.remark = data.getAt("rows")[i].getAt("ChengYunBeiZhu")?:"null"
				ship.status = "VerifyPassed"
				ship.transType = "Whole"
				ship.companyName = "深圳市长帆国际物流有限公司"
				ship.createBy = "cailie"
				ship.updateBy = "cailie"
				ShippingPrices newPrices = new ShippingPrices()
				ship.prices = newPrices
				ship.prices.gp20 = data.getAt("rows")[i].getAt("t1").toBigDecimal()-100
				ship.prices.gp40 = data.getAt("rows")[i].getAt("t2").toBigDecimal()-100
				ship.prices.hq40 = data.getAt("rows")[i].getAt("t3").toBigDecimal()-100
				ship.prices.createBy = "cailie"
				ship.prices.updateBy = "cailie"
			}catch(Exception e){
					//println data.getAt("rows")[i].getAt("StartTime");
					//println data.getAt("rows")[i].getAt("EndTime")
					continue;
			}
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
		}
		
	}
	}	
	def getIp(){
		/*def ip
		def address
		InetAddress addr = InetAddress.getLocalHost();
		 ip=addr.getHostAddress();//获得本机IP
		 address=addr.getHostName();//获得本机名称
		 println ip
		 println address
		 if(ip=="120.25.103.111"){
			 println ip
		 }*/
		def ip = WebServletUtil.getRemoteAddr(request)
		//def data = [:]
		//data.ip = ip
		//render data as JSON
		return ip
	}
	def testAccessLog() {
		
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		SimpleDateFormat sdf2 = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
		Date date = new Date()
		def today = sdf.format(date)
		println today
		def filePath ="E:\\tomcat-front\\logs\\localhost_access_log."+today+".txt"
		//def filePath ="/opt/tomcat-front/logs/localhost_access_log."+today+".txt"
		File file = new File(filePath);
		if (file.isFile() && file.exists()) {
			try {
				InputStreamReader read = new InputStreamReader(new FileInputStream(file), "UTF-8");
				BufferedReader reader = new BufferedReader(read);
				String line;
				try {
									  //循环，每次读一行
					while ((line = reader.readLine()) != null) {
						AccessLog accessLog = new AccessLog()
						if(line.split("&&&")[0].size()<3){
							continue
						}else{
							accessLog.ip = line.split("&&&")[0]
						}
						String url = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip="+accessLog.ip
						def jsonData = client.postForObject(url, null, String.class)
						def data = JSON.parse(jsonData)
						accessLog.city = data.getAt("city")
						accessLog.url =StringUtils.substringBetween(line.split("&&&")[1],"GET","HTTP");
						
						
						def username = LoginLog.findByIp(accessLog.ip)?.username
						if(username){
							accessLog.visitor = username
							accessLog.type = "登录用户"
						}else{
							if(line.split("&&&")[2].indexOf("Baiduspider")!=-1){
								accessLog.visitor = "百度蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("360Spider")!=-1){
								accessLog.visitor = "360蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("bingbot")!=-1){
								accessLog.visitor = "bing蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("Sogou")!=-1){
								accessLog.visitor = "Sogou蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("Googlebot")!=-1){
								accessLog.visitor = "Google蜘蛛"
								accessLog.type = "搜索引擎"
							}
							else{
								accessLog.visitor = "游客"
								accessLog.type = "游客"
							}
						}
						def time = line.split("&&&")[3]
						accessLog.time = sdf2.parse(time)
						accessLog.createBy = "cailie"
						accessLog.updateBy = "cailie"
						if( !accessLog.save() ) {   accessLog.errors.each {        println it   }}
						accessLog.save(flush:true);
					}
					reader.close();
					read.close();
				} catch (IOException e) {
					e.printStackTrace();
				}

			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	def jsoupTest() {
		def url = "http://www.100allin.com/fcl/list----0-0-0-----1.html"
		 Document doc = Jsoup.connect(url).timeout(4000).get();
		 Elements elements = doc.select("div.box-bd > ul >li")
		 for(Element element:elements) {
			CargoShipInformation ship = new CargoShipInformation()
			
			ship.startPort = element.select("div.port > div").first().text()
			ship.endPort = element.select("div.port > div").last().text()
			
			String[] array1 = element.select("div.range").text().split("[\\D]+");
			println array1[1]
			ship.shippingDays = Integer.parseInt(array1[1])   
			ship.shippingDay = element.select("div.date").text()
			
			
			
			String reg = "[\u4e00-\u9fa5]";
			def endDate = element.select("div.valid").text().replaceAll(reg, "");
			SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
			Date today = new Date();
			ship.startDate = today
			ship.endDate = sdf.parse(endDate)
			ship.shipCompany = element.select("div.carrier").text()
			ship.companyName = element.select("div.company").text()
			ship.status = "VerifyPassed"
			ship.transType = "Whole"
			ship.fromBy = "后台"
			ship.releaseNum = "P6666"
			ship.createBy = "cailie"
			ship.updateBy = "cailie"
			ShippingPrices newPrices = new ShippingPrices()
			ship.prices = newPrices
			if(element.select("div.freight > dl:eq(0)>dd").text()){
				ship.prices.gp20 = element.select("div.freight > dl:eq(0)>dd").text()?.toBigDecimal()
			}
			if(element.select("div.freight > dl:eq(2)>dd").text()){
				ship.prices.gp40 = element.select("div.freight > dl:eq(2)>dd").text()?.toBigDecimal()
			}
			if(element.select("div.freight > dl:eq(4)>dd").text()){
				ship.prices.hq40 = element.select("div.freight > dl:eq(4)>dd").text()?.toBigDecimal()
			}
			ship.prices.createBy = "cailie"
			ship.prices.updateBy = "cailie"
			ship.prices.extra = "详情请咨询客服！"
			println "=========="
			if( !ship.save() ) {   ship.errors.each {        println it   }}
			ship.save(flush:true);
		}
	}
}
