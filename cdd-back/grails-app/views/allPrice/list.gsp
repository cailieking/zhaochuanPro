<!DOCTYPE html>
<html>
<head>
<title>全部应价</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/inquiry_common.css" />
<asset:stylesheet src="c_css/inquiry_all.css" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
<asset:javascript src="c_js/common.js" />
<g:set var="menuService" bean="menuService" />
</head>
<body>
<div class="shipListEidts">
    <div class="manage_md_right">
    	<ul class="rightNav1" style="width:1200px;">
            <li class="sel"><a>全部应价</a></li>
        </ul>
        <!-- 部门询盘 -->
        <div class="inpuiry_manage_all">
        	<div class="rControlLine" style="position:relative;">
        		<div class="txt1"><span name="time_slot" class="blue hand">今天</span></div>
        		<div class="txt1"><span name="time_slot" class="blue hand">昨天</span></div>
        		<div class="txt1"><span name="time_slot" class="blue hand">本周</span></div>
        		<div class="txt1"><span name="time_slot" class="blue hand">本月</span></div>
        		<div class="txt1" style="margin-left:20px;">时间段：</div>
        		<input class="box1" type="text" placeholder="开始时间" id="start_date" onClick="WdatePicker()"/>
        		<div class="txt1" style="margin:0;">-</div>
        		<input class="box1" type="text" placeholder="结束时间" style="margin-right:20px;" id="end_date" onClick="WdatePicker()"/>
        		<input class="box1" type="text" placeholder="询盘编号/客户名称" id="searchKey"/>
                <div class="btnL btnMod1" style="margin-right:20px;" onclick="search(event)">查询</div>
        	</div>
        	<div class="rControlLine" style="position:relative;">
        				<div class="txt1"><span class="blue" onclick="search(event)" name="终止">终止</span><span class="orange" id="stop">（12）</span></div>
                <div class="txt1"><span class="blue" onclick="search(event)"  name="订舱">订舱</span><span class="orange" id="booking">（34）</span></div>
                <div class="txt1"><span class="blue" onclick="search(event)" name="已应价">已应价</span><span class="orange" id="bidding">（134）</span></div>
                <div class="txt1"><span class="blue" onclick="search(event)" name="补充询盘">补充询盘</span><span class="orange" id="supplement">（12）</span></div>
                <div class="txt1"><span class="new" onclick="search(event)" name="新询盘">new</span><span class="orange" id="new">（134）</span></div>
                <div class="txt1" style="margin-left:10px;">专员：</div>
                <select class="select1" id="deal_select" onchange = "search(event)">
                	<option >全部</option>
                	<g:each in="${menuService.deals}" var="user" status="m">
                	<option value="${user.firstname}">${user.firstname}</option>
                	</g:each>
                </select>
                <div class="txt1" style="margin-left:10px;">航线：</div>
                <select class="select1" id="route_select" onchange = "search(event)">
                	<option >全部</option>
                	<g:each in="${menuService.routes}" var="route" status="m">
                	<option value="${route.routeName}">${route.routeName}</option>
                	</g:each>
                </select>
        	</div>
        	<table class="im_table">
        	</table>
        	<div class="rControlLine" style="position:relative;">
        		<div class="txt1"><span>总数：</span><span class="orange" id="total_count">（12）</span></div>
        		<div class="txt1">
        			<span>每页显示：</span>
        			<span class="blue hand" name="result_count">50</span>
        			<span class="blue hand" name="result_count">100</span>
        			<span class="blue hand" name="result_count">500</span>
        		</div>
        		<div class="im_pageBg"></div>
        	</div>
        	
        </div>
        <!-- 部门询盘 end -->
    </div>
</div>

<script>
$(function(){
	/*setCommonPage2Event($('.im_pageBg'),11,function(num){//初始化翻页控件 common.js中定义
		zcAlert(num+'页');
	})*/
	search(null)
	initresult()
	initDateInquirys()
	//initInquirys()
})
var dtd = $.Deferred();
var searchArgs = {
	startDate:	null,
	endDate:	null,
	timeSlot:	null,
	seacrhKey:	null,
	dealName : null,
	routeName : null,
	resultCount:	10,
	pageNum:	1,
	pageOffSet:	0,
	state : null
}
var pageTotal

function initresult(){
	$("span[name=result_count]").on("click",function(){
		searchArgs.resultCount = parseInt($(this).text())
		searchArgs.pageOffSet = 0
		search(null)	
	})
	
}

function search(event){
	 
	if(event != null){
		if($(event.target).text() == "查询" || event.target.tagName == "SELECT"){
			searchArgs.state = null
			searchArgs.resultCount = 10
			
		}else if($(event.target).text() == "new"){
			searchArgs.state = "新询盘"
		}else {
			searchArgs.state = $(event.target).text() 
		}
	}
	$.when(initInquirys()).done(function(){
		if(isNaN(pageTotal)){
			return 
		}else{
			setCommonPage2Event($('.im_pageBg'),pageTotal,function(num){
				pageNum = num
				searchArgs.pageOffSet = (num-1)*searchArgs.resultCount 
				initInquirys()
			})
		}
	})
}

function initDateInquirys(){
	console.log($("span[name=time_slot]"))
	$("span[name=time_slot]").on("click",function(){
		searchArgs.timeSlot = $(this).text()
		searchArgs.state = null
		searchArgs.resultCount = 10
		searchArgs.pageOffSet = 0
		search(null)
	})
}


