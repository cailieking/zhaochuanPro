<%@page import="com.cdd.base.enums.ArticleType"%>
<!DOCTYPE html>
<html>
<head>
<title>文章管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/inquiry_common.css" />
<asset:stylesheet src="c_css/inquiry_all.css" />
<asset:stylesheet src="c_css/font-awesome.min.css" />
<asset:stylesheet src="c_css/article.css" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
<asset:javascript src="c_js/common.js" />
<g:set var="menuService" bean="menuService" />
</head>
<body>
<div class="shipListEidts">
    <div class="manage_md_right">
    	<!-- <ul class="rightNav1" style="width:1200px;">
            <li class="sel"><a>部门询盘</a></li>
        </ul> -->
        <!-- 部门询盘 -->
        <div class="inpuiry_manage_all">
        	<div class="rControlLine" style="position:relative;width:115%">
        		<%-- <div class="txt1"><span name="time_slot" class="blue hand">今天</span></div>
        		<div class="txt1"><span name="time_slot" class="blue hand">昨天</span></div>
        		<div class="txt1"><span name="time_slot" class="blue hand">本周</span></div>
        		<div class="txt1"><span name="time_slot" class="blue hand">本月</span></div>--%>
        		<span class="label0">查询条件:</span>
        		<input class="box1" type="text" placeholder="标题名称/创建人" id="searchKey" name="searchKey"/>
        		<div class="txt1" style="margin-left:20px;">时间段：</div>
        		<input class="box1" type="text" placeholder="开始时间" id="start_date" onClick="WdatePicker()"/>
        		<div class="txt1" style="margin:0;">-</div>
        		<input class="box1" type="text" placeholder="结束时间" style="margin-right:20px;" id="end_date" onClick="WdatePicker()"/>
        		
                <div class="btnL btnMod1" style="margin-right:20px;margin-left: 30px"" onclick="search(event)">查询</div>
                 <!--  <select class="select1" id="route_select" onchange = "search(event)">-->
                	<select name="type" class="select1" onchange = "search(event)" style="margin-left: 55px">
							<option value="">--请选择--</option>
							<g:each in="${ArticleType.values()}" var="type">
									<option value="${type.name()}">${type.text}</option>
							</g:each>
						</select>
               <!--  </select> -->
        	</div>
        	<div class="rControlLine" style="position:relative;width:115%" >
        		<div class="txt1"><span>查询结果：</span><span class="orange" name="total_count">（12）</span></div>
        		<div class="txt1">
        			<span>每页显示：</span>
        			<span class="blue hand" name="result_count">50</span>
        			<span class="blue hand" name="result_count">100</span>
        			<span class="blue hand" name="result_count">500</span>
        		</div>
        		<div class="txt1"><span class="blue" onclick="search(event)" name="draft" style="cursor: pointer;" >草稿 </span><span class="orange" id="stop">（12）</span></div>
                <div class="txt1"><span class="blue" onclick="search(event)"  name="stick" style="cursor: pointer;" >置顶</span><span class="orange" id="booking">（34）</span></div>
                <div class="txt1"><span class="blue" onclick="search(event)" name="tweet" style="cursor: pointer;" >特推</span><span class="orange" id="bidding">（134）</span></div>
              	<div class="btnR btnMod1" onClick="delArticles()" style="margin-right: 0">删除</div>
              	<div class="btnR btnMod1" onClick="updateCategory(3)" style="margin-right: 55px">取消特推</div>
              	<div class="btnR btnMod1" onClick="updateCategory(2)" style="margin-right: -15px">特推</div>
              	<div class="btnR btnMod1" onClick="updateCategory(1)">取消置顶</div>
              	<div class="btnR btnMod1" onClick="updateCategory(0)" style="margin-right: -15px">置顶</div>
              	<div class="btnR btnMod1" onClick="addGuestDlgShow()" style="margin-right: 55px;">新建</div>
        	</div>
        	<table class="im_table" style="width:115%"> <!-- class="im_table"  -->
        	</table>
        	<div class="rControlLine" style="position:relative;width: 115%">
        		 <div class="txt1"><span>查询结果：</span><span class="orange" name="total_count">（12）</span></div>
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
	//initDateInquirys()
	//initArticles()
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
	state : null,
	state_type:false
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
		if($(event.target).text() == "查询" ){
			searchArgs.searchKey = $("#searchKey").val()
			searchArgs.startDate = $("#start_date").val()
			searchArgs.endDate = $("#end_date").val()
			searchArgs.state = null
			searchArgs.resultCount = 10
			searchArgs.pageNum = 1
			searchArgs.pageOffSet = 0
		}else if(event.target.tagName == "SELECT"){
			 searchArgs = {
						startDate:	null,
						endDate:	null,
						timeSlot:	null,
						searchKey:	null,
						dealName : null,
						routeName : null,
						resultCount:	10,
						pageNum:	1,
						pageOffSet:	0,
						state : null,
						state_type:false
					}
			searchArgs.type = $(event.target).val()
		}else {
			 searchArgs = {
				startDate:	null,
				endDate:	null,
				timeSlot:	null,
				searchKey:	null,
				dealName : null,
				routeName : null,
				resultCount:	10,
				pageNum:	1,
				pageOffSet:	0,
				state : null,
				state_type:false
			}
			searchArgs.state = $(event.target).text()
		}
	}
	$.when(initArticles()).done(function(){
		if(isNaN(pageTotal)){
			return 
		}else{
			setCommonPage2Event($('.im_pageBg'),pageTotal,function(num){
				searchArgs.pageNum = num
				searchArgs.pageOffSet = (num-1)*searchArgs.resultCount 
				initArticles()
			})
		}
	})
}

