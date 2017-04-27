package com.cdd.back.controller

import grails.converters.JSON

import java.text.SimpleDateFormat;
import java.util.Map;
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import javax.servlet.http.HttpServletRequest
import com.cdd.base.domain.Booking;
import com.cdd.base.domain.BookingSo
import com.cdd.base.domain.CargoShipInformation;
import com.cdd.base.domain.CompanyCertificate;
import com.cdd.base.domain.Order;
import com.cdd.base.enums.BookingStatus;
import com.cdd.base.service.OssService;
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



class BookingController extends BaseController{
	def excludeFields = ['salt', 'password']
	def model = 'booking'
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd hh:mm:ss')

	OssService ossService
	def grailsApplication
	def list() {
		//render getList(model: model, domainClass: Booking,excludeFields: excludeFields, isConjunction: true)
		if(params.dataType != 'json') {
			render view: "/${model}/list", model: [settings: getSettings(menuService.findMenu("/${model}/list"))]
			return
		}
		String searchKey
		if(params.search) {
			searchKey = "%${params.search}%"
		}
		def result=CRUDService.list(Booking, params,){
			if(searchKey) {
				or {
					like "bookingName",searchKey
				}
			}
			if(params.booknumber){
				and{
					eq "id",params.booknumber as Long
				}
			}
			if(params.startPort){
				info {
						like "startPort", "%"+params.startPort+"%"
					}
			}
			if(params.endPort){
				info {
						like "endPort", "%"+params.endPort+"%"
					}
			}
			if(params.dateCreated){
				SimpleDateFormat sdf1 = new SimpleDateFormat('yyyy-MM-dd')
				def date1=sdf1.parse(params.dateCreated)
				def date2=sdf1.parse(params.dateCreated)+1
				and{
					between ("dateCreated", date1,date2)
				}
			}
			if(params.operateBy){
				and{
					like "operateBy","%${params.operateBy}%"
				}
			}
			
			if(params.finishedBy){
				and{
					like "finishedBy","%${params.finishedBy}%"
				}
			}
			if(params.status){
				and {
					eq "status", params.status
				}
			}
			
		}
		def criteria
		criteria = Booking.createCriteria()
		def unCheckNum = criteria.count {
			eq "status", "UnCheck"
		}
		def criteria2
		criteria2 = Booking.createCriteria()
		def inBookingNum = criteria2.count {
			eq "status", "InBooking"
		}
		def map=[rows:[],total:result.totalCount,unCheckNum:unCheckNum,inBookingNum:inBookingNum]
		result.list.each { Booking Booking ->
			def data=[:]
			switch(Booking.status){
				case BookingStatus.Invalid.name():
					data.status="已失效"
				break
				case BookingStatus.UnCheck.name():
					data.status="未审核"
				break
				case BookingStatus.NoPass.name():
					data.status="不通过"
				break
				case BookingStatus.InBooking.name():
					data.status="订舱中"
				break
				case BookingStatus.ShippingSpaced.name():
				data.status="已放舱"
				break
				case BookingStatus.FailBooking.name():
				data.status="订舱失败"
				break
				case BookingStatus.InChcek.name():
				data.status="审核中"
				break
			}
			data.id=Booking.id
			data.infoId=Booking.info.id
			data.bookingName=Booking.bookingName
			data.startPort=Booking.info.startPort
			data.endPort=Booking.info.endPort
			data.dateCreated=sdf.format(Booking.dateCreated)
			data.operateBy=Booking.operateBy
			data.finishedBy=Booking.finishedBy
			
			map.rows << data
		}
		
		render map as JSON
	}
	
