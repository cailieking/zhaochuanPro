package com.cdd.back.controller

import grails.converters.JSON
import java.text.SimpleDateFormat;
import jxl.write.WritableWorkbook
import jxl.write.WritableSheet
import jxl.SheetSettings
import jxl.Workbook
import jxl.write.WritableFont
import jxl.write.WritableCellFormat
import jxl.write.Label
import jxl.format.Alignment;  
import jxl.format.Border;  
import jxl.format.BorderLineStyle;  
import jxl.format.Colour;  
import jxl.format.UnderlineStyle;  
import jxl.format.VerticalAlignment;  
import com.cdd.base.domain.AccessLog
import com.cdd.base.domain.City
class AccessLogController extends BaseController{
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
	def limit = 10
	def offset = 0
	def state = false
	def model = "accessLog"
	def list(){
		if(params.offset == null && params.limit == null){
			params.offset = offset
			params.limit = limit
		}
		params.sort = 'time'
		def searchKey
		if(params.searchKey) {
			searchKey = "%${params.searchKey}%"
		}
		def result = CRUDService.list(AccessLog,params){
			
			if(searchKey) {
				or {
					like "visitor", searchKey
					like "url", searchKey
					like "ip", searchKey
				}
			}
			
			if(params.startDate&&params.endDate) {
				//def date1=new java.sql.Date(sdf.parse(params.startDate).getTime())
				//def date2=new java.sql.Date(sdf.parse(params.endDate).getTime())
				def date1 = sdf.parse(params.startDate)
				def date2 = sdf.parse(params.endDate)
				and{
					between ("time", date1,date2)
				}
			}else if(params.startDate) {
				def date=sdf.parse(params.startDate)
			
					ge "time", date
				
			}else if(params.endDate) {
				def date=sdf.parse(params.endDate)
					le "time", date
			
			}else {
			}
			
			if(params.cityId){
				or{
					eq "city", City.get(params.cityId as Long).name //params.cityId
				}
			}
			
			if(params.type){
				or{
					eq "type", params.type
				}
			}
		}
		Map map = [totalCount:result.totalCount,rows:[]]
		result.list.each { AccessLog accessLog ->
			def data=[:]
			data.visitor = accessLog.visitor
			data.type = accessLog.type
			data.url = accessLog.url
			data.time = accessLog.time
			data.ip = accessLog.ip
			data.city = accessLog.city
			map.rows << data
		}
		if(!params.state){
			render view:"/accessLog/list",model:[map:map]
		}else {
			render map as JSON
		}
	}
	def export() {
		params.sort = 'time'
		def searchKey
		if(params.searchKey) {
			searchKey = "%${params.searchKey}%"
		}
		def result = CRUDService.list(AccessLog,params){
			
			if(searchKey) {
				or {
					like "visitor", searchKey
					like "url", searchKey
					like "ip", searchKey
				}
			}
			
			if(params.startDate&&params.endDate) {
				//def date1=new java.sql.Date(sdf.parse(params.startDate).getTime())
				//def date2=new java.sql.Date(sdf.parse(params.endDate).getTime())
				def date1 = sdf.parse(params.startDate)
				def date2 = sdf.parse(params.endDate)
				and{
					between ("time", date1,date2)
				}
			}else if(params.startDate) {
				def date=sdf.parse(params.startDate)
			
					ge "time", date
				
			}else if(params.endDate) {
				def date=sdf.parse(params.endDate)
					le "time", date
			
			}else {
			}
			
			if(params.cityId){
				or{
					eq "city", City.get(params.cityId as Long).name //params.cityId
				}
			}
			
			if(params.type){
				or{
					eq "type", params.type
				}
			}
		}
		Map map = [totalCount:result.totalCount,rows:[]]
		result.list.each { AccessLog accessLog ->
			def data=[:]
			data.visitor = accessLog.visitor
			data.type = accessLog.type
			data.url = accessLog.url
			data.time = accessLog.time
			data.ip = accessLog.ip
			data.city = accessLog.city
			map.rows << data
		}
		def excelData = map.rows
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmSS")
		
		String[] Title=["序号","访问者","访问类型","链接","访问时间","IP","城市"];
		
		
		String fileName = sdf1.format(new Date())+"访问日志.xls"
		try {
		 OutputStream os = response.getOutputStream();
		 response.reset();
		 response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("GB2312"),"ISO8859-1"));
		 // 设定输出文件头
		 response.setContentType("application/msexcel");
		 
		
		 WritableWorkbook workbook = Workbook.createWorkbook(os);
		
		
		 WritableSheet sheet = workbook.createSheet("访问日志", 0);
		
		 SheetSettings sheetset = sheet.getSettings();
		 sheetset.setProtected(false);
		 sheetset.setDefaultColumnWidth(20)
		
		 WritableFont NormalFont = new WritableFont(WritableFont.ARIAL, 10);
		 WritableFont BoldFont = new WritableFont(WritableFont.ARIAL, 10,WritableFont.BOLD);
		
		 WritableCellFormat wcf_center = new WritableCellFormat(BoldFont);
		 wcf_center.setBackground(Colour.LIGHT_TURQUOISE);
		 wcf_center.setBorder(Border.ALL, BorderLineStyle.THIN);
		 wcf_center.setVerticalAlignment(VerticalAlignment.CENTRE);
		 wcf_center.setAlignment(Alignment.CENTRE);
		 wcf_center.setWrap(false);
		   
		 WritableCellFormat wcf_left = new WritableCellFormat(NormalFont);
		 wcf_left.setBorder(Border.NONE, BorderLineStyle.THIN);
		 wcf_left.setVerticalAlignment(VerticalAlignment.CENTRE);
		 wcf_left.setAlignment(Alignment.LEFT);
		 wcf_left.setWrap(false);
		 
		
		 String s;
		 for (int i = 0; i < Title.length; i++) {
		  sheet.addCell(new Label(i, 0,Title[i],wcf_center));
		 }
		 int i=1;
		 
		 for(int k = 0;k < excelData.size(); k++){
			 sheet.addCell(new Label(0, k+1,k+1+"",wcf_left))
			 sheet.addCell(new Label(1,k+1,excelData[k].visitor.toString(), wcf_left))
			 sheet.addCell(new Label(2,k+1,excelData[k].type.toString(), wcf_left))
			 sheet.addCell(new Label(3,k+1,excelData[k].url.toString(), wcf_left))
			 sheet.addCell(new Label(4,k+1,excelData[k].time.toString(), wcf_left))
			 sheet.addCell(new Label(5,k+1,excelData[k].ip.toString(), wcf_left))
			 sheet.addCell(new Label(6,k+1,excelData[k].city.toString(), wcf_left))
		 }

		 workbook.write();
		 workbook.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
