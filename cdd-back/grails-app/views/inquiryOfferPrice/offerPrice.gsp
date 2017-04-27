<!DOCTYPE html>
<html>
<head>
<title>今日应价</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/inquiry_today.css" />

<asset:javascript src="c_js/common.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
</head>
<body>
<div class="shipListEidts">
    <div class="manage_md_right">
    	<ul class="rightNav1" style="width:1200px;">
        	<li class="sel" ><a href="#">今日应价</a></li>
          
        </ul>
        <!-- 今日询盘 -->
        <div class="inpuiry_manage_today">
        	<div class="rControlLine" style="position:relative;">
        		<div class="txt1" ><span class="blue" onClick="inqueryByStatus('终止')">终止</span><span class="orange">（${cancleTotal}）</span></div>
                <div class="txt1" onClick="inqueryByStatus('订舱')"><span class="blue">订舱</span><span class="orange">（${bookingTotal}）</span></div>
                <div class="txt1" onClick="inqueryByStatus('已应价')"><span class="blue">已应价</span><span class="orange">（${offereddInquiryTotal}）</span></div>
                <div class="txt1" onClick="inqueryByStatus('补充询盘')"><span class="blue">补充询盘</span><span class="orange">（${addInquiryTotal}）</span></div>
               <!--  <div class="txt1"><span class="blue">新询盘</span><span class="orange">（${newInquiryTotal}）</span></div> -->
                <div class="txt1" onClick="inqueryByStatus('新询盘')"><span class="new">new</span><span class="orange">（${newInquiryTotal}）</span></div>
                <div class="txt1"><span class="red hand" onClick="myselfInquiry()">我的询盘</span></div>
                <div class="txt1"><span>其他专员询盘：</span></div>
                <select id="businessSelect" class="select1">
                	
                </select>
                <input class="box1" type="text" style="margin-left:15px;" placeholder="输入交易专员" id="salesMan"/>
                <div class="btnL btnMod1" style="margin-left:15px;" onClick="queryInquiryList()">查询</div>
        	</div>
        	<ul class="todayInpuiryList">
        	<g:each in="${result}" var="data">
        		<li>
        			<div class="t_line" style="border-bottom:1px #777777 solid;">
        				<g:if test="${data.inquiryStatus =="新询盘"}">
        				<div class="new">new</div>
        				</g:if>
        				<div class="num">编号：<span class="inpuiryNo">${data.number}</span></div>
        				<div class="status"><span class="yellow">${data.inquiryStatus}</span></div>
        				<div class="onOff">展开</div>
        				<div class="details" data-number="${data.number}" onClick="inquiryDetails($(this))">详情</div>
        			</div>
        			<div class="t_data_cur">
        				<div class="t_topTxt">
        					<ul class="t_data_list" style="margin-top:4px;">
        						<li>
        							<div class="t_label">客&nbsp;&nbsp;&nbsp;户：</div>
        							<div class="t_txt">${data.companyName}</div>
        						</li>
        						<li>
        							<div class="t_label">联系人：</div>
        							<div class="t_txt">${data.customName}</div>
        						</li>
        					</ul>
        				</div>
        		
        			</div>
        			<div class="t_data_history">
        				
        			</div>
        			<div class="t_line">
        				<div class="more">更多详情</div>
        				<div class="onOff">展开</div>
        			</div>
        			<div class="t_bottom">
        			<g:if test="${data.inquiryStatus != "终止"&&data.inquiryStatus != "订舱"}">
        				<div class="btnMod1" data-number="${data.number}" onClick="inquiryStop($(this))">终止</div>
        				<div class="btnMod1" data-number="${data.number}" onClick="inquiryPrice($(this))">应价</div>
        			</g:if>
        			</div>
        		</li>
        		</g:each>
        	</ul>
        </div>
        <!-- 今日询盘 end -->
    </div>
</div>

