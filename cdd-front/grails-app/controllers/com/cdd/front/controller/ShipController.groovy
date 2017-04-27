package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.mail.MailService;
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.Date;
import java.util.Map;

import net.sf.ehcache.search.expression.Between;

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
import com.cdd.base.domain.ShippingPrices
import com.cdd.base.domain.User
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.OrderType
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.common.CRUDService
import com.cdd.front.constant.Constant
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.SearchLog

import grails.plugin.mail.MailService;
class ShipController implements ExceptionHandler {
	
	CRUDService CRUDService
	
	MailService mailService
	def grailsApplication
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def issue() {
		/*
		 * @author cailie
		 * @date 2015/12/25
		 */
		//批号生成Id生成
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		def releaseNum = sdf1.format(new Date())
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		boolean isLoggedIn = springSecurityService.isLoggedIn();
		CargoShipInformation info = new CargoShipInformation()
		FrontUser user = springSecurityService.currentUser
		info.owner = user;
		info.contactName = user.firstname
		info.companyName = user.companyName
		info.phone = user.username
		info.status = Status.UnVerify;
		info.endDate =sdf.parse(params.endDate)
		info.endPort =params.endPort
		if(params.middlePort){
		info.middlePort = params.middlePort
		}
		if(params.remark){
		info.remark = params.remark
		}
		info.shipCompany =params.shipCompany
		info.shippingDay = params.total_shipping_date

		info.shippingDays =Integer.parseInt(params.shippingDays)

		info.startDate = sdf.parse(params.startDate)
		info.startPort = params.startPort
		info.status = Status.UnVerify
		info.transType = params.box_style
		info.releaseNum = releaseNum
		//info.service = BackUser.get("10" as Long)
		if(params.limit_weight){
		info.weightLimit =params.limit_weight
		}
		info.prices = new ShippingPrices()
		if(params.total_local_cost){
			info.prices.extra = params.total_local_cost
			}
		if(params.gp20_commom_price){
			BigDecimal gp20 = new BigDecimal(params.gp20_commom_price)
			info.prices.gp20 = gp20
		}
		if(params.gp40_commom_price){
		BigDecimal gp40 = new BigDecimal(params.gp40_commom_price)
		info.prices.gp40 = gp40
		}
		if(params.hq40_commom_price){
		BigDecimal hq40 = new BigDecimal(params.hq40_commom_price)
		info.prices.hq40 = hq40
		}
		if(params.gp20_specical_price){
		BigDecimal gp20Vip = new BigDecimal(params.gp20_specical_price)
		info.prices.gp20Vip = gp20Vip
		}
		if(params.gp40_specical_price){
		BigDecimal gp40Vip = new BigDecimal( params.gp40_specical_price)
		info.prices.gp40Vip = gp40Vip
		}
		if(params.hq40_specical_price){
		BigDecimal hq40Vip = new BigDecimal(params.hq40_specical_price)
		info.prices.hq40Vip = hq40Vip
		}
		if(params.per_price){
		BigDecimal cbm = new BigDecimal(params.per_price)
		info.prices.cbm = cbm
		}
		if(params.min_charge){
		info.prices.lowestCost = params.min_charge
		}
		info.fromBy = "前台"
		if( !info.save() ) {   info.errors.each {        println it   }}
		info.save(flush:true)
		if(!info.hasErrors()) {
			render view:"/member/shiplist"
		} else {
			render ([msg: g.message(code: info.errors.allErrors[0].codes[0])] as JSON)
		}
	}
	
