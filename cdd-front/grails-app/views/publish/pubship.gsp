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
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/form.js"></script>
<script src="../js/biz/biz.js"></script>
<script src="../js/jquery-ui.js"></script>

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
.Ddz .p1{ padding-left:20px; height:30px; line-height:22px; }
.Ddz .p1 a{ display:inline-block; width:43px; height:22px; line-height:22px; text-align:center; color:#06c;}
.Ddz .p1 a:hover{background:#08d; color:#fff;}
.Ddz .p1 b{ margin-right:5px; color:#f90;}
.Ddz .p1 .on{ background:#08d; color:#fff;}
.Ddz .p2{ margin:0 8px 10px; padding:8px; width:464px; border:1px solid #eee; line-height:24px;}
.Ddz .p2 a{ display:inline-block; width:auto; margin:5px 5px 5px 0; padding:0 3px; text-align:center;}
.Ddz .p2 a:hover{background:#08d; color:#fff;}
.Ddz .p2 .on{ background:#08d; color:#fff;}


/*release_single*/
.release_single .one{ padding:20px 0; float:left; width:666px; line-height:42px;}
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
.release_single textarea{padding:10px; width:550px; height:68px; border:1px solid #ddd; font-size:14px; color:#999;}
/*****release_single*****/


</style>
<script type="text/javascript">
$(function(){
	$(".datepicker").datepicker({
		yearRange: "2015:+10"
	});
	$("#shippingDay").datepicker({
		yearRange: "2015:+10"

	})
	$(".Dwt").find("#close_purchase_refresh").bind("click",function(){
	    $(".Dwt").hide();
	    location.href = "/publish/findcargo"
	});

	$('#submit_purchase').bind("click",function(){
	
		var startPort=$.trim($("#startPort").val());
		var endPort=$.trim($("#endPort").val());
		var startPortCn=$.trim($("#startPortCn").val());
		var endPortCn=$.trim($("#endPortCn").val());
		var shipCompany=$.trim($("#shipCompany").val());
		var transType=$.trim($("#transType").val());
		var shippingDay=$.trim($("#shippingDay").val());
		var startDate=$.trim($("#startDate").val());
		var endDate=$.trim($("#endDate").val());
		var gp20=$.trim($("#gp20").val());
		var gp40=$.trim($("#gp40").val());
		var hq40=$.trim($("#hq40").val());
		var hq45=$.trim($("#hq45").val());
		var cbm=$.trim($("#cbm").val());
		var lowestCost=$.trim($("#lowestCost").val());
		var extra=$.trim($("#extra").val());
		var routeName=$.trim($("#routeName").val());
		var shippingDays=$.trim($("#shippingDays").val());
		var middlePort=$.trim($("#middlePort").val());
		var middlePortCn=$.trim($("#middlePortCn").val());
		var remark=$.trim($("#remark").val());
		var orderId=$.trim($("#orderId").val());
		var weightLimit = $.trim($("#weightLimit").val());
		var pinServiceType = $.trim($("#pinServiceType").val());
		
		var companyName=$.trim($("#companyName").val());
		var contactName=$.trim($("#contactName").val());
		var phone=$.trim($("#phone").val());
		var orderId=$.trim($("#orderId").val());
		var city_id=$.trim($("#city_id").val());
		var province_id=$.trim($("input[name='province_id']").val());
		var flag=true;
	
	
		if(!startPort){
			$(".p3").css({"color":"red"}).html("<i></i>请输入起始港英文名");
			$("#startPort").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(!startPortCn){
			$(".p3").css({"color":"red"}).html("<i></i>请输入起始港中文名");
			$("#startPortCn").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(!endPort){
			$(".p3").css({"color":"red"}).html("<i></i>请输入目的港英文名");
			$("#endPort").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(!endPortCn){
			$(".p3").css({"color":"red"}).html("<i></i>请输入目的港中文名");
			$("#endPortCn").focus();
			return false;
		}else{
			$(".p3").html("");
		}
	
		var transTypeVal = $("#transType").val();
		
		if(transTypeVal == 'Whole' && !gp20 && !gp40 && !hq40 && !hq45){
			$(".p3").css({"color":"red"}).html("<i></i>请填写至少一种柜型运价");
			$("#gp20").focus();
			return false;
		}else{
			$(".p3").html("");
		}
	
		if (checkBlank("cbm") && !checkNumericMax2("cbm")) {
			$(".p3").css({"color":"red"}).html("<i></i>CBM请输入数字, 最多保留2位小数");
			$("#cbm").focus();
			return false;
		} else {
			$(".p3").html("");
		}
	
		if(lowestCost.length > 20){
			$(".p3").css({"color":"red"}).html("<i></i>最低消费不能超过20个字");
			$("#lowestCost").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		
		if (checkBlank("shippingDays") && !checkNumeric("shippingDays")) {
			$(".p3").css({"color":"red"}).html("<i></i>航程请输入整数数字");
			$("#shippingDays").focus();
			return false;
		} else {
			$(".p3").html("");
		}
	
		if (checkBlank("gp20") && !checkNumericMax2("gp20")) {
			$(".p3").css({"color":"red"}).html("<i></i>柜型运价请输入数字, 最多保留2位小数");
			$("#gp20").focus();
			return false;
		} else {
			$(".p3").html("");
		}
	
		if (checkBlank("gp40") && !checkNumericMax2("gp40")) {
			$(".p3").css({"color":"red"}).html("<i></i>柜型运价请输入数字, 最多保留2位小数");
			$("#gp40").focus();
			return false;
		} else {
			$(".p3").html("");
		}
	
		if (checkBlank("hq40") && !checkNumericMax2("hq40")) {
			$(".p3").css({"color":"red"}).html("<i></i>柜型运价请输入数字, 最多保留2位小数");
			$("#hq40").focus();
			return false;
		} else {
			$(".p3").html("");
		}
	
		if (checkBlank("hq45") && !checkNumericMax2("hq45")) {
			$(".p3").css({"color":"red"}).html("<i></i>柜型运价请输入数字, 最多保留2位小数");
			$("#hq45").focus();
			return false;
		} else {
			$(".p3").html("");
		}
	
		if(extra.length > 500){
			$(".p3").css({"color":"red"}).html("<i></i>附加费不能超过500个字");
			$("#extra").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		
		if(checkBlank("startDate") && !checkSimpleDate("startDate")){
			$(".p3").css({"color":"red"}).html("<i></i>有效期格式不正确");
			$("#startDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(checkBlank("endDate") && !checkSimpleDate("endDate")){
			$(".p3").css({"color":"red"}).html("<i></i>有效期格式不正确");
			$("#endDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(startDate > endDate) {
			$(".p3").css({"color":"red"}).html("<i></i>有效期开始日期不能大于结束日期");
			$("#startDate").focus();
			return false;
		}else{
			$(".p3").html("");
		}
		if(remark.length > 500){
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
		}else if(companyName.length<4){
			$(".p3").css({"color":"red"}).html("<i></i>请正确填写公司名称");
			$("#companyName").focus();
			return false;
		}
		$(".p3").html("");
			
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
				url:SITE_URL+'ship/issue', 
				type:'post',         
				dataType:'json',  
				async: false,
				data :{startPort:startPort,endPort:endPort,startPortCn:startPortCn,endPortCn:endPortCn,shipCompany:shipCompany,startDate:startDate,endDate:endDate,transType:transType,
					gp20:gp20,gp40:gp40,hq40:hq40,hq45:hq45,cbm:cbm,lowestCost:lowestCost,pinServiceType:pinServiceType,extra:extra,routeName:routeName,shippingDay:shippingDay,shippingDays:shippingDays,middlePort:middlePort,middlePortCn:middlePortCn,remark:remark,weightLimit:weightLimit,orderId:orderId,companyName:companyName,contactName:contactName,phone:phone,orderId:orderId,city_id:city_id,province_id:province_id},
				success:function(rs){
					if(rs.status==1){
						$(".Dwt").show();
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
		(".Dwt").hide();
	});
});

function changeTransType() {
	var transTypeVal = $("#transType").val();
	if (transTypeVal == 'Whole') {
	  $("#TogetherRow1").show();
	  $("#TogetherRow2").hide();
	  $("#TogetherRow3").show();
	  $("#TogetherRow4").hide();
	} else {
	  $("#TogetherRow1").hide();
	  $("#TogetherRow2").show();
	  $("#TogetherRow3").hide();
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
<p class="lct2"></p>
<form id="myform" method="post">
<input type="hidden" id="orderId" name="orderId" value="${params.orderId}" />
<div class="l">





		<div class="release_single">
				<div class="one">
					<input type="hidden" id="orderId" name="orderId" value="${params.orderId}" />
					<table>
						<tr>
							<td style="text-align: right;width:200px;"><span style="color: red">*</span>起始港：</td>
							<td><input type="text" name="startPort" id="startPort" value="${params.startPort}" class="bd3"
										maxlength="100" placeholder="英文名">
								<input type="text" name="startPortCn" id="startPortCn" value="${params.startPortCn}" class="bd3"
										maxlength="50" placeholder="中文名"></td>
							<td style="text-align: right;"><span style="color: red">*</span>目的港：</td>
							<td>
								<input type="text" name="endPort" id="endPort" value="${params.endPort}"
										class="bd3" maxlength="100" placeholder="英文名"> 
								<input type="text" name="endPortCn" id="endPortCn" value="${params.endPortCn}" class="bd3"
										maxlength="50" placeholder="中文名">
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">中转港：</td>
							<td><input type="text" name="middlePort" id="middlePort" value="" class="bd3"
										maxlength="100" placeholder="英文名">
								<input type="text" name="middlePortCn" id="middlePortCn" value="" class="bd3"
										maxlength="50" placeholder="中文名">		
							</td>	
							<td style="text-align: right;width:85px;">运输种类：</td>
							<td>
								<select name="transType" id="transType" class="bd" onchange="changeTransType()">
									<option value="">---请选择---</option>
									<option value="Whole">整箱</option>
									<option value="Together">拼箱</option>
								</select>
							</td>

						</tr>
						<tr>
							<td style="text-align: right;">船公司：</td>
							<td><input type="text" name="shipCompany" id="shipCompany" value="" class="bd2"
								maxlength="50"></td>
								

							<td style="text-align: right;">开船日：</td>
							<td>
								<input type="text" name="shippingDay" id="shippingDay" value="" class="bd2"
									maxlength="20">
							</td>
						</tr>	
						<tr>
							<td style="text-align: right;">航线名称：</td>
							<td><input type="text" name="routeName" id="routeName" value="" class="bd2"
										maxlength="50"></td>
							<td style="text-align: right;">航程：</td>
							<td><input type="text" name="shippingDays" id="shippingDays" value="" class="bd2"
								maxlength="5"></td>
						</tr>
						<tr id="TogetherRow3" style="display:none;">
							<td style="text-align: right;">柜型运价：</td>
							<td colspan="3">
								<input type="text" name="gp20" id="gp20" value="" class="bd"
										maxlength="10">&nbsp;美元/20'GP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" name="gp40" id="gp40" value="" class="bd"
										maxlength="10">&nbsp;美元/40'GP&nbsp;&nbsp;&nbsp;&nbsp;
								<br/>		
								<input type="text" name="hq40" id="hq40" value="" class="bd"
										maxlength="10">&nbsp;美元/40'HQ&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" name="hq45" id="hq45" value="" class="bd"
										maxlength="10">&nbsp;美元/45'HQ&nbsp;&nbsp;&nbsp;&nbsp;
								（<font color="red">至少填写一种柜型运价</font>）		
							</td>
						</tr>
						<tr id="TogetherRow1" style="display:none;">
							<td style="text-align: right;">限重：</td>
							<td colspan="3">
								<textarea name="weightLimit" id="weightLimit"></textarea>
							</td>
						</tr>
						<tr id="TogetherRow2" style="display:none;">
							<td style="text-align: right;">CBM：</td>
							<td>
								<input type="text" name="cbm" id="cbm" value="" class="bd"
										maxlength="10">
							</td>
							
							<td style="text-align: right;">最低消费：</td>
							<td>
								<input type="text" name="lowestCost" id="lowestCost" value="" class="bd2"
										maxlength="20">
							</td>
						</tr>
						
						<tr id="TogetherRow4" style="display:none;">
							<td style="text-align: right;">服务类型：</td>
							<td colspan="3" >
								<input type="text" name="pinServiceType" id="pinServiceType" value="" class="bd2"
										maxlength="20">
							</td>
						</tr>
						
						
						
						<tr>
							<td style="text-align: right;">附加费：</td>
							<td colspan="3">
								<textarea name="extra" id="extra"></textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">备注：</td>
							<td colspan="3">
								<textarea name="remark" id="remark" placeholder="写下您的真实需求，收到后我们会立即给您回电确认，免费帮您找最适合的货源。"></textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">有效期：</td>
							<td colspan="3"><input
								type="text" name="startDate" id="startDate" value=""
								class="bd datepicker" maxlength="10"> - <input
								type="text" name="endDate" id="endDate" value=""
								class="bd datepicker" maxlength="10">
							</td>
						</tr>
						
						
			<tr>
				<td style="text-align: right;"><span style="color: red">*</span>公司名称：</td>
				<td>
					<input type="text" id="companyName" name="companyName" value="" class="bd2" maxlength="50">&nbsp;
				</td>
				<td style="text-align: right;"><span style="color: red">*</span>地区：</td>
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
					<td style="text-align: right;"><span style="color: red">*</span>联系人：</td>
					<td>
						<input type="text" class="bd2" id="contactName" name="contactName"  maxlength="10">
					</td>
					<td style="text-align: right;"><span style="color: red">*</span>联系手机：</td>
					<td>
						<input type="text" class="bd2" id="phone" class="text w2" name="phone"  maxlength="11" />
					</td>
				</tr>
			
						
					</table>
				</div>
			</div>



<p class="tc" style="text-align:center;"><a href="javascript:void(0);" class="button" id="submit_purchase">委托找货</a></p>
<p class="p3"><i></i>确认您发的找货信息真实无误，否则不能发布！谢谢！</p>
</div>
</form>
<div class="r">
<img src="../images/biz/img.jpg" title="" alt="">
</div>
</div>
</div>
</div>


<div class="Dwt" style="display: none;">
<p class="title_login" style="padding-left:20px;font-size:20px;">发布成功</p>
<div class="d" style="height:130px;">
<p><i></i>您的委托已受理，工作人员将在1个工作日内联系您。</p>
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