<script>
$(function(){
	loadInpuiryHistory();
	getBusinessList();
	//询盘列表详情展开、收缩
	$('.todayInpuiryList .onOff').click(function(){
		if($(this).html()=="展开"){
			$(this).parents('li').find('.t_data_history').show();
			$(this).parents('li').find('.t_data_cur').hide();
			$(this).parents('li').find('.onOff').html('收缩');
		}else{
			$(this).parents('li').find('.t_data_history').hide();
			$(this).parents('li').find('.t_data_cur').show();
			$(this).parents('li').find('.onOff').html('展开');
		}
	})
})


function inqueryByStatus(status){
	console.log(status);
	window.location.href='/inquiryOfferPrice/offerPrice?status='+status
}

//读取询盘记录
function loadInpuiryHistory(){
	var nums=$('.todayInpuiryList .inpuiryNo');
	for(var i=0;i<nums.length;i++){
		(function(i){
			var inpuiryNo=nums.eq(i).html();
			var thisLi=nums.eq(i).parents('li');
			$.ajax({
					type:'post',
					url:'/inquiryOfferPrice/getShow',
					dataType:'json',
					data:{number:inpuiryNo},
					success:function(rs){
							if(rs.showInquiry.textarea1){
							doInpuiryHistoryHtml(rs.showInquiry.textarea1,i,rs.showInquiry.createBy);
							}
							if(rs.showInquiry.textarea2){
							doInpuiryHistoryHtml2(rs.showInquiry.textarea2,i);
							}
							if(rs.showInquiry.textarea3){
							doInpuiryHistoryHtml3(rs.showInquiry.textarea3,i);
							}
							if(rs.showInquiry.textarea4){
								doInpuiryHistoryHtml4(rs.showInquiry.textarea4,i);
							}
					      
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
								console.log(XMLHttpRequest)
								console.log(textStatus)
								console.log(errorThrown)
					}
		
				})
		 }(i))
	}
}
function doInpuiryHistoryHtml(data,index,createBy){
		var ele=$('.todayInpuiryList>li').eq(index);
		var datas=data.split(';');
		var boxStr='';
		if(datas[4]){
			boxStr+=datas[4]+' ';
		}
		if(datas[5]){
			boxStr+=datas[5]+' ';
		}
		if(datas[6]){
			boxStr+=datas[6]+' ';
		}
		if(datas[7]){
			boxStr+=datas[7]+' ';
		}
		var doHtml=
'<div class="t_data_grid">'+
	'<div class="t_title">'+
		'<div class="time">'+datas[0]+'</div>'+
		'<div class="name">'+createBy+'</div>'+
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
			'<div class="t_label">柜型柜量：</div>'+
			'<div class="t_txt">'+boxStr+'</div>'+
		'</li>'+
		'<li>'+
			'<div class="t_label">说明：</div>'+
			'<div class="t_txt">'+datas[3]+'</div>'+
		'</li>'+
	'</ul>'+
'</div>';
	var cur=ele.find('.t_data_cur');
	cur.append(doHtml);
	var history=ele.find('.t_data_history');
	history.append(doHtml);
}
function doInpuiryHistoryHtml2(data,index){
	var ele=$('.todayInpuiryList>li').eq(index);
	var datas=data.split(';');
	var time=datas[0].split('^')[0];
	var name=datas[0].split('^')[1];
	var dataStr="";
	for(var i=1;i<datas.length-1;i++){
		var label=datas[i].split('^')[0];
		var txt=datas[i].split('^')[1];
		dataStr+=
		'<li>'+
			'<div class="t_label">'+label+'：</div>'+
			'<div class="t_txt">'+txt+'</div>'+
		'</li>'
	}
	var doHtml=
		'<div class="t_data_grid yellow">'+
		'<div class="t_title">'+
			'<div class="time">'+time+'</div>'+
			'<div class="name">'+name+'</div>'+
		'</div>'+
		'<ul class="t_data_list">'+
			dataStr+
		'</ul>'+
		'</div>';
	var history=ele.find('.t_data_history');
	history.append(doHtml);
}

