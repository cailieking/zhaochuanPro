<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>找船网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">

<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/shiplist.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../css/shipping.css">

<script src="../js/My97DatePicker/WdatePicker.js"></script>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/shipping.js"></script>

</head>
<body>
	<div class="w960">
		<div class="right release_single">
			<div class="shippingBg0">
				<!--顶部tabs-->
			    <ul class="topTabs">
			    	<li class="sel">运价管理</li>
			    </ul>
			    <!--顶部tabs end-->
			    <!--筛选-->
			   <form action="/ship/list">
			    <div class="filterBg">
			    	<ul class="filterList">
			        	<li>
			            	<div class="fLabel">运价状态</div>
			                <select name="status" id="status">
			                	<option value="0">全部</option>
			                	<option value="VerifyPassed">通过</option>
			                	<option value="UnVerify">未审核</option>
			                	<option value="InVerify">审核中</option>
			                	<option value="VerifyFailed">审核未通过</option>
			                	<option value="Expired">已过期</option>
			                	<option value="Revoked">已撤销</option>
								<option value="Closed">已关闭</option>
			                </select>
			            </li>
			            <li>
			            	<div class="fLabel">关键字</div>
			                <input class="len1" type="text" placeholder=" 起始港 /目的港 /运价编号 /进行搜索 " name="serach" id="serach" />
			            </li>
			            <li style="display:none;">
			            	<div class="fLabel">船公司</div>
			                <input class="len1" type="text" placeholder="输入船公司" name="shipCompany" id="shipCompany"/>
			            </li>
			            <li style="display:none;">
			            	<div class="fLabel">创建时间</div>
			                <input type="text" placeholder="发布开始时间"  class="len2" onClick="WdatePicker()"  name="createStratDate" id="createStratDate"/>
			                <div class="mdLine"></div>
			                <input  type="text" placeholder="发布结束时间"  class="len2"  onClick="WdatePicker()"  name="createEndDate" id="createEndDate"/>
			            </li>
			        </ul>
			        <div class="more ar_down">更多条件搜索</div>
			        <div class="searchBtn" id="inquery">搜索</div>
			    </div>
	
			    </form>
			    
			    <!--筛选 end-->
			    
			    <!--信息表格-->
			    <div class="shippingTable" id="shippinglist">
			    	<div class="headBg">
			        	<div class="grid1">起始港/目的港/航程/船期</div>
			            <div class="grid2">运费</div>
			            <div class="grid3">有效期</div>
			            <div class="grid4">交易状态</div>
			            <div class="grid5">操作</div>  
			        </div>
			        <div class="topOper">
			        	<input id="shippingAllCheck" type="checkbox" />
			            <label for="shippingAllCheck">全选</label>
			            <div class="blueBtn allDelete" id="allDelete">批量删除</div>
			            <div class="blueBtn allRepeal" id="allRepeal">批量撤销</div>
			            <div class="rightTxt">说明：批量上传的运价超过2条的，仅显示前2条，可通过显示条目数来调整</div>
			        </div>
			        <div class="tables"></div>

			     	<div class="btmOper">
			            <div class="common_pageBK">
			                <!--<div class="common_page_first">首页</div>
			                <div class="common_page_up">上一页</div>
			                <div class="common_page_number common_page_number_sel">1</div>
			                <div class="common_page_number">2</div>
			                <div class="common_page_number">3</div>
			                <div class="common_page_down">下一页</div>
			                <div class="common_page_last">尾页</div>
			                <div class="common_page_sum">共<span>12</span>页</div>
			                <input type="text" class="common_page_input_number" value="1"/>
			                <div class="common_page_go">go</div>-->
			            </div>
			        </div>
  
			     </div>
			   
		        <!--发布信息 end-->
		    </div>
		   </div>
		   
		   <div id="list"></div>
		</div>
		<div class=" backshiplist backpage backship needtop"></div>
		<!--详情-->
		
		<div class="shippingTips" style="display:none;">
			<div class="table">
		    	<div class="label">起始港：</div><div class="w1" id="startPort"></div>
		        <div class="label">目的港：</div><div class="w1" id="endPort"></div>
		        <div class="label">船公司：</div><div class="w1" id="shipCompany2"></div>
		        <div class="label">运输种类：</div><div class="w1" id="transType"></div>
		        <div class="label">开船日：</div><div class="w1" id="shippingDay"></div>
		        <div class="label">中转港：</div><div class="w1" id="middlePort"></div>
		        <div class="label">航线名称：</div><div class="w2" id="routeName"></div>
		        <div class="label">航程：</div><div class="w1" id="shippingDays"></div>
		        <div class="label">柜型运价：</div><div class="w3"><span id="gp20"></span><span>美元/20'GP&nbsp;&nbsp;</span><span id="gp40"></span><span>美元/40'GP&nbsp;&nbsp;</span><span id="hq40"></span><span>美元/40'HQ</span></div>
		        <div class="label">附加费：</div><div class="w3" id="extra"></div>
		        <div class="label">有效期：</div><div class="w3"><span id="startDate"></span><span>&nbsp;至&nbsp;</span><span id="endDate"></span></div>
		        <div class="label">备注</div><div class="w3" id="remark"></div>
		    </div>
		</div>
		<!--详情end-->
	<script type="text/javascript">

	var page = {
			  "totalPage":0,
			  "maxResultSize":5,
			  "pageNo" : 1
			}

	$(document).ready(function(){ 
		
		$(".searchBtn").click(function() {
			
			var showInqueryList = function(pageNo,maxResultSize){
			var status = $("#status").val()
			var serach = $("#serach").val()
			var createStratDate = $("#createStratDate").val()
			var createEndDate = $("#createEndDate").val()
			var shipCompany = $("#shipCompany").val()
		
					$.ajax({
								url : "/ship/myShips",
								type : "post",
								cache : true,
						        dataType : "json",
								data : {
									status : status,
									serach : serach,
									createStratDate : createStratDate,
									createEndDate : createEndDate,
									shipCompany : shipCompany,
									pageNo : pageNo,
									maxResultSize : maxResultSize
									
								},
								success : function(rs) {
									page.totalPage = rs.totalPage
									var shipMap = {}
									var result = rs.result
									var list = $("#shippinglist .tables")
									list.children().remove();
									var t = 0;
									
										for (i = 0; i <result.length; i++) {
											    var project=result[i]
											    ++t
												var releaseNum = project.releaseNum
												if(shipMap[releaseNum] != null){
															var cc = shipMap[releaseNum]
															cc.push(project);
														}else{
															var ccd = []
															ccd.push(project)
															shipMap[releaseNum] = ccd;
														}
											
										}
											
											if (t == 0) {
											list.children().remove();
											alert("你所选择的查询条件沒有数据")
										 }
										var model
										$(".issueBg").remove();
										for(var i in shipMap){
											model = inquery(shipMap[i])
											list.append(model);
										}
				
				$("[name=tenInfo],[name=twentyInfo],[name=fiftyInfo],[name=oneHundredInfo],[name=twoHundredInfo]").click(function() {
					var thisLink=$(this);
					var aa = $(this).parent().parent().find("span").first().text()
					//console.log(aa)
					var bb = aa.split("：")
					var strUrl;
					var name=$(this).attr('name');
					if(name=='tenInfo'){
						strUrl='tenPricingInfo';
					}
					if(name=='twentyInfo'){
						strUrl='twentyPricingInfo';
					}
					if(name=='fiftyInfo'){
						strUrl='fiftyPricingInfo';
					}
					if(name=='oneHundredInfo'){
						strUrl='oneHundredPricingInfo';
					}
					if(name=='twoHundredInfo'){
						strUrl='twoHundredPricingInfo';
					}
					var releaseNum  = bb[1].trim();
					
			 		$.ajax({
			 	
						url : "/ship/"+strUrl+"/?releaseNum='"+releaseNum+"'",
						type : "post",
						cache : true,
			        	dataType : "json",
						success : function(rsMsg) {  
						
			var priceHtml="";
			for(var i=0;i<rsMsg.length;i++){
				priceHtml+='<!--运价信息-->';
	            priceHtml+='<div class="pirceBg">';
	            priceHtml+='<div class="pirceTitle">';
	            priceHtml+='<input  data-id="'+rsMsg[i].id+'"  type="checkbox" />';
	            priceHtml+='<span>运价编号：'+rsMsg[i].id+'</span>';
	            priceHtml+='<span>运输类型：'+rsMsg[i].transType+'</span>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="pirceContent">';
	            priceHtml+='<div class="grid1">';
	            priceHtml+='<div class="shippingTxts">';
	            priceHtml+='<div class="top">';
	            priceHtml+='<span>'+rsMsg[i].startPort+'</span><span>—</span><span>'+rsMsg[i].endPort+'</span>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="btm">';
	            priceHtml+='<span>航程：'+rsMsg[i].shippingDays+'</span><span>船期：'+rsMsg[i].shippingDay+'</span>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid2">';
	            priceHtml+='<div class="priceTxts">';
	            priceHtml+='<div class="top">';
	            priceHtml+='<div>20GP</div><div>40GP</div><div>40HQ</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="btm">';
	            priceHtml+='<div>$'+rsMsg[i].gp20+'</div><div>$'+rsMsg[i].gp40+'</div><div>$'+rsMsg[i].hq40+'</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid3">';
	            priceHtml+='<div class="timesTxts">';
	            priceHtml+='<div class="top"><span>起：'+rsMsg[i].startDate+'</span></div>';
	            priceHtml+='<div class="btm"><span>止：'+rsMsg[i].endDate+'</span></div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid4">';
	            priceHtml+='<div class="statusTxts">';
	            priceHtml+='<div class="top"><span>'+rsMsg[i].status+'</span></div>';
	            priceHtml+='<div class="btm"><span class="blueLink"><a class="blueLink"  id="'+rsMsg[i].id+'" >详情</a></span></div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid5">';
	            priceHtml+='<div class="operTxts">';
	            priceHtml+='<div class="blueLink"><a href="/ship/pricing?id='+rsMsg[i].id+'" style="color:#0088dd;">修改</a></div>';
	            priceHtml+='<div class="blackLink"><a href="/ship/updateStatus?id='+rsMsg[i].id+'" class="hanggao repeal">撤销</a></div>';
	            priceHtml+='<div class="redLink"><a href="/ship/deleteShip?id='+rsMsg[i].id+'" style="color:red;" class="hanggao delete">删除</a></div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';	
	            priceHtml+='<!--运价信息 end-->';
	            
			}
			
			thisLink.parents('.issueBg').find('.pirceBg').remove();
			thisLink.parents('.issueBg').append($(priceHtml));
			tipsEvent(rsMsg);
						
							shippingCheckboxEvents()
						} 
							<!-- ajax 10 条  20条   50条 100条 200 条  执行成功结束 -->
							
							
					})
				
			  }),
			   
			  $(".status").each(function(){
					if($(this).html().trim()==="已撤销"){
						 var targetEl = $(this).parent().parent().children().find(".repeal");
						 targetEl.prop("href")=="javascript:void(0)";
						 targetEl.css({'color':'#b4b4b4'});
						}
				})
			
			tipsEvent(result);
			function tipsEvent(data){
				$(".statusTxts .blueLink").unbind('hover').hover(function(){
					//调整显示的位置
					var tips=$('.shippingTips');
					var thisLeft=$(this).offset().left;
					var thisTop=$(this).offset().top;
					var thisWidth=$(this).width();
					var thisHeight=$(this).height();
					var tipsWidth=tips.width();
					tips.css({
						left:thisLeft-tipsWidth,
						top:thisTop
					});
					var tipsHeight=tips.height();
					var tipsBottom=parseInt(tips.css('top'))+tips.height();
					var w_scrollHeight=$(window).scrollTop()+$(window).height();
					if(tipsBottom>w_scrollHeight){
						var h_diff=tipsBottom-w_scrollHeight;
						var tipsTop=parseInt(tips.css('top'))-h_diff;
						tips.css({top:tipsTop});
					}
					
					for (i = 0; i <data.length; i++){
						if(data[i].id == this.id){
							//console.log($("#shippingDay").text());
							   $("#startPort").text(data[i].startPort?data[i].startPort:" ") 
							   $("#endPort").text( data[i].endPort?data[i].endPort:" ") 
							   $("#shipCompany2").text(data[i].shipCompany?data[i].shipCompany:" ")
							   $("#transType").text(data[i].transType?data[i].transType:" ")
							   $("#shippingDay").text(data[i].shippingDay?data[i].shippingDay:" ")
							   $("#middlePort").text(data[i].middlePort?data[i].middlePort:" ")
							   
							   $("#routeName").text(data[i].routeName?data[i].routeName:" ")
							   $("#shippingDays").text(data[i].shippingDays?data[i].shippingDays:" ")
							   $("#gp20").text(data[i].gp20?data[i].gp20:" ")
							   $("#gp40").text(data[i].gp40?data[i].gp40:" ")
							   $("#hq40").text(data[i].hq40?data[i].hq40:" ")
							   $("#extra").text(data[i].extra?data[i].extra:" ")
							   $("#startDate").text(data[i].startDate?data[i].startDate:" ")
							   $("#endDate").text(data[i].endDate?data[i].endDate:" ")
							   $("#remark").text(data[i].remark?data[i].remark:" ")
						}
						tips.show();		
					}
					
				},function(){
					$(".shippingTips").hide();
				});
			}
			
			$(function(){
				shippingCheckboxEvents();//复选框事件关联
			})
			//复选框事件关联
			function shippingCheckboxEvents(){
				var topCheck=$('#shippingAllCheck');//顶部全选
				var tableChecks=$('.issueBg input[type="checkbox"]');//表格内的复选框
				var issueChecks=$('.issueTitle input[type="checkbox"]');//发布列的复选框
				var priceChecks=$('.pirceTitle input[type="checkbox"]');//运价列的复选框
				//顶部全选点击
				topCheck.off('click').on('click',function(){
					tableChecks.prop('checked',$(this).prop('checked'));
				})
				//表格内复选框点击
				/*tableChecks.off('click').on('click',function(){
					isAllChecked();//检测是否所有选项选中
				})*/
				//运价列复选框点击
				priceChecks.off('click').on('click',function(){
					isIssueAllChecked($(this));//检测是否所有选项选中_发布列中
					isAllChecked();//检测是否所有选项选中
				})
				//发布列复选框点击
				issueChecks.off('click').on('click',function(){
					var issueChecked=$(this).prop('checked');
					var pirceChecks=$(this).parents('.issueBg').find('.pirceTitle input[type="checkbox"]');
					pirceChecks.each(function(index, element) {
			            $(this).prop('checked',issueChecked);
			        });
					isAllChecked();//检测是否所有选项选中
				})
				//检测是否所有选项选中
				function isAllChecked(){
					var isAllCheck=true;
					tableChecks.each(function(index,element) {
						if($(this).prop('checked')==false){
							isAllCheck=false;
							return false;
						}
					});
					topCheck.prop('checked',isAllCheck);
				}
				//检测是否所有选项选中_发布列中
				function isIssueAllChecked($this){
					//console.log($this);
					var isAllCheck=true;
					var pirceChecks=$this.parents('.issueBg').find('.pirceTitle input[type="checkbox"]');
					pirceChecks.each(function(index,element) {
						if($(this).prop('checked')==false){
							isAllCheck=false;
							return false;
						}
					});
					$this.parents('.issueBg').find('.issueTitle input[type="checkbox"]').prop('checked',isAllCheck);
				}
			}
	
		} 
	})
		
		}
		
			var getTotalPage = function(){
			
			$.ajax({
			url : "/ship/getTotalPage?maxResultSize="+page.maxResultSize,
			type : "post",
			cache : true,
			dataType : "json",
			success : function(rs) {  
				 page.totalPage = rs.totalPage
				
					setCommonPageEvent(page.totalPage,function(pageNo){//公用翻页控件
										console.log('点击'+pageNo+'页');
								        showShipList(pageNo,page.maxResultSize);
				});
			}
		})
		
		}
	
		getTotalPage()
		
		showInqueryList(page.pageNo,page.maxResultSize);
		
	
	})
	
<!--读取query结束  -->
		var showShipList = function(pageNo,maxResultSize){
			
			var status = $("#status").val()
			var serach = $("#serach").val()
			var createStratDate = $("#createStratDate").val()
			var createEndDate = $("#createEndDate").val()
			var shipCompany = $("#shipCompany").val()
			
			$.ajax({
					url : "/ship/myShips",
					type : "post",
					cache : true,
				    dataType : "json",
					data : {
						status : status,
						serach : serach,
						shipCompany : shipCompany,
						createStratDate : createStratDate,
						createEndDate : createEndDate,
						pageNo : pageNo,
						maxResultSize: maxResultSize
					},
					success : function(rs) {
						page.totalPage = rs.totalPage
						
						var shipMap = {}
						var result = rs.result
							for (i = 0; i <result.length; i++) {
								    var project=result[i]
								   var list = $("#shippinglist .tables")
								  
									var releaseNum = project.releaseNum
									
									if(shipMap[releaseNum] != null){
												var cc = shipMap[releaseNum]
												cc.push(project);
											}else{
												var ccd = []
												ccd.push(project)
												shipMap[releaseNum] = ccd;
											}
								}
							var model
							$(".issueBg").remove();
							for(var i in shipMap){
								model = inquery(shipMap[i])
								list.append(model);
							}
							
				$("[name=tenInfo],[name=twentyInfo],[name=fiftyInfo],[name=oneHundredInfo],[name=twoHundredInfo]").click(function() {
					var thisLink=$(this);
					var aa = $(this).parent().parent().find("span").first().text()
					//console.log(aa)
					var bb = aa.split("：")
					var strUrl;
					var name=$(this).attr('name');
					if(name=='tenInfo'){
						strUrl='tenPricingInfo';
					}
					if(name=='twentyInfo'){
						strUrl='twentyPricingInfo';
					}
					if(name=='fiftyInfo'){
						strUrl='fiftyPricingInfo';
					}
					if(name=='oneHundredInfo'){
						strUrl='oneHundredPricingInfo';
					}
					if(name=='twoHundredInfo'){
						strUrl='twoHundredPricingInfo';
					}
					var releaseNum  = bb[1].trim();
					
			 		$.ajax({
			 	
						url : "/ship/"+strUrl+"/?releaseNum='"+releaseNum+"'",
						type : "post",
						cache : true,
			        	dataType : "json",
						success : function(rsMsg) {  						
						
			var priceHtml="";
			for(var i=0;i<rsMsg.length;i++){
				priceHtml+='<!--运价信息-->';
	            priceHtml+='<div class="pirceBg">';
	            priceHtml+='<div class="pirceTitle">';
	            priceHtml+='<input  data-id="'+rsMsg[i].id+'"  type="checkbox" />';
	            priceHtml+='<span>运价编号：'+rsMsg[i].id+'</span>';
	            priceHtml+='<span>运输类型：'+rsMsg[i].transType+'</span>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="pirceContent">';
	            priceHtml+='<div class="grid1">';
	            priceHtml+='<div class="shippingTxts">';
	            priceHtml+='<div class="top">';
	            priceHtml+='<span>'+rsMsg[i].startPort+'</span><span>—</span><span>'+rsMsg[i].endPort+'</span>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="btm">';
	            priceHtml+='<span>航程：'+rsMsg[i].shippingDays+'</span><span>船期：'+rsMsg[i].shippingDay+'</span>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid2">';
	            priceHtml+='<div class="priceTxts">';
	            priceHtml+='<div class="top">';
	            priceHtml+='<div>20GP</div><div>40GP</div><div>40HQ</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="btm">';
	            priceHtml+='<div>$'+rsMsg[i].gp20+'</div><div>$'+rsMsg[i].gp40+'</div><div>$'+rsMsg[i].hq40+'</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid3">';
	            priceHtml+='<div class="timesTxts">';
	            priceHtml+='<div class="top"><span>起：'+rsMsg[i].startDate+'</span></div>';
	            priceHtml+='<div class="btm"><span>止：'+rsMsg[i].endDate+'</span></div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid4">';
	            priceHtml+='<div class="statusTxts">';
	            priceHtml+='<div class="top"><span>'+rsMsg[i].status+'</span></div>';
	            priceHtml+='<div class="btm"><span class="blueLink"><a class="blueLink"  id="'+rsMsg[i].id+'" >详情</a></span></div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='<div class="grid5">';
	            priceHtml+='<div class="operTxts">';
	            priceHtml+='<div class="blueLink"><a href="/ship/pricing?id='+rsMsg[i].id+'" style="color:#0088dd;">修改</a></div>';
	            priceHtml+='<div class="blackLink"><a href="/ship/updateStatus?id='+rsMsg[i].id+'" class="hanggao repeal">撤销</a></div>';
	            priceHtml+='<div class="redLink"><a href="/ship/deleteShip?id='+rsMsg[i].id+'" style="color:red;" class="hanggao delete">删除</a></div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';
	            priceHtml+='</div>';	
	            priceHtml+='<!--运价信息 end-->';
	            
			}
			
			thisLink.parents('.issueBg').find('.pirceBg').remove();
			thisLink.parents('.issueBg').append($(priceHtml));
			tipsEvent(rsMsg);
						
							shippingCheckboxEvents()
						} 
							<!-- ajax 10 条  20条   50条 100条 200 条  执行成功结束  进入当前页查询-->
							
					})
					
				
			  }),
			 
				$(".status").each(function(){
					if($(this).html().trim()==="已撤销"){
						 var targetEl = $(this).parent().parent().children().find(".repeal");
						 targetEl.prop("href")=="javascript:void(0)";
						 targetEl.css({'color':'#b4b4b4'});
						}
				})
			
			tipsEvent(result);
			function tipsEvent(data){
				$(".statusTxts .blueLink").unbind('hover').hover(function(){
					//调整显示的位置
					var tips=$('.shippingTips');
					var thisLeft=$(this).offset().left;
					var thisTop=$(this).offset().top;
					var thisWidth=$(this).width();
					var thisHeight=$(this).height();
					var tipsWidth=tips.width();
					tips.css({
						left:thisLeft-tipsWidth,
						top:thisTop
					});
					var tipsHeight=tips.height();
					var tipsBottom=parseInt(tips.css('top'))+tips.height();
					var w_scrollHeight=$(window).scrollTop()+$(window).height();
					if(tipsBottom>w_scrollHeight){
						var h_diff=tipsBottom-w_scrollHeight;
						var tipsTop=parseInt(tips.css('top'))-h_diff;
						tips.css({top:tipsTop});
					}
					
					for (i = 0; i <data.length; i++){
						if(data[i].id == this.id){
							//console.log($("#shippingDay").text());
							   $("#startPort").text(data[i].startPort?data[i].startPort:" ") 
							   $("#endPort").text( data[i].endPort?data[i].endPort:" ") 
							   $("#shipCompany2").text(data[i].shipCompany?data[i].shipCompany:" ")
							   $("#transType").text(data[i].transType?data[i].transType:" ")
							   $("#shippingDay").text(data[i].shippingDay?data[i].shippingDay:" ")
							   $("#middlePort").text(data[i].middlePort?data[i].middlePort:" ")
							   
							   $("#routeName").text(data[i].routeName?data[i].routeName:" ")
							   $("#shippingDays").text(data[i].shippingDays?data[i].shippingDays:" ")
							   $("#gp20").text(data[i].gp20?data[i].gp20:" ")
							   $("#gp40").text(data[i].gp40?data[i].gp40:" ")
							   $("#hq40").text(data[i].hq40?data[i].hq40:" ")
							   $("#extra").text(data[i].extra?data[i].extra:" ")
							   $("#startDate").text(data[i].startDate?data[i].startDate:" ")
							   $("#endDate").text(data[i].endDate?data[i].endDate:" ")
							   $("#remark").text(data[i].remark?data[i].remark:" ")
						}
						tips.show();		
					}
					
				},function(){
					$(".shippingTips").hide();
				});
			}

			$(function(){
				shippingCheckboxEvents();//复选框事件关联
			})
			//复选框事件关联
			function shippingCheckboxEvents(){
				var topCheck=$('#shippingAllCheck');//顶部全选
				var tableChecks=$('.issueBg input[type="checkbox"]');//表格内的复选框
				var issueChecks=$('.issueTitle input[type="checkbox"]');//发布列的复选框
				var priceChecks=$('.pirceTitle input[type="checkbox"]');//运价列的复选框
				//顶部全选点击
				topCheck.off('click').on('click',function(){
					tableChecks.prop('checked',$(this).prop('checked'));
				})
				//表格内复选框点击
				/*tableChecks.off('click').on('click',function(){
					isAllChecked();//检测是否所有选项选中
				})*/
				//运价列复选框点击
				priceChecks.off('click').on('click',function(){
					isIssueAllChecked($(this));//检测是否所有选项选中_发布列中
					isAllChecked();//检测是否所有选项选中
				})
				//发布列复选框点击
				issueChecks.off('click').on('click',function(){
					var issueChecked=$(this).prop('checked');
					var pirceChecks=$(this).parents('.issueBg').find('.pirceTitle input[type="checkbox"]');
					pirceChecks.each(function(index, element) {
			            $(this).prop('checked',issueChecked);
			        });
					isAllChecked();//检测是否所有选项选中
				})
				//检测是否所有选项选中
				function isAllChecked(){
					var isAllCheck=true;
					tableChecks.each(function(index,element) {
						if($(this).prop('checked')==false){
							isAllCheck=false;
							return false;
						}
					});
					topCheck.prop('checked',isAllCheck);
				}
				//检测是否所有选项选中_发布列中
				function isIssueAllChecked($this){
					//console.log($this);
					var isAllCheck=true;
					var pirceChecks=$this.parents('.issueBg').find('.pirceTitle input[type="checkbox"]');
					pirceChecks.each(function(index,element) {
						if($(this).prop('checked')==false){
							isAllCheck=false;
							return false;
						}
					});
					$this.parents('.issueBg').find('.issueTitle input[type="checkbox"]').prop('checked',isAllCheck);
				}
			}
				
			$("#allDelete").click(function(){
					var tableChecks=$('.issueBg input[type="checkbox"]');//表格内的复选框
					var isCheck=false;
					tableChecks.each(function(index,element) {
						if($(this).prop('checked')==true){
							isCheck=true;
						}
					});
					if(!isCheck){
						alert("请选择至少一条删除的记录");
					}else{
						    var result = rs.result;
						   	var selBoxes=$('.issueBg input[type="checkbox"]:checked');
						  	var shipIds = []
						  	
						   // var selIssueBoxes=$('.issueTitle>input[type="checkbox"]:checked');//批次复选框_选中状态
							//var selPriceBoxes=$('.pirceTitle>input[type="checkbox"]:checked');//运价复选框_选中状态
							   
					 		var selLength=selBoxes.length;
					 		//var selIssueLength = selIssueBoxes.length;
					 		//var selPriceLength = selPriceBoxes.length;
							
					 		//var filelength;
					 		//var filelength2;
					 		
					 		//var fileContent;
					 		
					 		/*if(selIssueLength > 0 || selPriceLength > 0){
					 			filelength = selIssueLength;
					 			filelength2 = selPriceBoxes.length;
					 			
					 			if(!filelength){
					 				fileContent = ""
					 			}else{
					 				fileContent = filelength+"条批号或"
					 			}
					 			
					 			if(!filelength2){
					 				filelength2 = ""
					 			}
					 		}*/
						   
							if(confirm("是否删除当前选中的运价信息吗?")){
								for(var i=0;i<selBoxes.length;i++){
									var thisId=selBoxes.eq(i).attr('data-id');
									shipIds.push(thisId);   		
								}
								$.ajax({
								url : "/ship/deleteBatchShip/?ids="+shipIds,
								type : "post",
								cache : true,
					        	dataType : "json",
								success : function(rsMsg) {  
						      		if(rsMsg.allRepeal == 'Success'){
										window.location.href = "/member/shiplist";
									}
								} 
							})
						}
							
					}
			});
			
				$("#allRepeal").click(function(){
					var tableChecks=$('.issueBg input[type="checkbox"]');//表格内的复选框
					var isCheck=false;
					tableChecks.each(function(index,element) {
						if($(this).prop('checked')==true){
							isCheck=true;
						}
					});
					if(!isCheck){
						alert("请选择至少一条撤销记录");
					}else{
						  	var result = rs.result;
						   	var selBoxes=$('.issueBg input[type="checkbox"]:checked');
						  	var shipIds = []
						  	
						   //var selIssueBoxes=$('.issueTitle>input[type="checkbox"]:checked');//批次复选框_选中状态
							//var selPriceBoxes=$('.pirceTitle>input[type="checkbox"]:checked');//运价复选框_选中状态
							   
					 		var selLength=selBoxes.length;
					 		//var selIssueLength = selIssueBoxes.length;
					 		//var selPriceLength = selPriceBoxes.length;
				
							
					 		//var filelength;
					 		//var filelength2;
					 		
					 		//var fileContent;
					 		/*
						 		if(selIssueLength > 0 || selPriceLength > 0){
						 			filelength = selIssueLength + selPriceLength;
						 			filelength2 = selPriceBoxes.length
						 			if(!filelength){
						 				//filelength = ""
						 				fileContent = ""
						 			}else{
						 				fileContent = filelength+"条批号或"
						 			}
						 			
						 			if(!filelength2){
						 				filelength2 = ""
						 			}
						 		}
				 		     */
					   		if(confirm("是否撤销当前选中的运价信息吗?")){
							for(var i=0;i<selBoxes.length;i++){
								var thisId=selBoxes.eq(i).attr('data-id');
								shipIds.push(thisId); 
							}
							
							$.ajax({
							url : "/ship/repealBatchShip/?ids="+shipIds,
							type : "post",
				        	dataType : "json",
							success : function(rsMsg) {  
									if(rsMsg.grid4 == 'Success'){
											window.location.href = "/member/shiplist";
									}
							} 
						})
								
					}
			
						$(".status").each(function(){
												
							if($(this).html().trim()==="已撤销"){
								
								 var targetEl = $(this).parent().parent().children().find(".repeal");
								 targetEl.prop("href")=="javascript:void(0)";
								 targetEl.css({'color':'#b4b4b4'});
							}
						})	
							
					}
					
				});
			
			}
			
			
		})
		
	}
		var getTotalPage = function(){
			
			$.ajax({
			url : "/ship/getTotalPage?maxResultSize="+page.maxResultSize,
			type : "post",
			cache : true,
			dataType : "json",
			success : function(rs) {  
				 page.totalPage = rs.totalPage
				
					setCommonPageEvent(page.totalPage,function(pageNo){//公用翻页控件
										console.log('点击'+pageNo+'页');
								        showShipList(pageNo,page.maxResultSize);
				});
			}
		})
		
	}
	
		getTotalPage()
		showShipList(page.pageNo,page.maxResultSize);

		
})
	
	function inquery(shipArray){
		//console.log(shipArray)
		var msgTpl = [
		              <!--发布信息-->
				          '<div class="issueBg">',
				              '<div class="issueTitle">',
				            	'<input data-id="'+shipArray[0].releaseNum+'" type="checkbox" />',
				                '<span>发布批号：',shipArray[0].releaseNum,'&nbsp;&nbsp;</span>',
				                '<span>发布时间：',shipArray[0].dateCreated,'&nbsp;&nbsp;</span>',
				                '<span>记录数：',shipArray[0].totalCount,'&nbsp;&nbsp;</span>',
				                '<div class="nums">', 
				                	'<span>显示记录数：</span>',  
				                    '<a href="javascript:void(0)" name="tenInfo" style="color:#0088dd;">10</a>',
				                    '<a href="javascript:void(0)" name="twentyInfo" style="color:#0088dd;">20</a>',
				                    '<a href="javascript:void(0)" name="fiftyInfo" style="color:#0088dd;">50</a>',
				                    '<a href="javascript:void(0)" name="oneHundredInfo" style="color:#0088dd;">100</a>',
				                    '<a href="javascript:void(0)" name="twoHundredInfo" style="color:#0088dd;">200</a>',
				               '</div>',
				            '</div>',
				       
			]
			//.join('');
			
			for(var i in shipArray){
			
					var aa = [ '<div class="pirceBg"  name="tenInfoMsg">',
				            	'<div class="pirceTitle">',
				                	'<input data-id="'+shipArray[i].id+'" type="checkbox" />',
				                    '<span>运价编号：',shipArray[i].id,'</span>',
				                    '<span>运输类型：',shipArray[i].transType,'</span>',
				            	'</div>',
				                '<div class="pirceContent">',
				                	'<div class="grid1">',
				                    	'<div class="shippingTxts">',
				                        	'<div class="top">',
				                        		'<span>',shipArray[i].startPort,'</span><span>—</span><span>',shipArray[i].endPort,'</span>',
				                            '</div>',
				                            '<div class="btm">',
				                            	'<span>航程：',shipArray[i].shippingDays,'</span><span>船期：',shipArray[i].shippingDay,'</span>',
				                            '</div>',
				                        '</div>',
				                    '</div>',
				                    '<div class="grid2">',
				                    	'<div class="priceTxts">',
				                        	'<div class="top">',
				                            	'<div>20GP</div><div>40GP</div><div>40HQ</div>',
				                            '</div>',
				                            '<div class="btm">',
				                            	'<div>$',shipArray[i].gp20,'</div><div>$',shipArray[i].gp40,'</div><div>$',shipArray[i].hq40,'</div>',
				                            '</div>',
				                        '</div>',
				                    '</div>',
				                    '<div class="grid3">',
				                    	'<div class="timesTxts">',
				                        	'<div class="top"><span>起：',shipArray[i].startDate,'</span></div>',
				                            '<div class="btm"><span>止：',shipArray[i].endDate,'</span></div>',
				                        '</div>',
				                    '</div>',
				                    '<div class="grid4">',
				                    	'<div class="statusTxts">',
				                        	'<div class="top"><span class="hanggao status" >',shipArray[i].status,'</span></div>',
				                            '<div class="btm"><a class="blueLink"  id="'+shipArray[i].id+'" >详情</a></div>',
				                        '</div>',
				                    '</div>',
				                    '<div class="grid5">',
				                    	'<div class="operTxts">',
				                        	'<div class="blueLink"><a href="/ship/pricing?id='+shipArray[i].id+'" style="color:#0088dd;">修改</a></div>',
				                            '<div class="blackLink" ><a href="/ship/updateStatus?id='+shipArray[i].id+'" class="hanggao repeal">撤销</a></div>',
				                            '<div class="redLink"><a href="/ship/deleteShip?id='+shipArray[i].id+'" style="color:red;" class="hanggao delete">删除</a></div>',
				                        '</div>',
				                    '</div>',
				            	'</div>',
				            '</div>',
				         ]
				           
				        msgTpl  = msgTpl.concat(aa);
			}
			var cc = ['</div>',]
			msgTpl = msgTpl.concat(cc)
			msgTpl = msgTpl.join('');
			//console.log(msgTpl)
		return msgTpl;
		
	}
		
		var status = $("#status").val()
			var serach = $("#serach").val()
			var shipCompany = $("#shipCompany").val()
			var createStratDate = $("#createStratDate").val()
			var createEndDate = $("#createEndDate").val()
       
      $("#shippinglist").click(function(evt){
									//  evt.stopPropagation();
							        //	evt.preventDefault();
									 var $target = $(evt.target);
									  if($target.hasClass('repeal')){
										  var rel = confirm("确实是否需要撤销吗？")
										  if(rel == true){
												return true
											}
										  else{
												return false
											  }
									   }
									   
							      		if($target.hasClass('delete')){
								      		var del = confirm("确实是否需要删除吗？");
								      		if(del==true){
													return true
									      		}
								      		else {
												    return false
									      		}
								      	}	
								     
							     })
	
		//$("#createStratDate").datepicker();
		//$("#createEndDate").datepicker(); 
		
	</script>
</body>
</html>