	/***
	 * 运价上传
	 */
	int maxSize = 1024 * 1024 * 1 // 1MB maximum
	@Secured('ROLE_SHIP_AGENT')
	def issueBatch() {
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		def releaseNum = sdf1.format(new Date())
		
		
		def file = request.getFile('xls')
		if(file.size > maxSize) {
			render(text: "<script>alert('文件不能超过1MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		String name = file.fileItem.fileName
		if(!name.endsWith('.xls')) {
			render(text: "<script>alert('只接受xls文件');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		HSSFWorkbook wb = new HSSFWorkbook(file.inputStream)
		HSSFSheet sheet = wb.getSheetAt(0)
		int rowCount = sheet.physicalNumberOfRows
		List<String>  errorInfo = new ArrayList<String>();
		
		if(rowCount < 1) {
			render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
			return ;
		} else {
			def datas = []

			String msg //公共字段
			
			String sumCount
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
			
			Map aa = [:]
			
			int count;
			
			for (int i=0; i<rowCount-1; i++) {

				CargoShipInformation data = new CargoShipInformation()
				
				int pos = i + 1
				
				HSSFRow row = sheet.getRow(pos)
				
				try {
					String routeName = row.getCell(0)?.stringCellValue?:null
							
					 if(routeName?.length() > 255) { 
						 msg = "第${pos+1}行【航线名称】不能超过255个字符"
						 errorInfo.add(msg);
					}
					data.routeName = routeName
				} catch(e) {
					msg = "第${pos+1}行【航线名称】单元格格式有误，请使用文本格式 "
					errorInfo.add(msg);
				}
				
				try {
					String startPort = row.getCell(1)?.stringCellValue.toString().toUpperCase()?:null
					if(!startPort) {
						msg = "第${pos+1}行【起始港(英文)】不能为空"
						errorInfo.add(msg);
					} else if(startPort.length() > 255) {
						 msg = "第${pos+1}行【起始港(英文)】不能超过255个字符 "
						 errorInfo.add(msg);
					}
					data.startPort = startPort
				} catch(e) {
					msg = "第${pos+1}行【起始港(英文)】单元格格式有误，请使用文本格式 "
					errorInfo.add(msg);
				}
			
				try {
					String endPort = row.getCell(2)?.stringCellValue.toString().toUpperCase()?:null
					if(!endPort) {
						msg = "第${pos+1}行【目的港(英文)】不能为空"
						errorInfo.add(msg);
					} else if(endPort.length() > 255) {
						msg = "第${pos+1}行【目的港(英文)】不能超过255个字符"
						errorInfo.add(msg);
					}
					data.endPort = endPort
				} catch(e) {
					 msg = "第${pos+1}行【目的港(英文)】单元格格式有误，请使用文本格式 "
					 errorInfo.add(msg);
				}

				try {
					String startPortCn = row.getCell(3)?.stringCellValue?:null;
					if(!startPortCn) {
						msg = "第${pos+1}行【起始港(中文)】不能为空"
						errorInfo.add(msg);
					} else if(startPortCn.length() > 255) {
						msg = "第${pos+1}行【起始港(中文)】不能超过255个字符"
						errorInfo.add(msg)
					}
					data.startPortCn = startPortCn
				} catch(e) {
					msg = "第${pos+1}行【起始港(中文)】单元格格式有误，请使用文本格式 "
					errorInfo.add(msg)
				}

				try {
					String endPortCn = row.getCell(4)?.stringCellValue?:null;
					if(!endPortCn) {
						msg = "第${pos+1}行【目的港(中文)】不能为空"
						errorInfo.add(msg)
					} else if(endPortCn.length() > 255) {
						msg = "第${pos+1}行【目的港(中文)】不能超过255个字符 "
						errorInfo.add(msg)
					}
					data.endPortCn = endPortCn
				} catch(e) {
					msg = "第${pos+1}行【目的港(中文)】单元格格式有误，请使用文本格式 "
					errorInfo.add(msg)
				}

				try {
					String middlePort = row.getCell(5)?.stringCellValue.toString().toUpperCase()?:null
					if(middlePort?.length() > 255) {
						msg = "第${pos+1}行【中转港(英文)】不能超过255个字符 "
						errorInfo.add(msg);
					}
					data.middlePort = middlePort
				} catch(e) {
					msg = "第${pos+1}行【中转港(英文)】单元格格式有误，请使用文本格式"
					errorInfo.add(msg);
				}

				try {
					String middlePortCn = row.getCell(6)?.stringCellValue?:null;
					if(middlePortCn?.length() > 255) {
						msg = "第${pos+1}行【中转港(中文)】不能超过255个字符"
						errorInfo.add(msg);
					}
					data.middlePortCn = middlePortCn
				} catch(e) {
					msg = "第${pos+1}行【中转港(中文)】单元格格式有误，请使用文本格式"
					errorInfo.add(msg);
				}
				
				try {
					String shipCompany = row.getCell(7)?.stringCellValue?:null;
					if(!shipCompany) {
						msg = "第${pos+1}行【船公司】不能为空"
						errorInfo.add(msg);
					} else if(shipCompany.length() > 255) {
						msg = "第${pos+1}行【船公司】不能超过255个字符"
						errorInfo.add(msg);
					}
					data.shipCompany = shipCompany
				} catch(e) {
					msg = "第${pos+1}行【船公司】单元格格式有误，请使用文本格式"
					errorInfo.add(msg);
				}

				try {
					String shippingDay
					try {
						shippingDay = row.getCell(8)?.stringCellValue?:null;
					} catch(e) {
						shippingDay = row.getCell(8)?.dateCellValue ? sdf.format(row.getCell(8).dateCellValue) : null
					}
					if(!shippingDay) {
						 msg = "第${pos+1}行【开船日】不能为空"
						 errorInfo.add(msg);
					} else if(shippingDay.length() > 255) {
						msg = "第${pos+1}行【开船日】不能超过255个字符"
						errorInfo.add(msg);
					}
					data.shippingDay = shippingDay
				} catch(e) {
					msg = "第${pos+1}行【开船日】单元格格式有误，请使用文本格式或日期格式 "
					errorInfo.add(msg);
				}

				Double shippingDays
				try {
					shippingDays = row.getCell(9)?.numericCellValue ?: null;
				} catch(e) {
					try {
						shippingDays = row.getCell(9)?.stringCellValue ? Double.valueOf(row.getCell(9).stringCellValue) : null
					} catch(e1) {
						msg = "第${pos+1}行【航程】单元格格式有误，请使用文本格式或数字格式"
						errorInfo.add(msg);
					}
				}
				data.shippingDays = shippingDays

				try {
					String transType = row.getCell(10)?.stringCellValue?:null;
					if(!transType) {
						msg = "第${pos+1}行【运输类别】不能为空"
						errorInfo.add(msg);
					}
					try {
						data.transType = TransportationType.getCodeByText(transType)
						if(!data.transType) {
							throw new RuntimeException()
						}
					} catch(e) {
						msg = "第${pos+1}行【运输类别】内容有误，请使用有效文本：整箱 | 拼箱"
						errorInfo.add(msg);
					}
				} catch(e) {
					  msg = "第${pos+1}行【运输类别】单元格格式有误，请使用文本格式"
					  errorInfo.add(msg);
				}

				if(TransportationType.Whole == data.transType) {
					try {
						String weightLimit = row.getCell(11)?.stringCellValue?:null;
						data.weightLimit = weightLimit
					} catch(e) {
						msg = "第${pos+1}行【限重】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
				}

				Date startDate
				try {
					startDate = row.getCell(12)?.dateCellValue ?: null
					if(!startDate) {
						msg = "第${pos+1}行【有效期开始日期】不能为空 "
						errorInfo.add(msg);
					}
				} catch(e) {
					try {
						startDate = row.getCell(12)?.stringCellValue ? sdf.parse(row.getCell(12).stringCellValue): null
					} catch(e1) {
						msg = "第${pos+1}行【有效期开始日期】格式有误，有效格式：2016-01-01"
						errorInfo.add(msg)
					}
					if(!startDate) {
						msg = "第${pos+1}行【有效期开始日期】不能为空"
						errorInfo.add(msg)
					}
				}
				data.startDate = startDate

				Date endDate
				try {
					endDate = row.getCell(13)?.dateCellValue ?: null
					if(!endDate) {
						msg = "第${pos+1}行【有效期结束日期】不能为空 "
						errorInfo.add(msg)
					}
				} catch(e) {
					try {
						endDate = row.getCell(13)?.stringCellValue ? sdf.parse(row.getCell(13).stringCellValue): null
					} catch(e1) {
						msg = "第${pos+1}行【有效期结束日期】格式有误，有效格式：2016-01-01"
						errorInfo.add(msg)
					}
					if(!endDate) {
						msg = "第${pos+1}行【有效期结束日期】不能为空"
						errorInfo.add(msg)
					}
				}
				data.endDate = endDate

				try {
					String remark = row.getCell(14)?.stringCellValue?:null;
					if(remark?.length() > 500) {
						msg = "第${pos+1}行【备注】不能超过500个字符"
						errorInfo.add(msg)
					}
					data.remark = remark
				} catch(e) {
					msg = "第${pos+1}行【备注】单元格格式有误，请使用文本格式"
					errorInfo.add(msg)
				}

				def priceParams = [:]

				if(TransportationType.Whole == data.transType) {
					BigDecimal gp20
					try {
						gp20 = row.getCell(15)?.numericCellValue ? new BigDecimal(row.getCell(15).numericCellValue) : null;
					} catch(e) {
						 msg = "第${pos+1}行【USD/20GP】单元格格式有误，请使用文本格式"
						 errorInfo.add(msg)
					}
					if(gp20) {
						priceParams.gp20 = gp20
					}
					
					BigDecimal gp20Vip
					try {
						gp20Vip = row.getCell(16)?.numericCellValue ? new BigDecimal(row.getCell(16).numericCellValue) : null;
					} catch(e) {
						msg = "第${pos+1}行【USD/20GPVIP】单元格格式有误，请使用文本格式"
						errorInfo.add(msg)
					}
					if(gp20Vip) {
						priceParams.gp20Vip = gp20Vip
					}
					BigDecimal gp40
					try {
						gp40 = row.getCell(17)?.numericCellValue ? new BigDecimal(row.getCell(17).numericCellValue) : null;
					} catch(e) {
						msg = "第${pos+1}行【USD/40GP】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					if(gp40) {
						priceParams.gp40 = gp40
					}
					
					BigDecimal gp40Vip
					try {
						gp40Vip = row.getCell(18)?.numericCellValue ? new BigDecimal(row.getCell(18).numericCellValue) : null;
					} catch(e) {
						msg = "第${pos+1}行【US D/40GPVIP】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					if(gp40Vip) {
						priceParams.gp40Vip = gp40Vip
					}
					BigDecimal hq40
					try {
						hq40 = row.getCell(19)?.numericCellValue ? new BigDecimal(row.getCell(19).numericCellValue) : null;
					} catch(e) {
						msg = "第${pos+1}行【USD/40HQ】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					if(hq40) {
						priceParams.hq40 = hq40
					}
					
					BigDecimal hq40Vip
					try {
						hq40Vip = row.getCell(20)?.numericCellValue ? new BigDecimal(row.getCell(20).numericCellValue) : null;
					} catch(e) {
						msg = "第${pos+1}行【USD/40HQVIP】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					if(hq40Vip) {
						priceParams.hq40Vip = hq40Vip
					}
				}

				try {
					String extra = row.getCell(21)?.stringCellValue?:null;
					if(extra?.length() > 1000) {
						msg = "第${pos+1}行【附加费】不能超过1000个字符 "
						errorInfo.add(msg);
					}
					priceParams.extra = extra
				} catch(e) {
					msg = "第${pos+1}行【附加费】单元格格式有误，请使用文本格式"
					errorInfo.add(msg);
				}

				if(TransportationType.Together == data.transType) {
					try {
						String pinServiceType = row.getCell(22)?.stringCellValue?:null;
						data.pinServiceType = pinServiceType
					} catch(e) {
						msg = "第${pos+1}行【服务类型】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}

					BigDecimal cbm
					try {
						cbm = row.getCell(23)?.stringCellValue ? new BigDecimal(row.getCell(23).stringCellValue) : null;
					} catch(e) {
						msg = "第${pos+1}行【USD/cbm】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
					if(cbm) {
						priceParams.cbm = cbm
					}

					try {
						String lowestCost = row.getCell(24)?.stringCellValue?:null;
						priceParams.lowestCost = lowestCost
					} catch(e) {
						msg = "第${pos+1}行【最低消费】单元格格式有误，请使用文本格式"
						errorInfo.add(msg);
					}
				}
		
				if(priceParams.size() > 0) {
					data.prices = new ShippingPrices(priceParams)
				}
			
				FrontUser user = springSecurityService.currentUser
				data.owner = user;
				data.contactName = user.firstname
				data.companyName = user.companyName
				data.phone = user.username
				data.status = Status.UnVerify;
				data.service = BackUser.get("10" as Long)
				//data.batchId = Shipbatchnumber.get("1" as long)
				data.releaseNum = releaseNum
				data.fromBy = "前台"
				//datas << data
				if (datas.size < 199) {
					   datas << data
					} else {
					render(text: "<script>alert('批量发布航线条数不能多于200条');</script>", contentType: "text/html", encoding: "UTF-8")
				   return
				}
			}
			
			if (datas.size == 0) {
				render(text: "<script>alert('没有符合规则的数据可上传');</script>", contentType: "text/html", encoding: "UTF-8")
				return ;
			}
			
			if(errorInfo.size() > 0 ){
				render errorInfo;
				return;
			} else {
				boolean hasError = false
						def savedDatas = []
						int pos = 1
						datas.each {
							it.save()
							hasError = it.hasErrors()
							if(!hasError) {
								savedDatas << it
								pos++
							}
							return hasError
						}
							if(hasError) {
									CargoShipInformation.deleteAll(savedDatas)
									render(text: "<script>alert('第${pos}行保存失败');</script>", contentType: "text/html", encoding: "UTF-8")
							}
							else {
								
							def user = springSecurityService.getCurrentUser()
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
							def now = df.format(new Date());// new Date()为获取当前系统时间
							mailService.sendMail {
								async true
								to "custom@zhao-chuan.com" //data.service.email
								from grailsApplication.config.grails.mail.username
								subject "前台用户运价上传-通知"
								body """
								你好,亲爱的找船网工作人员
								用户${user.username}已于${now}批量发布${rowCount-1}条运价
								链接地址: http://${grailsApplication.config.domain}/shipInfo/list/
								联  系  人: ${user.username}
								联系方式: ${user.mobile}
								邮       箱 : ${user.email}

									请登录后台及时处理！

								系统后台自动发送，无需回复
								${now}
							"""
							}
						}
	
				 render (text: "<script>alert('上传成功, 共"+datas.size+"条记录！');</script>", contentType: "text/html", encoding: "UTF-8")
				 //return;
			}
						
		}
	}

	@Secured('ROLE_SHIP_AGENT')
	def downloadExample() {
		String fname = new String('货代公司标准上传模板'.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.xls")
		response.outputStream << getClass().getResourceAsStream("/com/cdd/front/files/ship.xls")
		return
	}

	
	JsonConverterFactory jsonConverterFactory
	SpringSecurityService springSecurityService
	
	/***
	 * 运价查询
	 * @return
	 */
	
	SessionFactory sessionFactory
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def myShips() {

		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')

		Date today = new Date();
		
		FrontUser user = springSecurityService.currentUser
		
		def owner=user.id
		
		def pageNo = params.pageNo
		def verified =user.verified
		
		SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select count(*) from (select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count from cargo_ship_information where owner_id=" + owner +"  and deleted=false  group by release_num order by date_created desc limit "+  Integer.parseInt(params.maxResultSize)*(Integer.parseInt(pageNo)-1)+","+ Integer.parseInt(params.maxResultSize)+") as total")
		
		int total = sql.uniqueResult()
		
		if(total > Integer.parseInt(params.maxResultSize)*(Integer.parseInt(pageNo)-1) || total==Integer.parseInt(params.maxResultSize)*(Integer.parseInt(pageNo)-1) || total < Integer.parseInt(params.maxResultSize)*(Integer.parseInt(pageNo)-1)){
			sql = sessionFactory.getCurrentSession().createSQLQuery("select release_num ,DATE_FORMAT(date_created,'%Y-%m-%d %H:%i:%s'),COUNT(release_num) as count from cargo_ship_information where owner_id=" + owner + "  and deleted=false group by release_num order by  date_created desc limit "+ Integer.parseInt(params.maxResultSize)*(Integer.parseInt(pageNo)-1) +","+Integer.parseInt(params.maxResultSize))
		}else{
			sql = null
		}
		
		StringBuffer s = new StringBuffer("")
		int count = 0
		List l = new ArrayList();
		
		List list = new ArrayList()
		
		if(sql != null){
			
			
			sql.list()?.collect{
				def data = [:]
				data.releaseNum = it[0]
				data.dateCreated = it[1]
				data.totalCount = it[2]
				l.add(data)
				s.append("(select  cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days, "
					+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,cago.release_num, "
					+" cago.status,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra "
					+" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id where cago.release_num = '"+it[0]+"' and  cago.deleted = false  ")
			
				if(params.serach != null && params.serach != ""){
			
					s.append(" and (cago.start_port like '%"+params.serach+"%'  ")
					s.append(" or cago.end_port like '%"+params.serach+"%'  ")
					s.append(" or cago.id like '%"+params.serach.trim()+"%' ) ")
			
				}
		
				if(params.shipCompany!= null && params.shipCompany!= ""){
					s.append(" and cago.ship_company like '%"+params.shipCompany+"%' ")
				}
		
				if(params.status!=null && params.status!=" "){
					switch(params.status){
						case Status.UnVerify.name():
						s.append(" and cago.status='"+Status.UnVerify.name() +"' ")
						break;
						case Status.InVerify.name():
						s.append(" and cago.status='"+Status.InVerify.name() +"' ")
						break;
						case Status.VerifyPassed.name():
						s.append(" and cago.status='"+Status.VerifyPassed.name() +"' ")
						break;
						case Status.VerifyFailed.name():
						s.append(" and cago.status='"+Status.VerifyFailed.name() +"' ")
						break;
						case Status.Expired.name():
						s.append(" and cago.status='"+Status.Expired.name() +"' ")
						break;
						case Status.Revoked.name():
						s.append(" and cago.status='"+Status.Revoked.name() +"' ")
						break;
						case Status.Closed.name():
						s.append(" and cago.status='"+Status.Closed.name() +"' ")
						break;
					}
				}
		
			if(params.createStratDate.trim() != null || params.createEndDate.trim() !=null){
				
				if(params.createStratDate.trim() != "" && params.createEndDate.trim() !=""){
					
						s.append("  and cago.date_created between '"+ params.createStratDate.trim()+"' and '"+ params.createEndDate.trim() +"'  ")
				}
				else if(params.createStratDate.trim() != "") {
						s.append(" and cago.date_created like '%"+params.createStratDate.trim()+"%' ")
				}else if(params.createEndDate.trim() !=""){
				
					s.append(" and cago.date_created like '%"+params.createEndDate.trim()+"%' ")
				}
				
			}

			s.append(" limit 0,2 ) ");
		
			if(count < total-1){
				s.append(" union all ");
			}
				count++;
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
				data.gp20 = it[6]?it[6]:0
				data.gp40 = it[7]?it[7]:0
				data.hq40 = it[8]?it[8]:0
				data.startDate = it[9]?new SimpleDateFormat('yyyy/MM/dd').format(it[9]) : it[9]
				data.endDate = it[10]?new SimpleDateFormat('yyyy/MM/dd').format(it[10]) : it[10]
				data.releaseNum = it[11]
				
				for(Map m : l){
					if(m.releaseNum == it[11]){
						data.totalCount = m.totalCount
						data.dateCreated = m.dateCreated
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
							  status = Status.Closed.text;
					  break;
					  }
				  }
				data.status = status
				data.shipCompany = it[13]
				data.middlePort = it[14]
				data.routeName = it[15]
				data.remark = it[16]
				data.extra = it[17]
	
				if (data.contactName != null && data.contactName.length() > 1) {
					data.contactName = data.contactName.substring(0, 1)+"**";
				}
	
				data.companyFullName = data.companyName
				if (data.companyName != null && data.companyName.length() > 11) {
					data.companyName = data.companyName.substring(0, 11)+"...";
				}
	
				//屏蔽公司名称
				data.companyName = "**公司"
				data.companyFullName = "**公司"
	
				return data
			}
		}
		render([result:list,verified:verified] as JSON)
	}

	@Secured('ROLE_SHIP_AGENT')
	def myOrders() {
		if (params.sort) {
			params.sort = "info." + params.sort;
		} else {
			params.sort = "info.lastUpdated";
			params.order = "desc";
		}

		def queryHandler =  {

			info { eq "owner", springSecurityService.currentUser }

			if (params.status) {
				//				switch(params.status) {
				//					case OrderStatus.TradeSuccess.name(): eq "orderStatus", OrderStatus.TradeSuccess; break;
				//					case OrderStatus.CertUnupload.name(): eq "orderStatus", OrderStatus.CertUnupload; break;
				//					case OrderStatus.CertUploaded.name(): eq "orderStatus", OrderStatus.CertUploaded; break;
				//					case OrderStatus.CertInVerify.name(): eq "orderStatus", OrderStatus.CertInVerify; break;
				//					case OrderStatus.CertPassed.name(): eq "orderStatus", OrderStatus.CertPassed; break;
				//					case OrderStatus.CertFailed.name(): eq "orderStatus", OrderStatus.CertFailed; break;
				//				}
				eq "orderStatus", OrderStatus.valueOf(params.status)
			} else {
				or {
					eq "orderStatus", OrderStatus.TradeSuccess
					eq "orderStatus", OrderStatus.CertUnupload
					eq "orderStatus", OrderStatus.CertUploaded
					eq "orderStatus", OrderStatus.CertInVerify
					eq "orderStatus", OrderStatus.CertPassed
					eq "orderStatus", OrderStatus.CertFailed
				}
			}
			if(params.search) {
				or {
					/*					info {
					 like "routeName", "%"+params.search+"%"
					 }*/
					info {
						like "startPort", "%"+params.search.toUpperCase()+"%"
					}
					info {
						like "endPort", "%"+params.search.toUpperCase()+"%"
					}
					info {
						like "startPortCn", "%"+params.search.toUpperCase()+"%"
					}
					info {
						like "endPortCn", "%"+params.search.toUpperCase()+"%"
					}
				}
			}

			eq 'deleted', false
		}

		def result = CRUDService.list(Order, params, queryHandler)
		def total = result.totalCount;
		def list = result?.list.collect {
			def data = [:]
			data.id = it.id
			data.startPort = it.startPort
			data.endPort = it.endPort
			data.startPortCn = it.startPortCn
			data.endPortCn = it.endPortCn
			data.startDate = it.startDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.startDate) : it.startDate
			data.endDate = it.endDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.endDate) : it.endDate
			data.biteEndDate = it.biteEndDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.biteEndDate) : it.biteEndDate

			if (it.orderStatus) {
				data.statusKey = it.orderStatus
				data.status = it.orderStatus.text
				//				switch(it.orderStatus) {
				//					case OrderStatus.UnTrade.name(): data.status =  OrderStatus.UnTrade.text; break;
				//					case OrderStatus.InTrade.name(): data.status =  OrderStatus.InTrade.text; break;
				//					case OrderStatus.TradeSuccess.name(): data.status =  OrderStatus.TradeSuccess.text; break;
				//					case OrderStatus.CertUploaded.name(): data.status =  OrderStatus.CertUploaded.text; break;
				//					case OrderStatus.CertInVerify.name(): data.status =  OrderStatus.CertInVerify.text; break;
				//					case OrderStatus.CertPassed.name(): data.status =  OrderStatus.CertPassed.text; break;
				//				}
			} else if (it.status) {
				data.statusKey = it.status
				data.status = it.status.text
				//				switch(it.status) {
				//					case Status.UnVerify.name(): data.status = Status.UnVerify.text; break;
				//					case Status.InVerify.name(): data.status = Status.InVerify.text; break;
				//					case Status.VerifyPassed.name(): data.status = Status.VerifyPassed.text; break;
				//					case Status.VerifyFailed.name():data.status = Status.VerifyFailed.text; break;
				//				}
			}

			data.cargoNums = it.cargoNums
			data.cargoWeight = it.cargoWeight
			data.cargoCube = it.cargoCube
			data.cargoWidth = it.cargoWidth
			data.cargoHeight = it.cargoHeight
			data.cargoLength = it.cargoLength
			data.cargoName = it.cargoName
			def orderType = ""
			if (it.orderType) {
				switch(it.orderType) {
					case OrderType.Furniture.name(): orderType = OrderType.Furniture.text; break;
					case OrderType.Building.name(): orderType = OrderType.Building.text; break;
					case OrderType.Clothing.name(): orderType = OrderType.Clothing.text; break;
					case OrderType.Other.name(): orderType = OrderType.Other.text; break;
				}
			}
			data.orderType = orderType;


			def transType = "";
			if (it.transType) {
				switch(it.transType) {
					case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
					case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
				}
			}
			data.transType = transType;

			def cargoBoxType = "";
			if (it.cargoBoxType) {
				switch(it.cargoBoxType) {
					case CargoBoxType.GP20.name() : cargoBoxType = CargoBoxType.GP20.text; break;
					case CargoBoxType.GP40.name() : cargoBoxType = CargoBoxType.GP40.text; break;
					case CargoBoxType.HQ40.name() : cargoBoxType = CargoBoxType.HQ40.text; break;
					case CargoBoxType.HQ45.name() : cargoBoxType = CargoBoxType.HQ45.text; break;
				}
			}
			data.cargoBoxType = cargoBoxType;
			data.cargoBoxNums = it.cargoBoxNums;
			data.certFilePath = getFilePath(it.certFilePath)
			data.bookingFilePath = getFilePath(it.bookingFilePath)
			data.isoFilePath = getFilePath(it.isoFilePath)

			if (it.info) {
				//				data.info = it.info
				dealInfoForOrder(data, it.info)
			}

			if (it.owner) {
				data.companyName = it.owner.companyName
			} else {
				data.companyName = it.companyName
			}
			data.companyFullName = data.companyName
			if (data.companyName != null && data.companyName.length() > 11) {
				data.companyName = data.companyName.substring(0, 11)+"...";
			}

			return data
		}

		render ([total: total, rows: list] as JSON)

	}

	private getFilePath(filePath) {
		if(filePath) {
			return "http://${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}/${filePath}"
		}
		return null
	}

	@Secured(['ROLE_CARGO_OWNER'])
	def dealInfoForOrder(data, it) {
		def info = [:];
		info.startPort = it.startPort
		info.endPort = it.endPort
		info.startPortCn = it.startPortCn
		info.endPortCn = it.endPortCn
		info.shipCompany = it.shipCompany
		info.startDate = it.startDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.startDate) : it.startDate
		info.endDate = it.endDate ? new SimpleDateFormat('yyyy-MM-dd').format(it.endDate) : it.endDate
		if (it.status) {
			switch(it.status) {
				case Status.UnVerify.name(): info.status = Status.UnVerify.text; break;
				case Status.InVerify.name(): info.status = Status.InVerify.text; break;
				case Status.VerifyPassed.name(): info.status = Status.VerifyPassed.text; break;
				case Status.VerifyFailed.name():info.status = Status.VerifyFailed.text; break;
			}
		}
		info.middlePort = it.middlePort

		def transType = "";
		if (it.transType) {
			switch(it.transType) {
				case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
				case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
			}
		}
		info.transType = transType;

		info.shippingDay = it.shippingDay
		if (it.prices) {
			if (it.prices.gp20) {
				info.gp20 = it.prices.gp20
			}
			if (it.prices.gp40) {
				info.gp40 = it.prices.gp40
			}
			if (it.prices.hq40) {
				info.hq40 = it.prices.hq40
			}
			if (it.prices.hq45) {
				info.hq45 = it.prices.hq45
			}
			if (it.prices.extra) {
				info.extra = it.prices.extra
			}
		}
		info.routeName = it.routeName
		info.shippingDays = it.shippingDays
		info.remark = it.remark
		data.info = info;
	}
		
	/**
	 * 查询总数（发布批号）
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def getTotalPage(){
		FrontUser user = springSecurityService.currentUser
		def owner=user.id
		
		SQLQuery sqlTotal = sessionFactory.getCurrentSession().createSQLQuery("select COUNT(distinct(release_num)) as count from cargo_ship_information where owner_id= '"+ owner +"' and  deleted=false ")
		
		def totalCount = sqlTotal.uniqueResult();
		
		def totalPage
		
		if(totalCount%Integer.parseInt(params.maxResultSize) > 0){
			totalPage = (int)totalCount/Integer.parseInt(params.maxResultSize) + 1
		}else{
			totalPage = totalCount/Integer.parseInt(params.maxResultSize)
		}
		
		render  ([totalPage:totalPage] as JSON)
	}
	
	/***
	 * 前端用户页面查询
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def list() {
//		if(springSecurityService.isLoggedIn()){
//			
//			
//		}
		
		if (!params.sort) {
			params.sort = "dateCreated";
			//params.order = "desc";
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
			case 'time': params.sort = "endDate"
		}
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')

		Date today = new Date();

		def queryHandler =  {
			createAlias('owner', 'owner', JoinType.LEFT_OUTER_JOIN)

			or {
				ge 'endDate', today-1
				isNull 'endDate'
			}
			
			notEqual "fromBy","商务"
			eq "status", Status.VerifyPassed
			/*
			 if(params.search) {
			 def searchKey = "%${params.search}%"
			 or {
			 like "startPort", searchKey
			 like "endPort", searchKey
			 like "startPortCn", searchKey
			 like "endPortCn", searchKey
			 like "companyName", searchKey
			 like "owner.companyName", searchKey
			 }
			 }*/

			if(params.transType) {
				def transType = "";
				switch(params.transType) {
					case TransportationType.Whole.name(): transType = TransportationType.Whole; break;
					case TransportationType.Together.name(): transType = TransportationType.Together; break;
				}
				eq "transType", transType
			}

			if(params.startPort) {
				or {
					like "startPort", "%"+params.startPort.toUpperCase()+"%"
					like "startPortCn", "%"+params.startPort.toUpperCase()+"%"
				}
			}

			if(params.endPort) {
				or {
					like "endPort", "%"+params.endPort.toUpperCase()+"%"
					like "endPortCn", "%"+params.endPort.toUpperCase()+"%"
				}
			}
			//船公司筛选
			if(params.shipCompany){
				
					eq "shipCompany", params.shipCompany
				
			}
			
			//箱型筛选
			if(params.cargoBoxType){
				
			def startprice=""
			def endprice=""
			if(params.startPrice!=""){
				BigDecimal bd=new BigDecimal(params.startPrice)
				startprice=bd.setScale(2, BigDecimal.ROUND_HALF_UP)
			}
			if(params.endPrice!=""){
				BigDecimal bdc=new BigDecimal(params.endPrice)
				endprice=bdc.setScale(2, BigDecimal.ROUND_HALF_UP)
			}
			
			if(params.cargoBoxType=="20GP"){
				
				if(params.startPrice||params.endPrice){
						or{
							prices{
								if(startprice==""){
									le "gp20",endprice
								}else if(endprice==""){
									ge "gp20",startprice
								}else{
							   between ("gp20",startprice,endprice)
								}
							 }
						}
				  }
			}else if(params.cargoBoxType=="40GP"){
			
				if(params.startPrice||params.endPrice){
						or{
							prices{
								if(startprice==""){
									le "gp40",endprice
								}else if(endprice==""){
									ge "gp40",startprice
								}else{
							   between ("g420",startprice,endprice)
								}
							 }
						}
				  }
			}else if(params.cargoBoxType=="40HQ"){
			
				if(params.startPrice||params.endPrice){
						or{
							prices{
								if(startprice==""){
									le "hq40",endprice
								}else if(endprice==""){
									ge "hq40",startprice
								}else{
							   between ("hq40",startprice,endprice)
								}
							 }
						}
				  }
				 }
			}

			if(params.startDate) {
				def startDate = params.startDate ? new SimpleDateFormat('yyyy-MM-dd').parse(params.startDate) : params.startDate
				ge "startDate",startDate
			}

			if(params.endDate) {
				def endDate = params.endDate ? new SimpleDateFormat('yyyy-MM-dd').parse(params.endDate) : params.endDate
				le "endDate", endDate
			}

			eq 'deleted', false
		}
		FrontUser user = springSecurityService.currentUser
		def verified =user?.verified
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
			data.weightLimit = it.weightLimit
			data.remark = it.remark
			data.pinServiceType = it.pinServiceType;
			data.companyName = it.companyName
			
			if(it.companyName == "深圳市长帆国际物流有限公司") {
				if(it.prices&&it.prices.gp20 > 500) {
					data.gp20 = it.prices ? it.prices.gp20 +100: 0;
				}else if(it.prices&&it.prices.gp20 <500) {
					data.gp20 = it.prices ? it.prices.gp20 +50: 0;
				}
				if(it.prices&&it.prices.gp40 > 500) {
					data.gp40 = it.prices ? it.prices.gp40 +100: 0;
				}else if(it.prices&&it.prices.gp40 <500) {
					data.gp40 = it.prices ? it.prices.gp40 +50: 0;
				}
				if(it.prices&&it.prices.hq40 > 500) {
					data.hq40 = it.prices ? it.prices.hq40 +100: 0;
				}else if(it.prices&&it.prices.hq40 < 500) {
					data.hq40 = it.prices ? it.prices.hq40 +50: 0;
				}
				
				data.gp20Vip = it.prices ? it.prices.gp20Vip : 0;
				data.gp40Vip = it.prices ? it.prices.gp40Vip : 0;
				data.hq40Vip = it.prices ? it.prices.hq40Vip : 0;
			}else {
				data.gp20 = it.prices ? it.prices.gp20 : 0;
				data.gp40 = it.prices ? it.prices.gp40 : 0;
				data.hq40 = it.prices ? it.prices.hq40 : 0;
				data.gp20Vip = it.prices ? it.prices.gp20Vip : 0;
				data.gp40Vip = it.prices ? it.prices.gp40Vip : 0;
				data.hq40Vip = it.prices ? it.prices.hq40Vip : 0;
			}
			
			data.cbm = it.prices ? it.prices.cbm : 0;
			data.lowestCost = it.prices ? it.prices.lowestCost : '';
			data.extra = it.prices ? it.prices.extra : '';
			def transType = "";
			if (it.transType) {
				switch(it.transType) {
					case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
					case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
				}
			}
			data.transType = transType;
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
			//data.companyName = "**公司"
			data.companyFullName = "**公司"

			return data
		}

		render ([total: total, rows: list,verified:verified] as JSON)

	}
	
	/***
	 * 运价修改
	 * @return
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def pricing(){
	
		CargoShipInformation info = CargoShipInformation.get(params.id as Long)
	
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd")
				def startDate = formatter.format(info.startDate)
				def endDate = formatter.format(info.endDate)
				
				// 截取船期
				String shippingDay = info.shippingDay
		
				def aa = shippingDay.indexOf("截")
				
				def jj = " "
				//def jj = shippingDay.substring(0, aa)?shippingDay.substring(0, aa):" "
				def kk = " "
				//def  kk = shippingDay.substring(aa+1,shippingDay.length()-1)?shippingDay.substring(aa+1,shippingDay.length()-1):" "
				if(!jj){
						jj = shippingDay.substring(0, aa)
					}
				else {
					jj = " "
				}
				if(!kk){
					kk = shippingDay.substring(aa+1,shippingDay.length() - 1)
				}
				else {
					kk = " "
				}
				def id = info.id
						   
		render view: '/member/data.gsp', model: [info:info,startDate:startDate,endDate:endDate,jj:jj,kk:kk,id:id]
	}
	
	
	/***
	 * 修改运价保存
	 * @return
	 *
	 */
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def shipUpdate(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		CargoShipInformation info = CargoShipInformation.get(params.id as Long)
		FrontUser user = springSecurityService.currentUser
		
		if(info){
			info.owner = user;
			info.contactName = user.firstname
			info.companyName = user.companyName
			info.phone = user.username
			info.startPort=params.startPort
			info.endPort = params.endPort
			
			if(params.middlePort){
				 info.middlePort = params.middlePort
			}
			//info.shippingDays =Integer.parseInt(params.shippingDays)//航程
			info.shipCompany =  params.shipCompany //船公司
			info.shippingDay = params.total_shipping_date //船期
			info.transType = params.box_style //箱类型
			info.startDate = sdf.parse(params.startDate)
			info.endDate = sdf.parse(params.endDate)
			
			info.prices = new ShippingPrices()
			info.info = params.prices.info
		   //20gp普通价
			if(params.gp20_commom_price){
				BigDecimal gp20 = new BigDecimal(params.gp20_commom_price)
				info.prices.gp20 = gp20
			}
			//20gp会员价
			if(params.gp20_specical_price){
				BigDecimal gp20Vip = new BigDecimal(params.gp20_specical_price)
				info.prices.gp20Vip = gp20Vip
			}
			//gp40普通价
			if(params.gp40_commom_price){
				BigDecimal gp40 = new BigDecimal(params.gp40_commom_price)
				info.prices.gp40 = gp40
			}
			//gp40会员价
			if(params.gp40_specical_price){
				BigDecimal gp40Vip = new BigDecimal( params.gp40_specical_price)
				info.prices.gp40Vip = gp40Vip
			}
			//hq40普通价
			if(params.hq40_commom_price){
				BigDecimal hq40 = new BigDecimal(params.hq40_commom_price)
				info.prices.hq40 = hq40
			}
			//hq40会员价
			if(params.hq40_specical_price){
				BigDecimal hq40Vip = new BigDecimal(params.hq40_specical_price)
				info.prices.hq40Vip = hq40Vip
			}
			
			if(params.per_price){
				BigDecimal cbm = new BigDecimal(params.per_price)
				info.prices.cbm = cbm
			}
			if(params.min_charge){
				info.prices.lowestCost = params.min_charge
			}
			//附加费
			if(params.total_local_cost){
				info.prices.extra = params.total_local_cost
			}
			//限重
			if(params.limit_weight){
				info.weightLimit =params.limit_weight
			}
			//备注
			if(params.remark){
				info.remark = params.remark
			}
			
			info.status = Status.UnVerify
			render view: '/member/shiplist'
		}
		if(!info.save() ) {
			info.errors.each {
				println it   }
			}
		info.save()
		if(!info.hasErrors()) {
			render view: '/member/shiplist'
		} else {
			render ([msg: g.message(code: info.errors.allErrors[0].codes[0])] as JSON)
		}
	}
	
	   /***
		* 运价撤销
		* @return
		*/
		@Secured('ROLE_CLIENT')
		def updateStatus(){
			
			def status= Status.Revoked
			def id=params.id
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
				CargoShipInformation.errors.each{
					println "a:>====="+it
				}
			}
			redirect(url: "/member/shiplist",params:["grid4":"Success"])
		}