function doInpuiryHistoryHtml3(data,index){
	var ele=$('.todayInpuiryList>li').eq(index);
	var datas=data.split(';');
	var time=datas[0].split('^')[0];
	var name=datas[0].split('^')[1];
	var dataStr="";
	for(var i=1;i<datas.length-1;i++){
		var label=datas[i].split('^')[0];
		var txt=datas[i].split('^')[1];
		dataStr+=
		'<li>'+
			'<div class="t_label">'+label+'：</div>'+
			'<div class="t_txt">'+txt+'</div>'+
		'</li>'
	}
	var doHtml=
		'<div class="t_data_grid">'+
		'<div class="t_title">'+
			'<div class="time">'+time+'</div>'+
			'<div class="name">'+name+'</div>'+
		'</div>'+
		'<ul class="t_data_list">'+
			dataStr+
		'</ul>'+
		'</div>';
	var history=ele.find('.t_data_history');
	history.append(doHtml);
}

function doInpuiryHistoryHtml4(data,index){
	var ele=$('.todayInpuiryList>li').eq(index);
	var datas=data.split(';');
	var time=datas[0].split('^')[0];
	var name=datas[0].split('^')[1];
	var dataStr="";
	for(var i=1;i<datas.length-1;i++){
		var label=datas[i].split('^')[0];
		var txt=datas[i].split('^')[1];
		dataStr+=
		'<li>'+
			'<div class="t_label">'+label+'：</div>'+
			'<div class="t_txt">'+txt+'</div>'+
		'</li>'
	}
	var doHtml=
		'<div class="t_data_grid yellow">'+
		'<div class="t_title">'+
			'<div class="time">'+time+'</div>'+
			'<div class="name">'+name+'</div>'+
		'</div>'+
		'<ul class="t_data_list">'+
			dataStr+
		'</ul>'+
		'</div>';
	var history=ele.find('.t_data_history');
	history.append(doHtml);
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
		zcConfirm3("复制成功");
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
		zcConfirm3("复制成功");
	}else{
		zcAlert('复制失败，请检查浏览器是否允许访问粘贴板')
	}
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
		                '<div class="d_txt">'+data.shipCompany+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物类型：</div>'+
		                '<div class="d_txt">'+(data.ordersType||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">品名：</div>'+
		                '<div class="d_txt">'+data.ordersName+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货重：</div>'+
		                '<div class="d_txt"><span>'+data.weight+'</span><span style="padding-left:15px;color:#000;">吨</span></div>'+
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
		                '<div class="d_txt">'+data.specialContainer+'</div>'+
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
		                '<div class="d_txt">'+data.shipper+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">说明：</div>'+
		                '<div class="d_txt">'+data.remarks+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">补充说明：</div>'+
		                '<div class="d_txt">'+data.otherRemarks+'</div>'+
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
		                '<div class="d_txt"><span>'+(data.shippingdays||'-')+'</span><span style="padding-left:15px;color:#000;">天</span></div>'+
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
//提交最终状态
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
	 	console.log(data);
	 	$('.inquiryStop .closeBtn').trigger('click');
	 	window.location.reload();
	 },"json");
}
//应价
function inquiryPrice(number){
	var num=number.attr('data-number');
	console.log('num',num)
	$.ajax({
				type:'post',
				url:'/inquiryOfferPrice/getDetails',
				dataType:'json',
				data:{number:num},
				success:function(rs){
				console.log('rs',rs.inquiryPrice)
				console.log('aa',rs.salesOnline)
		var data = 	rs.inquiryPrice	
		var salesOnline = rs.salesOnline
		if(salesOnline){
			onlineStr = '<span class="green">在线</span>'
		}else{
			onlineStr = '<span class="gary">离线</span>'
		}
		
		var companys = data.shipCompany;
		var companysStr='';
		if(companys=='null'||companys==''||companys==null){
			companysStr='<span class="orange">未提供</span>';
		}else{
			companysStr='<span>'+companys+'</span>';
		}
		
		var ordersTypeStr='';
		if(data.ordersType=='null'||data.ordersType==''||data.ordersType==null){
			ordersTypeStr=	'<span class="isl_label orange">未提供</span>'+
		            		'<input data-type="货物类型" type="checkbox" />'+
		            		'<span class="isl_label" style="color:#000;">需要提供</span>';
		}else{
			ordersTypeStr=	'<span class="isl_label">'+data.ordersType+'</span>';
		}
		
		var ordersNameStr='';
		if(data.ordersName=='null'||data.ordersName==''||data.ordersName==null){
			ordersNameStr=	'<span class="isl_label orange">未提供</span>'+
		            		'<input data-type="品名" type="checkbox" />'+
		            		'<span class="isl_label" style="color:#000;">需要提供</span>';
		}else{
			ordersNameStr = '<span class="isl_label">'+data.ordersName+'</span>';
		}
		
		
		var weightStr='';
		if(data.weight=='null'||data.weight==''||data.weight==null){
			weightStr=	'<span class="isl_label orange">未提供</span>'+
		            		'<input data-type="货重" type="checkbox" />'+
		            		'<span class="isl_label" style="color:#000;">需要提供</span>';
		}else{
			weightStr = '<span class="isl_label">'+data.weight+'</span>';
		}
		
		
		var sendTimeStr='';
		if(data.sendTime=='null'||data.sendTime==''||data.sendTime==null){
			sendTimeStr=	'<span class="isl_label orange">未提供</span>'+
		            		'<input data-type="出货时间" type="checkbox" />'+
		            		'<span class="isl_label" style="color:#000;">需要提供</span>';
		}else{
			sendTimeStr = '<span class="isl_label">'+data.sendTime+'</span>';
		}
		
		var specialContainerStr=';'
		if(data.specialContainer=='null'||data.specialContainer==''||data.specialContainer==null){
			specialContainerStr='<div class="isl_txt">未要求</div>';
		}else{
			specialContainerStr = '<div class="isl_txt">'+data.specialContainer+'</div>';
		}
		       
		
		var shipperStr='';
		if(data.shipper=='null'||data.shipper==''||data.shipper==null){
			shipperStr=	'<span class="isl_label orange">未提供</span>'+
		            		'<input data-type="shipper" type="checkbox" />'+
		            		'<span class="isl_label" style="color:#000;">需要提供</span>';
		}else{
			shipperStr = '<span class="isl_label">'+data.shipper+'</span>';
		}
		
		var price20gpStr = '';
		if(data.priceGp20=='null'||data.priceGp20==''||data.priceGp20==null){
			price20gpStr= '<input type="text" id="gp20_1" class="red" value="" />';
		}else{
			price20gpStr= '<input type="text" id="gp20_1" class="red" value="'+data.priceGp20+'" />';
		}
		
		var price40gpStr = '';
		if(data.priceGp40=='null'||data.priceGp40==''||data.priceGp40==null){
			price40gpStr= '<input type="text" id="gp40_1" class="red" value="" />';
		}else{
			price40gpStr= '<input type="text" id="gp40_1" class="red" value="'+data.priceGp40+'" />';
		}
		
		var price40hqStr = '';
		if(data.priceHq40=='null'||data.priceHq40==''||data.priceHq40==null){
			price40hqStr= '<input type="text" id="hq40_1" class="red" value="" />';
		}else{
			price40hqStr= '<input type="text" id="hq40_1" class="red" value="'+data.priceHq40+'" />';
		}
		var price45hqStr = '';
		if(data.priceHq45=='null'||data.priceHq45==''||data.priceHq45==null){
			price45hqStr= '<input type="text" id="hq45_1" class="red" value="" />';
		}else{
			price45hqStr= '<input type="text" id="hq45_1" class="red" value="'+data.priceHq45+'" />';
		}
		
		
		
		
		var newGp20Str = '';
		if(data.newGp20=='null'||data.newGp20==''||data.newGp20==null){
			newGp20Str= '<input type="text" id="gp20_2" class="red" value="" />';
		}else{
			newGp20Str= '<input type="text" id="gp20_2" class="red" value="'+data.newGp20+'" />';
		}
		
		var newGp40Str = '';
		if(data.newGp40=='null'||data.newGp40==''||data.newGp40==null){
			newGp40Str= '<input type="text" id="gp40_2" class="red" value="" />';
		}else{
			newGp40Str= '<input type="text" id="gp40_2" class="red" value="'+data.newGp40+'" />';
		}
		
		var newHq40Str = '';
		if(data.newHq40=='null'||data.newHq40==''||data.newHq40==null){
			newHq40Str= '<input type="text" id="hq40_2" class="red" value="" />';
		}else{
			newHq40Str= '<input type="text" id="hq40_2" class="red" value="'+data.newHq40+'" />';
		}
		
		var newHq45Str = '';
		if(data.newHq45=='null'||data.newHq45==''||data.newHq45==null){
			newHq45Str= '<input type="text" id="hq45_2" class="red" value="" />';
		}else{
			newHq45Str= '<input type="text" id="hq45_2" class="red" value="'+data.newHq45+'" />';
		}
		
		
		
		
		
		
		
		var doHtml=
			'<div class="winModBg0">'+
			'<div class="winModBg inquirySuppl wEditMod">'+
	    	'<div class="titleBg">'+
	        	'<div class="caption">应价</div>'+
	        	'<span class="titleTime">'+new Date(data.dateCreated).toLocaleDateString()+ new Date(data.dateCreated).toLocaleTimeString()+'</span>'+
	        	'<span class="titleName">'+data.createBy+'（'+onlineStr+'）</span>'+
	            '<div class="closeBtn">X</div>'+
	        '</div>'+
	        '<div class="isl_left">'+
	        	'<div class="addInpuiryContent">'+
		        	'<ul class="editList" style="display:block;">'+
		        		'<li>'+
			            	'<div class="wLabel">起始港：<div class="imp"></div></div>'+
			            	'<div class="isl_txt">'+data.startPort+'</div>'+
			            '</li>'+
			            '<li>'+
			            	'<div class="wLabel">目的港：<div class="imp"></div></div>'+
			            	'<div class="isl_txt">'+data.endPort+'</div>'+
			            '</li>'+
			           
	       			'<li>'+
		            	'<div class="wLabel">柜型柜量：<div class="imp"></div></div>'+
		                '<ul class="inpuiryBoxes2">'+
		                	'<li>'+
		                		'<div class="i_text">20GPx<span class="red">'+data.gp20+'</span></div>'+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="i_text">40GPx<span class="red">'+data.gp40+'</span></div>'+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="i_text">40HQx<span class="red">'+data.hq40+'</span></div>'+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="i_text">45HQx<span class="red">'+data.hq45+'</span></div>'+
		                	'</li>'+
		                '</ul>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">指定船公司：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+companysStr+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物类型：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+
		            		ordersTypeStr+
		            	'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">品名：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+
		            		ordersNameStr+
		            	'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货重：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+
		            		weightStr+
		            	'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物状态：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+(data.ordersStatus||'')+'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">出货时间：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+
		            		sendTimeStr+
		            	'</div>'+
		            '</li>'+
		            '<li>'+
		            '<div class="wLabel">特种柜要求：<div class="imp"></div></div>'+
		            	specialContainerStr+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">免柜期要求：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">未要求</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">Shipper：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+
		            		shipperStr+
		            	'</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">询盘说明：<div class="imp"></div></div>'+
		            	'<div class="isl_txt">'+data.remarks+'</div>'+
		            '</li>'+
		        '</ul>'+
		    '</div>'+
		    '<div class="addInpuiryBottom" style="background:transparent;">'+
	        	'<div class="btnMod1" id="addInpuiryAllCheck">全选/取消全选</div>'+
		    '</div>'+
        '</div>'+
        '<div class="isl_right">'+
        	'<div class="addInpuiryTop">'+
	        	'<div class="btnMod1" data-number="'+data.number+'" onClick="transOthers($(this))">确定</div>'+
	        	'<input type="text" id="pointerBox" onClick="getOtherBusiness()"/>'+
	        	'<div class="at_label">询价转交其他商务专员：</div>'+
	        	'<div class="pointersBg">'+
                	'<div><span class="name blue">吴宝坤</span><span class="green">(在线)</span></div>'+
                	'<div><span class="name blue">王世鹏</span><span class="green">(在线)</span></div>'+
                	'<div><span class="name blue">吴宝坤</span><span class="green">(在线)</span></div>'+
                	'<div><span class="name blue">王世鹏</span><span class="green">(在线)</span></div>'+
                	'<div><span class="name blue">谢晶</span><span>(离线)</span></div>'+
                '</div>'+
		    '</div>'+
        	'<div class="addInpuiryContent" style="height:483px;">'+
        		'<ul class="editList" style="display:block;">'+
		            '<li>'+
		            	'<div class="wLabel red">报价：<div class="imp"></div></div>'+
		                '<ul class="inpuiryBoxes">'+
		                	'<li>'+
		                		'<div class="type">20GP</div>'+
		                		price20gpStr+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">40GP</div>'+
		                		price40gpStr+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">40HQ</div>'+
		                		price40hqStr+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">45HQ</div>'+
		                		price45hqStr+
		                	'</li>'+
		                '</ul>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel red">报价调整：<div class="imp"></div></div>'+
		                '<ul class="inpuiryBoxes">'+
		                	'<li>'+
		                		'<div class="type">20GP</div>'+
		                		newGp20Str+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">40GP</div>'+
		                		newGp40Str+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">40HQ</div>'+
		                		newHq40Str+
		                	'</li>'+
		                	'<li>'+
		                		'<div class="type">45HQ</div>'+
		                		newHq45Str+
		                	'</li>'+
		                '</ul>'+
		            '</li>'+
        			'<li style="position:relative;z-index:2;">'+
		            	'<div class="wLabel">指定船公司：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" placeholder="可多选" id="companysInput"/>'+
		                '<div class="companysBg">'+
		                	'<div class="topBg">'+
		                		'<div class="caption">请选择船公司</div>'+
		                		'<div class="blueBtn" id="companysOk">确定</div>'+
		                	'</div>'+
		                	'<div>'+
				                		'<div class="c_label">A-G</div>'+
				                		'<ul class="companyList">'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>APL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>COSCO</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>ANL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>CMA</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>CSCL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>DELMAS</span>'+
				                			'</li>'+
				                		'</ul>'+
				                	'</div>'+
				                	'<div>'+
				                		'<div class="c_label">H-J</div>'+
				                		'<ul class="companyList">'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>HMM</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>HPL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>IAL</span>'+
				                			'</li>'+
				                		'</ul>'+
				                	'</div>'+
				                	'<div>'+
				                		'<div class="c_label">L-S</div>'+
				                		'<ul class="companyList">'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>K-LINE</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>KMTC</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>MCC</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>MOL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>MSK</span>'+
				                			'</li>'+
				                		'</ul>'+
				                	'</div>'+
				                	'<div>'+
				                		'<div class="c_label">T-Z</div>'+
				                		'<ul class="companyList">'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>OOCL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>PHL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>PIL</span>'+
				                			'</li>'+
				                			'<li>'+
				                				'<input type="checkbox" name="companys" />'+
				                				'<span>RCL</span>'+
				                			'</li>'+
				                		'</ul>'+
				                	'</div>'+
		                	
		                '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">船期：<div class="imp"></div></div>'+
		                '<input type="text" id="sp_shipDay" class="box1" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">航程：<div class="imp"></div></div>'+
		                '<input type="text" id="sp_dayLength" class="box1" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">限重：<div class="imp"></div></div>'+
		                '<input type="text" id="sp_weight" class="box1" style="width:100px;" />'+
		                '<div class="a_label">吨</div>'+
		            '</li>'+
		            '<li style="position:relative;z-index:1;">'+
		            	'<div class="wLabel">供应商：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" id="supplysInput" />'+
		                '<div class="supplysBg">'+
		                	'<div>'+
		                		'<input type="radio" />'+
		                		'<div class="supplyName">供应商名供应商名供应商名1</div>'+
		                	'</div>'+
		                	'<div>'+
		                	'<input type="radio" />'+
		                		'<div class="supplyName">供应商名供应商名供应商名2</div>'+
		                	'</div>'+
		                	'<div>'+
		                		'<input type="radio" />'+
		                		'<div class="supplyName">供应商名供应商名供应商名3</div>'+
		                	'</div>'+
		                	'<div>'+
		                		'<input type="radio" />'+
		                		'<div class="supplyName">供应商名供应商名供应商名4</div>'+
		                	'</div>'+
		                '</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">可提供免柜期：<div class="imp"></div></div>'+
		            	'<div class="a_label" style="margin:0;">起始港-</div>'+
		                '<input type="text" id="startFreeDemurrage" class="box1" style="width:50px;"/>'+
		                '<div class="a_label" style="margin:0 30px 0 5px;">天</div>'+
		                '<div class="a_label" style="margin:0;">目的港-</div>'+
		                '<input type="text" id="endFreeDemurrage" class="box1" style="width:50px;"/>'+
		                '<div class="a_label" style="margin:0 0 0 5px;">天</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">应价说明：<div class="imp"></div></div>'+
		                '<textarea class="area1" id="sp_remark"></textarea>'+
		            '</li>'+
        		'</ul>'+
		    '</div>'+
		    '<div class="addInpuiryBottom">'+
	        	'<div class="btnMod1" id="addInpuiryCansel">取消</div>'+
	        	'<div class="btnMod1" data-number="'+data.number+'" onClick="sendPrice($(this))">提交</div>'+
		    '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.inquirySuppl'));
	//取消
	$('#addInpuiryCansel').click(function(){
		$('.inquirySuppl .closeBtn').trigger('click');
	})
	//全选/取消
	$('#addInpuiryAllCheck').click(function(){
		var checks=$('.isl_left input[type="checkbox"]');
		if(checks.length>0){
			var isHaveCheck=0;
			for(var i=0;i<checks.length;i++){
				if(checks.eq(i).prop('checked')==true){
					isHaveCheck=1;
					break;
				}
			}
			if(isHaveCheck==0){
				checks.prop('checked',true);
			}else{
				checks.prop('checked',false);
			}
		}
	})
	//船公司列表显示
	$('#companysInput').click(function(){
		if($('.companysBg').css('display')=="none"){
			$('.companysBg').show();
		}else{
			$('.companysBg').hide();
		}
	})
	//转交其他商务专员显示
	$('#pointerBox').click(function(){
		if($('.pointersBg').css('display')=="none"){
			$('.pointersBg').show();
		}else{
			$('.pointersBg').hide();
		}
	})
	
	//船公司列表确定
	$('#companysOk').click(function(){
		var checkcs=$('.companyList input[name="companys"]:checked');
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
	//供应商显示
	$('#supplysInput').click(function(){
		if($('.supplysBg').css('display')=="none"){
			$('.supplysBg').show();
			var supplys=$('.supplysBg>div');
			var boxStr=$(this).val();
			$('.supplysBg>div').find('input[type="radio"]').prop('checked',false);
			for(var i=0;i<supplys.length;i++){
				if(boxStr==supplys.eq(i).find('.supplyName').html()){
					supplys.eq(i).find('input[type="radio"]').prop('checked',true);
				}
			}
		}else{
			$('.supplysBg').hide();
		}
	})
	//供应商点击
	$('.supplysBg>div').click(function(){
		var name=$(this).find('.supplyName').html();
		$('#supplysInput').val(name);
		$('.supplysBg').hide();
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

function sendPrice(ele){
		var aa =ele.attr('data-number');
		console.log('inquiryNumber',aa)
		var sendData={};
		//需要提供
		var needGetBoxes=$('.isl_left input[type="checkbox"]:checked');
		var needGetStr='';
		if(needGetBoxes.length>0){
			for(var i=0;i<needGetBoxes.length;i++){
				if(i!=needGetBoxes.length-1){
					needGetStr+=needGetBoxes.eq(i).attr('data-type')+'/';
				}else{
					needGetStr+=needGetBoxes.eq(i).attr('data-type');
				}
			}
		}
		sendData.needOffer=needGetStr;
		sendData.number = aa
		//价格
		sendData.GP20=$('#gp20_1').val();
		sendData.GP40=$('#gp40_1').val();
		sendData.HQ40=$('#hq40_1').val();
		sendData.HQ45=$('#hq45_1').val();
		//价格调整
		sendData.newGP20=$('#gp20_2').val();
		sendData.newGP40=$('#gp40_2').val();
		sendData.newHQ40=$('#hq40_2').val();
		sendData.newHQ45=$('#hq45_2').val();
		//船公司
		sendData.companys=$('#companysInput').val();
		//船期
		sendData.shipDay=$('#sp_shipDay').val();
		//航程
		sendData.dayLength=$('#sp_dayLength').val();
		//限重
		sendData.maxWeight=$('#sp_weight').val();
		//供应商
		sendData.supplys=$('#supplysInput').val();
		//免柜期
		sendData.freeDemurrage=$('#startFreeDemurrage').val()+','+$('#endFreeDemurrage').val();
		//说明
		sendData.remark=$('#sp_remark').val();
		console.log(sendData);
		
		$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/offerPriceSave',
			dataType:'json',
			data:sendData,
			success:function(rs){
				if(rs.status == "ok"){
					$('.inquirySuppl .closeBtn').trigger('click');
					window.location.reload();
				}
			},
		
			error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
};


function myselfInquiry(){
	var myself = 'myself';
		  window.location.href='/inquiryOfferPrice/offerPrice?myself='+myself
	
}

function getBusinessList(){

	$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/getBusinessList',
			dataType:'json',
			data:'',
			success:function(rs){
				
			 var nameStr = '<option selected="true">全部</option>';          
				for(var i=0;i<rs.list.length;i++){
				 nameStr+=
					'<option>'+rs.list[i]+'</option>'
				}
				var doHtml = nameStr;
				$('#businessSelect').html($(doHtml));
				//$('#businessSelect').val()
				$('#businessSelect').change(function(){
					var selStr=$(this).val();
					//$(this).find('option:selected').attr()
					console.log(selStr);
				})
			},
		
			error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
}

function queryInquiryList(){
	var businessMan = $('#businessSelect').val();
	var salesMan = $('#salesMan').val();
	 window.location.href='/inquiryOfferPrice/offerPrice?businessMan='+businessMan+'&salesMan='+salesMan
}
function getOtherBusiness(){
$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/getBusinessList',
			dataType:'json',
			data:'',
			success:function(rs){
				
			 var nameStr = '';          
				for(var i=0;i<rs.list.length;i++){
				if(rs.online[i]){
						 nameStr+=
							'<div><span class="name blue">'+rs.list[i]+'</span><span class="green">(在线)</span></div>'
					}else{
						 nameStr+=
							'<div><span class="name blue">'+rs.list[i]+'</span><span class="gary">(离线)</span></div>'
					}
				}
				var doHtml = nameStr;
				$('.pointersBg').html($(doHtml));
				//指定商务专员点击
				$('.pointersBg>div').click(function(){
					var name=$(this).find('.name').html();
					$('#pointerBox').val(name);
					$('.pointersBg').hide();
				})
				
			},
		
			error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})

}
//转交其他专员
function transOthers(number){
		var number =number.attr('data-number');
		var transBusinessMan = $("#pointerBox").val();
		 window.location.href='/inquiryOfferPrice/updateInquiry?number='+number+'&transBusinessMan='+transBusinessMan
}
</script>
</body>
</html>
