<!DOCTYPE html>
<html>
<head>
<title>今日询盘</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/inquiry_today.css" />
<asset:javascript src="/c_js/searchbox.js" />
<asset:stylesheet src="c_css/shipping_search.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>

</head>
<body>
<div class="shipListEidts">
    <div class="manage_md_right">
    	<ul class="rightNav1" style="width:1200px;">
        	<li class="sel" ><a href="#">今日询盘</a></li>
           
        </ul>
        <!-- 今日询盘 -->
       
        <div class="inpuiry_manage_today">
        	<div class="rControlLine" style="position:relative;">
        		<div class="txt1" onClick="inqueryByStatus('终止')"><span class="blue">终止</span><span class="orange">（${cancleTotal}）</span></div>
                <div class="txt1" onClick="inqueryByStatus('订舱')"><span class="blue">订舱</span><span class="orange">（${bookingTotal}）</span></div>
                <div class="txt1" onClick="inqueryByStatus('已应价')"><span class="blue">已应价</span><span class="orange">（${offereddInquiryTotal}）</span></div>
                <div class="txt1" onClick="inqueryByStatus('补充询盘')"><span class="blue">补充询盘</span><span class="orange">（${addInquiryTotal}）</span></div>
               <!--  <div class="txt1"><span class="blue">新询盘</span><span class="orange">（${newInquiryTotal}）</span></div>-->
                <div class="txt1" onClick="inqueryByStatus('新询盘')"><span class="new">new</span><span class="orange">（${newInquiryTotal}）</span></div>
                
                <input class="box1" type="text" style="margin-right:8px;" placeholder="输入客户名称" id="searchInput"/>
                <div class="btnL btnMod1" style="margin-right:20px;" onClick="queryInquiry()">查询</div>
                <div class="btnL btnMod1" onClick="addInquiry()">询盘</div>
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
        				<div class="btnMod1"  data-number="${data.number}" onClick="inquirySuppl($(this))">补充</div>
        			</g:if>
        			</div>
        			
        		</li>
        		</g:each>
        	</ul>
        </div>
        <!-- 今日询盘 end -->
    </div>
</div>

