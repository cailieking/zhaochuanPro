<%@page import="com.cdd.base.enums.CargoBoxType"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(".datepicker").datepicker({
		yearRange: "2015:+10"
	});

	$(".Dwt").find("#close_purchase_refresh").bind("click",function(){
	    $(".Dwt").hide();
	    location.href = "/member/cargo"
	});
	

	$("#cargoBoxUp").bind("click",function(){
		var cargoBoxNums = $("#cargoBoxNums").val();
		try {
			cargoBoxNums = parseInt(cargoBoxNums)
		} catch (ex) {
			$("#cargoBoxNums").val(1);
		}
		if (cargoBoxNums < 100) {
			$("#cargoBoxNums").val(cargoBoxNums+1);
		} else {
			$("#cargoBoxNums").val(100);
		}
			
	});

	$("#cargoBoxDown").bind("click",function(){
		var cargoBoxNums = $("#cargoBoxNums").val();
		try {
			cargoBoxNums = parseInt(cargoBoxNums)
		} catch (ex) {
			$("#cargoBoxNums").val(1);
		}
		if (cargoBoxNums > 1) {
			$("#cargoBoxNums").val(parseInt(cargoBoxNums)-1);
		} else {
			$("#cargoBoxNums").val(1);
		}
	});

	$('#submit_purchase').bind("click",function(){
		var startPort=$.trim($("#startPort").val());
		var endPort=$.trim($("#endPort").val());
		var startPortCn=$.trim($("#startPortCn").val());
		var endPortCn=$.trim($("#endPortCn").val());
		var startDate=$.trim($("#startDate").val());
		var endDate=$.trim($("#endDate").val());
		var biteEndDate=$.trim($("#biteEndDate").val());
		var transType=$.trim($("#transType").val());
		var cargoBoxType = $("#cargoBoxType").val();
		var cargoBoxNums = $("#cargoBoxNums").val();
		var cargoNums=$.trim($("#cargoNums").val());
		var cargoWeight=$.trim($("#cargoWeight").val());
		var cargoCube=$.trim($("#cargoCube").val());
		var cargoWidth=$.trim($("#cargoWidth").val());
		var cargoHeight=$.trim($("#cargoHeight").val());
		var cargoLength=$.trim($("#cargoLength").val());
		var cargoName=$.trim($("#cargoName").val());
		var orderType=$.trim($("#orderType").val());
		var remark=$.trim($("#remark").val());
		var infoId=$.trim($("#infoId").val());
		if(!startPort){
			$("#valiResult").css({"color":"red"}).html("<i></i>请输入起始港");
			$("#startPort").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!endPort){
			$("#valiResult").css({"color":"red"}).html("<i></i>请输入目的港");
			$("#endPort").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!startDate){
			$("#valiResult").css({"color":"red"}).html("<i></i>请输入走货日期");
			$("#startDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!checkSimpleDate("startDate")){
			$("#valiResult").css({"color":"red"}).html("<i></i>走货日期格式不正确");
			$("#startDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!endDate){
			$("#valiResult").css({"color":"red"}).html("<i></i>请输入走货日期");
			$("#endDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!checkSimpleDate("endDate")){
			$("#valiResult").css({"color":"red"}).html("<i></i>走货日期格式不正确");
			$("#endDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(startDate > endDate) {
			$("#valiResult").css({"color":"red"}).html("<i></i>走货开始日期不能大于结束日期");
			$("#startDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!biteEndDate){
			$("#valiResult").css({"color":"red"}).html("<i></i>请输入报价截至时间");
			$("#biteEndDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!checkSimpleDate("biteEndDate")){
			$("#valiResult").css({"color":"red"}).html("<i></i>报价截至时间格式不正确");
			$("#biteEndDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(biteEndDate > startDate) {
			$("#valiResult").css({"color":"red"}).html("<i></i>报价截至时间不能大于走货开始日期");
			$("#biteEndDate").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}
		if(!transType){
			$("#valiResult").css({"color":"red"}).html("<i></i>请选择运输种类");
			$("#transType").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}


		if(transType == 'Whole'){
			if(!cargoBoxType) {
				$("#valiResult").css({"color":"red"}).html("<i></i>请选择柜型");
				$("#cargoBoxType").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}

			if(!cargoBoxNums) {
				$("#valiResult").css({"color":"red"}).html("<i></i>请选择柜型数量");
				$("#cargoBoxNums").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}

			try {
				parseInt(cargoBoxNums)
			} catch (ex) {
				$("#valiResult").css({"color":"red"}).html("<i></i>柜型数量请输入1到100之间的整数");
				$("#cargoBoxNums").focus();
				return false;
			}
			if (cargoBoxNums < 1 || cargoBoxNums > 100) {
				$("#valiResult").css({"color":"red"}).html("<i></i>柜型数量请输入1到100之间的整数");
				$("#cargoBoxNums").focus();
				return false;
			}
			
		} else {
			if(!cargoNums){
				$("#valiResult").css({"color":"red"}).html("<i></i>请输入件数");
				$("#cargoNums").focus();
				return false;
			}else{
				$("#valiResult").html("");
			}
			if (!checkNumeric("cargoNums")) {
				$("#valiResult").css({"color":"red"}).html("<i></i>件数请输入大于0的整数数字");
				$("#cargoNums").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}
			if(!cargoWeight){
				$("#valiResult").css({"color":"red"}).html("<i></i>请输入毛重");
				$("#cargoWeight").focus();
				return false;
			}else{
				$("#valiResult").html("");
			}
			if (!checkNumericMax2("cargoWeight")) {
				$("#valiResult").css({"color":"red"}).html("<i></i>毛重请输入数字, 最多保留2位小数");
				$("#cargoWeight").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}
			if(!cargoCube){
				$("#valiResult").css({"color":"red"}).html("<i></i>请输入体积");
				$("#cargoCube").focus();
				return false;
			}else{
				$("#valiResult").html("");
			}
			if (!checkNumericMax2("cargoCube")) {
				$("#valiResult").css({"color":"red"}).html("<i></i>体积请输入数字, 最多保留2位小数");
				$("#cargoCube").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}
			if (checkBlank("cargoWidth") && !checkNumericMax2("cargoWidth")) {
				$("#valiResult").css({"color":"red"}).html("<i></i>单位尺寸请输入数字, 最多保留2位小数");
				$("#cargoWidth").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}
			if (checkBlank("cargoHeight") && !checkNumericMax2("cargoHeight")) {
				$("#valiResult").css({"color":"red"}).html("<i></i>单位尺寸请输入数字, 最多保留2位小数");
				$("#cargoHeight").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}
			if (checkBlank("cargoLength") && !checkNumericMax2("cargoLength")) {
				$("#valiResult").css({"color":"red"}).html("<i></i>单位尺寸请输入数字, 最多保留2位小数");
				$("#cargoLength").focus();
				return false;
			} else {
				$("#valiResult").html("");
			}
		}
		if(remark > 500){
			$("#valiResult").css({"color":"red"}).html("<i></i>备注不能超过500个字");
			$("#remark").focus();
			return false;
		}else{
			$("#valiResult").html("");
		}

		$.ajax({
				url:SITE_URL+'order/issue', 
				type:'post',         
				dataType:'json',  
				async: false,
				data :{startPort:startPort,endPort:endPort,startPortCn:startPortCn,endPortCn:endPortCn,startDate:startDate,endDate:endDate,biteEndDate:biteEndDate,transType:transType,cargoNums:cargoNums,cargoWeight:cargoWeight,
					cargoCube:cargoCube,cargoWidth:cargoWidth,cargoHeight:cargoHeight,cargoLength:cargoLength,cargoBoxType:cargoBoxType,cargoBoxNums:cargoBoxNums,cargoName:cargoName,orderType:orderType,remark:remark,infoId:infoId},
				success:function(rs){
				if(rs.status==1){
					$(".Dwt").show();
					$(".Dwt").find('#purchase_sn').html(rs.data);
					flag=true;
					myform.reset();
				}else{
					alert(rs.msg);
					flag=false;
				}
			}
		});
		
	});
});

function changeTransType() {
	var transTypeVal = $("#transType").val();
	if (transTypeVal == 'Whole') {
	  $("#TogetherRow1").hide();
	  $("#TogetherRow2").hide();
	  $("#TogetherRow3").hide();
	  $("#TogetherRow4").hide();
	  $("#TogetherRow5").show();
	  $("#TogetherRow6").show();
	} else {
	  $("#TogetherRow5").hide();
	  $("#TogetherRow6").hide();
	  $("#TogetherRow1").show();
	  $("#TogetherRow2").show();
	  $("#TogetherRow3").show();
	  $("#TogetherRow4").show();
	}
}

</script>
</head>
<body>

	<div class="w960">

		<form id="myform" method="post">
			<div class="right release_single">
				<p class="headtitle">
					<span>发布货物信息（<i style="color: red">*</i><i style="font-size: 13px;color:#676767">为必填项</i>）</span>
				</p>
				<div class="one">
					<input type="hidden" id="infoId" name="infoId" value="${params.infoId}" />
					<table>
						<tr>
							<td><span style="color: red">*</span>起始港：</td>
							<td><input type="text" name="startPort" id="startPort" value="${params.startPort}" class="bd2"
										maxlength="100">
								<input type="hidden" name="startPortCn" id="startPortCn" value="${params.startPortCn}"
										maxlength="50">		
							</td>
							<td><span style="color: red">*</span>目的港：</td>
							<td>
								<input type="text" name="endPort" id="endPort" value="${params.endPort}"
										class="bd2" maxlength="100"> &nbsp;&nbsp;&nbsp;
								<input type="hidden" name="endPortCn" id="endPortCn" value="${params.endPortCn}"
										maxlength="50">		
							</td>
						</tr>
						<tr>
							<td><span style="color: red">*</span>走货日期：</td>
							<td> <input
								type="text" name="startDate" id="startDate" value=""
								class="bd datepicker" maxlength="10"> - <input
								type="text" name="endDate" id="endDate" value=""
								class="bd datepicker" maxlength="10">
							</td>
							<td><span style="color: red">*</span>报价截至时间：</td>
							<td>
								<input type="text" name="biteEndDate" id="biteEndDate" value=""
								class="bd datepicker" maxlength="10"> 
							</td>
						</tr>
						<tr>
							<td>货物名称：</td>
							<td><input
								type="text" name="cargoName" id="cargoName" value=""
								class="bd2" maxlength="50" /></td>
							<td>货物类型：</td>
							<td>
								<select name="orderType" id="orderType" class="bd">
									<option value="">---请选择---</option>
									<option value="Furniture">家居</option>
									<option value="Building">建材</option>
									<option value="Clothing">服装</option>
									<option value="Other">其他</option>
								</select>
							</td>
						</tr>	
						<tr>
							<td><span style="color: red">*</span>运输种类：</td>
							<td>
								<select name="transType" id="transType" class="bd" onchange="changeTransType()">
									<option value="Whole" selected>整箱</option>
									<option value="Together">拼箱</option>
								</select>
							</td>
							<td><span style="color: red">*</span><span id="TogetherRow3" style="display:none;">件数</span><span id="TogetherRow5">柜型</span>：</td>
							<td>
								<span id="TogetherRow4" style="display:none;"><input type="text" name="cargoNums" id="cargoNums" value="" class="bd" maxlength="10"></span>
								<span id="TogetherRow6">
									<select id="cargoBoxType" name="cargoBoxType" class="bd" >
								  		<option value="">---请选择---</option> 
								   		<g:each in="${CargoBoxType.values()}" var="boxType">
								   		<option value="${boxType.name()}">${boxType.text}</option> 
								   		</g:each>
							  		</select>
							  		<span id="cargoBoxUp" class="amount_up">+</span>
							  		<input type="text" id="cargoBoxNums" name="cargoBoxNums" value="1" class="amount_input" maxlength="3">
							  		<span id="cargoBoxDown" class="amount_down">-</span>
								</span>
							</td>
						</tr>
						
						<tr id="TogetherRow1" style="display:none;">
							<td><span style="color: red">*</span>毛重：</td>
							<td>
								<input type="text" name="cargoWeight" id="cargoWeight" value="" class="bd" maxlength="16">&nbsp;KG
							</td>
							<td><span style="color: red">*</span>体积：</td>
							<td>
								<input type="text" name="cargoCube" id="cargoCube" value="" class="bd" maxlength="16">&nbsp;CBM
							</td>
						</tr>
						
						<tr id="TogetherRow2" style="display:none;">
							<td>单位尺寸：</td>
							<td colspan="3">
								<input
								type="text" name="cargoWidth" id="cargoWidth" value=""
								class="bd" maxlength="16" placeholder="宽度" >&nbsp;CM&nbsp;&nbsp;&nbsp;&nbsp;
								<input
								type="text" name="cargoHeight" id="cargoHeight" value=""
								class="bd" maxlength="16" placeholder="高度">&nbsp;CM&nbsp;&nbsp;&nbsp;&nbsp;
								<input
								type="text" name="cargoLength" id="cargoLength" value=""
								class="bd" maxlength="16" placeholder="长度">&nbsp;CM
							</td>
						</tr>
						<tr>
							<td>备注：</td>
							<td colspan="3">
								<textarea name="remark" id="remark"></textarea>
							</td>
						</tr>
						
					</table>
					<p>
						<input type="button" class="Button" id="submit_purchase"
							style="margin: 20px 0 20px 75px;" value="发布">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="valiResult"></span>
					</p>
				</div>
			</div>
		</form>
	</div>

	<div class="" style="display: none; position: absolute;">
		<div class="aui_outer">
			<table class="aui_border">
				<tbody>
					<tr>
						<td class="aui_nw"></td>
						<td class="aui_n"></td>
						<td class="aui_ne"></td>
					</tr>
					<tr>
						<td class="aui_w"></td>
						<td class="aui_c"><div class="aui_inner">
								<table class="aui_dialog">
									<tbody>
										<tr>
											<td colspan="2" class="aui_header"><div
													class="aui_titleBar">
													<div class="aui_title" style="cursor: move;"></div>
													<a class="aui_close" href="javascript:/*artDialog*/;">×</a>
												</div></td>
										</tr>
										<tr>
											<td class="aui_icon" style="display: none;"><div
													class="aui_iconBg" style="background: none;"></div></td>
											<td class="aui_main" style="width: auto; height: auto;"><div
													class="aui_content" style="padding: 20px 25px;"></div></td>
										</tr>
										<tr>
											<td colspan="2" class="aui_footer"><div
													class="aui_buttons" style="display: none;"></div></td>
										</tr>
									</tbody>
								</table>
							</div></td>
						<td class="aui_e"></td>
					</tr>
					<tr>
						<td class="aui_sw"></td>
						<td class="aui_s"></td>
						<td class="aui_se" style="cursor: se-resize;"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="Dwt" style="display: none;">
		<p class="title_login" style="padding-left: 20px; font-size: 20px;">成功发布</p>
		<div class="d" style="height: 130px;">
			<p>
				<i></i> 您的委托已受理，订单号&nbsp;&nbsp;<span id="purchase_sn" style="color:red;"></span>&nbsp;&nbsp;，工作人员将在1个工作日内联系您。
			</p>
			<p style="text-align: center; margin-top: 10px;">
				<img alt="我知道了" src="../images/biz/dwt_btn.png" id="close_purchase_refresh">
			</p>
		</div>
	</div>

	<div class="backpage backcargo needtop"></div>

</body>
</html>