	def data() {
		Booking data = Booking.get(params.id as Long)
		int infoId=data.info.id
		CargoShipInformation info=CargoShipInformation.get(infoId)
		if(data.so){
		int soId = data.so.id
		BookingSo so=BookingSo.get(soId)
		}
		Order order=Order.findByInfo(info)
		def newData=[:]
		if(order!=null){
			String str=order.cargoBoxType
			if(str!=null && str.indexOf(",")>=0){
				String[] aa=str.split(",")
				newData.GP20=aa[0]
				newData.GP40=aa[1]
				newData.HQ40=aa[2]
				String c=order.cargoBoxNums
				String[] bb=c.split(",")
				newData.GP20CargoBoxNums=bb[0]
				newData.GP40CargoBoxNums=bb[1]
				newData.HQ40CargoBoxNums=bb[2]
				newData.data=data
				newData.order=order
				newData.str="str"
			}else{
				newData.data=data
				newData.order=order
				newData.str=null
				
			}
		}else{
			newData.data=data
		}
		render view: "/${model}/data", model: [data: newData, settings: getSettings(getMenu('查看', "/${model}/list"))]
	}
	/********删除*******/
	def delete={
		request.view = "/$model/list"
		String[] ids = params.ids.split(',(\\s)*')
		if(ids) {
			def objs = []
			for(def id in ids) {
				Booking	 booking = Booking.get(id as Long)
				booking.delete(flush:true);
			}
		}
		flash.msgs = ['删除成功']
		redirect uri: "/${model}/list"
	}
	
	//受理
	def operate(){
		Booking data=Booking.get(params.id as Long)
		int infoId=data.info.id
		CargoShipInformation info=CargoShipInformation.get(infoId)
		Order order=Order.findByInfo(info)
		def newData=[:]
		if(order!=null){
			String str=order.cargoBoxType
			if(str.indexOf(",")>=0){
				String[] aa=str.split(",")
				newData.GP20=aa[0]
				newData.GP40=aa[1]
				newData.HQ40=aa[2]
				String c=order.cargoBoxNums
				String[] bb=c.split(",")
				newData.GP20CargoBoxNums=bb[0]
				newData.GP40CargoBoxNums=bb[1]
				newData.HQ40CargoBoxNums=bb[2]
				newData.data=data
				newData.order=order
				newData.str="str"
			}else{
				newData.data=data
				newData.order=order
				newData.str=null
			}
		 }else{
		 		newData.data=data
		 }
		render view: "/${model}/operate", model: [data: newData, settings: getSettings(getMenu('结单', "/${model}/list"))]
	}
	//审核结果
	def save(){
		
	Booking data=Booking.get(params.bookingId as Long)
	if(params.status=="1"){
		data.status = "InBooking"
		data.remark = params.remarkReason
		data.operateBy = springSecurityService.currentUser.username
		
		flash.msgs = ['审核成功']
	}else{
		data.status = "NoPass"
		data.failReason = params.failReason
		data.remark = params.remarkReason
		data.operateBy = springSecurityService.currentUser.username
		
		flash.msgs = ['审核不通过']
	}
	if( !data.save() ) {   data.errors.each {        println it   }}
	data.save()
	render view: "/${model}/list", model: [ settings: getSettings(getMenu('结单', "/${model}/list"))]
	
	}	
	def finish(){
		Booking data=Booking.get(params.id as Long)
		int infoId=data.info.id
		CargoShipInformation info=CargoShipInformation.get(infoId)
		Order order=Order.findByInfo(info)
		def newData=[:]
		if(order!=null){
			String str=order.cargoBoxType
			if(str.indexOf(",")>=0){
				String[] aa=str.split(",")
				newData.GP20=aa[0]
				newData.GP40=aa[1]
				newData.HQ40=aa[2]
				String c=order.cargoBoxNums
				String[] bb=c.split(",")
				newData.GP20CargoBoxNums=bb[0]
				newData.GP40CargoBoxNums=bb[1]
				newData.HQ40CargoBoxNums=bb[2]
				newData.data=data
				newData.order=order
				newData.str="str"
			}else{
				newData.data=data
				newData.order=order
				newData.str=null
			}
		 }else{
				 newData.data=data
		 }
		render view: "/${model}/finish", model: [data: newData, settings: getSettings(getMenu('结单', "/${model}/list"))]
	}
	
	
	def finishReasult(){
		println params.bookingId
		if(params.status == "1"){
			BookingSo so = new BookingSo()
			so.soNumber = params.soNumber
			so.shipCompany = params.shipCompany
			so.shipName = params.shipName
			so.voyageNo = params.voyageNo
			so.startPort = params.startPort
			so.endPort = params.endPort
			if(params.gp20Num){
				so.gp20Num = Integer.parseInt(params.gp20Num) 
			 }
			if(params.gp40Num){
				so.gp40Num = Integer.parseInt(params.gp40Num)
			 }
			if(params.hq40Num){
				so.hq40Num = Integer.parseInt(params.hq40Num)
			 }
			SimpleDateFormat sdf2 = new SimpleDateFormat('yyyy-MM-dd')
			so.endDate = sdf2.parse(params.endDate)
			so.startShipDate = sdf2.parse(params.startShipDate)
			CommonsMultipartFile f = request.getFile('file')
			if(f.size > 0) {
				String fileName = "files/booking/so/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
				ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
						"files/booking/so/" + f.fileItem.fileName)
				so.soFilePath = fileName
				
			}
			so.remark = params.remark
			if( !so.save() ) {   so.errors.each {        println it   }}
			so.save()
			Booking data=Booking.get(params.bookingId as Long)
			data.status = "ShippingSpaced"
			data.finishedBy = springSecurityService.currentUser.username
			data.so = so
			data.save()
			flash.msgs = ['结单成功']
			/*CommonsMultipartFile f = request.getFile('file')
			String prefix = "files/data/${data.id}/iso/"
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
					prefix + f.fileItem.fileName)*/
			
			}else{
			Booking data=Booking.get(params.bookingId as Long)
			data.status = "FailBooking"
			data.failReason = params.failReason
			data.finishedBy = springSecurityService.currentUser.username
			data.save()
			flash.msgs = ['结单失败']
			}
		
