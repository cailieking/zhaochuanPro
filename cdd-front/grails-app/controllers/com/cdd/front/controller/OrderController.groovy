package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.mail.MailService;
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.hibernate.SQLQuery
import org.hibernate.SessionFactory
import org.springframework.web.multipart.commons.CommonsMultipartFile

import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.CargoShipItemScore
import com.cdd.base.domain.City
import com.cdd.base.domain.EndPort;
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.RecommendedRoute
import com.cdd.base.domain.RecommendedShipInfo
import com.cdd.base.domain.StartPort;
import com.cdd.base.domain.User
import com.cdd.base.enums.CargoBoxType
import com.cdd.base.enums.OrderStatus
import com.cdd.base.enums.OrderType
import com.cdd.base.enums.Status
import com.cdd.base.enums.TransportationType
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.OrderService
import com.cdd.base.service.OssService
import com.cdd.base.service.common.CRUDService
import com.cdd.base.util.CommonUtils
import com.cdd.front.constant.Constant
import com.itextpdf.awt.AsianFontMapper
import com.itextpdf.text.Chunk
import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.PageSize
import com.itextpdf.text.pdf.BaseFont
import com.itextpdf.text.pdf.ColumnText
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfImportedPage
import com.itextpdf.text.pdf.PdfReader
import com.itextpdf.text.pdf.PdfWriter


class OrderController implements ExceptionHandler {

	JsonConverterFactory jsonConverterFactory
	OrderService orderService
	MailService mailService
	
