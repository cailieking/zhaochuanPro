$(function(){
	//manageAddTopHtml();//添加后台管理顶部UI
	//manageAddBottomHtml();//添加后台管理底部UI
	//manageAddLeftHtml();//添加后台管理左侧导航UI
	//setManageLeftNavSel(5,1);//设置左侧导航选中状态
	
	rightNavClick();//右侧页面切换导航点击
	companyListShow();//船公司列表事件关联
	uploadShipFileEvent();//上传运价文件事件关联
	uploadShipFileEvent2();//上传运价文件事件关联
})

function shipSubmit(){
	var strDay='';
	for(var i=0;i<$('.shipDayBg').length;i++){
		$('.shipDayBg').eq(i).find('.dayBox').eq(0).val();
		var sDay=$('#shipDayDiv').find('.dayBox').eq(0).val();
		var eDay=$('#shipDayDiv').find('.dayBox').eq(1).val();
		if(sDay==''){sDay=0;}
		if(eDay==''){eDay=0;}
		strDay+=sDay+'截'+eDay+'开';
		if(i!=$('.shipDayBg').length-1){
			strDay+=',';
		}
	}
	$('input[name="total_shipping_date"]').val(strDay);
	
	
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
		/*var strTemp='';
		*/
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
	var  phone = $.trim($("#phone").val());
	var startPort=$.trim($("#startPort").val());
	var endPort=$.trim($("#endPort").val());
	var shippingDays=$.trim($("#shippingDays").val()); 
	var shipCompany =$.trim($("#companysInputbox").val());
	var jj=$.trim($("#jj").val());
	var kk=$.trim($("#kk").val());
	var startDate =$.trim($("#startDate").val());
	var endDate =$.trim($("#endDate").val());
	var gp20=$.trim($("#gp20").val());
	var gp40=$.trim($("#gp40").val());
	var hq40=$.trim($("#hq40").val());
	var gp20Vip = $.trim($("#gp20Vip").val());
	var gp40Vip = $.trim($("#gp40Vip").val());
	var hq40Vip = $.trim($("#hq40Vip").val());	
	
	
	if(companyName==""|| companyName == null){
		zcAlert("供应商不能为空!")
		return 
	}
	if(contactName==""|| contactName == null){
		zcAlert("联系人不能为空!")
		return 
		
	}
	if(phone==""|| phone == null){
		zcAlert("联系方式不能为空!")
		return 
		
	}
	if(startPort==""||startPort==null){
		zcAlert("起始港不能为空!")
		return 
	}
	
	if(endPort==""||endPort==null){
		zcAlert("目的港不能为空!")
		return 
	}
	if(shippingDays==""||shippingDays==null){
		zcAlert("航程不能为空!")
		return 
	}
	if(shipCompany==""||shipCompany==null){
		zcAlert("船公司不能为空!")
		return 
	}
	
	if(jj==""||jj==null && kk==""||kk==null ){
		zcAlert("船期不能为空!")
		return 
	}
	if(startDate==""||startDate==null){
		zcAlert("有效期开始日期不能为空!")
		return 
	}
	if(endDate==""||endDate==null){
		zcAlert("有效期结束日期不能为空!")
		return 
	}
	if(gp20==""||gp20==null){
		zcAlert("请至少填写一种箱型的运价!")
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
					$('#dataFormCreat').submit();
				}else{
					return;
				}
			})
		}else{
			zcConfirm2('未添加任何附加费用，是否继续发布？',function(r){
				if(r){
					$('#dataFormCreat').submit();
				}else{
					return;
				}
			})
		}
		
	}else{
		$('#dataFormCreat').submit();
	}
	
}

function ShipNoBtn(){
	window.location.href='/tariffManager/bactchList/'
}