		render view: "/${model}/list", model: [ settings: getSettings(getMenu('结单', "/${model}/list"))]
	}
	
	private fileExistOrNot( Map flash,BookingSo so,String file) {
		
		CommonsMultipartFile f = request.getFile(file)
		if(f.size <= 0 && !data.image) {
			flash.msgs = ['请上传图片']+file
			return
		}
		if(f.size > maxSize) {
			flash.msgs  = ['图片不能超过10MB']
			return
		}
		if(f.size > 0) {
			String fileName = "files" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,
					"files/" + f.fileItem.fileName)
			so.soFilePath = fileName
			
		}
	}
	def importBooking(){
		Booking booking = Booking.get(params.id as Long)
		String filePath = "booking/${booking.id}/booking/booking_${booking.id}.pdf"
		String rootFilePath = "${grailsApplication.config.appInfo.rootPath}/tmp/${filePath}"
		
		Document document = new Document(PageSize.A4);
		File outputFile = new File(rootFilePath)
		outputFile.getParentFile().mkdirs()
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(rootFilePath));
		document.open();
		PdfContentByte cb = writer.getDirectContent();
		
		PdfReader reader = new PdfReader(getClass().getResourceAsStream('/com/cdd/back/files/booking_template.pdf'));
		PdfImportedPage page = writer.getImportedPage(reader, 1);
		
		document.newPage();
		cb.addTemplate(page, 0, 0);

		cb.saveState()
		printText(params.bookingName, 20, 795, cb) // service contract no
		
		
		cb.restoreState();
		
		// save doc
		document.close();
		
		
		String bookingFilePath = "files/${filePath}"
		
		ossService.uploadFile(new FileInputStream(rootFilePath), grailsApplication.config.oss.publicbucket, bookingFilePath)
		
		
		println booking
		println "ok!"
		render ([msg:'保存成功', status: 1] as JSON)
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
