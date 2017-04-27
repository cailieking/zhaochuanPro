<!DOCTYPE html>
<html>
<head>
<title>按记录管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/shipping_manage.css" />
<asset:stylesheet src="c_css/shipping_send.css"/>

<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/shipping_manage.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>

</head>
<body>
	<div class="shipListEidts" id="shipListEidts">
    <div class="manage_md_right">
    	<ul class="rightNav1" style="width:1300px;">
        	<li class="sel" >按记录管理</li>
            <li>按批次管理</li>
        </ul>
        <!--记录管理-->
        <div class="shipMagContent" id="shipSearchMag" style="width:1300px;">
         <form action="/tariffManager/list">
        	<div class="rControlLine" style="position:relative;">
            	<span class="label0">查询条件:</span>
            	<span class="label1" style="text-indent:14px;">起始港:</span>
            	<input class="box1" type="text" id="start" />
            	<span class="label1">目的港:</span>
            	<input class="box1" type="text" id="end" />
            	<span class="label1" style="text-indent:14px;">船公司:</span>
            	<input class="box1" type="text" id="shipCompanys" name="shipCompanys" />
            	<span class="label1">供应商:</span>
            	<input class="box1" type="text" id="company" />
            	<div class="modTishiBg" style="position:absolute;left:1114px;top:70px;width:150px;">
                    <div class="modTishiTxt"><span style="color:#2a9de9;">蓝色为公开报价</span></div>
                    <div class="modTishiTxt"><span style="color:#f00;">红色为优惠价</span></div>
                </div>
            </div>
            <div class="rControlLine">
            	<span class="label1" style="margin-left:90px;">运价编号:</span>
            	<input class="box1" type="text" id="infoId"/>
            	<span class="label1">创建人:</span>
            	<input class="box1" type="text" id="createman" />
            	<span class="label1">创建时间:</span>
            	<input class="box1" type="text" id="createtimes"  onClick="WdatePicker()"  style="width:90px;" />
            	<span class="label1" style="width:20px;">--</span>
            	<input class="box1" type="text" id="createtimes"  onClick="WdatePicker()"  style="width:90px;" />
            	<select class="select1"  name="status" id="status" style="margin-left:15px;">
            		<option value="">审核状态</option>
            		<option value="VerifyPassed">审核通过</option>
            		<option value="Expired">已过期</option>
            		<option value="Revoked">已撤销</option>
            		<option value="Closed">已关闭</option>
            	</select>
            	<div class="btnR btnMod1" onClick="querySearch()">查询</div>
            </div>
            </form>
            <div class="rControlLine">
                <div class="txt1">查询结果：<span class="red">${total?total:''}条</span></div>
              
                <div class="txt1">审核通过：<span class="red">( ${releaseNumCount?releaseNumCount:'0' } )</span></div>
                <div class="txt1">已撤销：<span class="red">( ${revokedNumCount?revokedNumCount:'0' } )</span></div>
                <div class="txt1">已过期：<span class="red">( ${expiredNumCount?expiredNumCount:'0' } )</span></div>
           
                <div class="btnL btnMod1" style="margin-left:0;" id="shipDelete" >删除</div>
                <div class="btnR btnMod1" style="margin-right:0;" onClick="batchImport()">导入</div>
                <div class="btnR btnMod1" onClick="shipCreateRelease()">发布</div>
                <div class="txt1" style="float:right;">
                	<span style="float:left">每页记录数：</span>
                	<a class="link"  href="/tariffManager/twentyShipInfo/"  name="twentyInfo">20</a>
                 	<a class="link"  href="/tariffManager/fiftyShipInfo/"  name="fiftyInfo">50</a>
                  	<a class="link"  href="/tariffManager/oneHundredShipInfo/"  name="oneHundredInfo">100</a>
                  	<a class="link"  href="/tariffManager/wubaiShipInfo/"  name="wubaiInfo">500</a>
                  	<a class="link"  href="/tariffManager/thousandShipInfo/"  name="oneThousandInfo">1000</a>
                </div>
            </div>
            <div class="rGridTop" style="width:1300px;">
            	<div class="sw1">
            		<div class="checkAll modCheckbox0" id="searchCheckAll" ></div>
            	</div>
                <div class="sw2">运价编号</div>
                <div class="sw3">批次编号</div>
                <div class="sw4">起始港</div>
                <div class="sw5">目的港</div>
                <div class="sw6">船公司</div>
                <div class="sw7">20GP($)</div>
                <div class="sw8">40GP($)</div>
                <div class="sw9">40HQ($)</div>
                <div class="sw10">供应商</div>
                <div class="sw11">提交时间</div>
                <div class="sw12">状态</div>
                <div class="sw13">操作</div>
            </div>
            <ul class="rGridList">
           		<g:each in="${rows}" var="row"  status="m">
            	<li>
            		<div class="sw1">
	            		<input type="checkbox" data-id="${row.id}" /> 
	            	</div>
	            	
	                <div class="sw2"  title="查看"  onClick="shippingDetailsShow($(this))" 
	                   data-id="${row.id}"  data-releaseNum="${row.releaseNum }"  
	                   data-startPort="${row.startPort }"  data-endPort="${row.endPort }" data-companyName="${row.companyName}" 
	                   data-gp20="${row.gp20?row.gp20:'-' }" data-gp20Vip="${row.gp20Vip?row.gp20Vip:'-' }"
	                   data-gp40="${row.gp40?row.gp40:'-' }" data-gp40Vip="${row.gp40Vip?row.gp40Vip:'-' }"  data-hq40="${row.hq40?row.hq40:'-' }"  data-hq40Vip="${row.hq40Vip?row.hq40Vip:'-' }"
	                  data-shipCompany="${row.shipCompany }"  data-middlePort="${row.middlePort?row.middlePort:'直达'}"  data-shippingDay="${row.shippingDay }"
	                  data-weightLimit="${row.weightLimit }" data-shippingDays="${row.shippingDays}" data-transType="${row.transType }"
	                  data-startDate="${row.startDate }" data-endDate="${row.endDate }"  data-extra="${row.extra}"
	                
	                
	                >${row.id}</div>
	                <div class="sw3">${row.releaseNum}</div>
	                <div class="sw4">${row.startPort }</div>
	                <div class="sw5" title="${row.endPort }">${row.endPort }</div>
	                <div class="sw6">${row.shipCompany }</div>
	                <div class="sw7">
	                	<div class="price1">${row.gp20?row.gp20:'-' }</div>
	                	<div class="price2">${row.gp20Vip?row.gp20Vip:'-' }</div>
	                </div>
	                <div class="sw8">
	                	<div class="price1">${row.gp40?row.gp40:'-' }</div>
	                	<div class="price2">${row.gp40Vip?row.gp40Vip:'-' }</div>
	                </div>
	                <div class="sw9">
	                	<div class="price1">${row.hq40?row.hq40:'-' }</div>
	                	<div class="price2">${row.hq40Vip?row.hq40Vip:'-'}</div>
	                </div>
	                <div class="sw10" title="${row.companyName }">${row.companyName }</div>
	                <div class="sw11">${row.dateCreated }</div>
	                <div class="sw12"><span>${row.status }</span></div>
	                <div class="sw13">
	                	<div class="blueBtn" onClick="shipRepeal(${row.id})">撤销</div>
	                	<div class="blueBtn"
	                				onClick="editShipShow($(this))" data-infoids="${row.id}"
	                				data-routeNames="${row.routeName}" data-companyNames="${row.companyName}" 
	                				data-contactNames="${row.contactName }" data-phones="${row.phone }" 
                                    data-startPorts="${row.startPort}" data-endPorts="${row.endPort }" data-shippingDayss="${row.shippingDays}"
                                    data-shipCompanys="${row.shipCompany}" data-shippingDays="${row.shippingDay}" 
                                    data-transTypes="${row.transType}" data-startDates="${row.startDate}"
                                    data-endDates="${row.endDate}"  data-gp20s="${row.gp20}" data-gp20Vips="${row.gp20Vip}"  data-gp40s="${row.gp40}"
                                    data-gp40Vips="${row.gp40Vip }" data-hq40s="${row.hq40 }" data-hq40Vips="${row.hq40Vip }" data-extras="${row.extra }"  
                                    data-weightLimits="${row.weightLimit}" data-remarks="${row.remark }"  data-cbms="${row.cbm}"
                                    data-lowestCosts="${row.lowestCost}"  data-middlePorts="${row.middlePort}">
	                	 修改</div>
					</div>
            	</li>
           	  </g:each>
            </ul>
        	<div class="rControlLine" style="position:relative;">
        		<div class="txt1" style="position:absolute;left:0;top:0;">查询结果：<span class="red">${total?total:''}条</span></div>
        		<div class="txt1" style="position:absolute;left:650px;top:0;">
                	<span style="float:left">每页记录数：</span>
               		<a class="link"  href="/tariffManager/twentyShipInfo/"  style="position:relative;z-index:2;" name="twentyInfo">20</a>
                 	<a class="link"  href="/tariffManager/fiftyShipInfo/" style="position:relative;z-index:2;"  name="fiftyInfo">50</a>
                  	<a class="link"  href="/tariffManager/oneHundredShipInfo/" style="position:relative;z-index:2;"  name="oneHundredInfo">100</a>
                  	<a class="link"  href="/tariffManager/wubaiShipInfo/"  style="position:relative;z-index:2;" name="wubaiInfo">500</a>
                  	<a class="link"  href="/tariffManager/thousandShipInfo/" style="position:relative;z-index:2;"  name="oneThousandInfo">1000</a>
                </div>
                <div id="shipPage1"   data-maxSum="${total?total:''}"  class="shipPage" style="position:absolute;left:right;top:10px;"></div>
            </div>
        </div>
        <!--记录管理 end-->
    </div>
    </div>

 <!-- <div class="winModBg0" id="shipping_detailsBg" style="display:none;">
	<div class="winModBg wEditMod shipping_details">
    	<div class="titleBg">
        	<div class="caption">运价详情<span class="shippingNum">运价编号：<span class="num">10086</span></span><span class="shippingNum">批次编号：<span class="num">95527</span></span></div>
            <div class="closeBtn">X</div>
        </div>
        <div class="details_content">
        	<div>
        		<div class="startPort">起始港：<span id="startPort">CHIWAN</span></div>
        		<div class="endPort">目的港：<span id="endPort">BUENAVENTURA</span></div>
        	</div>
        	<div class="supplier">
        		<div class="dLabel">供应商：</div>
        		<div class="sName" id="supplier">深圳市长帆国际物流有限公司</div>
        	</div>
        	<div class="priceBg">
        		<div class="dLabel">运&nbsp;&nbsp;&nbsp;费：</div>
        		<div class="pGrid">
        			<div class="boxtype">20GP</div>
        			<div class="price1"><span id="20GP_1">$110</span></div>
        			<div class="price2"><span id="20GP_2">$100</span></div>
        		</div>
        		<div class="pGrid">
        			<div class="boxtype">40GP</div>
        			<div class="price1"><span id="40GP_1">$110</span></div>
        			<div class="price2"><span id="40GP_2">$100</span></div>
        		</div>
        		<div class="pGrid">
        			<div class="boxtype">40HQ</div>
        			<div class="price1"><span id="40HQ_1">$110</span></div>
        			<div class="price2"><span id="40HQ_2">$100</span></div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">船公司：</div>
        			<div class="bName" id="shipCompany">MTK</div>
        		</div>
        		<div class="bg50">
        			<div class="dLabel">中转港：</div>
        			<div class="bName" id="mdPort">直达</div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">船&nbsp;&nbsp;&nbsp;期：</div>
        			<div class="bName" id="shipDay">2截5开</div>
        		</div>
        		<div class="bg50">
        			<div class="dLabel">限&nbsp;&nbsp;&nbsp;重：</div>
        			<div class="bName" id="shipWeight">20吨</div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">航&nbsp;&nbsp;&nbsp;程：</div>
        			<div class="bName" id="shipLong">24天</div>
        		</div>
        		<div class="bg50">
        			<div class="dLabel">运输类型：</div>
        			<div class="bName" id="shipType">整箱</div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">有效期：</div>
        			<div class="bName" id="shipValidity">2015-09-13至2015-10-23</div>
        		</div>
        		<div class="bg50">
        			
        		</div>
        	</div>
        	<div class="fjPrice">
        		<div class="dLabel">附加费：</div>
        		<ul class="fjPriceList" id="fjPriceList">
        			<li class="fTitle">
        				<div class="fw1">名称</div>
        				<div class="fw2">单位</div>
        				<div class="fw3">币种</div>
        				<div class="fw4">20GP</div>
        				<div class="fw5">40GP</div>
        				<div class="fw6">40HQ</div>
        				<div class="fw7">单票价格</div>
        			</li>
        			<li>
        				<div class="fw1 fName">AFC</div>
        				<div class="fw2">票</div>
        				<div class="fw3">USD</div>
        				<div class="fw4">-</div>
        				<div class="fw5">-</div>
        				<div class="fw6">-</div>
        				<div class="fw7">452</div>
        			</li>
        			<li>
        				<div class="fw1 fName">AMS</div>
        				<div class="fw2">箱</div>
        				<div class="fw3">CNY</div>
        				<div class="fw4">23</div>
        				<div class="fw5">23</div>
        				<div class="fw6">23</div>
        				<div class="fw7">-</div>
        			</li>
        			<li>
        				<div class="fw1 fName">DOC</div>
        				<div class="fw2">票</div>
        				<div class="fw3">USD</div>
        				<div class="fw4">-</div>
        				<div class="fw5">-</div>
        				<div class="fw6">-</div>
        				<div class="fw7">452</div>
        			</li>
        			<li>
        				<div class="fw1 fName">EIR</div>
        				<div class="fw2">票</div>
        				<div class="fw3">CNY</div>
        				<div class="fw4">-</div>
        				<div class="fw5">-</div>
        				<div class="fw6">-</div>
        				<div class="fw7">110</div>
        			</li>
        		</ul>
        	</div>
        	<div class="mark">
        		<div class="dLabel">备&nbsp;&nbsp;&nbsp;注：</div>
        		<div class="mTxt" id="shipMark">可出SWB 目的港收取 EIS JPY1000/2000可出SWB 目的港收取 EIS JPY1000/2000可出SWB 目的港收取 EIS JPY1000/2000可出SWB 目的港收取 EIS JPY1000/2000</div>
        	</div>
        </div>
    </div>
