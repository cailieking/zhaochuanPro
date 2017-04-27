<!DOCTYPE html>
<html>
<head>
<title>按批次管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/shipping_manage.css" />
<asset:stylesheet src="c_css/shipping_send.css"/>

<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/batch_manager.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
</head>
<body>
	<div class="shipListEidts" id="shipListEidts">
    <div class="manage_md_right">
    	<ul class="rightNav1">
        	<li>按记录管理</li>
            <li class="sel">按批次管理</li>
        </ul>
        <!--批次管理-->
        <div class="shipMagContent" id="shipIssueMag">
        	<div class="rControlLine">
            	<span class="label0">查询条件:</span>
            	<span class="label1" style="text-indent:14px;">起始港:</span>
            	<input class="box1" type="text" id="starts" />
            	<span class="label1">目的港:</span>
            	<input class="box1" type="text" id="ends" />
            	<span class="label1" style="text-indent:14px;">船公司:</span>
            	<input class="box1" type="text" id="shipCompanysd" />
            	<span class="label1">供应商:</span>
            	<input class="box1" type="text" id="companys" />
            </div>
            <div class="rControlLine">
            	<span class="label1" style="margin-left:90px;">批次编号:</span>
            	<input class="box1" type="text" id="releaseNums"/>
            	<span class="label1">创建人:</span>
            	<input class="box1" type="text" id="createmans" />
            	<span class="label1">创建时间:</span>
            	<input class="box1" type="text" id="createtimesd"  onClick="WdatePicker()" style="width:90px;" />
            	<span class="label1" style="width:20px;">--</span>
            	<input class="box1" type="text" id="createtimesd"  onClick="WdatePicker()"  style="width:90px;" />
            	<select class="select1" id="statusd" name="statusd" style="margin-left:15px;">
            		<option value="">审核状态</option>
            		<option value="VerifyPassed">审核通过</option>
            		<option value="Expired">已过期</option>
            		<option value="Revoked">已撤销</option>
            		<option value="Closed">已关闭</option>
            	</select>
            	<div class="btnR btnMod1" onclick="batchSearch()">查询</div>
            </div>
            <div class="rControlLine"> 
                <div type="checkbox" class="checkAll modCheckbox0" id="issueCheckAll" style="cursor:pointer;" ></div>
                <div class="txt1" style="padding-right:20px;">全选</div>
                <div class="txt1">审核通过：<span class="red">( ${releaseNumCount?releaseNumCount:'0'} )</span></div>
                <div class="txt1">已撤销：<span class="red">( ${revokedNumCount?revokedNumCount:'0'} )</span></div>
                <div class="txt1">已过期：<span class="red">( ${expiredNumCount?expiredNumCount:'0'} )</span></div>
                <div class="btnL btnMod1" style="margin-left:0;" id="batchDelete">批量删除</div>
                <div class="btnL btnMod1" id="batchRepeal">批量撤销</div>
                <div class="btnR btnMod1" style="margin-right:0;" onClick="batchImport()">导入</div>
                <div class="btnR btnMod1" onClick="shipCreate()">发布</div>
                <div class="txt1" style="float:right;">
                	<span style="float:left">每页记录数：</span>
                	<a class="link"  href="/tariffManager/batchTwentyTariff/" >20</a>
                	<a class="link"  href="/tariffManager/batchFiftyTariff/" >50</a>
                	<a class="link"  href="/tariffManager/batchOneHundredTariff/" >100</a>
                </div>
            </div>
            <div class="rGridTop">
            	<div class="w1" style="text-align:left;text-indent:30px;">编号/状态</div>
                <div class="w2">起始港/目的港</div>
                <div class="w3">供应商/运费</div>
                <div class="w4">创建人/有效期</div>
                <div class="w5">操作</div>
            </div>
          
            <div class="shipTable"> 
            	<g:each in="${batrows}" var="batrow" >
                <div class="issueBg">
                    <div class="issueTitle">
                        <div class="issueCheck modCheckbox0" data-id="${batrow.releaseNum }" ></div>
                        <div class="datas">
                        	<div class="data">发布批号：<span>${batrow.releaseNum}</span></div>
                        	<div class="data">发布时间：<span>${batrow.dateCreated}</span></div>
                        	<div class="data">记录数：<span>${batrow.totalCount}</span></div>
                        </div>
                        <div class="companyName">${batrow.companyName }</div>
                        <div class="createName">${batrow.createBy}</div>
                        <div class="nums">
                            <span>显示数：</span>
                            <a class="link" href="javascript:void(0)"  name="tenInfo">10</a>
                			<a class="link" href="javascript:void(0)"  name="fiftyInfo">50</a>
                			<a class="link" href="javascript:void(0)"  name="twoHundredInfo">200</a>
                        </div>
                    </div>
                   <g:each in="${rows}" var="row"  status="m">
                   	<g:if test="${batrow.releaseNum.equals(row.releaseNum)}">
                    <div class="pirceBg">
                        <div class="w1">
                        	<div class="tTop">
                            	<input type="checkbox" class="priceCheck" data-id="${row.id }" />
                                <div class="data">运价编号：<span>${row.id }</span></div>
                            </div>
                            <div class="tDown">
                            	<div class="status">状态：<span style="color:#FF9966;">${row.status }</span></div>
                            </div>
                        </div>
                        <div class="w2">
                        	<div>
                            	<div class="pLabel">起：</div>
                                <div class="pName">${row.startPort }</div>
                            </div>
                            <div>
                            	<div class="pLabel">终：</div>
                                <div class="pName">${row.endPort }</div>
                            </div>
                        </div>
                        <div class="w3">
                        	<div>
                        		<div class="typeLine">20GP</div>
	                            <div class="priceLine">
	                            	<div class="price1">${row.gp20?row.gp20:'-' }</div>
	                                <div class="price2">${row.gp20Vip?row.gp20Vip:'-' }</div>
	                            </div>
                        	</div>
                        	<div>
                        		<div class="typeLine">40GP</div>
	                            <div class="priceLine">
	                            	<div class="price1">${row.gp40?row.gp40:'-' }</div>
	                                <div class="price2">${row.gp40Vip?row.gp40Vip:'-' }</div>
	                            </div>
                        	</div>
                        	<div>
                        		<div class="typeLine">40HQ</div>
	                            <div class="priceLine">
	                            	<div class="price1">${row.hq40?row.hq40:'-' }</div>
	                                <div class="price2">${row.hq40Vip?row.hq40Vip:'-' }</div>
	                            </div>
                        	</div>
                        </div>
                        <div class="w4">
                        	<div>起：<span class="gary4">${row.startDate }</span></div>
                            <div>止：<span class="gary4">${row.endDate }</span></div>
                        </div>
                        <div class="w5">
                        	<div>
                            	<div class="blueBtn"  title="查看" onClick="shippingDetailsShow($(this))"
                            			 data-id="${row.id}"  data-releaseNum="${row.releaseNum }"  
                    	                 data-startPort="${row.startPort }"  data-endPort="${row.endPort }" data-companyName="${row.companyName}" 
                    	                 data-gp20="${row.gp20?row.gp20:'-' }" data-gp20Vip="${row.gp20Vip?row.gp20Vip:'-' }"
                    	                 data-gp40="${row.gp40?row.gp40:'-' }" data-gp40Vip="${row.gp40Vip?row.gp40Vip:'-' }"  data-hq40="${row.hq40?row.hq40:'-' }"  data-hq40Vip="${row.hq40Vip?row.hq40Vip:'-' }"
                    	                 data-shipCompany="${row.shipCompany }"  data-middlePort="${row.middlePort?row.middlePort:'直达'}"  
                    	                 data-shippingDay="${row.shippingDay }"
                    	                 data-weightLimit="${row.weightLimit }" data-shippingDays="${row.shippingDays}" data-transType="${row.transType }"
                    	                 data-startDate="${row.startDate }" data-endDate="${row.endDate }"  data-extra="${row.extra}">详情</div>
                            	
                                <div class="blueBtn"
                                	onClick="bactchEditShip($(this))" data-infoids="${row.id}"
	                			    data-companyNames="${row.companyName}" 
	                				data-contactNames="${row.contactName }" data-phones="${row.phone }" 
                                    data-startPorts="${row.startPort}" data-endPorts="${row.endPort }" data-shippingDayss="${row.shippingDays}"
                                    data-shipCompanys="${row.shipCompany}" data-shippingDays="${row.shippingDay}" 
                                    data-transTypes="${row.transType}" data-startDates="${row.startDate}"
                                    data-endDates="${row.endDate}"  data-gp20s="${row.gp20?row.gp20:''}" data-gp20Vips="${row.gp20Vip?row.gp20Vip:''}"  data-gp40s="${row.gp40}"
                                    data-gp40Vips="${row.gp40Vip }" data-hq40s="${row.hq40 }" data-hq40Vips="${row.hq40Vip}" data-extras="${row.extra }"  
                                    data-weightLimits="${row.weightLimit }" data-remarks="${row.remark }"  data-cbms="${row.cbm}"
                                    data-lowestCosts="${row.lowestCost}"  data-middlePorts="${row.middlePort}"
                                
                                >修改</div>
                                <div class="blackBtn" onClick="shipRepeal(${row.id})">撤销</div>
                                <div class="redBtn" onClick="shipDelete(${row.id})">删除</div>
                            </div>
                        </div>
                    </div>
                     </g:if>
                  </g:each>
                </div>
               
                 </g:each>
            </div>
            <div class="rControlLine" style="position:relative;">
            	<div style="position:relative;float:left;z-index:1;">
	            	<div type="checkbox" class="checkAll modCheckbox0" id="issueCheckAll2" ></div>
	                <div class="txt1" style="padding-right:20px;">全选</div>
	                <div class="btnL btnMod1" style="margin-left:0;" id="batchDelete_b">批量删除</div>
	                <div class="btnL btnMod1" id="batchRepeal_b">批量撤销</div>
	                <div class="txt1" style="margin-left:425px;">
	                	<span style="float:left">每页记录数：</span>
	                	<a class="link"  href="/tariffManager/batchTwentyTariff/" >20</a>
                		<a class="link"  href="/tariffManager/batchFiftyTariff/" >50</a>
                		<a class="link"  href="/tariffManager/batchOneHundredTariff/" >100</a>
	                </div>
                </div>
                <div class="shipPage"   data-maxSum="${totalCount?totalCount:''}"  id="shipPage2" style="position:absolute;right:0;top:10px;"></div>
            </div>
        </div>
        <!--批次管理 end-->
    </div>
	</div>
