package com.cdd.back.controller


import grails.converters.JSON
import java.text.SimpleDateFormat
import com.cdd.base.domain.SearchLog
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.google.gson.JsonObject
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

import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject
import java.sql.Timestamp

class SearchLogController extends BaseController{
	def model = "searchLog"
	def limit = 10
	def offset = 0
	def state = false
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:MM:SS")
	SimpleDateFormat sdf1 = new SimpleDateFormat('yyyy-MM-dd')
	def list(){
		
		params.dataType = 'json'
		if(params.offset == null && params.limit == null){
			params.offset = offset
			params.limit = limit
		}
		def map = getLogs();
//		result?.collect{
//			//String str = Timestamp.valueOf(sdf.format(it.searchTime))
//			String st =  it.searchTime.toString()
//			//String st = sdf.format(it.searchTime)
//			
//			it.searchTime = sdf.parse(st)
//			println it.searchTime 
//		}
//		def startPort = params.startPort
//		def endPort = params.endPort
//		def shipCompany = params.shipCompany
//		def searchUser = params.searchUser
//		def startDate = params.startDate
//		def endDate = params.endDate
//		def searchSource = params.searchSource
//		def resultCount = params.resultCount 
//		
//		
//		def result = CRUDService.list(SearchLog,params){
//			if(startPort) {
//				info {
//					like "startPort", "%"+params.startPort+"%"
//				}
//			}
//			if(endPort){
//				info {
//						like "endPort", "%"+params.endPort+"%"
//					}
//			}
//			if(shipCompany){
//				and {
//					like "shipCompany", "%"+params.shipCompany+"%"
//				}
//			}
//			if(searchUser){
//				and {
//					like "searchUser", "%"+params.searchUser+"%"
//				}
//			}
//			if(startDate || endDate){
//				println "6"
//				SimpleDateFormat sdf1 = new SimpleDateFormat('yyyy-MM-dd')
//				def date1=sdf1.parse(startDate)
//				def date2=sdf1.parse(endDate)
//				and {
//					between ("searchTime", date1,date2)
//				}
//			}
//			if(searchSource){
//				and {
//					like "searchSource", "%"+searchSource+"%"
//				}
//			}
//			if(resultCount){
//				if(resultCount.equals('0')){
//					and{	
//						eq "resultCount" , 0
//					}
//				}
//				else if(resultCount.indexOf('~')>0){
//					def countArray = resultCount.split('~')
//					and{
//						between ("resultCount" ,countArray[0] as int ,countArray[1] as int)
//					}
//				}else if(!resultCount.equals("")){
//					and {
//						gt("resultCount" , 500)
//					}
//				
//				}else {
//				}
//			}
//		}
	//	Map map = [totalCount:result.totalCount,rows:result]
//		result.list.each { SearchLog info ->
//			map.rows << info
//		}
		
		if(!params.state){
			render view:"/${model}/list" ,model:[map:map] 
		}else{
			render map as JSON
		}
	}
	
	
	
	def export (){
		println params
		
		def result = getLogList()
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyymmddHHMMSS")
		
		String[] Title=["序号","起始港","目的港","船公司","结果数","耗时(秒)","搜索人","搜索时间","来源"];
		
		
		String fileName = sdf1.format(new Date())+"搜索日志.xls"
		try {
		 OutputStream os = response.getOutputStream();
		 response.reset();
		 response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("GB2312"),"ISO8859-1"));
		 // 设定输出文件头
		 response.setContentType("application/msexcel");
		 
		
		 WritableWorkbook workbook = Workbook.createWorkbook(os);
		
		
		 WritableSheet sheet = workbook.createSheet("搜索日志", 0);
		
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
		 
		 for(int k = 0;k < result.size(); k++){
			 sheet.addCell(new Label(0, k+1,k+1+"",wcf_left))
			 
			 for(int l = 0; l <result[k].size(); l++){
				 	if(result[k][l] !=null ){
						 sheet.addCell(new Label(l+1, k+1,result[k][l].toString(), wcf_left))
					}else{
						 sheet.addCell(new Label(l+1, k+1,"-", wcf_left))
					}
			 }
		 }