	SessionFactory sessionFactory 
	//发布货物
	@Secured('ROLE_CLIENT')
	def issue() {

		boolean isLoggedIn = springSecurityService.isLoggedIn();

		Order order = new Order(params)
		
		if (!isLoggedIn || params.city_id) {
			if (!order.startPort || !order.endPort ||!order.contactName || !order.phone || !order.companyName) {
				render ([msg:'参数不正确', status: Constant.STATUS_FAILED] as JSON)
				return
			}

			if ((order.remark && order.remark.length() > 500)) {
				render ([msg:'委托找船内容不能超过500个字', status: Constant.STATUS_FAILED] as JSON)
				return
			}
			City city
			if((!params.city_id) || (Integer.parseInt(params.city_id) < 1)) {
				render ([msg:'请选择地区', status: Constant.STATUS_FAILED] as JSON)
				return
			} else {
				city = City.findByCode(params.city_id);
				if (city == null) {
					render ([msg:'地区不合法', status: Constant.STATUS_FAILED] as JSON)
					return
				}
			}
			order.city = city;
		} else {
			if (!order.startDate || !order.endDate || !order.startPort || !order.endPort
			|| !order.biteEndDate || !order.transType) {
				render ([msg:'参数不正确', status: Constant.STATUS_FAILED] as JSON)
				return
			}

			if (order.transType == TransportationType.Whole) {
				if (!order.cargoBoxType || !order.cargoBoxNums) {
					render ([msg:'参数不正确', status: Constant.STATUS_FAILED] as JSON)
					return
				}
				order.cargoNums = null;
				order.cargoWeight = null;
				order.cargoCube = null;
				order.cargoWidth = null;
				order.cargoHeight = null;
				order.cargoLength = null;
				order.sales = BackUser.get("10" as Long )
				//发布时将货盘来源默认为前台发布
				order.orderCome = "F"
			} else {
				if (!order.cargoNums || !order.cargoWeight || !order.cargoCube) {
					render ([msg:'参数不正确', status: Constant.STATUS_FAILED] as JSON)
					return
				}
				order.cargoBoxType = null;
				order.cargoBoxNums = null;
			}


			if ((order.remark && order.remark.length() > 500)) {
				render ([msg:'备注不能超过500个字', status: Constant.STATUS_FAILED] as JSON)
				return
			}
		}

		// 我要发货
		if(params.infoId) {
			CargoShipInformation info = CargoShipInformation.get(params.infoId as Long)
			if(info) {
				order.info = info
			}
		}
		if(!isLoggedIn || params.city_id) {
			order.createBy = User.ANONYMOUS.username
			order.updateBy = User.ANONYMOUS.username
		} else {
			FrontUser user = springSecurityService.currentUser
			order.owner = user;
			order.contactName = user.firstname
			order.companyName = user.companyName
			order.phone = user.username
		}
		order.dealPrice = BigDecimal.ZERO;
		order.status = Status.UnVerify;
		orderService.insert(order)
		if(!order.hasErrors()) {
			render ([data: order.number, status: Constant.STATUS_SUCCESS] as JSON)
		} else {
			render ([msg: g.message(code: order.errors.allErrors[0].codes[0]), status: Constant.STATUS_FAILED] as JSON)
		}
	}
	
	
		int maxSize = 1024 * 1024 * 1 // 1MB maximum
		/***
		 * 批量发布货盘
		 * @return
		 */
		@Secured('ROLE_CLIENT')
		def issueBatch() {
	
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
			if(rowCount < 1) {
				render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
				return
			} else {
				def datas = []
	
				String msg          //公共字段
				
				String sumCount        //总记录数
				
				String cargoNameSize = " "   //货物名称 大小
				
				String cargoNameFormat = " "   //货物格式
				
				String startPortNon = " "     //起始港
				
				String startPortSize = " "     //起始港
				
				String startPortFormat = " "    //起始港
				
				String endPortNon = " "  // 目的港
				
				String endPortSize = " "
				 
				String endPortFormat = " "
				
				String transTypeNon = " " //运输类别
				
				String transTypeContent = " " //运输类别 内容
				
				String transTypeFormat = " " //运输类别 格式
				
				String orderTypeFormat = " " //货物类型
				
				String startDateNon = " " //走货开始日期
				
				String startDateFormat = " " //走货开始日期
				
				String endDateNon = " " // 走货截止日期/或走货结束日期
				
				String endDateFormat = " "  //走货结束日期
				
				String biteEndDateNon = " " //报价截止日期 非空 //2个判断
				
				String biteEndDateFormat = " " // 报价截止日期
				
				String remarkSize = " " // 备注
				
				String remarkFormat = " "
				
				String cargoBoxTypeNon = " "   //箱型
				
				String cargoBoxTypeContent = " "   //箱型内容
				
				String cargoBoxTypeFormat = " "   //箱型文本格式
				
				String cargoBoxNumsNon = " "   //箱个数
				
				String cargoBoxNumsFormat = " " //箱个数
				
				String cargoNumsNon  = " "  //数量/件数
				
				String  cargoNumsFormat = " "  //数量/件数 格式
				
				String  cargoWeightNon = " "  //毛重  非空
				
				String  cargoWeightFormat = " "  //毛重
				
				String cargoCubeNon = " "      //体积
				
				String cargoCubeFormat = " "    //体积
				
				String cargoLengthFormat = " "    //长度
				
				String cargoWidthFormat = " "      //宽度
				
				String  cargoHeightFormat = " "   //高度
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
	
				for (int i=0; i<rowCount-1; i++) {
	
					Order data = new Order()
					int pos = i + 1
					HSSFRow row = sheet.getRow(pos)
	
					try {
						String cargoName = row.getCell(0)?.stringCellValue?:null
						if(cargoName.length() > 255) {
							msg = "第${pos+1}行[货物名称]不能超过255个字符 "
							cargoNameSize = msg
						}
						data.cargoName = cargoName
					} catch(e) {
						msg = "第${pos+1}行[货物名称]单元格格式有误，请使用文本格式 "
						cargoNameFormat = msg
					}
	
					try {
						String startPort = row.getCell(1)?.stringCellValue.toString().toUpperCase()?:null
						if(!startPort) {
							msg = "第${pos+1}行[起始港]不能为空 "
							startPortNon=msg
						} else if(startPort.length() > 255) {
							msg = "第${pos+1}行[起始港]不能超过255个字符 "
							startPortSize = msg
						}
						data.startPort = startPort
					} catch(e) {
						msg ="第${pos+1}行[起始港]单元格格式有误，请使用文本格式"
						startPortFormat = msg
					}
	
					try {
						String endPort = row.getCell(2)?.stringCellValue.toString().toUpperCase()?:null
						if(!endPort) {
							msg  = "第${pos+1}行[目的港]不能为空"
							endPortNon= msg
						} else if(endPort.length() > 255) {
							msg = "第${pos+1}行[目的港]不能超过255个字符"
							endPortSize = msg
						}
						data.endPort = endPort
					} catch(e) {
						msg = "第${pos+1}行[目的港]单元格格式有误，请使用文本格式"
						endPortFormat = msg
					}
	
					try {
						String transType = row.getCell(3)?.stringCellValue?:null;
						if(!transType) {
							msg = "第${pos+1}行[运输类别]不能为空"
							transTypeNon = msg
						}
						try {
							data.transType = TransportationType.getCodeByText(transType)
							if(!data.transType) {
								throw new RuntimeException()
							}
						} catch(e) {
							msg = "第${pos+1}行[运输类别]内容有误，请使用有效文本：整箱 | 拼箱"
							transTypeContent = msg
						}
					} catch(e) {
						msg = "第${pos+1}行[运输类别]单元格格式有误，请使用文本格式"
						transTypeFormat = msg
					}
	
					try {
						String orderType = row.getCell(4)?.stringCellValue?:null;
						data.orderType = orderType
					} catch(e) {
						msg = "第${pos+1}行[货物类型]单元格格式有误，请使用文本格式"
						orderTypeFormat = msg
					}
	
					Date startDate
					try {
						startDate = row.getCell(5)?.dateCellValue ?: null
						if(!startDate) {
							msg = "第${pos+1}行[走货开始日期]不能为空"
							startDateNon = msg
						}
					} catch(e) {
						try {
							startDate = row.getCell(5)?.stringCellValue ? sdf.parse(row.getCell(5).stringCellValue): null
						} catch(e1) {
							msg = " 第${pos+1}行[走货开始日期]格式有误，有效格式：2015-01-01 "
							startDateFormat = msg
						}
						if(!startDate) {
							msg = "第${pos+1}行[走货开始日期]不能为空"
							startDateNon = msg
						}
					}
					data.startDate = startDate
	
					Date endDate
					try {
						endDate = row.getCell(6)?.dateCellValue ?: null
						if(!endDate) {
							msg = "第${pos+1}行[走货结束日期]不能为空"
							endDateNon = msg
						}
					} catch(e) {
						try {
							endDate = row.getCell(6)?.stringCellValue ? sdf.parse(row.getCell(6).stringCellValue): null
						} catch(e1) {
							msg = "第${pos+1}行[走货结束日期]格式有误，有效格式：2016-01-01"
							endDateFormat = msg
						}
						if(!endDate) {
							msg = "第${pos+1}行[走货结束日期]不能为空"
							endDateNon=msg
						}
					}
					data.endDate = endDate
	
					Date biteEndDate
					try {
						biteEndDate = row.getCell(7)?.dateCellValue ?: null
						if(!biteEndDate) {
							msg = "第${pos+1}行[报价截止日期]不能为空"
							biteEndDateNon = msg
						}
					} catch(e) {
						try {
							biteEndDate = row.getCell(7)?.stringCellValue ? sdf.parse(row.getCell(7).stringCellValue): null
						} catch(e1) {
							 msg = "第${pos+1}行[报价截止日期]格式有误，有效格式：2016-01-01"
							 biteEndDateFormat = msg
						}
						if(!biteEndDate) {
							msg = "第${pos+1}行[报价截止日期]不能为空"
							biteEndDateNon = msg
						}
					}
					data.biteEndDate = biteEndDate
	
					try {
						String remark = row.getCell(8)?.stringCellValue?:null;
						if(remark?.length() > 500) {
							msg = "第${pos+1}行[备注]不能超过500个字符"
							remarkSize = msg
						}
						data.remark = remark
					} catch(e) {
						msg = "第${pos+1}行[备注]单元格格式有误，请使用文本格式"
						remarkFormat = msg
					}
	
					if(data.transType == TransportationType.Whole) {
						try {
							String cargoBoxType = row.getCell(9)?.stringCellValue?:null;
							if(!cargoBoxType) {
								msg = "第${pos+1}行[箱型]不能为空"
								cargoBoxTypeNon = msg
							}
							try {
								data.cargoBoxType = CargoBoxType.getCodeByText(cargoBoxType)
								if(!data.cargoBoxType) {
									throw new RuntimeException()
								}
							} catch(e) {
								msg = "第${pos+1}行[箱型]内容有误，请使用有效文本：20GP | 40GP | 40HQ | 45HQ"
								cargoBoxTypeContent = msg
							}
						} catch(e) {
							msg = "第${pos+1}行[箱型]单元格格式有误，请使用文本格式"
							cargoBoxTypeFormat = msg
						}
	
						Integer cargoBoxNums
						try {
							cargoBoxNums = row.getCell(10)?.numericCellValue ?: null;
							if(!cargoBoxNums) {
								msg = "第${pos+1}行[箱个数]不能为空"
								cargoBoxNumsNon = msg
							}
						} catch(e) {
							try {
								cargoBoxNums = row.getCell(10)?.stringCellValue ? Integer.valueOf(row.getCell(10).stringCellValue) : null
								if(!cargoBoxNums) {
									msg = "第${pos+1}行[箱个数]不能为空"
									cargoBoxNumsNon=msg
								}
							} catch(e1) {
								msg = "第${pos+1}行[箱个数]单元格格式有误，请使用文本格式或数字格式"
								cargoBoxNumsFormat = msg
							}
						}
						data.cargoBoxNums = cargoBoxNums
					} else {
						Integer cargoNums
						try {
							cargoNums = row.getCell(11)?.numericCellValue ?: null;
							if(!cargoNums) {
								 msg = "第${pos+1}行[数量/件数]不能为空"
								 cargoNumsNon = msg
							}
						} catch(e) {
							try {
								cargoNums = row.getCell(11)?.stringCellValue ? Integer.valueOf(row.getCell(11).stringCellValue) : null
								if(!cargoNums) {
									msg = "第${pos+1}行[数量/件数]不能为空"
									cargoNumsNon = msg
								}
							} catch(e1) {
								msg = "第${pos+1}行[数量/件数]单元格格式有误，请使用文本格式或数字格式"
								cargoNumsFormat = msg
							}
						}
						data.cargoNums = cargoNums
	
						Double cargoWeight
						try {
							cargoWeight = row.getCell(12)?.numericCellValue ?: null;
							if(!cargoWeight) {
								msg = "第${pos+1}行[毛重]不能为空"
								cargoWeightNon = msg
							}
						} catch(e) {
							try {
								cargoWeight = row.getCell(12)?.stringCellValue ? Double.valueOf(row.getCell(12).stringCellValue) : null
								if(!cargoWeight) {
									msg = "第${pos+1}行[毛重]不能为空"
									cargoWeightNon = msg
								}
							} catch(e1) {
								msg = "第${pos+1}行[毛重]单元格格式有误，请使用文本格式或数字格式"
								cargoWeightFormat = msg
							}
						}
						data.cargoWeight = cargoWeight
	
						Double cargoCube
						try {
							cargoCube = row.getCell(13)?.numericCellValue ?: null;
							if(!cargoCube) {
								msg = "第${pos+1}行[体积]不能为空"
								cargoCubeNon = msg
							}
						} catch(e) {
							try {
								cargoCube = row.getCell(13)?.stringCellValue ? Double.valueOf(row.getCell(13).stringCellValue) : null
								if(!cargoCube) {
									msg = "第${pos+1}行[体积]不能为空"
									cargoCubeNon = msg
								}
							} catch(e1) {
								msg = "第${pos+1}行[体积]单元格格式有误，请使用文本格式或数字格式"
								cargoCubeFormat = msg
							}
						}
						data.cargoCube = cargoCube
					}
	
					Double cargoLength
					try {
						cargoLength = row.getCell(14)?.numericCellValue ?: null;
					} catch(e) {
						try {
							cargoLength = row.getCell(14)?.stringCellValue ? Double.valueOf(row.getCell(14).stringCellValue) : null
						} catch(e1) {
							msg = "第${pos+1}行[长度]单元格格式有误，请使用文本格式或数字格式"
							cargoLengthFormat = msg
						}
					}
					data.cargoLength = cargoLength
	
					Double cargoWidth
					try {
						cargoWidth = row.getCell(15)?.numericCellValue ?: null;
					} catch(e) {
						try {
							cargoWidth = row.getCell(15)?.stringCellValue ? Double.valueOf(row.getCell(15).stringCellValue) : null
						} catch(e1) {
							msg = "第${pos+1}行[宽度]单元格格式有误，请使用文本格式或数字格式"
							cargoWidthFormat = msg
						}
					}
					data.cargoWidth = cargoWidth
	
					Double cargoHeight
					try {
						cargoHeight = row.getCell(16)?.numericCellValue ?: null;
					} catch(e) {
						try {
							cargoHeight = row.getCell(16)?.stringCellValue ? Double.valueOf(row.getCell(16).stringCellValue) : null
						} catch(e1) {
							msg = "第${pos+1}行[高度]单元格格式有误，请使用文本格式或数字格式"
							cargoHeightFormat = msg
						}
					}
					data.cargoHeight = cargoHeight
	
					FrontUser user = springSecurityService.currentUser
					data.owner = user;
					data.contactName = user.firstname
					data.companyName = user.companyName
					data.phone = user.username
					data.dealPrice = BigDecimal.ZERO;
					data.status = Status.UnVerify
					data.service = BackUser.get("10" as Long)
					//批量发布货物时将货盘来源默认为发布
					data.orderCome='F'
					datas << data
				
				}
	
				if(msg) {
					
					sumCount = "${cargoNameSize}  " + "${cargoNameFormat}  " + "${startPortNon}  " + "${startPortSize}" + "${startPortFormat}  "+
					"${endPortNon}  " + "${endPortSize}  " + "${endPortFormat}  " + "${transTypeNon}  " + "${transTypeContent}  " + "${transTypeFormat}  "+
					"${orderTypeFormat}  " + "${startDateNon}  " + "${startDateFormat}  " + "${endDateNon}  " + "${endDateFormat}  " + "${biteEndDateNon}   "+
					"${biteEndDateFormat}  " + "${remarkSize}  " + "${remarkFormat}  " + "${cargoBoxTypeNon}  " + "${cargoBoxTypeContent}" + "${cargoBoxTypeFormat}  "+
					"${cargoBoxNumsNon}  " + "${cargoBoxNumsFormat}  " + "${cargoNumsNon}  " + "${cargoNumsFormat}  " + "${cargoWeightNon}  " + "${cargoWeightFormat}  "+
					"${cargoCubeNon}  " + "${cargoCubeFormat}  " + "${cargoLengthFormat}  " + "${cargoWidthFormat}  " + "${cargoHeightFormat}"
					
					
					render(text: "<script>alert('${sumCount}')</script>", contentType:"text/html",encoding:"UTF-8")
					
					return
					
				}
	
				if (datas.size == 0) {
					render(text: "<script>alert('没有符合规则的记录可上传');</script>", contentType: "text/html", encoding: "UTF-8")
					return
				}
	
							boolean hasError = false
							def savedDatas = []
							datas.each {
								orderService.insert(it)
								hasError = it.hasErrors()
								if(!hasError) {
									savedDatas << it
								}
								return hasError
							}
							if(hasError) {
								Order.deleteAll(savedDatas)
								render(text: "<script>alert('"+g.message(code: it.errors.allErrors[0].codes[0])+"');</script>", contentType: "text/html", encoding: "UTF-8")
								return
							}else {
							
							def user = springSecurityService.getCurrentUser()
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
							def now = df.format(new Date());// new Date()为获取当前系统时间
							mailService.sendMail {
								async true
								to "custom@zhao-chuan.com" //data.service.email
								from grailsApplication.config.grails.mail.username
								subject "前台用户货盘上传-通知"
								body """
							你好,亲爱的找船网工作人员
							用户${user.username}已于${now}批量发布${rowCount-1}条货盘
							链接地址: http://${grailsApplication.config.domain}/order/list/
							联  系  人: ${user.username}
							联系方式: ${user.mobile}
							邮       箱 : ${user.email}

								请登录后台及时处理！

							系统后台自动发送，无需回复
							${now}
						"""
							}
						}
				
				Order.saveAll(datas)
				
				render (text: "<script>alert('上传成功, 共"+datas.size+"条记录！');</script>", contentType: "text/html", encoding: "UTF-8")
				return;
	
			}
		}
	