<script>
$(function(){

	rightNavClick();//右侧页面切换导航点击
	
	 $("#batchRepeal,#batchRepeal_b").click(function(){
			var tableChecks=$('.shipTable input[type="checkbox"]');//表格内的复选框
			var isCheck=false;
			tableChecks.each(function(index,element) {
				if($(this).prop('checked')==true){
					isCheck=true;
				}
			});
			if(!isCheck){
				zcAlertrt("请选择至少一条撤销记录"); 
			}else{
				var issueCheck=$('.issueBg').find('.modCheckbox2');
			   	var selBoxes=$('.pirceBg').find('input[type="checkbox"]:checked');

			   	console.log('selBoxes',selBoxes);

				 
			  	var shipIds = []
			  	
		 		var selLength=selBoxes.length;

			  	zcConfirm("是否撤销当前选中的运价信息?",function(m){
					 if(m){	
						 for(var i=0;i<selBoxes.length;i++){
								var thisId=selBoxes.eq(i).attr('data-id');
								shipIds.push(thisId); 
							}
							for(var i=0;i<issueCheck.length;i++){
								var thisId=issueCheck.eq(i).attr('data-id');
								shipIds.push(thisId); 
							
							}
							console.log("thisId",thisId)
							
							$.ajax({
							url : "/tariffManager/batchRepeal/?ids="+shipIds,
							type : "post",
				        	dataType : "json",
							success : function(rsMsg) {  
									if(rsMsg.grid4 == 'Success'){
											window.location.href = "/tariffManager/bactchList";
									}
							} 
						})	
					}
			  	})
			}
	 	});


		$("#batchDelete,#batchDelete_b").click(function(){
			var tableChecks=$('.shipTable input[type="checkbox"]');//表格内的复选框
			var isCheck=false;
			tableChecks.each(function(index,element) {
				if($(this).prop('checked')==true){
					isCheck=true;
				}
			});
			if(!isCheck){
				zcAlertrt("请选择至少一条删除的记录");
			}else{
				var issueCheck=$('.issueBg').find('.modCheckbox2');
		   		var selBoxes=$('.issueBg').find('input[type="checkbox"]:checked');
			  	var shipIds = []
		 		var selLength=selBoxes.length;

				zcConfirm("是否删除当前选中的运价信息?",function(m){
					 if(m){	
						 for(var i=0;i<selBoxes.length;i++){
								var thisId=selBoxes.eq(i).attr('data-id');
								shipIds.push(thisId);   		
							}
							for(var i=0;i<issueCheck.length;i++){
								var thisId=issueCheck.eq(i).attr('data-id');
								shipIds.push(thisId); 
							}
							//console.log('shipIds',shipIds)
							$.ajax({
							url : "/tariffManager/batchDelete/?ids="+shipIds,
							type : "post",
							cache : true,
				        	dataType : "json",
							success : function(rsMsg) {  
					      		if(rsMsg.allRepeal == 'Success'){
									window.location.href = "/tariffManager/bactchList";
								}
							} 
						})
						 
					 }
				})
			}
	   });	
	  
})

	$("[name=tenInfo],[name=fiftyInfo],[name=twoHundredInfo]").click(function() {
		var thisLink=$(this);
		var releaseNum = $(this).parent().parent().find("span").first().text()
		//var bb = aa.split("：")
		
		var strUrl;
		var name=$(this).attr('name');
		
		if(name=='tenInfo'){
			strUrl='batchTenPricingInfo';
		}
		if(name=='fiftyInfo'){
			strUrl='batchFiftyPricingInfo';
		}
		if(name=='twoHundredInfo'){
			strUrl='batchTwoHundredPricingInfo'; 
		}
		//var releaseNum  = bb[1].trim();
		
 		$.ajax({
 	
			url : "/tariffManager/"+strUrl+"/?releaseNum='"+releaseNum+"'",
			type : "post",
			cache : true,
        	dataType : "json",
			success : function(rsMsg) {  
			var priceHtml="";
			for(var i=0;i<rsMsg.length;i++){
				priceHtml+='<!--运价信息-->';
				priceHtml+='<div class="pirceBg">';
				priceHtml+='<div class="w1">';
				priceHtml+='<div class="tTop">';
				priceHtml+='<input type="checkbox" class="priceCheck" data-id="'+rsMsg[i].id+'" />';
				priceHtml+='<div class="data">运价编号：<span>'+rsMsg[i].id+'</span></div>';
				priceHtml+='</div>';
				priceHtml+='<div class="tDown">';
				priceHtml+='<div class="status">状态：<span style="color:#FF9966;">'+rsMsg[i].status+'</span></div>';
				priceHtml+='</div>';
				priceHtml+='</div>';
				priceHtml+='<div class="w2">';
				priceHtml+='<div>';
				priceHtml+='<div class="pLabel">起：</div>';
				priceHtml+='<div class="pName">'+rsMsg[i].startPort+'</div>';
				priceHtml+='</div>';
				priceHtml+='<div>';
				priceHtml+='<div class="pLabel">终：</div>';
				priceHtml+='<div class="pName">'+rsMsg[i].endPort+'</div>';
				priceHtml+='</div>';
				priceHtml+='</div>';
				priceHtml+='<div class="w3">';
				priceHtml+='<div>';
				priceHtml+='<div class="typeLine">20GP</div>';
				priceHtml+='<div class="priceLine">';
				priceHtml+='<div class="price1">'+rsMsg[i].gp20Vip+'</div>';
				priceHtml+='<div class="price2">'+rsMsg[i].gp20+'</div>';
				priceHtml+='</div>';
				priceHtml+='</div>';
				priceHtml+='<div>';
				priceHtml+='<div class="typeLine">40GP</div>';
				priceHtml+='<div class="priceLine">';
				priceHtml+='<div class="price1">'+rsMsg[i].gp40Vip+'</div>';
				priceHtml+='<div class="price2">'+rsMsg[i].gp40+'</div>';
				priceHtml+='</div>';
				priceHtml+='</div>';
				priceHtml+='<div>';
				priceHtml+='<div class="typeLine">40HQ</div>';
				priceHtml+='<div class="priceLine">';
				priceHtml+='<div class="price1">'+rsMsg[i].hq40Vip+'</div>';
				priceHtml+=' <div class="price2">'+rsMsg[i].hq40+'</div>';
				priceHtml+='</div>';
				priceHtml+='</div>';
				priceHtml+='</div>';
				priceHtml+='<div class="w4">';
          		priceHtml+='<div>起：<span class="gary4">'+rsMsg[i].startDate+'</span></div>';
                priceHtml+='<div>止：<span class="gary4">'+rsMsg[i].endDate+'</span></div>';
                priceHtml+='</div>';
                priceHtml+='<div class="w5">';
                priceHtml+='<div>';
                priceHtml+='<div class="blueBtn" onClick="shippingDetailsShow($(this))" data-id="'+rsMsg[i].id+'" data-releaseNum="'+rsMsg[i].releaseNum+'"  data-startPort="'+rsMsg[i].startPort+'"  data-endPort="'+rsMsg[i].endPort+'" data-companyName="'+rsMsg[i].companyName+'"  data-gp20="'+rsMsg[i].gp20+'" data-gp20Vip="'+rsMsg[i].gp20Vip+'"  data-gp40="'+rsMsg[i].gp40+'"  data-gp40Vip="'+rsMsg[i].gp40Vip+'"  data-hq40="'+rsMsg[i].hq40+'" data-hq40Vip="'+rsMsg[i].hq40Vip+'" data-shipCompany="'+rsMsg[i].shipCompany+'"  data-middlePort="'+rsMsg[i].middlePort+'"  data-shippingDay="'+rsMsg[i].shippingDay+'" data-weightLimit="'+rsMsg[i].weightLimit+'" data-shippingDays="'+rsMsg[i].shippingDays+'" data-transType="'+rsMsg[i].transType+'" data-startDate="'+rsMsg[i].startDate+'" data-endDate="'+rsMsg[i].endDate+'" data-extra="'+rsMsg[i].extra+'" >详情</div>';
                priceHtml+='<div class="blueBtn" onClick="bactchEditShip($(this))" data-cbms="'+rsMsg[i].cbm+'" data-lowestCosts="'+rsMsg[i].lowestCost+'"  data-infoids="'+rsMsg[i].id+'"  data-routeNames="'+rsMsg[i].routeName+'"  data-companyNames="'+rsMsg[i].companyName+'"  data-contactNames="'+rsMsg[i].contactName+'"  data-phones="'+rsMsg[i].phone+'"  data-startPorts="'+rsMsg[i].startPort+'"  data-endPorts="'+rsMsg[i].endPort+'" data-shipCompanys="'+rsMsg[i].shipCompany+'"  data-gp20s="'+rsMsg[i].gp20+'" data-gp20Vips="'+rsMsg[i].gp20Vip+'"  data-gp40s="'+rsMsg[i].gp40+'"  data-gp40Vips="'+rsMsg[i].gp40Vip+'"  data-hq40s="'+rsMsg[i].hq40+'" data-hq40Vips="'+rsMsg[i].hq40Vip+'"   data-middlePorts="'+rsMsg[i].middlePort+'"  data-shippingDays="'+rsMsg[i].shippingDay+'" data-weightLimits="'+rsMsg[i].weightLimit+'" data-remarks="'+rsMsg[i].remark+'"  data-shippingDayss="'+rsMsg[i].shippingDays+'" data-transTypes="'+rsMsg[i].transType+'" data-startDates="'+rsMsg[i].startDate+'" data-endDates="'+rsMsg[i].endDate+'" data-extras="'+rsMsg[i].extra+'" >修改</div>';
                priceHtml+='<div class="blackBtn" onClick="shipRepeal('+rsMsg[i].id+')">撤销</div>';
                priceHtml+='<div class="redBtn" onClick="shipDelete('+rsMsg[i].id+')" >删除</div>';
                priceHtml+='</div>';
                priceHtml+='</div>';
                priceHtml+='</div>';
		        priceHtml+='<!--运价信息 end-->';
		}
				thisLink.parents('.issueBg').find('.pirceBg').remove();
				thisLink.parents('.issueBg').append($(priceHtml));
				checkClickEvent()
					
			} 
						
		})
				
	})