function initInquirys(){
	var dtd = $.Deferred();
	searchArgs.searchKey = $("#searchKey").val()
	searchArgs.startDate = $("#start_date").val()
	searchArgs.endDate = $("#end_date").val()
	searchArgs.routeName = $("#route_select").val()
	searchArgs.dealName = $("#deal_select").val()
	
	$.ajax({
		url:  "/allPrice/listPrice",
		type: "post",
		dataType: 'json',
		data: searchArgs,
		success:function(rs){
				var rows = rs.rows
				var count = rs.count
				var state_counts = rs.stateCounts
				var status_count = {
					new:  0,
					stop: 0,
					booking: 0,
					bidding: 0,
					supplement: 0
				}
				$(".rControlLine .orange").text("("+rs.totalcount+")")
				//clients = rs.rows
				$(".im_table").empty()
				var tb = '<thead>'+
        		'<tr><th width="125">询盘编号</th>'+
    			'<th width="150">起始港</th>'+
    			'<th width="170">目的港</th>'+
    			'<th width="150">航线</th>'+
    			'<th width="195">客户</th>'+
    			'<th width="80">状态</th>'+
    			'<th width="80">交易专员</th>'+
    			'<th width="80">商务专员</th>'+
    			'<th width="85">日期</th>'+
    			'<th width="80">时间</th></tr></thead><tr style="height:10px;border:0;"></tr><tbody>'
	       		for(var i in rows){
	       			if(rows[5] == "新询盘"){
	       				tb += '<tr>'+
	        			'<td><span class="im_name" onClick="inquiryHistory('+"rows[i][0]"+')">'+rows[i][0]+'<span class="new">New</span></span></td>'
	       			}else{
	       				tb += '<tr>'+
	        				'<td><span class="im_name" onClick="inquiryHistory(event)">'+rows[i][0]+'</span></td>' 
	       			}
	       			
	       			tb +=  
	        			'<td>'+(rows[i][1]||'-')+'</td>'+
	        			'<td>'+(rows[i][2]||'-')+'</td>'+
	        			'<td>'+(rows[i][3]||'-')+'</td>'+
	        			'<td>'+(rows[i][4]||'-')+'</td>'
	        		
	        		switch(rows[i][5]){
	        			case "新询盘" : tb += '<td><span class="orange">新询盘</span></td>'
	        						status_count.new++ 
	        						break;
	        			case "已应价" : tb += '<td><span  class="yellow">已应价</span></td>'
	        						status_count.bidding++ 
	        						break;
	        			case "补充询盘" : tb += '<td><span class="red">补充询盘</span></td>'
	        						status_count.supplement++
	        						break;
	        			case "订舱" : tb += '<td><span class="green">订舱</span></td>'
	        						status_count.booking++
	        						break;
						case "终止" : tb += '<td><span class="black">终止</span></td>'
									status_count.stop++
	        						break;
	        			default :	break; 			        						
	        		}	
	        			
	        			tb += '<td>'+rows[i][6]+'</td>'+
	        			'<td>'+rows[i][7]+'</td>'
	        		var date = new Date(rows[i][8])
	        		var dateTime = date.getFullYear()
              			 + "-"
              			 + ((date.getMonth() + 1) > 10 ? (date.getMonth() + 1) : "0"
                      	 + (date.getMonth() + 1))
              			 + "-"
             	  		 + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate())
              			 + " "
              		var time = 
              			 + (date.getHours() < 10 ? "0" + date.getHours() : date.getHours())
              			 + ":"
               		 + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes())
              			 + ":"
             			 + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds());
	        			
               		tb += '<td>'+dateTime+'</td>'+
	        			'<td>'+time+'</td>'+
	        		'</tr>'
	       		}	

       			
	       		tb += '</tbody>'	
				$(".im_table").append(tb)
				var all_count = 0;
				for(var k in state_counts){
						if(k == "新询盘"){
							$("#new").text("("+state_counts[k]+")")
						}else {
							$("span[name="+k+"]").next().text("("+state_counts[k]+")")
						}
						 all_count += parseInt(state_counts[k])
				}
				
				$("#total_count").text("("+all_count+")")
				
				/*if(count != undefined){
					$("#total_count").text("("+count+")")
				}else{
					$("#total_count").text("(0)")
				}*/
				//$("#total_count").text("("+count+")")
				pageTotal = count % searchArgs.resultCount > 0 ? Math.floor(count/ searchArgs.resultCount) + 1 :  count / searchArgs.resultCount
				dtd.resolve()
				
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				console.log(XMLHttpRequest)
				console.log(textStatus)
				console.log(errorThrown)
			}
		})
		return dtd.promise()
		//return dtd
}

//询盘记录
function inquiryHistory(eve){

		
		var inpuiryNo = $(eve.target).text()
		$.ajax({
				type:'post',
				url:'/allPrice/detailPrice',
				dataType:'json',
				data:{number:inpuiryNo},
				success:function(rs){
						showAll(rs)
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
						console.log(XMLHttpRequest)
						console.log(textStatus)
						console.log(errorThrown)
					}
		
		})
}