		 workbook.write();
		 workbook.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	   }
		

	def getLogs(){
		
		def startPort = params.startPort
		def endPort = params.endPort
		def shipCompany = params.shipCompany
		def searchUser = params.searchUser
		def startDate = params.startDate
		def endDate = params.endDate
		def searchSource = params.searchSource
		def resultCount = params.resultCount
		
		
		def result = CRUDService.list(SearchLog,params){
			if(startPort) {
				and {
					like "startPort", "%"+params.startPort+"%"
				}
			}
			if(endPort){
				and {
						like "endPort", "%"+params.endPort+"%"
					}
			}
			if(shipCompany){
				and {
					like "shipCompany", "%"+params.shipCompany+"%"
				}
			}
			if(searchUser){
				and {
					like "searchUser", "%"+params.searchUser+"%"
				}
			}
			if(startDate && endDate){
				def date1=sdf1.parse(startDate)
				def date2=sdf1.parse(endDate)
				and {
					between ("searchTime", date1,date2)
				}
			}else if(startDate){
				def date=sdf1.parse(startDate)
				and {
					between ("searchTime", date,date+1)
				}
			}else if(endDate){
				def date=sdf1.parse(endDate)
					and {
						between ("searchTime", date,date+1)
					}
			}else{
			
			}
			if(searchSource){
				and {
					like "searchSource", "%"+searchSource+"%"
				}
			}
			if(resultCount){
				if(resultCount.equals('0')){
					and{
						eq "resultCount" , 0
					}
				}
				else if(resultCount.indexOf('~')>0){
					def countArray = resultCount.split('~')
					and{
						between ("resultCount" ,countArray[0] as int ,countArray[1] as int)
					}
				}else if(!resultCount.equals("")){
					and {
						gt("resultCount" , 500)
					}
				
				}else {
				}
			}
		}
		Map map = [totalCount:result.totalCount,rows:result]
		return map
	} 
	
	def getLogList(){
		StringBuffer sql = new StringBuffer()
		sql.append("select start_port,end_port,ship_company,result_count,consuming,search_user,search_time,search_source from search_log where 1=1 ")
//		def searchArguments= params.searchArguments

		def startPort = params.startPort
		
		def endPort = params.endPort
		def shipCompany = params.shipCompany
		def searchUser = params.searchUser
		def startDate = params.startDate
		def endDate = params.endDate
		def searchSource = params.searchSource
		def resultCount = params.resultCount
		
		if(startPort.trim() != "" ) {
			sql.append(" and start_port like  '%"+startPort+"%' ")
		}
	 
		if(endPort.trim() != "" ){
			sql.append(" and end_port like  '%"+endPort+"%' ")
			
		}
			
		if(shipCompany != ""){
			sql.append( " and ship_company like  '%"+shipCompany+"%' ")
		}
		if(searchUser != ""){
			sql.append( " and search_user like  '%"+searchUser+"%' ")
		}
		if(startDate != '' && endDate != ''){
			def date1=sdf1.parse(startDate)
			def date2=sdf1.parse(endDate)
			sql.append(" and search_time between '"+startDate +"' and '" +endDate+"' " )
		
		}else if(startDate != ''){
			def date=sdf1.parse(startDate)
			sdf.parse(date+1)
			sql.append(" and search_time between '"+startDate +"' and '" +sdf.parse(date+1)+"' " )
		
		}else if(endDate != ''){
			def date=sdf1.parse(endDate)
			sql.append(" and search_time between '"+endDate +"' and '" +sdf.parse(date+1)+"' " )
		
		}else{
		
		}
		
		if(searchSource != ""){
			sql.append( " and search_source like '%"+searchSource+"%' ")
		}
		if(resultCount){
			if(resultCount.equals('0')){
				sql.append( " and result_count=0 ")
			}
			else if(resultCount.indexOf('~')>0){
				def countArray = resultCount.split('~')
				sql.append(" and result_count between "+countArray[0]+" and " +countArray[1] )
			
			}else if(!resultCount.equals("")){
				sql.append(" and result_count > 500 ")
			
			}else {
			
			}
		}
		def query = sessionFactory.currentSession.createSQLQuery(sql.toString())
		println query.list()
		return query.list()
		
	}
}