	@Secured('ROLE_CLIENT')
	def downloadExample() {
		String fname = new String('货主公司标准上传模板'.getBytes("UTF-8"), "ISO8859-1");
		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "attachment; filename=${fname}.xls")
		response.outputStream << getClass().getResourceAsStream("/com/cdd/front/files/cargo.xls")
		return
	}

	CRUDService CRUDService
	SpringSecurityService springSecurityService

	@Secured(['ROLE_CLIENT'])
	def myOrders() {

		if (!params.sort) {
			params.sort = "lastUpdated";
			params.order = "desc";
		}

		def queryHandler =  {
			FrontUser user = springSecurityService.currentUser
			eq "createBy", user.username
          //  println user.username
			if (params.status) {
				try {
					eq "status", Status.valueOf(params.status)
				} catch(e) {
					eq "orderStatus", OrderStatus.valueOf(params.status)
				}
				//				switch(params.status) {
				//					case Status.UnVerify.name(): eq "status", Status.UnVerify; break;
				//					case Status.InVerify.name(): eq "status", Status.InVerify; break;
				//					case Status.VerifyPassed.name(): eq "status", Status.VerifyPassed; break;
				//					case Status.VerifyFailed.name(): eq "status", Status.VerifyFailed; break;
				//					case OrderStatus.UnTrade.name(): eq "orderStatus", OrderStatus.UnTrade; break;
				//					case OrderStatus.InTrade.name(): eq "orderStatus", OrderStatus.InTrade; break;
				//					case OrderStatus.CloseTrade.name(): eq "orderStatus", OrderStatus.CloseTrade; break;
				//					case OrderStatus.TradeSuccess.name(): eq "orderStatus", OrderStatus.TradeSuccess; break;
				//					case OrderStatus.CertUploaded.name(): eq "orderStatus", OrderStatus.CertUploaded; break;
				//					case OrderStatus.CertInVerify.name(): eq "orderStatus", OrderStatus.CertInVerify; break;
				//					case OrderStatus.CertPassed.name(): eq "orderStatus", OrderStatus.CertPassed; break;
				//				}
			}
			if(params.search) {
				or {
					like "startPort", "%"+params.search.toUpperCase()+"%"
					like "endPort", "%"+params.search.toUpperCase()+"%"
					like "startPortCn", "%"+params.search.toUpperCase()+"%"
					like "endPortCn", "%"+params.search.toUpperCase()+"%"
					//like "cargoName", "%"+params.search+"%"
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

			data.canScore = 0;

			if (it.orderStatus) {
				data.statusKey = it.orderStatus
				data.status = it.orderStatus.text
				//				switch(it.orderStatus) {
				//					case OrderStatus.UnTrade.name(): data.status =  OrderStatus.UnTrade.text; break;
				//					case OrderStatus.InTrade.name(): data.status =  OrderStatus.InTrade.text; break;
				//					case OrderStatus.TradeSuccess.name(): data.status =  OrderStatus.TradeSuccess.text; break;
				//					case OrderStatus.CertUploaded.name(): data.status =  OrderStatus.CertUploaded.text; break;
				//					case OrderStatus.CertInVerify.name(): data.status =  OrderStatus.CertInVerify.text; break;
				//					case OrderStatus.CertPassed.name(): data.status =  OrderStatus.CertPassed.text; data.canScore = 1;break;
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
			//			def orderType = ""
			//			if (it.orderType) {
			//				switch(it.orderType) {
			//					case OrderType.Furniture.text: orderType = OrderType.Furniture.text; break;
			//					case OrderType.Building.text: orderType = OrderType.Building.text; break;
			//					case OrderType.Clothing.text: orderType = OrderType.Clothing.text; break;
			//					case OrderType.Electronic.name(): orderType = OrderType.Electronic.text; break;
			//				}
			//			}
			data.orderType = it.orderType


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


			data.remark = it.remark

			if (it.info) {
				data.info = it.info
				dealInfoForOrder(data, it.info, it.orderStatus)
				if (it.status == Status.VerifyPassed && it.orderStatus != null
				&& it.orderStatus != OrderStatus.UnTrade && it.orderStatus != OrderStatus.InTrade) {
					dealCargoShipScore(data, it);
				}
			}

			data.recommendedInfos = []
			it.recommendedInfos?.each { info ->
				def infoMap = CommonUtils.tranferToMap(info.info, ['info', 'orders', 'owner', 'wantedOrder', 'service'])
				infoMap.recommendedRoutes = []
				if(info.info.owner) {
					def routes = RecommendedRoute.findAllByUser(info.info.owner)
					SQLQuery countQuery = sessionFactory.currentSession.createSQLQuery("""
						select route_name from new_route where route_english_name = ?
					""")
					
					routes?.each { route ->
						countQuery.setString(0, routes.category)
						String categoryName = countQuery.uniqueResult();
						infoMap.recommendedRoutes << categoryName
					}
				}
				data.recommendedInfos << infoMap
			}

			return data
		}

		render ([total: total, rows: list] as JSON)

	}

	//	@Secured('ROLE_CLIENT')
	//	def checkBooking() {
	//		Order order = request.order
	//		render ([data:getFilePath(order.bookingFilePath), status: Constant.STATUS_SUCCESS] as JSON)
	//	}
	//
	//	@Secured('ROLE_CLIENT')
	//	def checkIso() {
	//		Order order = request.order
	//		render ([data:getFilePath(order.isoFilePath), status: Constant.STATUS_SUCCESS] as JSON)
	//	}
	//
	//	@Secured('ROLE_CLIENT')
	//	def checkCert() {
	//		Order order = request.order
	//		render ([data:getFilePath(order.certFilePath), status: Constant.STATUS_SUCCESS] as JSON)
	//	}

	private getFilePath(filePath) {
		if(filePath) {
			return "http://${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}/${filePath}"
		}
		return null
	}

	protected def dealInfoForOrder(data, it, orderStatus) {
		def info = [:];
		info.startPort = it.startPort
		info.endPort = it.endPort
		info.startPortCn = it.startPortCn
		info.endPortCn = it.endPortCn
		info.shipCompany = it.shipCompany
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
		info.routeName = it.routeName
		info.shippingDays = it.shippingDays

		if (it.owner) {
			info.companyName = it.owner.companyName
		} else {
			info.companyName = it.companyName
		}
		info.companyFullName = info.companyName
		if (info.companyName != null && info.companyName.length() > 11) {
			info.companyName = info.companyName.substring(0, 11)+"...";
		}

		if (it.owner) {
			info.contactName = it.owner.firstname
		} else {
			info.contactName = it.contactName
		}

		info.orderId = data.id;

		if (!(orderStatus == OrderStatus.TradeSuccess
		|| orderStatus == OrderStatus.CertUploaded
		|| orderStatus == OrderStatus.CertInVerify
		|| orderStatus == OrderStatus.CertUnupload
		|| orderStatus == OrderStatus.CertFailed
		|| orderStatus == OrderStatus.CertPassed)) {
			info.companyFullName = "**公司";
			info.companyName = "**公司";
			if (info.contactName != null && info.contactName.length() > 1) {
				info.contactName = info.contactName.substring(0, 1)+"**";
			}
		}
		data.info = info;
	}

	protected def dealCargoShipScore(data, order) {
		CargoShipItemScore score = CargoShipItemScore.findByOrder(order);
		data.info.score = score;
	}




	@Secured(SpringSecurityConstant.AUTH_PERMIT_ALL)
	def list() {

		def map2=[:]
		//def a=EndPort.executeQuery("""select distinct (a.portName),a.portEnglishName from EndPort a""")
		//def b=StartPort.executeQuery("""select distinct (b.portName),b.portEnglishName from StartPort b""")
		def e=CargoShipInformation.executeQuery("""select distinct c.shipCompany from CargoShipInformation c where c.shipCompany is not null """)
		def a=EndPort.list()
		def c=StartPort.list()
		//def e=CargoShipInformation.list()
		def b=a.collect(){
			def map=[:]
			map.endPortCn=it.portName
			map.endPort=it.portEnglishName
			return map
		}
		def d=c.collect(){
			def map1=[:]
			map1.startPortCn=it.portName
			map1.startPort=it.portEnglishName
			return map1
		}
		// def map3=[:]

		//  map3.shipCompanyPort=e

		def Result
		def status
		def message


      

		if(e==[null]||a==[null]||c==[null]){
			
			status=0;
			Result="false"
			message="加载数据出现异常"
			
		}else {
		   status=1
		   Result="success"
		   message=""
		}
		def map3=[:]
		map3.put("startPort",d)
		map3.put("endPort",b)
		map3.put("shipCompany",e)



		if (!params.sort) {
			params.sort = "dateCreated";
			params.order = "desc";
		}

		Date today = new Date();

		def queryHandler =  {

			or {
				ge 'biteEndDate', today-1
				isNull 'biteEndDate'
			}

			eq "status", Status.VerifyPassed

			or {
				isNull "orderStatus"
				eq "orderStatus", OrderStatus.InTrade
				eq "orderStatus", OrderStatus.UnTrade
			}

			/*			if(params.search) {
			 or {
			 like "startPort", "%"+params.search+"%"
			 like "endPort", "%"+params.search+"%"
			 like "startPortCn", "%"+params.search+"%"
			 like "endPortCn", "%"+params.search+"%"
			 //					switch(params.search) {
			 //						case OrderType.Furniture.text: eq "orderType", OrderType.Furniture; break;
			 //						case OrderType.Building.text: eq "orderType", OrderType.Building; break;
			 //						case OrderType.Clothing.text: eq "orderType", OrderType.Clothing; break;
			 //						case OrderType.Electronic.text: eq "orderType", OrderType.Electronic; break;
			 //					}
			 eq "orderType", params.search
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

			if(params.orderType){
				or{  eq	 "orderType",params.orderType }

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

		def result = CRUDService.list(Order, params, queryHandler)
		def total = result.totalCount;
		def list = result?.list.collect {
			def data = [:]
			data.orderId = it.id
			data.startPort = it.startPort
			data.endPort = it.endPort
			data.startPortCn = it.startPortCn
			data.endPortCn = it.endPortCn
			data.startDate = it.startDate ? new SimpleDateFormat('yyyy.MM.dd').format(it.startDate) : it.startDate
			data.endDate = it.endDate ? new SimpleDateFormat('yyyy.MM.dd').format(it.endDate) : it.endDate

			data.cargoName = it.cargoName
			data.cargoBoxNums = it.cargoBoxNums
			//data.cargoWeight = it.cargoWeight
			//data.cargoCube = it.cargoCube
			//data.cargoWidth = it.cargoWidth
			//data.cargoHeight = it.cargoHeight
			//data.cargoLength = it.cargoLength
			data.biteEndDate = it.biteEndDate? new SimpleDateFormat('yyyy.MM.dd').format(it.biteEndDate) : it.biteEndDate
			def transType = "";
			if (it.transType) {
				switch(it.transType) {
					case TransportationType.Whole.name(): transType = TransportationType.Whole.text; break;
					case TransportationType.Together.name(): transType = TransportationType.Together.text; break;
				}
			}
			data.transType = transType;

			//			def orderType = ""
			//			if (it.orderType) {
			//				switch(it.orderType) {
			//					case OrderType.Furniture.name(): orderType = OrderType.Furniture.text; break;
			//					case OrderType.Building.name(): orderType = OrderType.Building.text; break;
			//					case OrderType.Clothing.name(): orderType = OrderType.Clothing.text; break;
			//					case OrderType.Electronic.name(): orderType = OrderType.Electronic.text; break;
			//				}
			//			}
			//			data.orderType = orderType;
			data.orderType = it.orderType;

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
			//data.cargoBoxNums = it.cargoBoxNums;

			//println result
			return data
		}


		map3.put("total",total)
		map2.put("message",message)
		map2.put("result",map3)
		map2.put("status",status) 
		//println map2 as JSON

		//render ([map:map2,total: total, rows:list] as JSON)
		render ([total: total, rows:list] as JSON)
	}


	def beforeInterceptor = [action: this.&auth, only: ['toDelegate', 'saveBooking', 'cancel', 'checkIso']]

	private auth() {
		Order order = Order.get(params.id as Long)
		if(!order) {
			render ([msg:'找不到订单信息', status: Constant.STATUS_FAILED] as JSON)
			return false
		}
		if(order.owner != springSecurityService.currentUser) {
			render ([msg:'非法订单', status: Constant.STATUS_FAILED] as JSON)
			return false
		}
		request.order = order
	}

	@Secured('ROLE_CLIENT')
	def toDelegate() {
		Order order = request.order
		CargoShipInformation info = CargoShipInformation.get(params.infoId as Long)
		if(!info) {
			render ([msg:'找不到委托信息', status: Constant.STATUS_FAILED] as JSON)
			return
		}
		order.info = info
		order.orderStatus = OrderStatus.TradeSuccess
		if(order.recommendedInfos) {
			RecommendedShipInfo.deleteAll(order.recommendedInfos)
			order.recommendedInfos.clear()
		}
		order.save()
		render ([msg:'委托成功', status: Constant.STATUS_SUCCESS] as JSON)
	}

	@Secured('ROLE_CLIENT')
	def cancel() {
		Order order = request.order
		order.info = null
		order.orderStatus = OrderStatus.CloseTrade
		if(order.recommendedInfos) {
			RecommendedShipInfo.deleteAll(order.recommendedInfos)
			order.recommendedInfos.clear()
		}
		order.save()
		render ([msg:'关闭成功', status: Constant.STATUS_SUCCESS] as JSON)
	}

	OssService ossService
	def grailsApplication

	@Secured('ROLE_SHIP_AGENT')
	def uploadIso() {
		int maxSize = 1014 * 1024 * 10

		Order order = Order.get(params.id as Long)
		if(!order) {
			render ([msg:'找不到订单信息', status: Constant.STATUS_FAILED] as JSON)
			//			render(text: "<script>alert('找不到订单信息');</script>", contentType: "text/html", encoding: "UTF-8")
			return false
		}
		if(order.info.owner != springSecurityService.currentUser) {
			render ([msg:'非法订单', status: Constant.STATUS_FAILED] as JSON)
			//			render(text: "<script>alert('非法订单');</script>", contentType: "text/html", encoding: "UTF-8")
			return false
		}

		CommonsMultipartFile f = request.getFile('file')
		if(f.size > maxSize) {
			render ([msg:'文件不能超过10MB', status: Constant.STATUS_FAILED] as JSON)
			//			render(text: "<script>alert('文件不能超过10MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		String prefix = "files/order/${order.id}/iso/"
		ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
				prefix + f.fileItem.fileName)
		String fileName = prefix + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
		order.isoFilePath = fileName
		order.save()
		render (text: "{\"msg\":\"上传成功\", \"status\": \"${Constant.STATUS_SUCCESS}\"}", contentType: "text/html")

	}

	@Secured('ROLE_SHIP_AGENT')
	def uploadCert() {
		int maxSize = 1014 * 1024 * 10

		Order order = Order.get(params.id as Long)
		if(!order) {
			render ([msg:'找不到订单信息', status: Constant.STATUS_FAILED] as JSON)
			//			render(text: "<script>alert('找不到订单信息');</script>", contentType: "text/html", encoding: "UTF-8")
			return false
		}
		if(order.info.owner != springSecurityService.currentUser) {
			render ([msg:'非法订单', status: Constant.STATUS_FAILED] as JSON)
			//			render(text: "<script>alert('非法订单');</script>", contentType: "text/html", encoding: "UTF-8")
			return false
		}

		CommonsMultipartFile f = request.getFile('file')
		if(f.size > maxSize) {
			render ([msg:'文件不能超过10MB', status: Constant.STATUS_FAILED] as JSON)
			//			render(text: "<script>alert('文件不能超过10MB');</script>", contentType: "text/html", encoding: "UTF-8")
			return
		}
		String prefix = "files/order/${order.id}/cert/"
		ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
				prefix + f.fileItem.fileName)
		String fileName = prefix + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
		order.certFilePath = fileName
		order.orderStatus = OrderStatus.CertUploaded
		order.save()
		render (text: "{\"msg\":\"上传成功\", \"status\": \"${Constant.STATUS_SUCCESS}\"}", contentType: "text/html")
	}

	@Secured(['ROLE_CLIENT'])
	def saveBooking() {
		Order order = request.order
		String filePath = "order/${order.id}/booking/booking_${order.id}.pdf"
		String rootFilePath = "${grailsApplication.config.appInfo.rootPath}/tmp/${filePath}"
		// Create output PDF
		Document document = new Document(PageSize.A4);
		File outputFile = new File(rootFilePath)
		outputFile.getParentFile().mkdirs()
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(rootFilePath));
		document.open();
		PdfContentByte cb = writer.getDirectContent();

		// Load existing PDF
		PdfReader reader = new PdfReader(getClass().getResourceAsStream('/com/cdd/front/files/booking_template.pdf'));
		PdfImportedPage page = writer.getImportedPage(reader, 1);

		// Copy first page of existing PDF into output PDF
		document.newPage();
		cb.addTemplate(page, 0, 0);

		cb.saveState()
		printText(params.serviceContractNo, 20, 795, cb) // service contract no
		printText(params.bookingDate, 470, 810, cb) // booking date
		printText(params.bookingNo, 450, 793, cb) // booking no
		printText(params.exportLicenseNo, 340, 763, cb) // export license no
		printText(params.bookedByName, 55, 718, cb) // booked by name
		printText(params.bookedByContact, 60, 702, cb) // booked by contact
		printText(params.bookedByEmail, 190, 702, cb) // booked by email
		printText(params.bookedByTel, 50, 687, cb) // booked by tel
		printText(params.customerName, 375, 718, cb) // customer name
		printText(params.customerContact, 380, 702, cb) // customer contact
		printText(params.customerEmail, 492, 720, 575, 600, cb) // customer email
		printText(params.customerTel, 370, 687, cb) // customer tel
		printText(params.shipperName, 55, 655, cb) // shipper name
		printText(params.shipperContact, 60, 638, cb) // shipper contact
		printText(params.shipperEmail, 190, 638, cb) // shipper email
		printText(params.shipperTel, 50, 622, cb) // shipper tel
		printText(params.notifyName, 55, 592, cb) // notify name
		printText(params.notifyContact, 60, 575, cb) // notify contact
		printText(params.notifyEmail, 190, 575, cb) // notify email
		printText(params.notifyTel, 50, 559, cb) // notify tel
		printText(params.consigneeName, 55, 511, cb) // consignee name
		printText(params.consigneeContact, 60, 494, cb) // consignee contact
		printText(params.consigneeEmail, 190, 494, cb) // consignee email
		printText(params.consigneeTel, 50, 478, cb) // consignee tel
		printText(params.of, 405, 542, cb) // O/F
		printText(params.thc, 405, 526, cb) // THC/ORC
		printText(params.eir, 512, 526, cb) // EIR
		printText(params.doc, 405, 510, cb) // DOC
		printText(params.ebs, 512, 510, cb) // EBS
		printText(params.isps, 405, 494, cb) // ISPS
		printText(params.cic, 512, 494, cb) // CIC
		printText(params.seal, 405, 478, cb) // SEAL
		printText(params.tlx, 512, 478, cb) // TLX
		printText(params.ens, 405, 462, cb) // ENS/AMS
		printText(params.others, 512, 462, cb) // OTHERS
		printText(params.receiptPlace, 20, 416, cb) // place of receipt
		printText(params.loadingPort, 165, 416, cb) // port of loading
		if(params.originCY == 'true') {
			printText('√', 426, 416, cb, 12) // origin CY
		}
		if(params.originCFS == 'true') {
			printText('√', 538, 416, cb, 12) // origin CFS
		}
		printText(params.dischargePort, 20, 384, cb) // port of discharge
		printText(params.deliveryPlace, 165, 384, cb) // place of delivery
		if(params.destinationCY == 'true') {
			printText('√', 426, 384, cb, 12) // destination CY
		}
		if(params.destinationCFS == 'true') {
			printText('√', 538, 384, cb, 12) // destination CFS
		}
		printText(params.voyageNo, 20, 340, cb) // voyage no
		printText(params.precarriage, 163, 370, 330, 300, cb) // pre-carriage
		printText(params.etd, 340, 340, cb) // ETD
		printText(params.finalDestination, 462, 340, cb) // final destination
		printText(params.quantity20, 100, 250, cb) // 20 quantity
		printText(params.quantity40, 100, 234, cb) // 40 quantity
		printText(params.quantity40hq, 100, 218, cb) // 40hq quantity
		printText(params.quantity45, 100, 202, cb) // 45 quantity
		printText(params.quantity40hqReefer, 100, 186, cb) // 40hq reefer quantity
		printText(params.quantity20Reefer, 100, 170, cb) // 20 reefer quantity
		printText(params.commodity, 165, 270, 220, 150, cb) // commodity
		printText(params.weight20, 230, 250, cb) // 20 weight
		printText(params.weight40, 230, 234, cb) // 40 weight
		printText(params.weight40hq, 230, 218, cb) // 40hq weight
		printText(params.weight45, 230, 202, cb) // 45 weight
		printText(params.weight40hqReefer, 230, 186, cb) // 40hq reefer weight
		printText(params.weight20Reefer, 230, 170, cb) // 20 reefer weight
		printText(params.cbm20, 290, 250, cb) // 20 cbm
		printText(params.cbm40, 290, 234, cb) // 40 cbm
		printText(params.cbm40hq, 290, 218, cb) // 40hq cbm
		printText(params.cbm45, 290, 202, cb) // 45 cbm
		printText(params.cbm40hqReefer, 290, 186, cb) // 40hq reefer cbm
		printText(params.cbm20Reefer, 290, 170, cb) // 20 reefer cbm
		printText(params.temperature20, 340, 250, cb) // 20 temperature
		printText(params.temperature40, 340, 234, cb) // 40 temperature
		printText(params.temperature40hq, 340, 218, cb) // 40hq temperature
		printText(params.temperature45, 340, 202, cb) // 45 temperature
		printText(params.temperature40hqReefer, 340, 186, cb) // 40hq reefer temperature
		printText(params.temperature20Reefer, 340, 170, cb) // 20 reefer temperature
		printText(params.humidity20, 410, 250, cb) // 20 humidity
		printText(params.humidity40, 410, 234, cb) // 40 humidity
		printText(params.humidity40hq, 410, 218, cb) // 40hq humidity
		printText(params.humidity45, 410, 202, cb) // 45 humidity
		printText(params.humidity40hqReefer, 410, 186, cb) // 40hq reefer humidity
		printText(params.humidity20Reefer, 410, 170, cb) // 20 reefer humidity
		printText(params.probes20, 463, 250, cb) // 20 probes
		printText(params.probes40, 463, 234, cb) // 40 probes
		printText(params.probes40hq, 463, 218, cb) // 40hq probes
		printText(params.probes45, 463, 202, cb) // 45 probes
		printText(params.probes40hqReefer, 463, 186, cb) // 40hq reefer probes
		printText(params.probes20Reefer, 463, 170, cb) // 20 reefer probes
		printText(params.volume20, 515, 250, cb) // 20 volume
		printText(params.volume40, 515, 234, cb) // 40 volume
		printText(params.volume40hq, 515, 218, cb) // 40hq volume
		printText(params.volume45, 515, 202, cb) // 45 volume
		printText(params.volume40hqReefer, 515, 186, cb) // 40hq reefer volume
		printText(params.volume20Reefer, 515, 170, cb) // 20 reefer volume
		printText(params.remark, 20, 155, 330, 50, cb) // remark
		printText(params.signature, 380, 100, cb, 24) // signature
		printText(params.chargeTel, 365, 68, cb) // person in charge tel
		printText(params.chargeEmail, 500, 68, cb) // person in charge email
		cb.restoreState();

		// save doc
		document.close();

		String bookingFilePath = "files/${filePath}"
		ossService.uploadFile(new FileInputStream(rootFilePath), grailsApplication.config.oss.publicbucket, bookingFilePath)
		order.orderStatus = OrderStatus.CertUnupload
		order.bookingFilePath = bookingFilePath
		order.save()
		render ([msg:'保存成功', status: Constant.STATUS_SUCCESS] as JSON)
	}

	private def printText(text, x, y, canvas, fontSize = 10) {
		if(!text) {
			return
		}
		canvas.setFontAndSize(BaseFont.createFont(AsianFontMapper.ChineseSimplifiedFont,
				AsianFontMapper.ChineseSimplifiedEncoding_H,
				BaseFont.NOT_EMBEDDED), fontSize); //
		canvas.beginText();
		canvas.moveText(x, y);
		canvas.showText(text);
		canvas.endText();
	}

	private def printText(text, llx, lly, urx, ury, canvas, fontSize = 10) {
		if(!text) {
			return
		}
		ColumnText ct = new ColumnText(canvas);
		ct.setAlignment(Element.ALIGN_JUSTIFIED);
		ct.setSimpleColumn(llx, lly, urx, ury)
		ct.addText(new Chunk(text, new Font(
				BaseFont.createFont(AsianFontMapper.ChineseSimplifiedFont,
				AsianFontMapper.ChineseSimplifiedEncoding_H,
				BaseFont.NOT_EMBEDDED), fontSize)))
		ct.go()
	}
}