function showAll(rs){
	//'<div class="caption">询盘编号：'+rs.inquiry.number+'</div>'
	//'<span class="t_status yellow">有应价</span>'+
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod inpuiryHistory">'+
    	'<div class="titleBg">'+
        	'<div class="caption">询盘编号：'+rs.inquiry.number+'</div>'+
        	'<span class="t_status yellow">'+rs.inquiry.inquiryStatus+'</span>'+
        	'<span class="t_details" data-number="'+rs.inquiry.number+'" onClick="inquiryDetails($(this))" >详情</span>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="t_data_grid" style="background:#fff;">'+
			'<ul class="t_data_list">'+
				'<li>'+
					'<div class="t_label">客户：</div>'+
					'<div class="t_txt" style="color:#000;">'+rs.inquiry.companyName+'</div>'+
				'</li>'+
				'<li>'+
					'<div class="t_label">联系人：</div>'+
					'<div class="t_txt" style="color:#000;">'+rs.inquiry.customName+'</div>'+
				'</li>'+
			'</ul>'+
		'</div>'+
        '<div class="t_data_history">'+
			'<div class="t_data_grid">'+
				'<div class="t_title">'
				
				var datas = rs.price.textarea1.split(";")
				
				doHtml +='<div class="time">'+datas[0]+'</div>'+
					'<div class="name"></div>'+
				'</div>'+
				'<ul class="t_data_list">'+
					'<li>'+
						'<div class="t_label">起始港：</div>'+
						'<div class="t_txt">'+datas[1]+'</div>'+
					'</li>'+
					'<li>'+
						'<div class="t_label">目的港：</div>'+
						'<div class="t_txt">'+datas[2]+'</div>'+
					'</li>'+
					'<li>'+
						'<div class="t_label">柜型：</div>'+
						'<div class="t_txt">'+datas[4]+'</div>'+
					'</li>'+
					'<li>'+
						'<div class="t_label">柜量：</div>'+
						'<div class="t_txt">'+datas[3]+'</div>'+
					'</li>'+
				'</ul>'+
			'</div>'
			
			
			if(rs.price.textarea2 !=null && rs.price.textarea2 != ""){
				var datas = rs.price.textarea2.split(";")
				var time = datas[0].split("^")[0]
				var name = datas[0].split("^")[1]
				
				doHtml += '<div class="t_data_grid yellow">'+
				'<div class="t_title">'+
					'<div class="time">'+time+'</div>'+
					'<div class="name">'+name+'</div>'+
				'</div>'+
				'<ul class="t_data_list">'
					for(var i=1;i<datas.length-1;i++){
							var label=datas[i].split('^')[0];
							var txt=datas[i].split('^')[1];
							doHtml +=
							'<li>'+
								'<div class="t_label">'+label+'：</div>'+
								'<div class="t_txt">'+txt+'</div>'+
							'</li>'
					}
				
				doHtml += 	'</ul></div>'
			}
			
			
			if(rs.price.textarea3 !=null && rs.price.textarea3 != ""){
				var datas = rs.price.textarea3.split(";")
				var time = datas[0].split("^")[0]
				var name = datas[0].split("^")[1]
				
				doHtml += '<div class="t_data_grid">'+
				'<div class="t_title">'+
					'<div class="time">'+time+'</div>'+
					'<div class="name">'+name+'</div>'+
				'</div>'+
				'<ul class="t_data_list">'
					for(var i=1;i<datas.length-1;i++){
							var label=datas[i].split('^')[0];
							var txt=datas[i].split('^')[1];
							doHtml +=
							'<li>'+
								'<div class="t_label">'+label+'：</div>'+
								'<div class="t_txt">'+txt+'</div>'+
							'</li>'
					}
				
				doHtml += 	'</ul></div>'
			}
			
			if(rs.price.textarea4 !=null && rs.price.textarea4 != ""){
				var datas = rs.price.textarea4.split(";")
				var time = datas[0].split("^")[0]
				var name = datas[0].split("^")[1]
				
				doHtml += '<div class="t_data_grid yellow">'+
				'<div class="t_title">'+
					'<div class="time">'+time+'</div>'+
					'<div class="name">'+name+'</div>'+
				'</div>'+
				'<ul class="t_data_list">'
					for(var i=1;i<datas.length-1;i++){
							var label=datas[i].split('^')[0];
							var txt=datas[i].split('^')[1];
							doHtml +=
							'<li>'+
								'<div class="t_label">'+label+'：</div>'+
								'<div class="t_txt">'+txt+'</div>'+
							'</li>'
					}
				
				doHtml += 	'</ul></div>'
			}
			
			if(rs.inquiry.inquiryStatus == "终止"){
				doHtml +=  '<div class="t_data_grid black">'+
					'<div class="t_title">'+
						'<div class="time">'+rs.inquiry.lastUpdated+'</div>'+
						'<div class="name">'+rs.inquiry.updateBy+'</div>'+
					'</div>'+
					'<ul class="t_data_list">'+
						'<li class="white">'+
							'<div class="t_label">终止原因：</div>'+
							'<div class="t_txt">'+rs.inquiry.finalReason+'</div>'+
						'</li>'+
					'</ul>'+
				'</div>'+
			'</div>'
			}
			
			doHtml +=
		'<div class="t_bottom">'+
			'<div class="btnMod1" onClick="inquiryStop(event)">终止</div>'+
			'<div class="btnMod1" onClick="inquirySuppl(event)"  data-number='+rs.inquiry.number+'>补充</div>'+
		'</div>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.inpuiryHistory'));

}

