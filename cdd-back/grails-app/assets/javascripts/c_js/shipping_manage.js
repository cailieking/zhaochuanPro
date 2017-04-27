$(function(){
	rightNavClick();//右侧页面切换导航点击

	searchCheckClickEvent();//按搜索记录管理复选框点击事件
	//setCommonPage2Event($('#shipPage1'),11,function(num){//初始化翻页控件 common.js中定义
		//zcAlert('记录管理'+num+'页'); 
	//})
	
		//初始化翻页控件 common.js中定义 
		var maxNum=parseInt($('.shipPage').attr('data-maxSum')); 
		var pageSize=10;
		var maxPage=0;
		if(maxNum%pageSize==0){
			maxPage=parseInt(maxNum/pageSize);
		}else{
			maxPage=parseInt(maxNum/pageSize)+1; 
		}
		setCommonPage2Event($('.shipPage'),maxPage,function(num){
			window.location.href='/tariffManager/list?page='+num;
		})
		var page=GetQueryString("page");
		if(page !=null && page.toString().length>0)
		{
			//console.log('page',page);
			commonPage2Change($('.shipPage'),page,maxPage);
		}
		
})

//船公司列表事件关联
function companyListShow(){
	$('#companysInputbox').off('click').on('click',function(e){
		if (e && e.stopPropagation) {//非IE浏览器 
			e.stopPropagation(); 
		}else{//IE浏览器 
			window.event.cancelBubble = true; 
		}
		$('.companysBg').show();
	})
	$('body').off('click').on('click',function(){
		$('.companysBg').hide();
	})
	$('.companysBg li').off('click').on('click',function(){
		$('#companysInputbox').val($(this).html());
	})
}
//中转港隐藏显示
function transPortShow(){
	var transRadio=$('#group1Radio2');
	if(transRadio.prop('checked')==true){
		$('.transPort').show();
	}else{
		$('.transPort').hide();
	}
}
//使输入框只能输入数字
function setInputOnlyNum($ele){
	$ele.val($ele.val().replace(/\D/g,''));
}
//使输入框只能输入符合星期的数字
function setInputOnlyNumDay($ele){
	$ele.val($ele.val().replace(/\D/g,''));
	if($ele.val()<1){
		$ele.val(1);
	}
	if($ele.val()>7){
		$ele.val(7);
	}
}
//添加船期
function addShipDay(){
	var shipDayNum=$('#shipDayDiv .shipDayBg').length;
	if(shipDayNum>5){
		zcAlert('船期最多添加6个');
		return;
	}
	var shipDayHtml=
'<div class="shipDayBg" style="margin:10px 0 0 152px;">'+
	'<div class="dayBoxBg">'+
		'<input type="text" class="dayBox" onkeyup="setInputOnlyNumDay($(this))" onafterpaste="setInputOnlyNumDay($(this))" />'+
		'<div class="dayBoxBtnBg">'+
			'<div class="add" onClick="addShipDayNum($(this))">+</div>'+
			'<div class="sub" onClick="subShipDayNum($(this))">-</div>'+
		'</div>'+
	'</div>'+
	'<div class="dayLabel">截</div>'+
	'<div class="dayBoxBg">'+
		'<input type="text" class="dayBox" onkeyup="setInputOnlyNumDay($(this))" onafterpaste="setInputOnlyNumDay($(this))" />'+
		'<div class="dayBoxBtnBg">'+
			'<div class="add" onClick="addShipDayNum($(this))">+</div>'+
			'<div class="sub" onClick="subShipDayNum($(this))">-</div>'+
		'</div>'+
	'</div>'+
	'<div class="dayLabel">开</div>'+
	'<div class="dayDel" onClick="delShipDay($(this))">x</div>'+
'</div>';
	$('#shipDayDiv').append($(shipDayHtml));
}
//删除船期
function delShipDay($ele){
	$ele.parents('.shipDayBg').remove();
}
//船期数字+
function addShipDayNum($ele){
	var box=$ele.parents('.dayBoxBg').find('.dayBox');
	var lastNum=0;
	if(box.val()!=''){
		lastNum=parseInt(box.val());
	}
	var thisNum=lastNum+1;
	if(thisNum>7){thisNum=7;}
	box.val(thisNum);
}
//船期数字-
function subShipDayNum($ele){
	var box=$ele.parents('.dayBoxBg').find('.dayBox');
	var lastNum=0;
	if(box.val()!=''){
		lastNum=parseInt(box.val());
	}
	var thisNum=lastNum-1;
	if(thisNum<1){thisNum=1;}
	box.val(thisNum);
}

//拼箱的价格隐藏/显示
function boxPriceShow(){
	var boxRadio=$('#group2Radio2');
	if(boxRadio.prop('checked')==true){
		$('#unitPrice').show();
		$('#minPrice').show();
		$('#boxesPrice').hide();
	}else{
		$('#unitPrice').hide();
		$('#minPrice').hide();
		$('#boxesPrice').show();
	}
}

