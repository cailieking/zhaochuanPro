package com.cdd.back.controller

import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.LoginLog
import grails.converters.JSON

import java.text.DecimalFormat
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
class LoginLogController extends BaseController{
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
	def limit = 10
	def offset = 0
	def state = false
	def list() {
		if(params.offset == null && params.limit == null){
			params.offset = offset
			params.limit = limit
		}
		params.sort = 'loginTime'
		def result = CRUDService.list(LoginLog,params){
			if(params.username) {
				and {
					like "username", "%"+params.username+"%"
				}
			}
			
			if(params.startDate&&params.endDate) {
				//def date1=new java.sql.Date(sdf.parse(params.startDate).getTime())
				//def date2=new java.sql.Date(sdf.parse(params.endDate).getTime())
				def date1 = sdf.parse(params.startDate)
				def date2 = sdf.parse(params.endDate)
				and{
					between ("loginTime", date1,date2)
				}
			}else if(params.startDate) {
				def date=sdf.parse(params.startDate)
			
					ge "loginTime", date
				
			}else if(params.endDate) {
				def date=sdf.parse(params.endDate)
					le "loginTime", date
			
			}else {
			}
			
		}
		Map map = [totalCount:result.totalCount,rows:[]]
		result.list.each { LoginLog loginLog ->
			def data=[:]
			data.username = loginLog.username
			data.loginTime = loginLog.loginTime
			data.loginOutTime = loginLog.loginOutTime
			if(loginLog.loginTime&&loginLog.loginOutTime) {
			def aa = loginLog.loginOutTime.getTime() - loginLog.loginTime.getTime()
			def onlineTime =aa/60000
			DecimalFormat df = new DecimalFormat("######0.00")
			data.onlineTime =df.format(onlineTime)
			}else {
			data.onlineTime="-"
			}
			data.ip = loginLog.ip
			data.city = loginLog.city
			map.rows << data
		}
		if(!params.state){
			render view:"/loginLog/list",model:[map:map]
		}else {
			render map as JSON
		}
	}
	
	def export() {
		params.sort = 'loginTime'
		def result = CRUDService.list(LoginLog,params){
			if(params.username) {
				and {
					like "username", "%"+params.username+"%"
				}
			}
			
			if(params.startDate&&params.endDate) {
				def date1 = sdf.parse(params.startDate)
				def date2 = sdf.parse(params.endDate)
				and{
					between ("loginTime", date1,date2)
				}
			}else if(params.startDate) {
				def date=sdf.parse(params.startDate)
			
					ge "loginTime", date
				
			}else if(params.endDate) {
				def date=sdf.parse(params.endDate)
					le "loginTime", date
			
			}else {
			}
			
		}
		Map map = [rows:[]]
		result.list.each { LoginLog loginLog ->
			def data=[:]
			data.username = loginLog.username
			data.loginTime = loginLog.loginTime
			data.loginOutTime = loginLog.loginOutTime
			if(loginLog.loginTime&&loginLog.loginOutTime) {
			def aa = loginLog.loginOutTime.getTime() - loginLog.loginTime.getTime()
			def onlineTime =aa/60000
			DecimalFormat df = new DecimalFormat("######0.00")
			data.onlineTime =df.format(onlineTime)
			}else {
			data.onlineTime="-"
			}
			data.ip = loginLog.ip
			data.city = loginLog.city
			map.rows << data
		}
		
		def excelData = map.rows
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmSS")
		
		String[] Title=["序号","用户名","登录时间","退出时间","在线时长（分钟）","登录IP","城市"];
		
		
		String fileName = sdf1.format(new Date())+"登录日志.xls"
		try {
		 OutputStream os = response.getOutputStream();
		 response.reset();
		 response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("GB2312"),"ISO8859-1"));
		 // 设定输出文件头
		 response.setContentType("application/msexcel");
		 
		
		 WritableWorkbook workbook = Workbook.createWorkbook(os);
		
		
		 WritableSheet sheet = workbook.createSheet("登录日志", 0);
		
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
			 sheet.addCell(new Label(1,k+1,excelData[k].username.toString(), wcf_left))
			 sheet.addCell(new Label(2,k+1,excelData[k].loginTime.toString(), wcf_left))
			 sheet.addCell(new Label(3,k+1,excelData[k].loginOutTime.toString(), wcf_left))
			 sheet.addCell(new Label(4,k+1,excelData[k].onlineTime.toString(), wcf_left))
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
