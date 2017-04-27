<%@page import="com.cdd.base.enums.CargoBoxType"%>
<%@page import="com.cdd.base.enums.TransportationType"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/biz/biz.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/form.js"></script>
<script src="../js/biz/biz.js"></script>

</head>
<body>





<style type="text/css">
*html { background-image:url(about:blank); background-attachment:fixed; }
* { padding: 0; margin: 0; }
body { font-family:Tahoma,arial,"宋体"; font-size:12px; color:#333; }
p{ margin:0; padding:0; }
a{ color:#333; text-decoration:none;}
a:hover{ text-decoration:underline;}
.Ddz{ position:fixed;z-index:9999; top:35%; left:35%;_position: absolute; _top:expression(documentElement.scrollTop+(documentElement.clientHeight-this.clientHeight)/2); z-index:100001; width:498px; border:1px solid #448aca; background:#fff;}
.Ddz .title{ height:31px; border-bottom:1px solid #ddd; line-height:31px;}
.Ddz .title a{ float:right; width:31px; height:31px; background:url(../images/common/pic_admin_dzx.png) no-repeat 0 0;}
.Ddz .p1{ padding-left:20px; height:30px; line-height:22px;}
.Ddz .p1 a{ display:inline-block; width:43px; height:22px; line-height:22px; text-align:center; color:#06c;}
.Ddz .p1 a:hover{background:#08d; color:#fff;}
.Ddz .p1 b{ margin-right:5px; color:#f90;}
.Ddz .p1 .on{ background:#08d; color:#fff;}
.Ddz .p2{ margin:0 8px 10px; padding:8px; width:464px; border:1px solid #eee; line-height:24px;}
.Ddz .p2 a{ display:inline-block; width:auto; margin:5px 5px 5px 0; padding:0 3px; text-align:center;}
.Ddz .p2 a:hover{background:#08d; color:#fff;}
.Ddz .p2 .on{ background:#08d; color:#fff;}








.table_palletDetail {margin-top: 25px; color: #666;}
.table_palletDetail .topBox .icon {float: left; width: 15px; height: 14px; margin: 3px 15px 0 0; background: url(../images/icons.png) no-repeat 0 -214px;}
.table_palletDetail .topBox .name {float: left; font-family: Microsoft YaHei; font-size: 16px; color: #ff840c; height: 20px; line-height: 20px;}
.table_palletDetail .topBox .No {float: left; height: 15px; line-height: 15px; margin-top: 5px;}
.icon_zhao {float: left; width: 17px; height: 17px; overflow: hidden; text-indent: -99em; background: url(../images/icons.png) no-repeat 0 -561px;}
.table_palletDetail .topBox .icon_zhao {margin: 4px 5px 0 0;}
.table_palletDetail .infoBox { margin-top: 10px; margin-bottom: 20px; position: relative;}
.table_palletDetail .infoBox .maskLayer {width: 133px; height: 50px; position: absolute; right: 50px; top: 200px;}
.table_palletDetail .infoBox table {border: 1px solid #dfdfdf;}
.table_palletDetail .infoBox td {width: 500px; border: 1px solid #dfdfdf; padding: 15px 0;}
.table_palletDetail .infoBox .cell {}
.table_palletDetail .infoBox .title {float: left; width: 120px; line-height: 21px; font-family: Microsoft YaHei; font-size: 15px; text-align: right;}
.table_palletDetail .infoBox .text {float: left;  line-height: 21px; font-family: Microsoft YaHei; font-size: 16px; margin-left: 105px; margin-right: 10px;}
.table_palletDetail .infoBox .yunFei { margin: -1px; border: 0 none; line-height: 21px; font-family: Microsoft YaHei; font-size: 16px; font-weight: 700;}
.table_palletDetail .infoTip {height: 19px; line-height: 19px; margin-top: 15px; text-align: center; font-family: Microsoft YaHei; font-size: 16px;}
.table_palletDetail .infoTip em {font-weight: 700; color: #ff840c;}
.table_palletDetail .infoTip a {font-family: Arial; font-size: 12px; margin-left: 15px;}




/*release_single*/
.release_single .one{ padding:20px 0; float:left; width:660px; line-height:42px;}
.release_single .one .bd{ background: url(../../images/member/pic_member.png) repeat-x 0 -650px; padding:0 5px; width:88px; height:30px; border:1px solid #d2d2d2; line-height:30px; vertical-align:middle;}
.release_single .one .bd2{ background: url(../../images/member/pic_member.png) repeat-x 0 -650px; padding:0 5px; width:168px; height:30px; border:1px solid #d2d2d2; line-height:30px; vertical-align:middle;}
.release_single .one .bd3{ background: url(../../images/member/pic_member.png) repeat-x 0 -650px; padding:0 5px; width:108px; height:30px; border:1px solid #d2d2d2; line-height:30px; vertical-align:middle;}
.release_single .one select.bd{ padding:0;}
.release_single .one .w1{ width:78px;}
.release_single .one .w2{ width:128px;}
.release_single .one .color1{ color:#666;}
.release_single .add{ padding-left:50px; float:left; width:728px; height:38px; background:#f5f5f5; border:1px solid #ddd; line-height:38px;}
.release_single .add b{ color:#06c;}
.release_single .div1{float: left; width: 70px;}
.release_single .div2{margin-left:75px;}
.release_single textarea{padding:10px; width:500px; height:68px; border:1px solid #ddd; font-size:14px; color:#999;}
/*****release_single*****/

.amount_down, .amount_up {
	background: #F2F2F2;
	cursor: pointer;
	width: 30px;
	border-radius: 3px;
	height: 30px;
	border: 1px solid #DDD;
	text-align: center;
	line-height: 30px;
	margin-top:4px;
}

.amount_down{
	float: right;
}

.amount_up{
	float: right;
}

.amount_input {
	width: 24px;
	float: right;
	margin: 4px 10px 0 10px;
	background: url(../../images/member/pic_member.png) repeat-x 0 -650px;
	padding: 0 5px;
	height: 30px;
	border: 1px solid #d2d2d2;
	line-height: 30px;
	text-align:center;
	vertical-align: middle;
	clear: none;
}

</style>
<script type="text/javascript">
$(function(){
	$(".datepicker").datepicker({
		yearRange: "2015:+10"
	});
	$(".Dwt").find("#close_purchase_refresh").bind("click",function(){
	    $(".Dwt").hide();
	    location.href = "/publish/findship"
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
		
		var companyName=$.trim($("#companyName").val());
		var contactName=$.trim($("#contactName").val());
		var phone=$.trim($("#phone").val());
		var infoId=$.trim($("#infoId").val());
		var city_id=$.trim($("#city_id").val());
		var province_id=$.trim($("input[name='province_id']").val());
		var flag=true;

		if(!startPort){
			$(".p3").css({"color":"red"}).html("<i></i>请输入起始港");
			$("#startPort").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(!endPort){
			$(".p3").css({"color":"red"}).html("<i></i>请输入目的港");
			$("#endPort").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		
		if(checkBlank("startDate") && !checkSimpleDate("startDate")){
			$(".p3").css({"color":"red"}).html("<i></i>走货日期格式不正确");
			$("#startDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(checkBlank("endDate") && !checkSimpleDate("endDate")){
			$(".p3").css({"color":"red"}).html("<i></i>走货日期格式不正确");
			$("#endDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(startDate > endDate) {
			$(".p3").css({"color":"red"}).html("<i></i>走货开始日期不能大于结束日期");
			$("#startDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(checkBlank("biteEndDate") && !checkSimpleDate("biteEndDate")){
			$(".p3").css({"color":"red"}).html("<i></i>报价截至时间格式不正确");
			$("#biteEndDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(biteEndDate > startDate) {
			$(".p3").css({"color":"red"}).html("<i></i>报价截至时间不能大于走货开始日期");
			$("#biteEndDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}


		if(transType == 'Whole'){
			try {
				parseInt(cargoBoxNums)
			} catch (ex) {
				$(".p3").css({"color":"red"}).html("<i></i>柜型数量请输入1到100之间的整数");
				$("#cargoBoxNums").focus();
				return false;
			}
			if (cargoBoxNums < 1 || cargoBoxNums > 100) {
				$(".p3").css({"color":"red"}).html("<i></i>柜型数量请输入1到100之间的整数");
				$("#cargoBoxNums").focus();
				return false;
			}
			
		} else {
			if (!checkNumeric("cargoNums")) {
				$(".p3").css({"color":"red"}).html("<i></i>件数请输入大于0的整数数字");
				$("#cargoNums").focus();
				return false;
			} else {
				$(".p3").html("");
			}
			if (!checkNumericMax2("cargoWeight")) {
				$(".p3").css({"color":"red"}).html("<i></i>毛重请输入数字, 最多保留2位小数");
				$("#cargoWeight").focus();
				return false;
			} else {
				$(".p3").html("");
			}
			if (!checkNumericMax2("cargoCube")) {
				$(".p3").css({"color":"red"}).html("<i></i>体积请输入数字, 最多保留2位小数");
				$("#cargoCube").focus();
				return false;
			} else {
				$(".p3").html("");
			}
			if (checkBlank("cargoWidth") && !checkNumericMax2("cargoWidth")) {
				$(".p3").css({"color":"red"}).html("<i></i>单位尺寸请输入数字, 最多保留2位小数");
				$("#cargoWidth").focus();
				return false;
			} else {
				$(".p3").html("");
			}
			if (checkBlank("cargoHeight") && !checkNumericMax2("cargoHeight")) {
				$(".p3").css({"color":"red"}).html("<i></i>单位尺寸请输入数字, 最多保留2位小数");
				$("#cargoHeight").focus();
				return false;
			} else {
				$(".p3").html("");
			}
			if (checkBlank("cargoLength") && !checkNumericMax2("cargoLength")) {
				$(".p3").css({"color":"red"}).html("<i></i>单位尺寸请输入数字, 最多保留2位小数");
				$("#cargoLength").focus();
				return false;
			} else {
				$(".p3").html("");
			}
		}
		if(remark > 500){
			$(".p3").css({"color":"red"}).html("<i></i>备注不能超过500个字");
			$("#remark").focus();
			return false;
		}else{
			$(".p3").html("");
		}


		if(!companyName){
			$(".p3").css({"color":"red"}).html("<i></i>请输入您的公司名称");
			$("#companyName").focus();
			return false;
		}else{
			if(companyName.length<4){
				$(".p3").css({"color":"red"}).html("<i></i>请正确填写公司名称");
				$("#companyName").focus();
				return false;
			}
			$(".p3").html("");
		}
		if(city_id<1){
			$(".p3").css({"color":"red"}).html("<i></i>请选择地区");
			$("#sel_regions").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(!contactName){
			$(".p3").css({"color":"red"}).html("<i></i>请输入联系人");
			$("#contactName").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(!phone){
			$(".p3").css({"color":"red"}).html("<i></i>请输入您的联系方式");
			$("#phone").focus();
			return false;
		}else{
			var reg=/^1[3|4|5|8][0-9]{9}$/;
			if(!reg.test(phone)){
			$(".p3").css({"color":"red"}).html("<i></i>联系方式格式不对,请输入11位的手机号码");
			$("#phone").focus();
			return false;
		}
		$(".p3").html("");
	}
	if(startPort && endPort && companyName && contactName && phone){
		$.ajax({
			url:SITE_URL+'order/issue', 
			type:'post',         
			dataType:'json',  
			async: false,
			data :{startPort:startPort,endPort:endPort,startPortCn:startPortCn,endPortCn:endPortCn,startDate:startDate,endDate:endDate,biteEndDate:biteEndDate,transType:transType,cargoNums:cargoNums,cargoWeight:cargoWeight,
				cargoCube:cargoCube,cargoWidth:cargoWidth,cargoHeight:cargoHeight,cargoLength:cargoLength,cargoBoxType:cargoBoxType,cargoBoxNums:cargoBoxNums,cargoName:cargoName,orderType:orderType,remark:remark,infoId:infoId,companyName:companyName,contactName:contactName,phone:phone,infoId:infoId,city_id:city_id,province_id:province_id},
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
			}
		return flag;
	});
	$(".Dwt").find("#close_purchase").bind("click",function(){
	$(".Dwt").hide();
});
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
<script type="text/javascript">
function selectcity(pid,pname,_this){
$("#citydiv .Ddz .p2").html("");
$("#selectedprovince").html(pname);
$("input[name='city_id']").attr("value","");
$("#region_name").html(pname);
$("input[name='province_id']").attr("value",pid);
$('a').removeClass("on");
$(_this).addClass("on");
$.ajax({
url:SITE_URL+'city/getCitys?pcode='+pid, 
type:'GET',         
dataType:'json',    
success:function(data){
var k;
var regs=data;
var inhtml='';
for(k in regs){
    inhtml +='<a href="javascript:void(0);" onclick="addtotext('+regs[k].code+',\''+regs[k].name+'\');"';
    if(regs[k].hot==1) inhtml+='style="color:red;"';
    inhtml+='>'+regs[k].name+'</a>';    
}
$("#citydiv .Ddz .p2").html(inhtml);
}
});	
}

function addtotext(cid,cname){
$("#selectedcity").html("-"+cname);
var cp=$("#selectedprovince").html()+$("#selectedcity").html();
$("input[name='city_id']").attr("value",cid);
$("#region_name").html(cp);
$("#citydiv").hide(100);
$("#sel_regions").removeAttr("disabled");
};

function closediv(co){
if(co){
$("#citydiv").show(100);
$("#sel_regions").attr("disabled","disabled");
}
else{
$("#sel_regions").removeAttr("disabled");
$("#citydiv").hide(100);
}
};
</script>

<div class="main">
<div class="w960" style="overflow:hidden;">
<div class="post_buy">
<p class="lct"></p>



<g:if test="${data}">
<div class="table_palletDetail">
	<div class="infoBox">
		<table>
			<tbody>
				<tr>
					<td style="background: #eaf4fb;">
						<div class="cell clearfix">
							<b class="title">起始港：</b> <b style="color: #0b83f6;"
								class="text">${data.startPort}</b>
						</div>
					</td>
					<td style="background: #eaf4fb;">
						<div class="cell clearfix">
							<b class="title">目的港：</b> <b style="color: #0b83f6;"
								class="text">${data.endPort}</b>
						</div>
					</td>
				</tr>
				<g:if test="${data.transType==TransportationType.Together}">
				<tr>
					<td>
						<div class="cell clearfix">
							<b class="title">CBM：</b> <b class="text" style="font-size:20px;color:#ff540c;"><g:if test="${data.prices && data.prices.cbm}">${data.prices.cbm}</g:if></b>
						</div>
					</td>
					<td>
						<div class="cell clearfix">
							<b class="title">最低消费：</b> <b class="text" style="font-size:20px;color:#ff540c;"><g:if test="${data.prices && data.prices.lowestCost}">${data.prices.lowestCost}</g:if>
							</b>
						</div> 
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="cell clearfix">
							<b class="title">服务类型：</b> <b class="text">${data.pinServiceType}</b>
						</div>
					</td>
				</tr>
				</g:if>
				<g:else>
				<tr>
					<td style="border: 0; padding: 0;" colspan="2">
						<table class="yunFei">
							<tbody>
								<tr>
									<td style="width: 130px;" rowspan="2">
										<div style="width: 120px; vertical-align: top;"
											class="cell clearfix">
											<b class="title">运费：</b>
										</div>
									</td>
									<td style="text-align: center;height: 30px;padding:0;font-weight: normal;">20'GP</td>
									<td style="text-align: center;height: 30px;padding:0;font-weight: normal;">40'GP</td>
									<td style="text-align: center;height: 30px;padding:0;font-weight: normal;">40'HQ</td>
								</tr>
								<tr>

									<td class="prRed" style="text-align: center;height: 60px;padding:0;font-size:20px;color:#ff540c;">$<g:if test="${data.prices && data.prices.gp20}">${data.prices.gp20}</g:if></td>
									<td class="prRed" style="text-align: center;height: 60px;padding:0;font-size:20px;color:#ff540c;">$<g:if test="${data.prices && data.prices.gp40}">${data.prices.gp40}</g:if></td>
									<td class="prRed" style="text-align: center;height: 60px;padding:0;font-size:20px;color:#ff540c;">$<g:if test="${data.prices && data.prices.hq40}">${data.prices.hq40}</g:if></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				</g:else>
				<tr>
					<td colspan="2">
						<div class="cell clearfix">
							<b class="title">附加费：</b> <b class="text"><g:if test="${data.prices && data.prices.extra}">${data.prices.extra}</g:if></b>
						</div>
					</td>
				</tr>
				
				<g:if test="${data.transType==TransportationType.Whole}">
				<tr>
					<td colspan="2">
						<div class="cell clearfix">
							<b class="title">限重：</b> <b class="text">${data.weightLimit}</b>
						</div>
					</td>
				</tr>
				</g:if>
				
				<tr>
					<td>
						<div class="cell clearfix">
							<b class="title">开船日：</b> <b class="text">${data.shippingDay}</b>
						</div> <b class="text"> <b> </b>
					</b>
					</td>
					<td>
						<div class="cell clearfix">
							<b class="title">船公司：</b> <b class="text">${data.shipCompany}
							</b>
						</div> <b class="text"> <b> </b>
					</b>
					</td>
				</tr>
				<tr>
					<td>
						<div class="cell clearfix">
							<b class="title">航程：</b> <b class="text">${data.shippingDays} 天</b>
						</div> <b class="text"> <b></b>
					</b>
					</td>
					<td>
						<div class="cell clearfix">
							<b class="title">中转港：</b> <b class="text">${data.middlePort}</b>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</g:if>

<%--
<div class="l">
<form id="myform" method="post">
<input type="hidden" id="infoId" name="infoId" value="${params.infoId}" />
<div class="release_single">
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
				<td style="width: 90px;">走货日期：</td>
				<td> <input
					type="text" name="startDate" id="startDate" value=""
					class="bd datepicker" maxlength="10"> - <input
					type="text" name="endDate" id="endDate" value=""
					class="bd datepicker" maxlength="10">&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
				<td style="width: 100px;">报价截至时间：</td>
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
				<td>运输种类：</td>
				<td>
					<select name="transType" id="transType" class="bd" onchange="changeTransType()">
						<option value="Whole" selected>整箱</option>
						<option value="Together">拼箱</option>
					</select>
				</td>
				<td><span id="TogetherRow3" style="display:none;">件数</span><span id="TogetherRow5">柜型</span>：</td>
				<td>
					<span id="TogetherRow4" style="display:none;"><input type="text" name="cargoNums" id="cargoNums" value="" class="bd" maxlength="10"></span>
					<span id="TogetherRow6">
						<select id="cargoBoxType" name="cargoBoxType" class="bd"  style="float:left;margin-top:5px;">
					  		<option value="">---请选择---</option> 
					   		<g:each in="${CargoBoxType.values()}" var="boxType">
					   		<option value="${boxType.name()}">${boxType.text}</option> 
					   		</g:each>
				  		</select>
				  		<span>
				  		<span id="cargoBoxUp" class="amount_up">+</span>
				  		<input type="text" id="cargoBoxNums" name="cargoBoxNums" value="1" class="amount_input" maxlength="3">
				  		<span id="cargoBoxDown" class="amount_down">-</span>
				  		</span>
					</span>
				</td>
			</tr>
			
			<tr id="TogetherRow1" style="display:none;">
				<td>毛重：</td>
				<td>
					<input type="text" name="cargoWeight" id="cargoWeight" value="" class="bd" maxlength="16">&nbsp;KG
				</td>
				<td>体积：</td>
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
					<textarea name="remark" id="remark" placeholder="写下您的真实需求，收到后我们会立即给您回电确认，免费帮您找最适合的货代。"></textarea>
				</td>
			</tr>
			
			<tr>
				<td><span style="color: red">*</span>公司名称：</td>
				<td>
					<input type="text" id="companyName" name="companyName" value="" class="bd2" maxlength="50">&nbsp;
				</td>
				<td><span style="color: red">*</span>地区：</td>
				<td>
					<select class="bd2"
						onfocus="closediv(1);" onclick="closediv(1);"
						id="sel_regions">
							<option id="region_name"></option>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<input type="hidden" value="" name="province_id"> 
					<input type="hidden" value="" name="city_id" id="city_id">
				</td>
			</tr>
			
			<tr>
				<td><span style="color: red">*</span>联系人：</td>
				<td>
					<input type="text" class="bd2" id="contactName" name="contactName"  maxlength="10">
				</td>
				<td><span style="color: red">*</span>联系手机：</td>
				<td>
					<input type="text" class="bd2" id="phone" class="text w2" name="phone"  maxlength="11" />
				</td>
			</tr>
			
			
		</table>
	</div>
</div>
</form>

<p class="tc" style="text-align:center;"><a href="javascript:void(0);" class="button" id="submit_purchase">委托找好船</a></p>
<p class="p3"><i></i>确认您发的找好船信息真实无误，否则不能发布！谢谢！</p>
</div>
<div class="r">

<img src="../images/biz/img.jpg" title="" alt="">
</div>
 --%>
</div>
</div>
</div>


<div class="Dwt" style="display: none;">
<p class="title_login" style="padding-left:20px;font-size:20px;">成功发布</p>
<div class="d" style="height:130px;">
<p><i></i>
 您的委托已受理，订单号&nbsp;&nbsp;<span id="purchase_sn" style="color:red;"></span>&nbsp;&nbsp;，工作人员将在1个工作日内联系您。</p>
<p style="text-align: center;margin-top: 10px;"><img alt="我知道了" src="../images/biz/dwt_btn.png" id="close_purchase_refresh"></p>
</div>
</div>

<div style="display: none;"><span id="selectedprovince"></span><span id="selectedcity"></span></div>
  	<div id="citydiv" style="display:none;z-index:10000; top:0; left:0; position:fixed; _display:none; width:100%; height:100%; background:#000; filter:alpha(opacity=30);background: rgba(0, 0, 0, 0.4)!important; ">
<div class="Ddz">
<p class="title"><a href="javascript:void(0);" id="cityclose" onclick="closediv(0);"><!--关闭--></a>&nbsp;&nbsp;&nbsp;&nbsp;请选择地址</p>
<p class="p1" style="margin-top:10px;"><b>A-G</b>
<a href="javascript:void(0);" onclick="selectcity(110000,&#39;北京&#39;,this);">北京</a>
<a href="javascript:void(0);" onclick="selectcity(340000,&#39;安徽&#39;,this);">安徽</a>
<a href="javascript:void(0);" onclick="selectcity(350000,&#39;福建&#39;,this);">福建</a>
<a href="javascript:void(0);" onclick="selectcity(440000,&#39;广东&#39;,this);">广东</a>
<a href="javascript:void(0);" onclick="selectcity(450000,&#39;广西&#39;,this);">广西</a>
<a href="javascript:void(0);" onclick="selectcity(500000,&#39;重庆&#39;,this);">重庆</a>
<a href="javascript:void(0);" onclick="selectcity(520000,&#39;贵州&#39;,this);">贵州</a>
<a href="javascript:void(0);" onclick="selectcity(620000,&#39;甘肃&#39;,this);">甘肃</a>
<a href="javascript:void(0);" onclick="selectcity(820000,&#39;澳门&#39;,this);">澳门</a>
</p>
<p class="p1" style="margin-top:10px;"><b>H-J</b>
<a href="javascript:void(0);" onclick="selectcity(130000,&#39;河北&#39;,this);">河北</a>
<a href="javascript:void(0);" onclick="selectcity(220000,&#39;吉林&#39;,this);">吉林</a>
<a href="javascript:void(0);" onclick="selectcity(230000,&#39;黑龙江&#39;,this);">黑龙江</a>
<a href="javascript:void(0);" onclick="selectcity(320000,&#39;江苏&#39;,this);">江苏</a>
<a href="javascript:void(0);" onclick="selectcity(360000,&#39;江西&#39;,this);">江西</a>
<a href="javascript:void(0);" onclick="selectcity(410000,&#39;河南&#39;,this);">河南</a>
<a href="javascript:void(0);" onclick="selectcity(420000,&#39;湖北&#39;,this);">湖北</a>
<a href="javascript:void(0);" onclick="selectcity(430000,&#39;湖南&#39;,this);">湖南</a>
<a href="javascript:void(0);" onclick="selectcity(460000,&#39;海南&#39;,this);">海南</a>
</p>
<p class="p1" style="margin-top:10px;"><b>L-S</b>
<a href="javascript:void(0);" onclick="selectcity(140000,&#39;山西&#39;,this);">山西</a>
<a href="javascript:void(0);" onclick="selectcity(150000,&#39;内蒙古&#39;,this);">内蒙古</a>
<a href="javascript:void(0);" onclick="selectcity(210000,&#39;辽宁&#39;,this);">辽宁</a>
<a href="javascript:void(0);" onclick="selectcity(310000,&#39;上海&#39;,this);">上海</a>
<a href="javascript:void(0);" onclick="selectcity(370000,&#39;山东&#39;,this);">山东</a>
<a href="javascript:void(0);" onclick="selectcity(510000,&#39;四川&#39;,this);">四川</a>
<a href="javascript:void(0);" onclick="selectcity(610000,&#39;陕西&#39;,this);">陕西</a>
<a href="javascript:void(0);" onclick="selectcity(630000,&#39;青海&#39;,this);">青海</a>
<a href="javascript:void(0);" onclick="selectcity(640000,&#39;宁夏&#39;,this);">宁夏</a>
</p>
<p class="p1" style="margin-top:10px;"><b>T-Z</b>
<a href="javascript:void(0);" onclick="selectcity(120000,&#39;天津&#39;,this);">天津</a>
<a href="javascript:void(0);" onclick="selectcity(330000,&#39;浙江&#39;,this);">浙江</a>
<a href="javascript:void(0);" onclick="selectcity(530000,&#39;云南&#39;,this);">云南</a>
<a href="javascript:void(0);" onclick="selectcity(540000,&#39;西藏&#39;,this);">西藏</a>
<a href="javascript:void(0);" onclick="selectcity(650000,&#39;新疆&#39;,this);">新疆</a>
<a href="javascript:void(0);" onclick="selectcity(810000,&#39;香港&#39;,this);">香港</a>
</p>
<p class="p2"></p>
</div>
</div><div class="" style="display: none; position: absolute;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;"></div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div>

<div class="cargopubpage needtop needsearch"></div>

</body></html>