//附加费单位类型改变
function additionalBoxTypeChange($ele){
	if($ele.val()=="票"){
		$ele.parents('.gridRow').find('.w3 input').prop('disabled',true);
		$ele.parents('.gridRow').find('.w4 input').prop('disabled',false);
	}else{
		$ele.parents('.gridRow').find('.w3 input').prop('disabled',false);
		$ele.parents('.gridRow').find('.w4 input').prop('disabled',true);
	}
}
//添加附加费价格项
function addAdditionalRow(){
	var gridNum=$('.additional .gridRow').length;
	if(gridNum>9){
		zcAlert('附加费最多添加10个');
		return;
	}
	var doHtml=
'<div class="gridRow">'+
	'<div class="w1">'+
		'<select>'+
			'<option>请选择</option>'+
			'<option>ACF</option>'+
			'<option>AMS</option>'+
			'<option>DOC</option>'+
			'<option>EIR</option>'+
			'<option>ISPS</option>'+
			'<option>ORC</option>'+
			'<option>PSD</option>'+
			'<option>SEAL</option>'+
			'<option>TLX</option>'+
			'<option>其他</option>'+
		'</select>'+
	'</div>'+
	'<div class="w2">'+
		'<select onchange="additionalBoxTypeChange($(this))">'+
			'<option selected="selected">箱</option>'+
			'<option>票</option>'+
		'</select>'+
	'</div>'+
	'<div class="w3">'+
		'<span>20&#39;</span> '+
		'<input type="text" /> '+
		'<span>40&#39;</span> '+
		'<input type="text" /> '+
		'<span>40H&#39;</span> '+
		'<input type="text" />'+
	'</div>'+
	'<div class="w4">'+
		'<input type="text" disabled="disabled" />'+
	'</div>'+
	'<div class="w5">'+
		'<select>'+
			'<option>CNY</option>'+
			'<option>USD</option>'+
			'<option>EUR</option>'+
			'<option>HKD</option>'+
		'</select>'+
	'</div>'+
	'<div class="w6">'+
		'<div class="btnMod1" onClick="delAdditionalRow($(this))">删除</div>'+
	'</div>'+
'</div>';
	$('.additional').append($(doHtml));
}
//删除附加费价格项
function delAdditionalRow($ele){
	$ele.parents('.gridRow').remove();
}
//单次发布重置
function singleReset(){
	var doHtml=
'<div>'+
	'<div class="sLabel">起始港：<div class="imp">*</div></div>'+
	'<input type="text" class="box1 modTextBox" />'+
	'<div class="tishi1 modTishiBg">'+
		'<div class="modTishiTxt">*为必填项</div>'+
	'</div>'+
'</div>'+
'<div>'+
	'<div class="sLabel">目的港：<div class="imp">*</div></div>'+
	'<input type="text" class="box1 modTextBox" />'+
'</div>'+
'<div>'+
	'<div class="sLabel">目的港：<div class="imp">*</div></div>'+
	'<input id="group1Radio1" name="group1" type="radio" onClick="transPortShow()" />'+
	'<label for="group1Radio1">直航</label>'+
	'<input id="group1Radio2" name="group1" type="radio" onClick="transPortShow()" />'+
	'<label for="group1Radio2">中转</label>'+
	'<div class="transPort">'+
		'<span>中转港：</span>'+
		'<input type="text" class="box1 modTextBox" />'+
	'</div>'+
'</div>'+
'<div>'+
	'<div class="sLabel">航程（天）：<div class="imp">*</div></div>'+
	'<input type="text" class="box2 modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))"/>'+
	'<div class="tishi2 modTishiBg">'+
		'<div class="modTishiTxt">*请填写航程天数，例如：10、31。</div>'+
	'</div>'+
'</div>'+
'<div id="companysDiv">'+
	'<div class="sLabel">船公司：<div class="imp">*</div></div>'+
	'<input id="companysInputbox" type="text" class="box1 modTextBox" />'+
	'<div class="companysBg" style="display:none;">'+
		'<div class="caption">请选择船公司</div>'+
		'<div class="cListLabel">A-G</div>'+
		'<ul class="cList">'+
			'<li>ANL</li>'+
			'<li>APL</li>'+
			'<li>CMA</li>'+
			'<li>COSCO</li>'+
			'<li>CSCL</li>'+
			'<li>DELMAS</li>'+
			'<li>EMC</li>'+
			'<li>ESL</li>'+
		'</ul>'+
		'<div class="cListLabel">H-J</div>'+
		'<ul class="cList">'+
			'<li>HMM</li>'+
			'<li>HPL</li>'+
			'<li>IAL</li>'+
			'<li>HANJIN</li>'+
			'<li>HEUNG-A</li>'+
			'<li>HAMBURG-SUD</li>'+
		'</ul>'+
		'<div class="cListLabel">K-N</div>'+
		'<ul class="cList">'+
			'<li>K-LINE</li>'+
			'<li>KMTC</li>'+
			'<li>MARIANA</li>'+
			'<li>MCC</li>'+
			'<li>MOL</li>'+
			'<li>MSC</li>'+
			'<li>MSK</li>'+
			'<li>NYK</li>'+
			'<li>NAMSUNG</li>'+
		'</ul>'+
		'<div class="cListLabel">O-Z</div>'+
		'<ul class="cList">'+
			'<li>OOCL</li>'+
			'<li>PHL</li>'+
			'<li>PIL</li>'+
			'<li>RCL</li>'+
			'<li>SAF</li>'+
			'<li>SITC</li>'+
			'<li>TSL</li>'+
			'<li>UASC</li>'+
			'<li>WHL</li>'+
			'<li>YML</li>'+
			'<li>ZIM</li>'+
			'<li>SINOTRANS</li>'+
		'</ul>'+
		'<div class="cListLabel">其他</div>'+
		'<ul class="cList">'+
			'<li>不指定船公司</li>'+
		'</ul>'+

	'</div>'+
'</div>'+

'<div id="shipDayDiv">'+
	'<div class="sLabel">船期：<div class="imp">*</div></div>'+
	'<div class="shipDayBg">'+
		'<div class="dayBoxBg">'+
			'<input type="text" class="dayBox" onkeyup="setInputOnlyNumDay($(this))" onafterpaste="setInputOnlyNumDay($(this))" />'+
			'<div class="dayBoxBtnBg">'+
				'<div class="add" onClick="addShipDayNum($(this))">+</div>'+
				'<div class="sub" onClick="subShipDayNum($(this))">-</div>'+
			'</div>'+
		'</div>'+
		'<div class="dayLabel">截</div>'+
		'<div class="dayBoxBg">'+
			'<input type="text" class="dayBox" onkeyup="setInputOnlyNumDay($(this))" onafterpaste="setInputOnlyNumDay($(this))" />'+
			'<div class="dayBoxBtnBg">'+
				'<div class="add" onClick="addShipDayNum($(this))">+</div>'+
				'<div class="sub" onClick="subShipDayNum($(this))">-</div>'+
			'</div>'+
		'</div>'+
		'<div class="dayLabel">开</div>'+
		'<div class="dayAdd" onClick="addShipDay()">+</div>'+
	'</div>'+
'</div>'+
'<div>'+
	'<div class="sLabel">运输类别：<div class="imp">*</div></div>'+
	'<input id="group2Radio1" name="group2" type="radio" onClick="boxPriceShow()" />'+
	'<label for="group2Radio1">整箱</label>'+
	'<input id="group2Radio2" name="group2" type="radio" onClick="boxPriceShow()" />'+
	'<label for="group2Radio2">拼箱</label>'+
'</div>'+
'<div id="unitPrice" style="display:none;">'+
	'<div class="sLabel">单价(USD/CBM)：<div class="imp">*</div></div>'+
	'<input type="text" class="box1 modTextBox" />'+
'</div>'+
'<div id="minPrice" style="display:none;">'+
	'<div class="sLabel">最低消费(USD)：<div class="imp">*</div></div>'+
	'<input type="text" class="box1 modTextBox" />'+
'</div>'+
'<div>'+
	'<div class="sLabel">有效期：<div class="imp">*</div></div>'+
	'<input type="text" class="box1 modTextBox" />'+
	'<div class="midLine">一</div>'+
	'<input type="text" class="box1 modTextBox" />'+
'</div>'+
'<div>'+
	'<div class="sLabel">运价：<div class="imp">*</div></div>'+
	'<div class="modTextBox shipPriceBg">'+
		'<span>20GP</span>'+
		'<input type="text" class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" />'+
		'<span>40GP</span>'+
		'<input type="text" class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" />'+
		'<span>40HQ</span>'+
		'<input type="text" class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" />'+
	'</div>'+
	'<div class="tishi3 modTishiBg">'+
		'<div class="modTishiTxt">请至少填写一种箱型的运价，运价单位为“$"</div>'+
	'</div>'+
'</div>'+
'<div>'+
	'<div class="sLabel">附加费：<div class="imp"></div></div>'+
	'<div class="tishi4 modTishiBg">'+
		'<div class="modTishiTxt">没有则不需要填写</div>'+
	'</div>'+
	'<div class="additional">'+
		'<div class="gridTopBg">'+
			'<div class="w1">名称</div>'+
			'<div class="w2">单位</div>'+
			'<div class="w3">柜型</div>'+
			'<div class="w4">单票价格</div>'+
			'<div class="w5">币种</div>'+
			'<div class="w6"></div>'+
		'</div>'+
		'<div class="gridRow">'+
			'<div class="w1">'+
				'<select>'+
					'<option>请选择</option>'+
					'<option>ACF</option>'+
					'<option>AMS</option>'+
					'<option>DOC</option>'+
					'<option>EIR</option>'+
					'<option>ISPS</option>'+
					'<option>ORC</option>'+
					'<option>PSD</option>'+
					'<option>SEAL</option>'+
					'<option>TLX</option>'+
					'<option>其他</option>'+
				'</select>'+
			'</div>'+
			'<div class="w2">'+
				'<select onchange="additionalBoxTypeChange($(this))">'+
					'<option selected="selected">箱</option>'+
					'<option>票</option>'+
				'</select>'+
			'</div>'+
			'<div class="w3">'+
				'<span>20&#39;</span> '+
				'<input type="text" /> '+
				'<span>40&#39;</span> '+
				'<input type="text" /> '+
				'<span>40H&#39;</span> '+
				'<input type="text" />'+
			'</div>'+
			'<div class="w4">'+
				'<input type="text" disabled="disabled" />'+
			'</div>'+
			'<div class="w5">'+
				'<select>'+
					'<option>CNY</option>'+
					'<option>USD</option>'+
					'<option>EUR</option>'+
					'<option>HKD</option>'+
				'</select>'+
			'</div>'+
			'<div class="w6">'+
				'<div class="btnMod1" onClick="addAdditionalRow()">添加</div>'+
			'</div>'+
		'</div>'+
	'</div>'+
'</div>'+
'<div>'+
	'<div class="sLabel">其他附加费：<div class="imp"></div></div>'+
	'<textarea class="modTextBox"></textarea>'+
'</div>'+
'<div>'+
	'<div class="sLabel">限重：<div class="imp"></div></div>'+
	'<input type="text" class="box2 modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" maxlength="2"/>'+
	'<div class="tishi2 modTishiBg">'+
		'<div class="modTishiTxt">请填写两位整数，重量单位是吨（T）</div>'+
	'</div>'+
'</div>'+
'<div>'+
	'<div class="sLabel">备注：<div class="imp"></div></div>'+
	'<textarea class="modTextBox" placeholder="请控制在120字以内"></textarea>'+
'</div>'+
'<div class="singleBottom">'+
	'<div class="btnMod1">发布</div>'+
	'<div class="btnMod1" onClick="singleReset()">重置</div>'+
'</div>';
	$('.singleBg').html($(doHtml));
	companyListShow();//船公司列表事件关联
}




 //运价发布