//右侧页面切换导航点击
function rightNavClick(){
	$('.rightNav1 li').click(function(){
		var lis=$('.rightNav1 li');
		var index=lis.index($(this));
		lis.removeClass('sel');
		$(this).addClass('sel');
		switch(index){
			case 0:{//按记录管理
				window.location.href='/tariffManager/list'
			}
			break;
			case 1:{//按批次管理
				window.location.href='/tariffManager/bactchList'
			}
			break;
		}
	})
}
//各个复选框的点击事件关联
function checkClickEvent(){
	//全选复选框点击
	$('#issueCheckAll,#issueCheckAll2').off('click').on('click',function(){
		var state=getModCheckState($(this));//获取自制复选框状态 于common.js中定义
		var issueChecks=$('.shipTable .issueCheck');
		var priceChecks=$('.shipTable input[type="checkbox"]');
		if(state==0||state==1){//无和部分选中->全选
			setModCheckState($('#issueCheckAll'),2);
			setModCheckState($('#issueCheckAll2'),2);
			for(var i=0;i<issueChecks.length;i++){
				setModCheckState(issueChecks.eq(i),2);
			}
			priceChecks.prop('checked',true);
		}
		if(state==2){//全选->无
			setModCheckState($('#issueCheckAll'),0);
			setModCheckState($('#issueCheckAll2'),0);
			for(var i=0;i<issueChecks.length;i++){
				setModCheckState(issueChecks.eq(i),0);
			}
			priceChecks.prop('checked',false);
		}
	})
	//发布批号复选框点击
	$('.shipTable .issueCheck').off('click').on('click',function(){
		var state=getModCheckState($(this));//获取自制复选框状态
		var priceChecks=$(this).parents('.issueBg').find('input[type="checkbox"]');
		if(state==0||state==1){//无和部分选中->全选
			setModCheckState($(this),2);
			priceChecks.prop('checked',true);
		}
		if(state==2){//全选->无
			setModCheckState($(this),0);
			priceChecks.prop('checked',false);
		}
		setModCheckState($('#issueCheckAll'),getAllCheckState());//设置“全选”复选框状态
		setModCheckState($('#issueCheckAll2'),getAllCheckState());//设置“全选”复选框状态
	})
	//运价复选框点击
	$('.shipTable input[type="checkbox"]').off('click').on('click',function(){
		var thisIssueCheck=$(this).parents('.issueBg').find('.issueCheck');
		setModCheckState(thisIssueCheck,getIssueCheckState(thisIssueCheck));//设置“发布批号”复选框状态
		setModCheckState($('#issueCheckAll'),getAllCheckState());//设置“全选”复选框状态
		setModCheckState($('#issueCheckAll2'),getAllCheckState());//设置“全选”复选框状态
	})
}
//检测"全选"复选框选中状态
//返回值 0无1部分选择2全选
function getAllCheckState(){
	var state=0;
	var checkLength=0;
	var isAll=true;
	var checks=$('.shipTable .issueCheck');
	for(var i=0;i<checks.length;i++){
		if(getIssueCheckState(checks.eq(i))!=0){
			checkLength++;
		}
		if(getIssueCheckState(checks.eq(i))==1){
			isAll=false;
		}
	}
	if(checkLength>0&&checkLength<checks.length){
		state=1;
	}
	if(checkLength==checks.length){
		if(isAll){
			state=2;
		}else{
			state=1;
		}
	}
	return state;
}
//检测"发布批号"复选框选中状态
//@$ele 复选框jq对象
//返回值 0无1部分选择2全选
function getIssueCheckState($ele){
	var state=0;
	var checkLength=0;
	var checks=$ele.parents('.issueBg').find('input[type="checkbox"]');//$('.myModeList .mCheck');
	for(var i=0;i<checks.length;i++){
		if(checks.eq(i).prop('checked')==true){
			checkLength++;
		}
	}
	if(checkLength>0&&checkLength<checks.length){
		state=1;
	}
	if(checkLength==checks.length){
		state=2;
	}
	return state;
}


	
	
</script>
</body>
</html>