//右侧页面切换导航点击
function rightNavClick(){
	$('.rightNav1 li').click(function(){
		var lis=$('.rightNav1 li');
		var index=lis.index($(this));
		lis.removeClass('sel');
		$(this).addClass('sel');
		switch(index){
			case 0:{//单条发布
				$('.singleBg').show();
				$('.batchBg').hide();
				$('.batchBg2').hide();
			}
			break;
			case 1:{//批量导入
				$('.singleBg').hide();
				$('.batchBg').show();
				$('.batchBg2').hide();
			}
			break;
			
			case 2:{//内部批量导入
				$('.singleBg').hide();
				$('.batchBg').hide();
				$('.batchBg2').show();
			}
			break;
		}
	})
	
	var intoType=sessionStorage.getItem("batchimport");
	if(intoType=='1'){
		$('.rightNav1 li').eq(1).trigger('click');
	}
	 sessionStorage.removeItem("batchimport");
}
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
			'<option>WRS</option>'+
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
		'<div class="sLabel">航线：<div class="imp">*</div></div>'+
		'<input type="text" class="box1 modTextBox" />'+
		'<div class="tishi1 modTishiBg">'+
			'<div class="modTishiTxt">*为必填项</div>'+
		'</div>'+
	'</div>'+	
	'<div>'+
		'<div class="sLabel">供应商：<div class="imp">*</div></div>'+
		'<input type="text" class="box1 modTextBox" />'+
		'<div class="tishi1 modTishiBg">'+
			'<div class="modTishiTxt">*为必填项</div>'+
		'</div>'+
	'</div>'+	
	'<div>'+
		'<div class="sLabel">联系人：<div class="imp">*</div></div>'+
		'<input type="text" class="box1 modTextBox" />'+
		'<div class="tishi1 modTishiBg">'+
			'<div class="modTishiTxt">*为必填项</div>'+
		'</div>'+
	'</div>'+
	'<div>'+
		'<div class="sLabel">联系方式：<div class="imp">*</div></div>'+
		'<input type="text" class="box1 modTextBox" />'+
		'<div class="tishi1 modTishiBg">'+
			'<div class="modTishiTxt">*为必填项</div>'+
		'</div>'+
	'</div>'+		
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
	'<div class="modTextBox shipPriceBg">'+
		'<span>20GPVip</span>'+
		'<input type="text" class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" />'+
		'<span>40GPVip</span>'+
		'<input type="text" class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" />'+
		'<span>40HQVip</span>'+
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
					'<option>WRS</option>'+
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


//上传运价文件事件关联
function uploadShipFileEvent(){
	$('#shiFileBtn').click(function(){
		 $('.bLine .filetset').trigger('click');
	})
	$('body').on('change','#xls',function(){
				//$('.bLine .filetset').change(function(){
				$('#shiFileBtn').hide();
				$('.shipFileData').show();
				var fileRoad=$(this).val().split('\\');
				var fileName=fileRoad[fileRoad.length-1];
				$('.shipFileData .fileName').html(fileName);
	})
	$('.shipFileData .fileDel').click(function(){
		$('#shiFileBtn').show();
		$('.shipFileData').hide();
		 $(".fileName").empty();
		 $('.bLine .filetset').remove()
		 $("#shiFileBtn").after('<input type="file" class="file filetset" name="xls" id="xls" style="display:none;">')
	})
}



//上传内部运价文件事件关联
function uploadShipFileEvent2(){
	$('#shiFileBtn2').click(function(){
		 $('.bLine2 .filetset').trigger('click');
	})
	$('body').on('change','#xls2',function(){
				//$('.bLine .filetset').change(function(){
				$('#shiFileBtn2').hide();
				$('.shipFileData2').show();
				var fileRoad=$(this).val().split('\\');
				var fileName=fileRoad[fileRoad.length-1];
				$('.shipFileData2 .fileName').html(fileName);
	})
	$('.shipFileData2 .fileDel').click(function(){
		$('#shiFileBtn2').show();
		$('.shipFileData2').hide();
		 $(".fileName").empty();
		 $('.bLine2 .filetset').remove()
		 $("#shiFileBtn2").after('<input type="file" class="file filetset" name="xls2" id="xls2" style="display:none;">')
	})
}