function shipCreateRelease(){ 
	window.location.href = "/tariffManager/recordAdd";
}

//批量导出运价
function batchImport(){
	sessionStorage.setItem("batchimport","1");
	window.location.href = "/tariffManager/recordAdd";
}

function querySearch(){
	var status = $('#status').val();
	var start = $("#start").val()
	var end = $("#end").val()
	var shipCompanys = $('#shipCompanys').val()
	var company = $("#company").val()
	var createman = $("#createman").val()
	var createtimes = $("#createtimes").val()
	var infoId = $("#infoId").val()
	console.log(infoId)
	//window.location.href='/tariffManager/list?serach='+serach+'&status='+status
  window.location.href='/tariffManager/list?&status='+status+'&start='+start+'&end='+end+'&shipCompanys='+shipCompanys+'&company='+company+'&createman='+createman+'&createtimes='+createtimes+'&infoId='+infoId
	
}

//记录运价详情
function shippingDetailsShow(key){
	var id =key.attr('data-id');
	var releaseNum =key.attr('data-releaseNum');
	var startPort =key.attr('data-startPort');
	var endPort =key.attr('data-endPort');
	var companyName = key.attr('data-companyName');
	var gp20 = key.attr('data-gp20');
	var gp20Vip = key.attr('data-gp20Vip');
	var gp40 = key.attr('data-gp40Vip');
	var gp40Vip = key.attr('data-gp40Vip');
	var hq40 = key.attr('data-hq40');
	var hq40Vip = key.attr('data-hq40Vip');
	var shipCompany = key.attr('data-shipCompany');
	var middlePort = key.attr('data-middlePort');
	var shippingDay = key.attr('data-shippingDay');
	var weightLimit = key.attr('data-weightLimit');
	var shippingDays = key.attr('data-shippingDays');
	var transType = key.attr('data-transType');
	var startDate = key.attr('data-startDate');
	var endDate = key.attr('data-endDate'); 
	var extra = key.attr('data-extra');

	var doHtml=
		//'<form action="/groupManager/save" method="post" id="dataForm" ><input type="hidden" name="id" value='+id+'>'+		
			'<div class="winModBg0" id="shipping_detailsBg">'+
				'<div class="winModBg wEditMod shipping_details">'+
			    	'<div class="titleBg">'+
			        	'<div class="caption">运价详情<span class="shippingNum">运价编号：<span class="num">'+id+'</span></span><span class="shippingNum">批次编号：<span class="num">'+releaseNum+'</span></span></div>'+
			            '<div class="closeBtn">X</div>'+
			        '</div>'+
			        '<div class="details_content">'+
			        	'<div>'+
			        		'<div class="startPort">起始港：<span id="startPort">'+startPort+'</span></div>'+
			        		'<div class="endPort">目的港：<span id="endPort">'+endPort+'</span></div>'+
			        	'</div>'+
			        	'<div class="supplier">'+
			        		'<div class="dLabel">供应商：</div>'+
			        		'<div class="sName" id="supplier">'+companyName+'</div>'+
			        	'</div>'+
			        	'<div class="priceBg">'+
			        		'<div class="dLabel">运&nbsp;&nbsp;&nbsp;费：</div>'+
			        		'<div class="pGrid">'+
			        			'<div class="boxtype">20GP</div>'+
			        			'<div class="price1"><span id="20GP_1">'+gp20+'</span></div>'+
			        			'<div class="price2"><span id="20GP_2">'+gp20Vip+'</span></div>'+
			        		'</div>'+
			        		'<div class="pGrid">'+
			        			'<div class="boxtype">40GP</div>'+
			        			'<div class="price1"><span id="40GP_1">'+gp40+'</span></div>'+
			        			'<div class="price2"><span id="40GP_2">'+gp40Vip+'</span></div>'+
			        		'</div>'+
			        		'<div class="pGrid">'+
			        			'<div class="boxtype">40HQ</div>'+
			        			'<div class="price1"><span id="40HQ_1">'+hq40+'</span></div>'+
			        			'<div class="price2"><span id="40HQ_2">'+hq40Vip+'</span></div>'+
			        		'</div>'+
			        	'</div>'+
			        	'<div>'+
			        		'<div class="bg50" style="margin-right:8px;">'+
			        			'<div class="dLabel">船公司：</div>'+
			        			'<div class="bName" id="shipCompany">'+shipCompany+'</div>'+
			        		'</div>'+
			        		'<div class="bg50">'+
			        			'<div class="dLabel">中转港：</div>'+
			        			'<div class="bName" id="mdPort">'+middlePort+'</div>'+
			        		'</div>'+
			        	'</div>'+
			        	'<div>'+
			        		'<div class="bg50" style="margin-right:8px;">'+
			        			'<div class="dLabel">船&nbsp;&nbsp;&nbsp;期：</div>'+
			        			'<div class="bName" id="shipDay">'+shippingDay+'</div>'+
			        		'</div>'+
			        		'<div class="bg50">'+
			        			'<div class="dLabel">限&nbsp;&nbsp;&nbsp;重：</div>'+
			        			'<div class="bName" id="shipWeight">'+weightLimit+'</div>'+
			        		'</div>'+
			        	'</div>'+
			        	'<div>'+
			        		'<div class="bg50" style="margin-right:8px;">'+
			        			'<div class="dLabel">航&nbsp;&nbsp;&nbsp;程：</div>'+
			        			'<div class="bName" id="shipLong">'+shippingDays+'天</div>'+
			        		'</div>'+
			        		'<div class="bg50">'+
			        			'<div class="dLabel">运输类型：</div>'+
			        			'<div class="bName" id="shipType">'+transType+'</div>'+
			        		'</div>'+
			        	'</div>'+
			        	'<div>'+
			        		'<div class="bg50" style="margin-right:8px;">'+
			        			'<div class="dLabel">有效期：</div>'+
			        			'<div class="bName" id="shipValidity">'+ startDate +' 至  '+ endDate +'</div>'+
			        		'</div>'+
			        		'<div class="bg50">'+
			        			
			        		'</div>'+
			        	'</div>'+
			        	'<div class="fjPrice">'+
			        		'<div class="dLabel">附加费：</div>'+
			        		'<ul class="fjPriceList" id="fjPriceList">'+
			        			'<li class="fTitle">'+
			        				'<div class="fw1">名称</div>'+
			        				'<div class="fw2">单位</div>'+
			        				'<div class="fw3">币种</div>'+
			        				'<div class="fw4">20GP</div>'+
			        				'<div class="fw5">40GP</div>'+
			        				'<div class="fw6">40HQ</div>'+
			        				'<div class="fw7">单票价格</div>'+
			        			'</li>'+
			        			'<li>'+
			        				'<div class="fw1 fName">AFC</div>'+
			        				'<div class="fw2">票</div>'+
			        				'<div class="fw3">USD</div>'+
			        				'<div class="fw4">-</div>'+
			        				'<div class="fw5">-</div>'+
			        				'<div class="fw6">-</div>'+
			        				'<div class="fw7">452</div>'+
			        			'</li>'+
			        		'</ul>'+
			        	'</div>'+
			        	'<div class="mark">'+
			        		'<div class="dLabel">备&nbsp;&nbsp;&nbsp;注：</div>'+
			        		'<div class="mTxt" id="shipMark">可出SWB 目的港收取 EIS JPY1000/2000可出SWB 目的港收取 EIS JPY1000/2000可出SWB 目的港收取 EIS JPY1000/2000可出SWB 目的港收取 EIS JPY1000/2000</div>'+
			        	'</div>'+
			        '</div>'+
			    '</div>'+
			'</div>';
	
		//'</form>';
				$('body').append($(doHtml));
				//modDlgEvent($('.addGroupDlg'));//自制弹出框公用事件 居中_拖拽_关闭
				setEleMiddle($('.shipping_details'));//使元素居中
				
				//运价详情事件
				setEleMove($('.shipping_details .titleBg'));//通过标头拖动窗口
				//关闭运价详情
				$('.shipping_details .closeBtn').on('click',function(){
					$('#shipping_detailsBg').remove();
				});
				//运价详情事件 end
				
				if(extra){
					if(getStrLength(extra)>3){//数据中有至少4个'-'，表示有正规表格数据
						var extraData=[];
						var temp1=extra.split(';');
						for(var i=0;i<temp1.length;i++){
							var temp2=temp1[i].split('-');
							//if(temp2[1]=='box'){temp2[1]='箱';}
							//if(temp2[1]=='piece'){temp2[1]='票';}
							if(temp2.length>3){
								extraData.push(temp2);
							}
						}
						var extraHtml=
							'<li class="fTitle">'+
		        				'<div class="fw1">名称</div>'+
		        				'<div class="fw2">单位</div>'+
		        				'<div class="fw3">币种</div>'+
		        				'<div class="fw4">20GP</div>'+
		        				'<div class="fw5">40GP</div>'+
		        				'<div class="fw6">40HQ</div>'+
		        				'<div class="fw7">单票价格</div>'+
		        			'</li>';
						for(var i=0;i<extraData.length;i++){
							if(extraData[i][1]=='box'){
								extraHtml+=
								'<li>'+
									'<div class="fw1 fName">'+extraData[i][0]+'</div>'+
									'<div class="fw2">箱</div>'+
									'<div class="fw3">'+extraData[i][6]+'</div>'+
									'<div class="fw4">'+extraData[i][2]+'</div>'+
									'<div class="fw5">'+extraData[i][3]+'</div>'+
									'<div class="fw6">'+extraData[i][4]+'</div>'+
									'<div class="fw7">-</div>'+
								'</li>';
							}else{
								extraHtml+=
								'<li>'+
									'<div class="fw1 fName">'+extraData[i][0]+'</div>'+
									'<div class="fw2">票</div>'+
									'<div class="fw3">'+extraData[i][6]+'</div>'+
									'<div class="fw4">-</div>'+
									'<div class="fw5">-</div>'+
									'<div class="fw6">-</div>'+
									'<div class="fw7">'+extraData[i][5]+'</div>'+
								'</li>';
							}
						}
						$('#fjPriceList').html(extraHtml);
					}else{
						$('#fjPriceList').html(extra);
					}
				}else{
					$('#fjPriceList').html('');
				}
			   
			   //获取'-'字符数量
				function getStrLength(str){
					if(/\-/i.test(str)){
						return str.match(/\-/ig).length;
					}
					return 0;
				}
				
	}