//询盘详情
function inquiryDetails(number){
	var num=number.attr('data-number');
	console.log('num',num)
	$.ajax({
				type:'post',
				url:'/inquiryOfferPrice/getDetails',
				dataType:'json',
				data:{number:num},
				success:function(rs){
				console.log('rs',rs.inquiryPrice)
				var data = rs.inquiryPrice;
				var boxesStr='';
				if(data.gp20){
					boxesStr+='gp20*'+data.gp20+' ';
				}
				if(data.gp40){
					boxesStr+='gp40*'+data.gp40+' ';
				}
				if(data.hq40){
					boxesStr+='hq40*'+data.hq40+' ';
				}
				if(data.hq45){
					boxesStr+='hq45*'+data.hq45;
				}
				var startFreeDemurrage="";
				var endFreeDemurrage = "";
				if(data.freeDemurrage){
					startFreeDemurrage = data.freeDemurrage.split(",")[0];
				    endFreeDemurrage = data.freeDemurrage.split(",")[1];
				}
				
				var startFreeDemurrageBusiness = "";
				var endFreeDemurrageBusiness = "";
				if(data.freeDemurrageBusiness){
				 	startFreeDemurrageBusiness = data.freeDemurrageBusiness.split(",")[0];
				 	endFreeDemurrageBusiness = data.freeDemurrageBusiness.split(",")[1];
					}
				
				var priceStr="";
				if(data.priceGp20&&data.priceGp20!=''&&data.priceGp20!='null'){
					priceStr+='<span>20GP </span><span style="color:#666666;padding-right:8px;">$'+data.priceGp20+'</span>';
				}
				if(data.priceGp40&&data.priceGp40!=''&&data.priceGp40!='null'){
					priceStr+='<span>40GP </span><span style="color:#666666;padding-right:8px;">$'+data.priceGp40+'</span>';
				}
				if(data.priceHq40&&data.priceHq40!=''&&data.priceHq40!='null'){
					priceStr+='<span>40HQ </span><span style="color:#666666;padding-right:8px;">$'+data.priceHq40+'</span>';
				}
				if(data.priceHq45&&data.priceHq45!=''&&data.priceHq45!='null'){
					priceStr+='<span>45HQ </span><span style="color:#666666;padding-right:8px;">$'+data.priceHq45+'</span>';
				}
				var newPriceStr="";
				if(data.newGp20&&data.newGp20!=''&&data.newGp20!='null'){
					newPriceStr+='<span>20GP </span><span style="color:#666666;padding-right:8px;">$'+data.newGp20+'</span>';
				}
				if(data.newGp40&&data.newGp40!=''&&data.newGp40!='null'){
					newPriceStr+='<span>40GP </span><span style="color:#666666;padding-right:8px;">$'+data.newGp40+'</span>';
				}
				if(data.newHq40&&data.newHq40!=''&&data.newHq40!='null'){
					newPriceStr+='<span>40HQ </span><span style="color:#666666;padding-right:8px;">$'+data.newHq40+'</span>';
				}
				if(data.newHq45&&data.newHq45!=''&&data.newHq45!='null'){
					newPriceStr+='<span>45HQ </span><span style="color:#666666;padding-right:8px;">$'+data.newHq45+'</span>';
				}

	var sendTimeStr = '';
	if(data.sendTime){
		sendTimeStr = '<div class="d_txt">'+new Date(data.sendTime).toLocaleDateString()+'</div>';
	}
	
	
	var finalReasonStr ='';
	if(data.inquiryStatus=='终止'){
		finalReasonStr = '<div class="d_left">'+
        		'<div>'+
        			'<div class="dl_label">状态：</div>'+
        			'<div class="dl_txt">终止</div>'+
        		'</div>'+
        		'<div>'+
        			'<div class="dl_label">终止方：</div>'+
        			'<div class="dl_txt">'+data.updateBy+'</div>'+
        		'</div>'+
        	'</div>'+
        	'<div class="d_md">'+
        		'<div class="dm_label">终止原因：</div>'+
        		'<div class="dm_txt">'+data.finalReason+'</div>'+
        	'</div>';
	}
	var doHtml=
			'<div class="winModBg0">'+
			'<div class="winModBg wEditMod inquiryDetails">'+
	    	'<div class="titleBg">'+
	        	'<div class="caption">详情</div>'+
	            '<div class="closeBtn">X</div>'+
	        '</div>'+
        	'<div class="detailsContent">'+
        	'<div class="details_left">'+
        		'<div class="d_title">询盘</div>'+
        		'<ul class="editList" id="detailsLeftList">'+
        			'<li>'+
		            	'<div class="wLabel">起始港：</div>'+
		                '<div class="d_txt">'+data.startPort+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">目的港：</div>'+
		                '<div class="d_txt">'+data.endPort+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">柜型柜量：</div>'+
		                '<div class="d_txt">'+
		                	'<span style="padding-right:15px;">'+boxesStr+'</span>'+
		                '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">指定船公司：</div>'+
		                '<div class="d_txt">'+(data.shipCompany||'-')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物类型：</div>'+
		                '<div class="d_txt">'+(data.ordersType||'-')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">品名：</div>'+
		                '<div class="d_txt">'+(data.ordersName||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货重：</div>'+
		                '<div class="d_txt"><span>'+(data.weight||'')+'</span><span style="padding-left:15px;color:#000;">吨</span></div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物状态：</div>'+
		                '<div class="d_txt">'+(data.ordersStatus||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">出货时间：</div>'+
		                	sendTimeStr+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">特种柜要求：</div>'+
		                '<div class="d_txt">'+(data.specialContainer||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">免柜期要求：</div>'+
		                '<div class="d_txt">'+
			                '<span style="color:#000;">起始港</span><span style="padding:0 8px;">'+(startFreeDemurrage||'-')+'</span><span style="color:#000;padding-right:20px;">天</span>'+
							'<span style="color:#000;">目的港</span><span style="padding:0 8px;">'+(endFreeDemurrage||'-')+'</span><span style="color:#000;">天</span>'+
		                 '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">Shipper：</div>'+
		                '<div class="d_txt">'+(data.shipper||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">说明：</div>'+
		                '<div class="d_txt">'+(data.remarks||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">补充说明：</div>'+
		                '<div class="d_txt">'+(data.otherRemarks||'')+'</div>'+
		            '</li>'+
        		'</ul>'+
        		'<div class="d_bottom">'+
        			'<div class="btnMod1" id="detailsLeftCopyBtn">复制到粘贴板</div>'+
        			'<textarea id="detailsLeftCopyText" style="width:0px;height:0px;opacity:0;filter:alpha(opacity=0);"></textarea>'+
        		'</div>'+
        	'</div>'+
        	'<div class="details_right">'+
        		'<div class="d_title">应价</div>'+
        		'<ul class="editList" id="detailsRightList">'+
        			'<li>'+
		            	'<div class="wLabel">起始港：</div>'+
		                '<div class="d_txt">'+data.startPort+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">目的港：</div>'+
		                '<div class="d_txt">'+data.endPort+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">价格：</div>'+
		                '<div class="d_txt">'+
		                	priceStr+
		                '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">最新价格：</div>'+
		                '<div class="d_txt">'+
		                	newPriceStr+
		                '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">船公司：</div>'+
		                '<div class="d_txt">'+(data.shipCompanyBusiness||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">船期：</div>'+
		                '<div class="d_txt">'+(data.shippingDayBusiness||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">限重：</div>'+
		                '<div class="d_txt"><span>'+(data.weightLimit||'')+'</span><span style="padding-left:15px;color:#000;">吨</span></div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">航程：</div>'+
		                '<div class="d_txt"><span>'+(data.shippingdays||'')+'</span><span style="padding-left:15px;color:#000;">天</span></div>'+
		            '</li>'+
		            
		            '<li>'+
		            	'<div class="wLabel">免柜期要求：</div>'+
		                '<div class="d_txt">'+
			                '<span style="color:#000;">起始港</span><span style="padding:0 8px;">'+(startFreeDemurrageBusiness||'-')+'</span><span style="color:#000;padding-right:20px;">天</span>'+
							'<span style="color:#000;">目的港</span><span style="padding:0 8px;">'+(endFreeDemurrageBusiness||'-')+'</span><span style="color:#000;">天</span>'+
		                 '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">说明：</div>'+
		                '<div class="d_txt">'+(data.priceRemarks||'')+'</div>'+
		            '</li>'+
		            
        		'</ul>'+
        		'<div class="d_bottom">'+
        			'<div class="btnMod1" id="detailsRightCopyBtn">复制到粘贴板</div>'+
        			'<textarea id="detailsRightCopyText" style="width:0px;height:0px;opacity:0;filter:alpha(opacity=0);"></textarea>'+
        		'</div>'+
        	'</div>'+
        '</div>'+
        '<div class="detailsBottom">'+
        	finalReasonStr+
        	'<div class="d_right">'+
        		'<div class="btnMod1" id="detailsClose">关闭</div>'+
        	'</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.inquiryDetails'));
	//关闭按钮
	$('#detailsClose').click(function(){
		$('.inquiryDetails .closeBtn').trigger('click');
	})
	//复制询盘
	$('#detailsLeftCopyBtn').click(function(){
		detailsLeftCopy();
	});
	//复制应价
	$('#detailsRightCopyBtn').click(function(){
		detailsRightCopy();
	});   
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
						console.log(XMLHttpRequest)
						console.log(textStatus)
						console.log(errorThrown)
				}
			
		})
	
}


//复制询盘
function detailsLeftCopy(){
	var lists=$('#detailsLeftList>li');
	var copyTxt='';
	for(var i=0;i<lists.length;i++){
		var thisLi=lists.eq(i);
		copyTxt+= thisLi.children('.wLabel').html();
		if(thisLi.find('.d_txt>span').length>0){
			var spans=thisLi.find('.d_txt>span');
			for(var j=0;j<spans.length;j++){
				copyTxt+=spans.eq(j).html()+' ';
			}
		}else{
			copyTxt+=thisLi.children('.d_txt').html();
		}
		copyTxt+='&#13;&#10;';
	}
	$('#detailsLeftCopyText').html(copyTxt);
	$('#detailsLeftCopyText').get(0).select();
	if(document.execCommand("Copy")){
		document.execCommand("Copy");
		zcAlert("复制成功");
	}else{
		zcAlert('复制失败，请检查浏览器是否允许访问粘贴板')
	}
}
//复制应价
function detailsRightCopy(){
	var lists=$('#detailsRightList>li');
	var copyTxt='';
	for(var i=0;i<lists.length;i++){
		var thisLi=lists.eq(i);
		copyTxt+= thisLi.children('.wLabel').html();
		if(thisLi.find('.d_txt>span').length>0){
			var spans=thisLi.find('.d_txt>span');
			for(var j=0;j<spans.length;j++){
				copyTxt+=spans.eq(j).html()+' ';
			}
		}else{
			copyTxt+=thisLi.children('.d_txt').html();
		}
		copyTxt+='&#13;&#10;';
	}
	$('#detailsRightCopyText').html(copyTxt);
	$('#detailsRightCopyText').get(0).select();
	if(document.execCommand("Copy")){
		document.execCommand("Copy");
		zcAlert("复制成功");
	}else{
		zcAlert('复制失败，请检查浏览器是否允许访问粘贴板')
	}
}
//去除字符窜中的标签
function removeHTMLTag(str) {
	str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
	str = str.replace(/[ | ]*\n/g,''); //去除行尾空白
	str = str.replace(/\n[\s| | ]*\r/g,''); //去除多余空行
	str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
	return str;
}

//终止询盘
function inquiryStop(number){

var num=number.attr('data-number');
console.log('num',num)
	
var doHtml=
	'<div class="winModBg0">'+
	'<div class="winModBg inquiryStop wEditMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">终止</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="is_top">'+
        	'<input id="stopSuccess" type="checkbox" />'+
        	'<span class="red">订舱成功</span>'+
        '</div>'+
        '<div class="is_mid">'+
        	'<div>'+
        		'<div class="reasonTitle">上游原因</div>'+
        		'<ul class="reason">'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因1</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因2</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因3</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因4</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="otherReason" type="checkbox" />'+
        				'<span>其他原因</span>'+
        				'<textarea></textarea>'+
        			'</li>'+
        		'</ul>'+
        	'</div>'+
        	'<div>'+
        		'<div class="reasonTitle">下游原因</div>'+
        		'<ul class="reason">'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因1</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因2</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因3</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="reason" type="checkbox" />'+
        				'<span>原因4</span>'+
        			'</li>'+
        			'<li>'+
        				'<input name="otherReason" type="checkbox" />'+
        				'<span>其他原因</span>'+
        				'<textarea></textarea>'+
        			'</li>'+
        		'</ul>'+
        	'</div>'+
        '</div>'+
        '<div class="is_btm">'+
        	'<div class="btnMod1" data-number="'+num+'" onClick="finishInquiry($(this))">确认</div>'+
        	'<div class="btnMod1" id="inquiryStopBack">返回</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.inquiryStop'));
	
	$('#inquiryStopBack').click(function(){
		$('.inquiryStop .closeBtn').trigger('click');
	})
	$('#stopSuccess').click(function(){
		if($(this).prop('checked')==true){
			$('.is_mid input[type="checkbox"]').prop('checked',false);
		}
	})
	$('.is_mid input[type="checkbox"]').click(function(){
		var midChecks=$('.is_mid input[type="checkbox"]');
		var isAllEmpty=1;
		for(var i=0;i<midChecks.length;i++){
			if(midChecks.eq(i).prop('checked')==true){
				isAllEmpty=0;
				break;
			}
		}
		if(isAllEmpty==0){
			$('#stopSuccess').prop('checked',false);
		}
	})

}
//补充询价
function inquirySuppl(eve){
	$(eve.target).attr("data-number")
	 num =$(eve.target).attr("data-number")
	//var num=number.attr('data-number');
	$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/getDetails',
			dataType:'json',
			data:{number:num},
			success:function(rs){
				console.log(rs.inquiryPrice)
				var data = rs.inquiryPrice
			var doHtml=
				'<div class="winModBg0">'+
					'<div class="winModBg inquirySuppl wEditMod">'+
				    	'<div class="titleBg">'+
				        	'<div class="caption">补充</div>'+
				        	'<span class="titleTime">'+new Date(data.lastUpdated).toLocaleDateString()+ new Date(data.lastUpdated).toLocaleTimeString()+'</span>'+
				        	'<span class="titleName">'+data.businessMan+'（<span class="green">在线</span>）</span>'+
				            '<div class="closeBtn">X</div>'+
				        '</div>'+
				        '<div class="isl_left">'+
				        	'<div class="addInpuiryContent">'+
						        	'<ul class="editList" style="display:block;">'+
		       			'<li>'+
			            	'<div class="wLabel red">报价：<div class="imp"></div></div>'+
			                '<ul class="inpuiryBoxes">'+
			                	'<li>'+
			                		'<div class="type">20GP</div>'+
			                		'<input type="text" value="'+(data.priceGp20||'-')+'" />'+
			                	'</li>'+
			                	'<li>'+
			                		'<div class="type">40GP</div>'+
			                		'<input type="text" value="'+(data.priceGp40||'-')+'" />'+
			                	'</li>'+
			                	'<li>'+
			                		'<div class="type">40HQ</div>'+
			                		'<input type="text" value="'+(data.priceHq40||'-')+'" />'+
			                	'</li>'+
			                	'<li>'+
			                		'<div class="type">45HQ</div>'+
			                		'<input type="text" value="'+(data.priceHq45||'-')+'" />'+
			                	'</li>'+
			                '</ul>'+
			            '</li>'+
			            '<li>'+
			            	'<div class="wLabel red">最新报价：<div class="imp"></div></div>'+
			                '<ul class="inpuiryBoxes">'+
			                	'<li>'+
			                		'<div class="type">20GP</div>'+
			                		'<input class="red" type="text" value="'+(data.newGp20||'-')+'" />'+
			                	'</li>'+
			                	'<li>'+
			                		'<div class="type">40GP</div>'+
			                		'<input class="red" type="text" value="'+(data.newGp40||'-')+'" />'+
			                	'</li>'+
			                	'<li>'+
			                		'<div class="type">40HQ</div>'+
			                		'<input class="red" type="text" value="'+(data.newHq40||'-')+'" />'+
			                	'</li>'+
			                	'<li>'+
			                		'<div class="type">45HQ</div>'+
			                		'<input class="red" type="text" value="'+(data.newHq45||'-')+'" />'+
			                	'</li>'+
			                '</ul>'+
			            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">可选船公司：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+(data.shipCompanyBusiness||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">船期：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+(data.shippingDayBusiness||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">航程：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+(data.shippingdays||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">限重：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+(data.weightLimit||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">应价说明：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+(data.priceRemarks||'')+'</div>'+
		            '</li>'+
		        '</ul>'+
		    '</div>'+
        '</div>'+
        '<div class="isl_right">'+
        	'<div class="addInpuiryContent">'+
        		'<ul class="editList" style="display:block;">'+
        			'<li>'+
		            	'<div class="wLabel red">起始港：<div class="imp"></div></div>'+
		                '<div class="isl_txt">'+data.startPort+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel red">目的港：<div class="imp"></div></div>'+
		                '<div class="isl_txt">'+data.endPort+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel red">柜型柜量：<div class="imp"></div></div>'+
		                '<ul class="inpuiryBoxes">'+
		                	'<li>'+
		                		'<div class="type">20GP</div>'+
		                		'<input id="inpuirySuppl20GP" type="text"  value="'+data.gp20+'"/>'+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">40GP</div>'+
		                		'<input id="inpuirySuppl40GP" type="text" value="'+data.gp40+'"/>'+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">40HQ</div>'+
		                		'<input id="inpuirySuppl40HQ" type="text" value="'+data.hq40+'"/>'+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">45HQ</div>'+
		                		'<input id="inpuirySuppl45HQ" type="text" value="'+data.hq45+'"/>'+
		                	'</li>'+
		                '</ul>'+
		            '</li>'+
        			'<li style="position:relative;z-index:1;">'+
		            	'<div class="wLabel">指定船公司：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" placeholder="可多选" id="companysInput" name="shipCompany" />'+
		                '<div class="companysBg">'+
		                	'<div class="topBg">'+
		                		'<div class="caption">请选择船公司</div>'+
		                		'<div class="blueBtn" id="companysOk">确定</div>'+
		                	'</div>'+
		                	'<div>'+
		                		'<div class="c_label">A-G</div>'+
		                		'<ul class="companyList">'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>APL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>COSCO</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>ANL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>CMA</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>CSCL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>DELMAS</span>'+
		                			'</li>'+
		                		'</ul>'+
		                	'</div>'+
		                	'<div>'+
		                		'<div class="c_label">H-J</div>'+
		                		'<ul class="companyList">'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>HMM</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>HPL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>IAL</span>'+
		                			'</li>'+
		                		'</ul>'+
		                	'</div>'+
		                	'<div>'+
		                		'<div class="c_label">L-S</div>'+
		                		'<ul class="companyList">'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>K-LINE</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>KMTC</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>MCC</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>MOL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>MSK</span>'+
		                			'</li>'+
		                		'</ul>'+
		                	'</div>'+
		                	'<div>'+
		                		'<div class="c_label">T-Z</div>'+
		                		'<ul class="companyList">'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>OOCL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>PHL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>PIL</span>'+
		                			'</li>'+
		                			'<li>'+
		                				'<input type="checkbox" data-name="companys" />'+
		                				'<span>RCL</span>'+
		                			'</li>'+
		                		'</ul>'+
		                	'</div>'+
		                	
		                '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物类型：<div class="imp"></div></div>'+
		                '<input type="radio" name="itemType" id="itemType_normal"/>'+
		                '<div class="a_label">普货</div>'+
		                '<input type="radio" name="itemType" id="itemType_special" value="普货"/>'+
		                '<div class="a_label">特殊货品</div>'+
		                '<input type="text" class="box1" id="itemType_special_box" style="display:none;" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">品名：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" id="ordesName" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货重：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" style="width:100px;" id="weight" />'+
		                '<div class="a_label">吨</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物状态：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" style="width:100px;" id="ordersStatus" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">出货时间：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" onClick="WdatePicker()" id="sendTime" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">特种柜要求：<div class="imp"></div></div>'+
		                '<input type="checkbox" id="needSpecial"/>'+
		                '<div class="a_label">需要特种柜</div>'+
		                '<input type="text" class="box1" id="needSpecialInput" style="display:none;" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">免柜期要求：<div class="imp"></div></div>'+
		            	'<div class="a_label" style="margin:0;">起始港-</div>'+
		                '<input type="text" class="box1" style="width:50px;" id="startFreeDemurrage"/>'+
		                '<div class="a_label" style="margin:0 30px 0 5px;">天</div>'+
		                '<div class="a_label" style="margin:0;">目的港-</div>'+
		                '<input type="text" class="box1" style="width:50px;"  id="endFreeDemurrage"/>'+
		                '<div class="a_label" style="margin:0 0 0 5px;">天</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">shipper：<div class="imp"></div></div>'+
		                '<textarea class="area1" id="addShipper">'+data.shipper+'</textarea>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">询价说明：<div class="imp"></div></div>'+
		                '<textarea class="area1" id="inquiryRemarks">'+data.remarks+'</textarea>'+
		            '</li>'+
        		'</ul>'+
		    '</div>'+
		    '<div class="addInpuiryBottom">'+
	        	'<div class="btnMod1" data-num="'+data.number+'" onClick="updateInquiry($(this))">提交</div>'+
	        	'<div class="btnMod1" id="inquiryAddCansel">取消</div>'+
		    '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.inquirySuppl'));
	$('#inquiryAddCansel').click(function(){
		$('.inquirySuppl .closeBtn').trigger('click');
	})
	

				
				//船公司列表显示
	$('#companysInput').click(function(){
		if($('.companysBg').css('display')=="none"){
			$('.companysBg').show();
		}else{
			$('.companysBg').hide();
		}
	})
	//船公司列表确定
	$('#companysOk').click(function(){
		var checkcs=$('.companyList input[data-name="companys"]:checked');
		var strChecks='';
		if(checkcs.length>0){
			for(var i=0;i<checkcs.length;i++){
				if(i!=checkcs.length-1){
					strChecks+=checkcs.eq(i).next().html()+'/';
				}else{
					strChecks+=checkcs.eq(i).next().html();
				}
			}
		}
		$('.companysBg').hide();
		$('#companysInput').val(strChecks);
	})
	//特殊货品输入框显示
	$('input[name="itemType"]').change(function(){
		if($('#itemType_special').prop('checked')==true){
			$('#itemType_special_box').show();
		}else{
			$('#itemType_special_box').hide();
		}
	})
	//特种柜输入框显示
	$('#needSpecial').change(function(){
		if($(this).prop('checked')==true){
			$('#needSpecialInput').show();
		}else{
			$('#needSpecialInput').hide();
		}
	})        
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
	
}
function updateInquiry(ele){
		var inquiryNumber =ele.attr('data-num');
		console.log('inquiryNumber',inquiryNumber)
		var sendData={};
		//柜量
		sendData.GP20=$('#inpuirySuppl20GP').val();
		sendData.GP40=$('#inpuirySuppl40GP').val();
		sendData.HQ40=$('#inpuirySuppl40HQ').val();
		sendData.HQ45=$('#inpuirySuppl45HQ').val();
		//船公司
		sendData.companys=$('#companysInput').val();
		//货物类型
		if($('#itemType_normal').prop('checked')==true){
			sendData.itemType='普货';
		}else if($('#itemType_special').prop('checked')==true){
			sendData.itemType=$('#itemType_special_box').val();
		}else{
			sendData.itemType='';
		}
		//品名
		sendData.ordesName=$('#ordesName').val();
		//货重
		sendData.weight=$('#weight').val();
		//货物状态
		sendData.ordersStatus=$('#ordersStatus').val();
		//出货时间
		sendData.sendTime=$('#sendTime').val();
		//特种柜要求
		if($('#needSpecial').prop('checked')==true){
			sendData.needSpecial=$('#needSpecialInput').val();
		}else{
			sendData.needSpecial='';
		}
		//免柜期要求
		sendData.freeDemurrage=$('#startFreeDemurrage').val()+','+$('#endFreeDemurrage').val();
		//shipper
		sendData.shipper=$('#addShipper').val();
		//询价说明
		sendData.remarks=$('#inquiryRemarks').val();
		sendData.number = inquiryNumber
		console.log('发送数据',sendData);
		
		$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/updateInquiry',
			dataType:'json',
			data:sendData,
			success:function(rs){
				if(rs.status == "ok"){
					$('.inquirySuppl .closeBtn').trigger('click');
					$('.inpuiryHistory .closeBtn').trigger('click');
					initDateInquirys()
					//window.location.reload();
				}
			},
		
			error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
		
		
	};
	
function finishInquiry(number){
	var num=number.attr('data-number');
	console.log('num',num)
	var data={};
	data.number = num;
	var success='';
	if($('#stopSuccess').prop('checked')==true){
		data.success=$('#stopSuccess').next().html();
	}
	
	var reason='';
	var reasonChecks=$('input[name="reason"]:checked');
	if(reasonChecks.length>0){
		for(var i=0;i<reasonChecks.length;i++){
			if(i<reasonChecks.length-1){
				reason+=reasonChecks.eq(i).next().html()+',';
			}else{
				reason+=reasonChecks.eq(i).next().html();
			}
			
		}
	}
	data.reason=reason;
	
	var otherReason='';
	var otherReasonChecks=$('input[name="otherReason"]:checked');
	if(otherReasonChecks.length>0){
		for(var i=0;i<otherReasonChecks.length;i++){
			if(i<otherReasonChecks.length-1){
				otherReason+=otherReasonChecks.eq(i).next().next().val()+',';
			}else{
				otherReason+=otherReasonChecks.eq(i).next().next().val();
			}
		}
	}
	data.otherReason=otherReason;
	console.log(data);
	
	 $.post("/inquiryOfferPrice/finishInquiry",data,function(data){
	 	if(data.status == "ok"){
	 		$('.inquiryStop .closeBtn').trigger('click');
	 		$('.inpuiryHistory .closeBtn').trigger('click');
	 		initDateInquirys()
	 		zcAlert("补充成功")
	 	}else{
	 		zcAlert("补充 失败")
	 	}
	 	//window.location.reload();
	 },"json");
}	

</script>
</body>
</html>