function initDateInquirys(){
	$("span[name=time_slot]").on("click",function(){
		searchArgs.timeSlot = $(this).text()
		searchArgs.state = null
		searchArgs.resultCount = 10
		searchArgs.pageOffSet = 0
		search(null)
	})
}

function initArticles(){
	var dtd = $.Deferred();
	
	$.ajax({
		url:  "/article/listArticles",
		type: "post",
		dataType: 'json',
		data: searchArgs,
		success:function(rs){
				var rows = rs.rows
				var count = rs.totalCount
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
        		'<tr><th width="3%" ><div ></div></th>'+
        		'<th width="4%" >序号</th>'+
    			'<th width="20%">文章标题</th>'+
    			'<th width="8%">类型</th>'+
    			'<th width="8%" >状态</th>'+
    			'<th width="12%" >创建时间</th>'+
    			'<th width="8%" >创建人</th>'+
    			'<th width="7%" >阅读量</th>'+
    			'<th width="10%" >已分享</th>'+
    			'<th width="18%" >操作</th>'+	
    			'</tr><thead><tbody>'
    			
	       		for(var i in rows){
	       			var sequence = searchArgs.resultCount*(searchArgs.pageNum-1)+(parseInt(i)+parseInt(1))
	       			tb += '<tr><td><input type="checkbox" data-id="'+rows[i].id+'" /></td><td><div>'+sequence+'</div></td>'
	       			if(rows[i].articleCategory != null && rows[i].articleCategory.split(",").length > 1){
	       				tb += '<td style="text-align :left"><span class="label label-danger">置顶</span><span class="label label-primary">特推</span>&nbsp;&nbsp;<span class="im_name" onClick="showDetails('+rows[i].id+')">'+rows[i].title+'</td>'
	       			}else if(rows[i].articleCategory == "特推"){
	       				tb += '<td style="text-align :left"><span class="label label-primary">特推</span>&nbsp;&nbsp;<span class="im_name" onClick="showDetails('+rows[i].id+')">'+rows[i].title+'</td>'
	       			}else if(rows[i].articleCategory == "置顶"){
	       				tb += '<td style="text-align :left"><span class="label label-danger">置顶</span>&nbsp;&nbsp;<span class="im_name" onClick="showDetails('+rows[i].id+')">'+rows[i].title+'</td>'
	       			}else if(rows[i].state == "草稿"){
	       				tb += '<td style="text-align :left"><span class="label label-default">草稿</span>&nbsp;&nbsp;<span class="im_name" onClick="showDetails('+rows[i].id+')">'+rows[i].title+'</td>'
	       			}else {
	       				 tb += '<td style="text-align :left"><span class="im_name" onClick="showDetails('+rows[i].id+')">'+rows[i].title+'</span></td>' 
	       			}
	        		tb += '<td>'+rows[i].type+'</td><td>'+(rows[i].state || '-')+'</td>'
	        		var date = new Date(rows[i].dateCreated)
	        		var dateTime = date.getFullYear()
              			 + "-"
              			 + ((date.getMonth() + 1) >= 10 ? (date.getMonth() + 1) : "0"
                      	 + (date.getMonth() + 1))
              			 + "-"
             	  		 + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate())
              			 + " "
              			 + (date.getHours() < 10 ? "0" + date.getHours() : date.getHours())
              			 + ":"
               		 + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes())
              			 + ":"
             			 + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds());
               		tb += '<td>'+dateTime+'</td>'
	       		
				tb += '<td>'+rows[i].createBy+'</td><td>'+rows[i].readCount+'</td>'
       		
       			if(rows[i].toShare != null){
       				var shares = rows[i].toShare.split(",")
       			if(shares.length > 0){
       				for(var j in shares){
       					if(shares[j] == "1"){
       							tb += '<td><div class="gImg we_chat" title="微信" style="margin-left:5px;" /></td>'
       					}else if(shares[j] == "2"){
       							tb += '<td><div class="gImg blog" title="微博" style="margin-left:5px;" /></td>'
       					}else{
       							tb += '<td><div class="gImg fase_book" title="fasebook" style="margin-left:5px;" /></td>'
       					}
       				}
       				}
       			}else{
       				tb += '<td>-</td>'
       			}
       			
       			/*tb += '<td style="">'+
					'<div class="tableBtnsBg" style="width: 156px;">'+
					'<input type="button" class=".gBtn issue" title="启动" style="margin-left:5px;" oncl><i class="icon-camera-retro"></i></input>'+
					'<a class=".gBtn edit" title="修改" style="margin-left:15px;"></a>'+
					'<a class=".gBtn share" style="margin-left:15px;" title="删除"></a>'+
					'<a class=".gBtn delete" title="修改" style="margin-left:15px;"></a>'+
					'<a class="delete" style="margin-left:15px;" title="删除"></a>'+
					'</div>'+
				'</td>'*/
				

   			tb += '<td><div class="btn-group" style="width: 178px;">'
   				if(rows[i].articleState == "发布"){
   					tb +='<a class="btn"  style="" href="#" title="撤销"  onclick='+"updateState('Repeal',event)"+' ><i class="icon-arrow-left" stle="#c83025" ></i></input>'
   				}else{
   					tb +='<a class="btn" style="color:green" href="#" title="发布"  onclick='+"updateState('Issue',event)"+'  ><i class="icon-arrow-right" style="#c83025" ></i></a>'
   				} 
   			
     		tb +='<a class="btn" href="/article/data?id='+rows[i].id+'"><i class="icon-edit" title="编辑"></i></a>'
     		
     			if(rows[i].toShare != null && rows[i].toShare != ""){
     				tb += '<a class="btn"  href="javascript:void(0);"><i class="icon-share" title="分享" ></i></a>'
     			}else{
     				tb += '<a class="btn" href="javascript:void(0);"  ><i class="icon-share" aria-hidden="true" title="分享" dia></i></a>'
     			}
     				
     		tb += '<a class="btn" href="#"><i class="icon-trash" title="删除" onclick="deleteArtilce('+rows[i].id+')"></i></a>'+
   				  '</div></td>'		
	       		tb += '</tr>'	
	       		
	       		}
	       		tb+="</tbody>"
				$(".im_table").append(tb)
				var all_count = 0;
				for(var k in state_counts){
						
					$("span[name="+k+"]").next().text("("+state_counts[k]+")")
						// all_count += parseInt(state_counts[k])
				}
				//$("#total_count").text("("+all_count+")")
				/*if(count != undefined){
					$("#total_count").text("("+all_count+")")
				}else{
					$("#total_count").text("(0)")
				}*/
				$("span[name=total_count]").text("("+count+")")
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

function showDetails(id){
		$.ajax({
				type:'post',
				url:'/article/showDetails',
				dataType:'json',
				data:{id:id},
				success:function(rs){
							console.log(rs)
							var date = new Date(rs.lastUpdated)
	        				var dateTime = date.getFullYear()
              								 + "-"
              								 + ((date.getMonth() + 1) >= 10 ? (date.getMonth() + 1) : "0"
                     	 					 + (date.getMonth() + 1))
              								 + "-"
             	  							 + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate())
              								 + " "
              								 + (date.getHours() < 10 ? "0" + date.getHours() : date.getHours())
              								 + ":"
               		 						 + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes())
              								 + ":"
             			 					 + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds());
				
						$("body").append('<div class="winModBg0" >'+
							'<div class="winModBg wEditMod web_banner_editDlg" >'+
							'<div class="titleBg">'+
						    '<div class="closeBtn">X</div>'+
						    '</div>'+
						    '<div class="msgsBg">'+
							'<div class="title">'+rs.title+'</div>'+
							'<div class="from">'+
							'<span>来源：<span class="link">'+rs.comes+'</span></span>'+
							'<span>日期：<span>'+dateTime+'</span></span>'+
							'</div>'+
							'<img class="image" />'+
							'<div class="msgContent">'+rs.content+
							'</div>'+
							'<ul class="tag_li"><label style="color:orange">标签：</label><li></li>'+
        					'</ul>'+
							'</div>'+
							'</div></div>')
							if(rs.pageTag != null ){
								var tags = rs.pageTag.split(",")
								for(var i = 0;i<tags.length;i++){
        							if(tags[i] != null && tags[i] != "" ){
        								$(".tag_li").append('<li >'+
    	        						'<a class="nofocus" href="javascript:;">'+tags[i].substring(2)+'</a>'+
    	        						'</li>')
        								}
        							}
								}
						modDlgEvent($('.web_banner_editDlg'));
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
			'</div></div></div>'

		}else{
			doHtml +=
		'<div class="t_bottom">'+
			'<div class="btnMod1" onClick="inquiryStop(event)" data-number="'+rs.inquiry.number+'">终止</div>'+
			'<div class="btnMod1" onClick="inquirySuppl(event)"   data-number="'+rs.inquiry.number+'">补充</div>'+
			'</div>'+
   		 '</div>'+
		'</div>';
		}
		
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

function removeHTMLTag(str) {
	str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
	str = str.replace(/[ | ]*\n/g,''); //去除行尾空白
	str = str.replace(/\n[\s| | ]*\r/g,''); //去除多余空行
	str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
	return str;
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
					zcAlert("补充成功")
					$('.inquirySuppl .closeBtn').trigger('click');
					$('.inpuiryHistory .closeBtn').trigger('click');
					initDateInquirys()
					//window.location.reload();
				}else{
					zcAlert("补充失败")
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

function addGuestDlgShow(){
	window.location.href = '/article/data/'
}

function updateCategory(num){
		var str = ""
		//var chk_num = $("input[type='checkbox']").is(':checked')
		var chk_num = 0 ;
		var isTweet  = false
		$("input[type='checkbox']").each(function(){
			if($(this).is(':checked')){
				if(str != ""){
     				str += "," + $(this).attr("data-id")
     			}else{
     				str += $(this).attr("data-id")
     			}
     			chk_num++ 
			}
			
		})
		/*if(category != null){
			var a = category.split(",")
			
			if(a.length > 1){
				if(a[0]=="特推" || a[1]=="特推"){
					isTweet = true
				}
			}else if(a.length = 1 &&　a[0] == "特推"){
				isTweet = true
			}else {
				isTweet = false
			}
		}*/
		
		if(chk_num > 0){
			switch(num){
	        			case 0 : 
	        					 $.post("/article/updateCategory?category="+num+"&articles="+str,function(result){
	        							zcAlert("置顶成功")
	        							search(null)
										initresult()
	        					 })
	        					 break;
	        			case 1 :  
	        					 $.post("/article/updateCategory?category="+num+"&articles="+str,function(result){
	        							zcAlert("取消置顶修改成功")
	        							search(null)
										initresult()
	        					 })
	        					 break;
	        			case 2 :  if(chk_num > 1){
	        						  zcAlert("请选择一项")
	        					  }/*else if(isTweet){
	        					  	  zcAlert("该项已是特推项")
	        					  }*/else {
	        						  $.post("/article/updateCategory?category="+num+"&articles="+str,function(result){
	        							zcAlert("特推成功")
	        							search(null)
										initresult()
	        						})
	        					  }
	        					  break;
	        			case 3 :  if(chk_num> 1){
	        						  zcAlert("请选择一项")
	        					  }/*else if(!isTweet){
	        					  	  zcAlert("该项已是特推项")
	        					  }*/else{
	        					  	$.post("/article/updateCategory?category="+num+"&articles="+str,function(result){
	        							zcAlert("取消特推成功")
	        							search(null)
										initresult()
	        					 	 })
	        					  }
	        					  break;
	        			default :	
	        					  break; 			        						
	        		}
		}else{
			zcAlert("请选中要修改的项")
		}
}

function delArticles(){
		var str = ""
		var chk_num = 0 ;
		$("input[type='checkbox']").each(function(){
			if($(this).is(':checked')){
				if(str != ""){
     				str += "," + $(this).attr("data-id")
     			}else{
     				str += $(this).attr("data-id")
     			}
     			chk_num++ 
			}
		})
		
		if(chk_num == 0){
			zcAlert("请选择要删除的项")
		}else{
			$.post("/article/delete?ids="+str,function(data){
				if(data == "true"){
					zcAlert("删除成功")
					search(null)
					initresult()
				}else{
					zcAlert("删除失败")
				}
			
			})
			
		}
}

function updateState(aState,eve){
	var aId = $(eve.target).parents("tr").find("input[type=checkbox]").attr('data-id')
	$.post("/article/updateState?id="+aId+"&state="+aState,function(data){
		if(data == "true"){
			if(aState == "Issue"){
				zcAlert("发布成功")
			}else{
				zcAlert("撤销成功")
			}
			search(null)
			initresult()
		}else{
			if(aState == "Issue"){
				zcAlert("发布失败")
			}else{
				zcAlert("撤销失败")
			}
		}
		console.log("data")
	})
}

function deleteArtilce(id){
    console.log(id)
	$.post("/article/delete?ids="+id,function(data){
				if(data == "true"){
					zcAlert("删除成功")
					search(null)
					initresult()
				}else{
					zcAlert("删除失败")
			}
})}
</script>
</body>
</html>