//运价修改
function editShipShow(key){
	$('.shipListAdd').hide();
	$('.shipListEidts').html('')
	//$('#shipList').hide();
	 var id=key.attr('data-infoids');
	 var routeName = key.attr('data-routeNames') 
	 var companyName = key.attr('data-companyNames')
	 var contactName = key.attr('data-contactNames')
	 var phone = key.attr('data-phones')
	 var startPort =  key.attr('data-startPorts')
	 var endPort = key.attr('data-endPorts')
	 var middlePort = key.attr('data-middlePorts')
	 var shippingDays = key.attr('data-shippingDayss')
	 var shipCompany = key.attr('data-shipCompanys')
	 var shippingDay = key.attr('data-shippingDays')
	 var transType = key.attr('data-transTypes')
	 var strStartDate = key.attr('data-startDates')
	 var strEndDate  = key.attr('data-endDates')
	 var startDate = strStartDate.replace(/\//g,"-");
	 var endDate = strEndDate.replace(/\//g,"-");
	 var gp20  = key.attr('data-gp20s')
	 var gp40 = key.attr('data-gp40s')
	 var hq40 = key.attr('data-hq40s')
	 var gp20Vip = key.attr('data-gp20Vips')
	 var gp40Vip = key.attr('data-gp40Vips')
	 var hq40Vip = key.attr('data-hq40Vips')
	
	 var extra = key.attr('data-extras')
	  
	   //获取'-'字符数量
		function getStrLength(str){
			if(/\-/i.test(str)){
				return str.match(/\-/ig).length;
			}
			return 0;
		}
	 
	 var weightLimit = key.attr('data-weightLimits')
	 var cbm = key.attr('data-cbms')
	 var lowestCost = key.attr('data-lowestCosts')
	 var middlePort = key.attr('data-middlePorts')
	 var remark = key.attr('data-remarks')
	 
	var doHtml= 
		 '<form action="/tariffManager/save"  method="post" id="dataFormCreats" ><input type="hidden" name="id" value="'+id+'" >'+
		  '<div class="manage_md_right editShipAll " id="shipEdit" >'+
		  	'<div class="rTitle" ></div>'+
		      '<ul class="rightNav1">'+
		      	'<li class="sel">运价编辑</li>'+
		      '</ul>'+
		      '<div class="rContent">'+
		      	'<!--单次发布-->'+
		     
		    '<div class="singleBg" id="shipAdd2">'+
		      '<div>'+
	          	'<div class="sLabel">供应商：<div class="imp">*</div></div>'+
	             '<input type="text"  name="companyName" id="companyName"  value="'+companyName+'"  class="box1 modTextBox"  style="width:360px;"  />'+
	             '<div class="tishi1 modTishiBg">'+
	              	'<div class="modTishiTxt">*为必填项</div>'+
	              '</div>'+
	          '</div>'+
		      	
		      	'<div>'+
              		'<div class="sLabel">联系人：<div class="imp">*</div></div>'+
              			'<input type="text"  name="contactName" id="contactName"  value="'+contactName+'"  class="box1 modTextBox"  />'+
              	'</div>'+
		      	
			      '<div>'+
	              	'<div class="sLabel">联系方式：<div class="imp">*</div></div>'+
	                 '<input type="text"  name="phone" id="phone"  value="'+phone+'"  class="box1 modTextBox"  />'+
	              '</div>'+
	              
		          	'<div>'+
		              	'<div class="sLabel">起始港：<div class="imp">*</div></div>'+
		              		'<input type="text"  name="startPort" id="startPort"  value="'+startPort+'"  class="box1 modTextBox"  />'+
		              '</div>'+
		             '<div>'+
		              	'<div class="sLabel">目的港：<div class="imp" >*</div></div>'+
		                  '<input type="text"  name="endPort" value="'+endPort+'"   id="endPort"  class="box1 modTextBox" />'+
		             '</div>'+
		             '<div>'+
		              	'<div class="sLabel">目的港：<div class="imp">*</div></div>'+
		              	'<input id="group1Radio1" name="group1" type="radio" checked onClick="transPortShow()" />'+
		                 '<label for="group1Radio1">直航</label>'+
		                 '<input id="group1Radio2" name="group1" type="radio" onClick="transPortShow()" />'+
		                  '<label for="group1Radio2">中转</label>'+
		                  '<div class="transPort">'+
		                  	'<span>中转港：</span>'+
		                      '<input type="text" name="middlePort"   class="box1 modTextBox"  value="'+middlePort+'"/>'+
		                  '</div>'+
		              '</div>'+
		              '<div>'+
		              	'<div class="sLabel">航程（天）：<div class="imp">*</div></div>'+ 
		              	'<input type="text" name="shippingDays" id="shippingDays"  value="'+shippingDays+'"  class="box2 modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))"/>'+
		                  '<div class="tishi2 modTishiBg">'+ 
		                  	'<div class="modTishiTxt">*请填写航程天数，例如：10、31。</div>'+
		                 '</div>'+
		              '</div>'+
		              '<div id="companysDiv">'+
		              	'<div class="sLabel">船公司：<div class="imp">*</div></div>'+
		              	'<input id="companysInputbox" type="text" name="shipCompany" value="'+shipCompany+'" class="box1 modTextBox" />'+
		                  '<div class="companysBg" style="display:none;">'+
		                  	'<div class="caption">请选择船公司</div>'+
		                     '<div class="cListLabel">A-G</div>'+
		                      '<ul class="cList">'+
		                      	'<li>ANL</li>'+
		                          '<li>APL</li>'+
		                          '<li>CMA</li>'+
		                          '<li>COSCO</li>'+
		                         '<li>CSCL</li>'+
		                         '<li>DELMAS</li>'+
		                          '<li>EMC</li>'+
		                         '<li>ESL</li>'+
		                      '</ul>'+
		                     '<div class="cListLabel">H-J</div>'+
		                      '<ul class="cList">'+
		                      	'<li>HMM</li>'+
		                          '<li>HPL</li>'+
		                          '<li>IAL</li>'+
		                          '<li>HANJIN</li>'+
		                          '<li>HEUNG-A</li>'+
		                          '<li>HAMBURG-SUD</li>'+
		                      '</ul>'+
		                      '<div class="cListLabel">K-N</div>'+
		                      '<ul class="cList">'+
		                      	'<li>K-LINE</li>'+
		                          '<li>KMTC</li>'+
		                          '<li>MARIANA</li>'+
		                          '<li>MCC</li>'+
		                          '<li>MOL</li>'+
		                          '<li>MSC</li>'+
		                          '<li>MSK</li>'+
		                         '<li>NYK</li>'+
		                          '<li>NAMSUNG</li>'+
		                      '</ul>'+
		                      '<div class="cListLabel">O-Z</div>'+
		                      '<ul class="cList">'+
		                      	'<li>OOCL</li>'+
		                          '<li>PHL</li>'+
		                          '<li>PIL</li>'+
		                          '<li>RCL</li>'+
		                          '<li>SAF</li>'+
		                          '<li>SITC</li>'+
		                          '<li>TSL</li>'+
		                          '<li>UASC</li>'+
		                          '<li>WHL</li>'+
		                          '<li>YML</li>'+
		                          '<li>ZIM</li>'+
		                          '<li>SINOTRANS</li>'+
		                      '</ul>'+
		                      '<div class="cListLabel">其他</div>'+
		                      '<ul class="cList">'+
		                      	'<li>不指定船公司</li>'+
		                      '</ul>'+
		                  '</div>'+
		              '</div>'+
		              
		              '<div id="shipDayDiv">'+
		              	'<div class="sLabel">船期：<div class="imp">*</div></div>'+
		              	'<input type="text" name="total_shipping_date"  id="shippingDay"  value="'+shippingDay+'"   class="box1 modTextBox" />'+
		              '</div>'+
		              '<div>'+
		              	'<div class="sLabel">运输类别：<div class="imp">*</div></div>'+
		              	'<input id="group2Radio1" name="group2" type="radio" checked value="Whole"  onClick="boxPriceShow()" />'+
		                  '<label for="group2Radio1">整箱</label>'+
		                  '<input id="group2Radio2" name="group2" type="radio" value="Together" onClick="boxPriceShow()" />'+
		                  '<label for="group2Radio2">拼箱</label>'+
		              '</div>'+
		              '<div id="unitPrice" style="display:none;">'+
		              	'<div class="sLabel">单价(USD/CBM)：<div class="imp"></div></div>'+
		              	'<input type="text" name="per_price" value="'+cbm+'" id="cbm"  class="box1 modTextBox" />'+
		              '</div>'+
		              '<div id="minPrice" style="display:none;">'+
		              	'<div class="sLabel">最低消费(USD)：<div class="imp"></div></div>'+
		              	'<input type="text" value="'+lowestCost+'" id="lowestCost"  name="min_charge"   class="box1 modTextBox" />'+
		              '</div>'+
		              '<div>'+
		              	'<div class="sLabel">有效期：<div class="imp">*</div></div>'+
		              	'<input type="text" name="startDate" value="'+startDate+'" id="startDate"  onClick="WdatePicker()" class="box1 modTextBox" />'+
		                  '<div class="midLine">一</div>'+
		                  '<input type="text" name="endDate" value="'+endDate+'"  id="endDate"   onClick="WdatePicker()"  class="box1 modTextBox" />'+
		              '</div>'+
		              
		              '<div id="boxesPrice">'+
	                	'<div class="sLabel">运价：<div class="imp">*</div></div>'+
	                	'<div class="modTextBox shipPriceBg" style="height:64px;padding-top:10px;">'+
	                    	'<div style="clear:both;height:32px;line-height:32px;text-align:center;">'+
	                        	'<div style="margin:0 5px 0 55px;width:58px;height:32px;color:#2a9de9;float:left;">公开价</div>'+
	                            '<div style="margin:0 5px 0 0;width:58px;height:32px;color:#f00;float:left;">优惠价</div>'+
	                            '<div style="margin:0 5px 0 55px;width:58px;height:32px;color:#2a9de9;float:left;">公开价</div>'+
	                            '<div style="margin:0 5px 0 0;width:58px;height:32px;color:#f00;float:left;">优惠价</div>'+
	                            '<div style="margin:0 5px 0 55px;width:58px;height:32px;color:#2a9de9;float:left;">公开价</div>'+
	                            '<div style="margin:0 5px 0 0;width:58px;height:32px;color:#f00;float:left;">优惠价</div>'+
	                        '</div>'+
	                    	'<span>20GP</span>'+
	                        '<input type="text" name="gp20_common_price" id="gp20"  value="'+gp20+'"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />'+
	                        '<input type="text" name="gp20_specical_price" id="gp20Vip"  value="'+gp20Vip+'"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />'+
	                        '<span>40GP</span>'+
	                        '<input type="text"  name="gp40_common_price" id="gp40"  value="'+gp40+'"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />'+
	                        '<input type="text"  name="gp40_specical_price" id="gp40Vip"  value="'+gp40Vip+'"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />'+
	                        '<span>40HQ</span>'+
	                        '<input type="text" name="hq40_common_price" id="hq40"  value="'+hq40+'"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />'+
	                        '<input type="text" name="hq40_specical_price" id="hq40Vip"  value="'+hq40Vip+'"   class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />'+
	                    '</div>'+
	                    '<div class="tishi3 modTishiBg" style="margin-left:5px;width:150px;">'+
	                    	'<div class="modTishiTxt">请至少填写一种箱型的运价，运价单位为“$"</div>'+
	                    '</div>'+
	                '</div>'+
		              
		              '<div>'+
		              	'<div class="sLabel">附加费：<div class="imp"></div></div>'+
		              	'<div class="tishi4 modTishiBg">'+
		                  	'<div class="modTishiTxt">没有则不需要填写</div>'+
		                 '</div>'+
		                  '<div class="additional">'+
		                  	'<div class="gridTopBg">'+
		                      	'<div class="w1">名称</div>'+
		                          '<div class="w2">单位</div>'+
		                          '<div class="w3">柜型</div>'+
		                          '<div class="w4">单票价格</div>'+
		                          '<div class="w5">币种</div>'+
		                          '<div class="w6"></div>'+
		                      '</div>'+
		                      '<div class="gridRow">'+
		                      	'<div class="w1">'+
		                          	'<select id="shipUser">'+
		                              	'<option>请选择</option>'+
		                                 '<option>ACF</option>'+
		                                  '<option>AMS</option>'+
		                                  '<option>DOC</option>'+
		                                  '<option>EIR</option>'+
		                                  '<option>ISPS</option>'+
		                                 ' <option>ORC</option>'+
		                                  '<option>PSD</option>'+
		                                  '<option>SEAL</option>'+
		                                  '<option>TLX</option>'+
		                                  '<option>其他</option>'+
		                              '</select>'+
		                          '</div>'+
		                          '<div class="w2">'+
		                          	'<select onchange="additionalBoxTypeChange($(this))" id="units">'+
		                              	'<option selected="selected">箱</option>'+
		                                  '<option>票</option>'+
		                              '</select>'+
		                          '</div>'+
		                          '<div class="w3">'+
		                              '<span>20&#39;</span>'+
		                              '<input type="text" name="gp20Num" id="gp20Num"/>'+
		                              '<span>40&#39;</span>'+
		                              '<input type="text" name="gp40Num" id="gp40Num"/>'+
		                              '<span>40H&#39;</span>'+
		                              '<input type="text" name="hq40Num" id="hq40Num"/>'+
		                          '</div>'+
		                          '<div class="w4">'+
		                          	'<input type="text" name="total_local_cost"  disabled="disabled" />'+
		                          '</div>'+
		                          '<div class="w5">'+
		                          	'<select id="currency">'+
		                              	'<option>CNY</option>'+
		                                  '<option>USD</option>'+
		                                  '<option>EUR</option>'+
		                                  '<option>HKD</option>'+
		                              '</select>'+
		                          '</div>'+
		                          '<div class="w6">'+
		                          	'<div class="btnMod1" onClick="addAdditionalRow()">添加</div>'+
		                          '</div>'+
		                      '</div>'+
		                  '</div>'+
		                  '<input type="hidden" name="total_shipextra_date"  >'+
		              '</div>'+
		              '<div>'+
		              	'<div class="sLabel">限重：<div class="imp"></div></div>'+
		              	'<input  type="text"  name="limit_weight"  class="box2 modTextBox"  onkeyup="setInputOnlyNum($(this))"   onafterpaste="setInputOnlyNum($(this))"  maxlength="2"    value="'+weightLimit+'"  >'+
		                  '<div class="tishi2 modTishiBg">'+
		                  	'<div class="modTishiTxt">请填写两位整数，重量单位是吨（T）</div>'+
		                  '</div>'+
		              '</div>'+
		              '<div>'+
		              	'<div class="sLabel">备注：<div class="imp"></div></div>'+
		              	'<textarea class="modTextBox" name="remark"  placeholder="请控制在120字以内">'+remark+'</textarea>'+
		              '</div>'+
		              '<div class="singleBottom">'+
		              	'<div id="editShipNoBtn" class="btnMod1">取消</div>'+
		              	'<div class="btnMod1"   id="shipEditSubmit" >发布</div>'+
		                //'<div class="btnMod1" onClick="singleReset()">重置</div>'+
		              '</div>'+
		             '</div>'+
		             '</div>'+
		         '</div>'; 
		         '</form>';
						$('.shipListEidts').append($(doHtml));
						//modDlgEvent($('.addGroupDlg'));//自制弹出框公用事件 居中_拖拽_关闭
						//取消
						$('#editShipNoBtn').on('click',function(){
							window.location.href='/tariffManager/list/'
						});
						
						companyListShow();//船公司列表事件关联
						
						if(extra){
							if(getStrLength(extra)>3){//数据中有至少4个'-'，表示有正规表格数据
								var extraData=[];
								var temp1=extra.split(';');
								for(var i=0;i<temp1.length;i++){
									var temp2=temp1[i].split('-');
									//console.log("temp2",temp2);
									//if(temp2[1]=='box'){temp2[1]='箱';}
									//if(temp2[1]=='piece'){temp2[1]='票';}
									if(temp2.length>3){
										extraData.push(temp2);
									}
								}
								for(var i=0;i<extraData.length;i++){
									var shipName= extraData[i][0] //名称
									var box = extraData[i][1] //箱
									var gps20 = extraData[i][2] //20gp
									var gps40 = extraData[i][3] //40gp
									var hqs40 = extraData[i][4] //40hq
									var picie = extraData[i][5] // 票价
								    var currency = extraData[i][6] // 币种
									
									if(i==0){
										var thisRow=$('#shipAdd2 .gridRow');
										thisRow.find('.w1 select').val(shipName)
										if(box=="box"){
											thisRow.find('.w2 select').val('箱');
										}else{
											thisRow.find('.w2 select').val('票');
										}
										
										if(extraData[i][1]=="box"){
											thisRow.find('.w3 input').attr('disabled',false)
											thisRow.find('.w4 input').attr('disabled',true)
											thisRow.find('input[name="gp20Num"]').val(gps20)
											thisRow.find('input[name="gp40Num"]').val(gps40)
											thisRow.find('input[name="hq40Num"]').val(hqs40)
										}else{
											thisRow.find('.w3 input').attr('disabled',true)
											thisRow.find('.w4 input').attr('disabled',false)
											thisRow.find('.w4 input').val(picie);
											
										}
										thisRow.find('.w5 select').val(currency);
									}else{
										addAdditionalRow();
										
										console.log('length',$('#shipAdd2 .gridRow').length)
										var lastRow=$('#shipAdd2 .gridRow').eq($('#shipAdd2 .gridRow').length-1);
										lastRow.find('.w1 select').val(shipName);
										if(box=="box"){
											lastRow.find('.w2 select').val('箱');
										}else{
											lastRow.find('.w2 select').val('票');
										}
										if(extraData[i][1]=="box"){
											lastRow.find('.w3 input').prop('disabled',false)
											lastRow.find('.w4 input').prop('disabled',true)
											lastRow.find('input[name="gp20Num"]').val(gps20)
											lastRow.find('input[name="gp40Num"]').val(gps40)
											lastRow.find('input[name="hq40Num"]').val(hqs40)
										}else{
											lastRow.find('.w3 input').prop('disabled',true)
											lastRow.find('.w4 input').prop('disabled',false)
											lastRow.find('.w4 input').val(picie);
										}
										lastRow.find('.w5 select').val(currency);
									}
								}
							}
						}
						
						//确定
						$('#shipEditSubmit').click(function(){
							
							//价格非空判定
							var prices=$('.additional .gridRow');
							var strPrice='';
							var isPriceHaveNumAry=[];
							for(var i=0;i<prices.length;i++){
								var isPriceHaveNum=0;
								var checkName=prices.eq(i).children('.w1').children('select');
								if(checkName.val()!="请选择"){
									isPriceHaveNum=1;
								}
								var checkType=prices.eq(i).children('.w2').children('select');
								if(checkType.val()=="箱"){
									var hasNum=0;
									var boxNums=prices.eq(i).children('.w3').children('input')
									for(var j=0;j<boxNums.length;j++){
										if(boxNums.eq(j).val()!=''){
											hasNum=1;
											break;
										}
									}
									if(hasNum==1){
										isPriceHaveNum=1;
									}
								}
								if(checkType.val()=="票"){
									var checkPiece=prices.eq(i).children('.w4').children('input');
									if(checkPiece.val()!=''){
										isPriceHaveNum=1;
									}
								}
								isPriceHaveNumAry.push(isPriceHaveNum);
							}
							//价格非空判定 end
							//判定：名称、箱价格、票价格其中之一有值
							for(var i=0;i<prices.length;i++){
								var strTemp='';
								
								//价格检测
								if(isPriceHaveNumAry[i]==1){
									var checkName=prices.eq(i).children('.w1').children('select');
									if(checkName.val()=="请选择"){
										zcAlert('请选择附加费名称');
										return;
									}
									var checkType=prices.eq(i).children('.w2').children('select');
									if(checkType.val()=="箱"){
										var hasNum=0;
										var boxNums=prices.eq(i).children('.w3').children('input')
										for(var j=0;j<boxNums.length;j++){
											if(boxNums.eq(j).val()!=''){
												hasNum=1;
												break;
											}
										}
										if(hasNum==0){
											zcAlert('请填写柜型价格');
											return;
										}
									}
									if(checkType.val()=="票"){
										var checkPiece=prices.eq(i).children('.w4').children('input');
										if(checkPiece.val()==''){
											zcAlert('请填写单票价格');
											return;
										}
									}
									//价格检测
									
									var strTemp='';
									var name=prices.eq(i).children('.w1').children('select');
									if(name.val()=="请选择"){
										strTemp+='无-';
									}else{
										strTemp+=name.val()+'-';
									}
									var type=prices.eq(i).children('.w2').children('select');
									if(type.val()=="箱"){
										strTemp+='box-';
										var boxes=prices.eq(i).children('.w3').children('input[type="text"]');
										if(boxes.eq(0).val()!=''){
											strTemp+=boxes.eq(0).val()+'-';
										}else{
											strTemp+='0-';
										}
										if(boxes.eq(1).val()!=''){
											strTemp+=boxes.eq(1).val()+'-';
										}else{
											strTemp+='0-';
										}
										if(boxes.eq(2).val()!=''){
											strTemp+=boxes.eq(2).val()+'-';
										}else{
											strTemp+='0-';
										}
										strTemp+='0-';
									}else{
										strTemp+='piece-';
										strTemp+='0-0-0-';
										var piece=prices.eq(i).children('.w4').children('input[type="text"]');
										if(piece.val()!=''){
											strTemp+=piece.val()+'-';
										}else{
											strTemp+='0-';
										}
									}
									var money=prices.eq(i).children('.w5').children('select');
									strTemp+=money.val()+';';
									strPrice+=strTemp;
								}
								
							}
							
							$('input[name="total_shipextra_date"]').val(strPrice);
							//console.log('strPrice',$('input[name="total_shipextra_date"]').val());
							
							var companyName = $.trim($("#companyName").val());
							var contactName = $.trim($("#contactName").val());
							var phone = $.trim($("#phone").val());
							var startPort=$.trim($("#startPort").val());
							var endPort=$.trim($("#endPort").val());
							var shippingDays=$.trim($("#shippingDays").val()); 
							var shipCompany=$.trim($("#companysInputbox").val());
							var shippingDay = $.trim($("#shippingDay").val()); 
							var startDate =$.trim($("#startDate").val());
							var endDate =$.trim($("#endDate").val());
							var gp20=$.trim($("#gp20").val());
							var gp40=$.trim($("#gp40").val());
							var hq40=$.trim($("#hq40").val());
							
							if(companyName=="" || companyName==null){
								zcAlert("供应商不能为空!")
								return
							}
							if(contactName=="" || contactName==null ){
								zcAlert("联系人不能为空!")
								return 
							}
							if(phone=="" || phone==null){
								zcAlert("联系方式不能为空!")
								return 
							}
							
							if(startPort==""||startPort==null){
								zcAlert("起始港不能为空!")
								return 
							}
							
							if(endPort==""||endPort==null){
								zcAlert("目的港不能为空")
								return 
							}
							if(shippingDays==""||shippingDays==null){
								zcAlert("航程不能为空")
								return 
							}
							if(shipCompany==""||shipCompany==null){
								zcAlert("船公司不能为空")
								return 
							}
							
							if(shippingDay==""||shippingDay==null){
								zcAlert("船期不能为空")
								return
							}
							
							if(startDate==""||startDate==null){
								zcAlert("有效期开始日期不能为空")
								return 
							}
							if(endDate==""||endDate==null){
								zcAlert("有效期结束日期不能为空")
								return 
							}
							if(gp20==""||gp20==null){
								zcAlert("请至少填写一种箱型的运价")
								return 
							}
							var isAnyPriceNone=0;
							var isPriceAfter=0;
							for(var i=0;i<isPriceHaveNumAry.length;i++){
								if(isPriceHaveNumAry[i]==0){
									isAnyPriceNone=1;
									if(i==0){
										isPriceAfter=1;
									}
								}
							}
							if(isAnyPriceNone==1){
								if(isPriceAfter==0){
									zcConfirm1('您有附加费项未填，是否继续添加？',function(r){
										if(!r){
											$('#dataFormCreats').submit();
										}else{
											return;
										}
									})
								}else{
									zcConfirm2('未添加任何附加费用，是否继续发布？',function(r){
										if(r){
											$('#dataFormCreats').submit();
										}else{
											return;
										}
									})
								}
								
							}else{
								$('#dataFormCreats').submit();
							}
							
						})
							  
				}




 



					
