</div> -->
<script>
$(function(){
	rightNavClick();//右侧页面切换导航点击
})

//运价详情显示
//function shippingDetailsShow(){
	//$('#shipping_detailsBg').show();
	//setEleMiddle($('.shipping_details'));//使元素居中
//}
//右侧页面切换导航点击
function rightNavClick(){
	$('.rightNav1 li').click(function(){
		var lis=$('.rightNav1 li');
		var index=lis.index($(this));
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

function shipRepeal(id){
	zcConfirm("确定需要撤销吗？",function(m){
		 if(m){
			 window.location.href='/tariffManager/repeal?id=' + id;
		 }
	 })
}

<%-- 运价删除    --%>
$("#shipDelete").click(function(){
	var tableChecks=$('.rGridList input[type="checkbox"]');//表格内的复选框
	var isCheck=false;
	tableChecks.each(function(index,element) {
		if($(this).prop('checked')==true){
			isCheck=true;
		}
	});
	if(!isCheck){
		zcAlert("请选择至少一条删除的记录");
	}else{
			//var issueCheck=$('.sw1').find('.modCheckbox2');
	   		var selBoxes=$('.sw1').find('input[type="checkbox"]:checked');
		  	var shipIds = []
	 		var selLength=selBoxes.length;
	 		

		  	zcConfirm("是否删除当前选中的运价信息吗?",function(m){
				 if(m){

						for(var i=0;i<selBoxes.length;i++){
							var thisId=selBoxes.eq(i).attr('data-id');
							shipIds.push(thisId);   		
						}
						$.ajax({
						url : "/tariffManager/delete/?ids="+shipIds,
						type : "post",
						cache : true,
			        	dataType : "json",
						success : function(rsMsg) {  
				      		if(rsMsg.allRepeal == 'Success'){
								window.location.href = "/tariffManager/list";
							}
						} 
					})
				 }
			 })
		}
  });	






//按搜索记录管理复选框点击事件
function searchCheckClickEvent(){
	//全选复选框点击
	$('#searchCheckAll').off('click').on('click',function(){
		var state=getModCheckState($(this));//获取自制复选框状态 于common.js中定义
		var checks=$('.rGridList input[type="checkbox"]');
		if(state==0||state==1){//无和部分选中->全选
			setModCheckState($(this),2);
			checks.prop('checked',true);
		}
		if(state==2){//全选->无
			setModCheckState($(this),0);
			checks.prop('checked',false);
		}
	})
	//搜索记录复选框点击
	$('.rGridList input[type="checkbox"]').off('click').on('click',function(){
		console.log('getSearchAllCheckState',getSearchAllCheckState());
		setModCheckState($('#searchCheckAll'),getSearchAllCheckState());//设置“全选”复选框状态
	})
}

//检测按搜索管理的"全选"复选框选中状态
//返回值 0无1部分选择2全选
function getSearchAllCheckState(){
	var state=0;
	var checkLength=0;
	var isAll=true;
	var checks=$('.rGridList input[type="checkbox"]');
	for(var i=0;i<checks.length;i++){
		if(checks.eq(i).prop('checked')==true){
			checkLength++;
		}else{
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
</script>
</body>
</html>
