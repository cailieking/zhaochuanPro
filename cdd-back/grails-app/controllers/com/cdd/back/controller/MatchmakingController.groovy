package com.cdd.back.controller

import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.HSSFRow
import com.cdd.base.domain.Matchmaking;

class MatchmakingController extends BaseController{
	def excludeFields = ['salt', 'password']
	def model = 'matchmaking'
	SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
	
	def list() {
		def searchKey;
		if(params.search){
			searchKey="%${params.search}%"
		}
		
		render getList(model: model, domainClass: Matchmaking,excludeFields: excludeFields, isConjunction: true, queryHandler:{
			if(searchKey){
				or{
					like "saler" ,searchKey
					
				}
			}
			if(params.bookingNo){
				or{
					like "bookingNo" ,"%${params.bookingNo}%"
					
				}
			}
			if(params.blNo){
				or{
					like "blNo" ,"%${params.blNo}%"
					
				}
			}
			if(params.shipCompany){
				or{
					like "shipCompany" ,"%${params.shipCompany}%"
					
				}
			}
			if(params.startPort){
				or{
					like "startPort" ,"%${params.startPort}%"
					
				}
			}
			if(params.endPort){
				or{
					like "endPort" ,"%${params.endPort}%"
					
				}
			}
			if(params.route){
				or{
					like "route" ,"%${params.route}%"
					
				}
			}
			if(params.commitStratDate||params.commitEndDate){
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				def date1=sdf1.parse(params.commitStratDate);
				def date2=sdf1.parse(params.commitEndDate);
				
				and{
					
					 between ("commitDate" , date1,date2)
				}
			}
			
		}){ item, map ->
			map.dateCreated = sdf.format(item.dateCreated)
			map.commitDate = sdf.format(item.commitDate)
			map.startShipDate = sdf.format(item.startShipDate)
			
		};
	}
	
	def data() {
		render data(model: model, menuName: '撮合交易信息', domainClass: Matchmaking, excludeFields: excludeFields)
	}
	
	def importData() {
		final SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		importDataWithHandler() {
			HSSFRow row ->
			Matchmaking data = new Matchmaking()
			data.saler = row.getCell(0)?.stringCellValue?.trim() ?: null
			try {
				data.commitDate = row.getCell(1)?row.getCell(1).dateCellValue:null
			} catch(e) {
				data.commitDate = row.getCell(1)?.stringCellValue
			}
			try {
				data.startShipDate = row.getCell(2)?row.getCell(2).dateCellValue:null
			} catch(e) {
				data.startShipDate = row.getCell(2)?.stringCellValue
			}
			try {
				data.bookingNo  =row.getCell(3)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(3).numericCellValue).longValue()) : null
			} catch(e) {
				data.bookingNo  = row.getCell(3)?.stringCellValue
			}
			try {
				data.blNo  = row.getCell(4)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(4).numericCellValue).longValue()) : null
			} catch(e) {
				data.blNo  = row.getCell(4)?.stringCellValue
			}
			data.shipCompany = row.getCell(5)?.stringCellValue?.trim() ?: null
			data.cargoName = row.getCell(6)?.stringCellValue?.trim() ?: null
			data.offerName = row.getCell(7)?.stringCellValue?.trim() ?: null
			data.area = row.getCell(8)?.stringCellValue?.trim() ?: null
			try {
				data.companyScale  = row.getCell(9)?.numericCellValue ? String.valueOf(new BigDecimal(row.getCell(9).numericCellValue).longValue()) : null
			} catch(e) {
				data.companyScale  = row.getCell(9)?.stringCellValue
			}
			try {
				data.gp20  = row.getCell(10)?.numericCellValue ?: null
			} catch(e) {
				data.gp20  = row.getCell(10)?.stringCellValue
			}
			try {
				data.gp40  = row.getCell(11)?.numericCellValue ?: null
			} catch(e) {
				data.gp40  = row.getCell(11)?.stringCellValue
			}
			try {
				data.hq40  = row.getCell(12)?.numericCellValue ?: null
			} catch(e) {
				data.hq40  = row.getCell(12)?.stringCellValue
			}
			data.productName = row.getCell(13)?.stringCellValue?.trim() ?: null
			data.startPort = row.getCell(14)?.stringCellValue?.trim() ?: null
		    data.endPort = row.getCell(15)?.stringCellValue?.trim() ?: null
			data.route = row.getCell(16)?.stringCellValue?.trim() ?: null
			try {
				data.ofUsd  = row.getCell(17)?.numericCellValue ?: null
			} catch(e) {
				data.ofUsd  = row.getCell(17)?.stringCellValue
			}
			try {
				data.ispsUsd  = row.getCell(18)?.numericCellValue ?: null
			} catch(e) {
				data.ispsUsd  = row.getCell(18)?.stringCellValue
			}
			try {
				data.thcRmb  = row.getCell(19)?.numericCellValue ?: null
			} catch(e) {
				data.thcRmb  = row.getCell(19)?.stringCellValue
			}
			try {
				data.docRmb  = row.getCell(20)?.numericCellValue ?: null
			} catch(e) {
				data.docRmb  = row.getCell(20)?.stringCellValue
			}
			try {
				data.sealRmb  = row.getCell(21)?.numericCellValue ?: null
			} catch(e) {
				data.sealRmb  = row.getCell(21)?.stringCellValue
			}
			try {
				data.eirRmb  = row.getCell(22)?.numericCellValue ?: null
			} catch(e) {
				data.eirRmb  = row.getCell(22)?.stringCellValue
			}
			try {
				data.otherRmb  = row.getCell(23)?.numericCellValue ?: null
			} catch(e) {
				data.otherRmb  = row.getCell(23)?.stringCellValue
			}
			try {
				data.remark  = row.getCell(24)?.numericCellValue ?: null
			} catch(e) {
				data.remark  = row.getCell(24)?.stringCellValue
			}
			return data
		}
	}
	
	def downloadExample() {
		downloadExampleWithInfo(fileName: '撮合交易上传模板', suffix: 'xls', filePath: '/com/cdd/back/files/matchmaking.xls')
	}
}