<script type="text/javascript">
$(function(){
	loadInpuiryHistory();
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
	window.location.href='/inquiryOfferPrice/inquiry?status='+status
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
						doInpuiryHistoryHtml(rs.showInquiry.textarea1,i);
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
function doInpuiryHistoryHtml(data,index){
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
//添加询盘
function addInquiry(){
	var doHtml=
		'<div class="winModBg0">'+
			'<div class="winModBg wEditMod addInquiry">'+
		    	'<div class="titleBg">'+
		        	'<div class="caption">询盘</div>'+
		            '<div class="closeBtn">X</div>'+
		        '</div>'+
		        '<form id="inquiryForm"  name= "myform" method = "post" action="/inquiryOfferPrice/saveInquiry">'+
		        '<div class="addInpuiryContent" id="searchStartEnd">'+
		        	'<ul class="dataBarList">'+
		        		'<li>基本询盘信息<div class="icon_OnOff">-</div></li>'+
		        		'<ul class="editList" style="display:block;">'+
		        		
		        			'<li>'+
				            	'<div class="wLabel red"><span class="label1">起始港:</span><div class="imp"></div></div>'+
				                '<input type="text" name="startPort" id="start_port_input" class="box1" />'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel red"><span class="label1">目的港:</span><div class="imp"></div></div>'+
				                '<input type="text" name="endPort" id="dest_port_input" class="box1" onchange="setBusiness()"/>'+
				                '<input style="display:none;" id="port_search_btn" />'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel red">柜型柜量：<div class="imp"></div></div>'+
				                '<ul class="inpuiryBoxes">'+
				                	'<li>'+
				                		'<div class="type">20GP</div>'+
				                		'<input name="gp20" id="inquiryGp20" type="text" />'+
				                	'</li>'+
				                	'<li>'+
				                		'<div class="type">40GP</div>'+
				                		'<input name="gp40" id="inquiryGp40" type="text" />'+
				                	'</li>'+
				                	'<li>'+
				                		'<div class="type">40HQ</div>'+
				                		'<input name="hq40" id="inquiryHq40" type="text" />'+
				                	'</li>'+
				                	'<li>'+
				                		'<div class="type">45HQ</div>'+
				                		'<input name="hq45" id="inquiryHq45" type="text" />'+
				                	'</li>'+
				                '</ul>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">说明：<div class="imp"></div></div>'+
				                '<textarea class="area1" name="remarks"></textarea>'+
				            '</li>'+
				            '<li style="position:relative;z-index:1;">'+
				            	'<span style="padding-left:20px;">系统分配商务专员：</span>'+
				                '<span class="blue" id="getSysBusiness"><span style="color:#333;"></span></span>'+
				                '<input name="sysBusinessMan" id="sysBusinessMan" type="hidden"/>'+
				                '<span style="padding-left:20px;">指定商务专员报价：</span>'+
				                '<input type="text" style="border:1px #a9a9a9 solid !important;border-radius:0;width:129px;" id="pointerBox" name="businessMan" onClick="getBusinessList()"/>'+
				                '<div class="pointersBg">'+
				                	
				                '</div>'+
				            '</li>'+
				            
		        		'</ul>'+
		        		'<li>更多询盘信息<div class="icon_OnOff">+</div></li>'+
		        		'<ul class="editList">'+
		        			'<li style="position:relative;z-index:1;">'+
				            	'<div class="wLabel">指定船公司：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" placeholder="可多选" id="companysInput" name="shipCompany"/>'+
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
				            	'<div class="wLabel">货物类型：<div class="imp"></div></div>'+
				                '<input type="radio" name="itemType" id="itemType_normal" value="普货"/>'+
				                '<div class="a_label">普货</div>'+
				                '<input type="radio" name="itemType" id="itemType_special" value="特殊货品"/>'+
				                '<div class="a_label">特殊货品</div>'+
				                '<input type="text" class="box1" id="itemType_special_box" style="display:none;" name="specialOrders"/>'+
				            
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">品名：<div class="imp"></div></div>'+
				                '<input type="text" name="ordersName" class="box1" />'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">货重：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" style="width:100px;" name="weight"/>'+
				                '<div class="a_label">吨</div>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">货物状态：<div class="imp"></div></div>'+
				                '<input type="radio" name="itemStatus" value="不明"/>'+
				                '<div class="a_label">不明</div>'+
				                '<input type="radio" name="itemStatus" value="准备中"/>'+
				                '<div class="a_label">准备中</div>'+
				                '<input type="radio" name="itemStatus" value="已好"/>'+
				                '<div class="a_label">已好</div>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">出货时间：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" name="sendTime" onClick="WdatePicker()"/>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">特种柜要求：<div class="imp"></div></div>'+
				                '<input type="checkbox" id="needSpecial"  />'+
				                '<div class="a_label">需要特种柜</div>'+
				                '<input type="text" class="box1" id="needSpecialInput" style="display:none;" name="specialContainer"/>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">免柜期要求：<div class="imp"></div></div>'+
				            	'<div class="a_label" style="margin:0;">起始港-</div>'+
				                '<input type="text" class="box1" style="width:50px;" name="freeDemurrageStart"/>'+
				                '<div class="a_label" style="margin:0 30px 0 5px;">天</div>'+
				                '<div class="a_label" style="margin:0;">目的港-</div>'+
				                '<input type="text" class="box1" style="width:50px;" name="freeDemurrageEnd"/>'+
				                '<div class="a_label" style="margin:0 0 0 5px;">天</div>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">其他说明：<div class="imp"></div></div>'+
				                '<textarea class="area1" name="otherRemarks"></textarea>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">shipper：<div class="imp"></div></div>'+
				                '<textarea class="area1" name="shipper"></textarea>'+
				            '</li>'+
		        		'</ul>'+
		        		'<li>客户资料<div class="icon_OnOff">+</div></li>'+
		        		'<ul class="editList">'+
		        			'<li>'+
				            	'<div class="wLabel">公司名称：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" name="companyName" />'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">姓名：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" name="customName"/>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">电话：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" name="phone"/>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">QQ：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" name="qq"/>'+
				            '</li>'+
				            '<li>'+
				            	'<div class="wLabel">邮箱：<div class="imp"></div></div>'+
				                '<input type="text" class="box1" name="email"/>'+
				            '</li>'+
		        		'</ul>'+
		        	'</ul>'+
		        '</div>'+
		        '</form>'+
		        '<div class="addInpuiryBottom">'+
		        	'<div class="btnMod1" id="addInquiryCansel">取消</div>'+
		        	'<div class="btnMod1" onClick="inquiryFormSub()">提交</div>'+
		        '</div>'+
		    '</div>'+
		'</div>';
	$('body').append($(doHtml));
	loadSearchData();
	modDlgEvent($('.addInquiry'));
	$('#addInquiryCansel').click(function(){
		$('.addInquiry .closeBtn').trigger('click');
	})
	//基本货盘信息、更多货盘信息、客户信息切换
	$('.dataBarList>li').click(function(){
		$('.dataBarList .editList').hide();
		$('.dataBarList>li .icon_OnOff').html('+');
		$(this).find('.icon_OnOff').html('-')
		$(this).next().show();
	})
	//指定商务专员显示
	$('#pointerBox').click(function(){
		if($('.pointersBg').css('display')=="none"){
			$('.pointersBg').show();
		}else{
			$('.pointersBg').hide();
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



//去除字符窜中的标签
function removeHTMLTag(str) {
	str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
	str = str.replace(/[ | ]*\n/g,''); //去除行尾空白
	str = str.replace(/\n[\s| | ]*\r/g,''); //去除多余空行
	str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
	return str;
}

//表单提交
function inquiryFormSub(){
	var startPort = $("#start_port_input").val();
	var endPort = $("#dest_port_input").val();
	var gp20 = $("#inquiryGp20").val();
	var gp40 = $("#inquiryGp40").val();
	var hq40 = $("#inquiryHq40").val();
	var hq45 = $("#inquiryHq45").val();
	var sysBusinessMan = $("#sysBusinessMan").val();
	var pointerMan = $("#pointerBox").val();
	if(startPort==""||startPort.trim()==""){
		zcAlert('起始港必填！');
		return;
	}
	if(endPort==""||endPort.trim()==""){
		zcAlert('目的港必填！');
		return;
	}
	if(gp20==""&&gp40==""&&hq40==""&&hq45==""){
		zcAlert('柜型柜量必填！');
		return;
	}
	if(sysBusinessMan==""&&pointerMan==""){
	
		zcAlert('暂无系统分配，请指定商务专员！');
		return;
	}
	$("#inquiryForm").submit();
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

//补充询价
function inquirySuppl(number){
	var num=number.attr('data-number');
	$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/getDetails',
			dataType:'json',
			data:{number:num},
			success:function(rs){
				console.log(rs.inquiryPrice)
				var data = rs.inquiryPrice
				var businessManOnline = rs.businessManOnline
				console.log(businessManOnline)
				var onlineStr='';
				if(businessManOnline){
				onlineStr = '<span class="green">在线</span>'
				}else{
				onlineStr = '<span class="gary">离线</span>'
				}
				
				var priceStr='';
				if(data.newGp20!=''&&data.newGp20!='null'&&data.newGp40!=''&&data.newGp40!='null'&&data.newHq40!=''&&data.newHq40!='null'&&data.newHq45!=''&&data.newHq45!='null'){
				
					 priceStr='<li>'+
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
			            '</li>'
				}else{
					priceStr='<li>'+
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
			            '</li>'
				}
				
				
				
			var doHtml=
				'<div class="winModBg0">'+
					'<div class="winModBg inquirySuppl wEditMod">'+
				    	'<div class="titleBg">'+
				        	'<div class="caption">补充</div>'+
				        	'<span class="titleTime">'+new Date(data.lastUpdated).toLocaleDateString()+ new Date(data.lastUpdated).toLocaleTimeString()+'</span>'+
				        	'<span class="titleName" id="businessNameTop">'+data.businessMan+'（'+onlineStr+'）</span>'+
				            '<div class="closeBtn">X</div>'+
				        '</div>'+
				        '<div class="isl_left">'+
				        	'<div class="addInpuiryContent">'+
						        	'<ul class="editList" style="display:block;">'+
						        	
		       			priceStr+
			            
			            
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
		                '<input type="text" class="box1" placeholder="可多选" id="companysInput" name="shipCompany" value="'+(data.shipCompany||'')+'"/>'+
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
		                '<input type="radio" name="itemType" id="itemType_normal" />'+
		                '<div class="a_label">普货</div>'+
		                '<input type="radio" name="itemType" id="itemType_special" value="普货"/>'+
		                '<div class="a_label">特殊货品</div>'+
		                '<input type="text" class="box1" id="itemType_special_box" style="display:none;" />'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">品名：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" id="ordesName" value="'+(data.ordersType||'')+'"/>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货重：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" style="width:100px;" id="weight" value="'+(data.weight||'')+'"/>'+
		                '<div class="a_label">吨</div>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">货物状态：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" style="width:100px;" id="ordersStatus" value="'+(data.ordersStatus||'')+'"/>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="wLabel">出货时间：<div class="imp"></div></div>'+
		                '<input type="text" class="box1" onClick="WdatePicker()" id="sendTime" value="'+(data.sendTime||'')+'"/>'+
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
	
function getBusinessList(){

	$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/getBusinessList',
			dataType:'json',
			data:'',
			success:function(rs){
				console.log('rs',rs);
				var list = rs.list
			 var nameStr = '';          
				for(var i=0;i<list.length;i++){
					if(rs.online[i]){
						 nameStr+=
							'<div><span class="name blue">'+list[i]+'</span><span class="green">(在线)</span></div>'
					}else{
						nameStr+=
							'<div><span class="name blue">'+list[i]+'</span><span class="gary">(离线)</span></div>'
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
	
function queryInquiry(){
	var companyName = $('#searchInput').val();
	  window.location.href='/inquiryOfferPrice/inquiry?companyName='+companyName
	
}	

//读取搜索输入框数据
function loadSearchData(){
	if(window.sessionStorage){
		console.log('支持sessionStorage')
		//sessionStorage.setItem("indexToShippingSearchData", JSON.stringify(indexSearchData));
		var zcPort=JSON.parse(sessionStorage.getItem("zhaochuanSearchtPort"));
		if(zcPort){//如果已有港口数据
			console.log('本地储存有港口数据',zcPort);
			initSearchBox(zcPort.startPort,zcPort.endPort);
		}else{
			console.log('没有本地储存港口数据',zcPort);
			$.ajax({
				url:'/Route/port',
				dataType:'json',
				success:function(rs){
					if(rs.status === 1){
						//本地储存港口数据
						var portData={};
						portData.startPort=rs.result.startPort;
						portData.endPort=rs.result.endPort;
						sessionStorage.setItem("zhaochuanSearchtPort", JSON.stringify(portData));
						console.log('本地储存港口数据结束',portData);
						//本地储存港口数据 end
						initSearchBox(rs.result.startPort,rs.result.endPort);
					}
				},
				error:function(rs){
					console.log('读取输入框数据失败',rs);
				}
			});
		}
	}else{
		$.ajax({
			url:'/Route/port',
			dataType:'json',
			success:function(rs){
				if(rs.status === 1){
					initSearchBox(rs.result.startPort,rs.result.endPort);
				}
			},
			error:function(rs){
				console.log('读取输入框数据失败',rs);
			}
		});
	}
}
function initSearchBox(sPort,ePort){
	//船公司数据
	var companyData = [
		{title:'中远',label:'COSCO'},
		{title:'现代商船',label:'HMM'},
		{title:'高丽海运',label:'KMTC'},
		{title:'马士基',label:'MSK'},
		{title:'MCC运输',label:'MCC'},
		{title:'地中海航运',label:'MSC'},
		{title:'宏海箱运',label:'RCL'},
		{title:'阿拉伯轮船',label:'UASC'},
		{title:'以星',label:'ZIM'},
		{title:'澳航',label:'ANL'},
		{title:'法国达飞',label:'CMA'},
		{title:'达贸',label:'DELMAS'},
		{title:'长荣',label:'EMC'},
		{title:'赫伯罗特',label:'HPL'},
		{title:'日本邮船',label:'NYK'},
		{title:'浦海',label:'PHL'},
		{title:'南非航运',label:'SAF'},
		{title:'山东海丰',label:'SITC'},
		{title:'万海',label:'WHL'},
		{title:'美国总统',label:'APL'},
		{title:'韩进海运',label:'HANJIN'},
		{title:'川崎汽船',label:'K-LINE'},
		{title:'太平船务',label:'PIL'},
		{title:'德翔航运',label:'TSL'},
		{title:'阳明海运',label:'YML'},
		{title:'中海',label:'CSCL'},
		{title:'阿联酋航运',label:'ESL'},
		{title:'兴亚海运',label:'HEUNG-A'},
		{title:'亚川船务',label:'IAL'},
		{title:'大阪三井',label:'MOL'},
		{title:'东方海外',label:'OOCL'},
		{title:'南星海运',label:'NAMSUNG'},
		{title:'中外运',label:'SINOTRANS'},
		{title:'玛丽亚那',label:'MARIANA'},
		{title:'汉堡南美',label:'HAMBURG-SUD'}
	];
	var sPortAlways = [];
	var ePortAlways = [];
	var cpAlways = [];
	start_port_list =  sPort;
	end_port_list = ePort;
	s_company_list = companyData;
	$('#searchPortBg').searchComp({
		dataSource: {
			start_port_list: start_port_list,
			start_port_list_always : sPortAlways,
			end_port_list: end_port_list,
			end_port_list_always : ePortAlways,
			s_company_list: s_company_list,
			s_company_list_always : cpAlways
		}
	});
}


function setBusiness(){
	var endPort=$('#dest_port_input').val();
	console.log(endPort);
	
	$.ajax({
			type:'post',
			url:'/inquiryOfferPrice/setBusiness?endPort='+endPort,
			dataType:'json',
			
			success:function(rs){
				if(rs.business){
					console.log('2222222222222222!');
					console.log(rs.business);
					$('#getSysBusiness').text(rs.business);
					$('#sysBusinessMan').val(rs.business);
				}
			},
		
			error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
	
}
</script>
</body>
</html>