		/***
		 * 运价删除
		 * @return
		 */
		@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		def deleteShip(){
			def deleted = true
			def id=params.id
			def hql="update CargoShipInformation a set a.deleted=:deleted where a.id=:id"
			def hql1=[:]
			def sta="deleted"
			def st=deleted
			def sta1="id"

			def st1=new Long(id)
			hql1.put(sta,st)
			hql1.put(sta1,st1)
			CargoShipInformation.executeUpdate(hql,hql1)
			redirect(url: "/member/shiplist")
		}
		
		
		/***
		 *  运价 ten 条 查询
		 * @return
		 */
		@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		def tenPricingInfo(){
			def deleted = false;
			def releaseNum = params.releaseNum
			SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
			+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
			+" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra "
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
				data.gp20 = it[6]?it[6]:0
				data.gp40 = it[7]?it[7]:0
				data.hq40 = it[8]?it[8]:0
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
				data.middlePort = it[14]
				data.routeName = it[15]
				data.remark = it[16]
				data.extra = it[17]
				return data
			}
			render list as JSON
		}
		
		/***
		 * 根据发布批号查询 twenty条运价信息
		 * @return
		 */
		@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		def twentyPricingInfo(){
			def deleted = false;
			def releaseNum = params.releaseNum
			SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
			+" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
			+" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra "
		   +" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id "
		   +" where cago.release_num = "+releaseNum+"  and cago.deleted = "+false+" limit 0,20 ");
	
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
				data.gp20 = it[6]?it[6]:0
				data.gp40 = it[7]?it[7]:0
				data.hq40 = it[8]?it[8]:0
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
				data.middlePort = it[14]
				data.routeName = it[15]
				data.remark = it[16]
				data.extra = it[17]
				return data
			}
			render list as JSON
		}
		
		  /***
		   * 根据发布批号查询 fifty 条运价信息
		   * @return
		   */
		  @Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		  def  fiftyPricingInfo(){
			  
			  def deleted = false;
			  def releaseNum = params.releaseNum
			  SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
			  +" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
			  +" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra "
			 +" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id "
			 +" where cago.release_num = "+releaseNum+"  and cago.deleted = "+false+" limit 0,50 ");
	  
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
				  data.gp20 = it[6]?it[6]:0
				  data.gp40 = it[7]?it[7]:0
				  data.hq40 = it[8]?it[8]:0
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
				  data.middlePort = it[14]
				  data.routeName = it[15]
				  data.remark = it[16]
				  data.extra = it[17]
				  return data
			  }
			  render list as JSON
		  }
		  
		  /***
		   * 根据发布批号查询   oneHundredInfo 条运价信息
		   * @return
		   */
		  @Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		  def  oneHundredPricingInfo(){
			  def deleted = false;
			  def releaseNum = params.releaseNum
			  SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
			  +" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
			  +" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra "
			 +" from cargo_ship_information cago left join ship_prices sps on cago.id = sps.info_id "
			 +" where cago.release_num = "+releaseNum+"  and cago.deleted = "+false+" limit 0,100 ");
	  
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
				  data.gp20 = it[6]?it[6]:0
				  data.gp40 = it[7]?it[7]:0
				  data.hq40 = it[8]?it[8]:0
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
				  data.middlePort = it[14]
				  data.routeName = it[15]
				  data.remark = it[16]
				  data.extra = it[17]
				  return data
			  }
			  render list as JSON
		  }
		  
		  /***
		   * 根据发布批号查询  twoHundredInfo 条运价信息
		   * @return
		   */
		  @Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		  def  twoHundredPricingInfo(){
			  def deleted = false;
			  def releaseNum = params.releaseNum
			  SQLQuery sql = sessionFactory.getCurrentSession().createSQLQuery("select cago.id,cago.trans_type,cago.start_port,cago.end_port,cago.shipping_days,"
			  +" cago.shipping_day,sps.gp20,sps.gp40,sps.hq40,cago.start_date,cago.end_date,"
			  +" cago.status,cago.release_num,cago.ship_company,cago.middle_port,cago.route_name,cago.remark,sps.extra "
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
				  data.gp20 = it[6]?it[6]:0
				  data.gp40 = it[7]?it[7]:0
				  data.hq40 = it[8]?it[8]:0
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
				  data.middlePort = it[14]
				  data.routeName = it[15]
				  data.remark = it[16]
				  data.extra = it[17]
				  return data
			  }
			  render list as JSON
		  }
		  
		  
		  /***
		   *  批量运价删除
		   * @return
		   */
		  @Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
		  def deleteBatchShip(){
			  
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
		   * 运价批量撤销
		   * @return
		   */
		   @Secured('ROLE_CLIENT')
		   
		def repealBatchShip(){
			
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
	 *
	 * @param owner
	 * @param it
	 * @return
	 */

	protected def getCargoShipScoreInfo(owner, it) {
		def map = [:]
		CargoShipScore data = CargoShipScore.findByCompanyName(it)
		def avgScore=""
		if (data) {
			DecimalFormat df = new DecimalFormat("0.0");
			avgScore = df.format((data.shipInTime + data.docInTime + data.infoInTime + data.serviceQuality + data.serviceContent) / 5)
		}
		def hornest = owner?.hornest
		def safety =  owner?.safety
		def verified = owner?.verified
		map = [avgScore: avgScore, hornest: hornest, safety : safety, verified: verified]
		return map;
	}

	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def getCargoShipScore(it) {
		def map = [:]
		CargoShipScore data = CargoShipScore.findByCompanyName(it)
		if (data) {
			DecimalFormat df = new DecimalFormat("0.0");
			map = [shipInTime: df.format(data.shipInTime), docInTime: df.format(data.docInTime), infoInTime: df.format(data.infoInTime), serviceQuality: df.format(data.serviceQuality), serviceContent: df.format(data.serviceContent)]
		}
		return map;
	}
	
	
	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def saveInfoConsuming(){
		if((params.startPort != null && params.startPort.trim() != "") || (params.endPort != null && params.endPort.trim() != "") ||(params.shipCompany != null && params.shipCompany.trim() != "")){
			saveSearchLog(params)
		}
		render null
	}

	private saveSearchLog(Map params) {
		def user = springSecurityService.currentUser
		SearchLog sl = new SearchLog();
		sl.startPort = params.startPort
		sl.endPort = params.endPort
		sl.shipCompany = params.shipCompany?params.shipCompany:"-"
		println  params.resultCount 
		sl.resultCount = params.resultCount as int
		sl.searchUser = user.username
		sl.deleted = false
		sl.searchTime = new Date()
		sl.searchSource = "前台"
		sl.consuming = params.consuming+"s";
		sl.save();
		if(sl.hasErrors()) {
			log.info "ERROE: "+sl.errors
		} else {
			log.info "SUCCESS: save this Record"
		}
	}
		
	
}
