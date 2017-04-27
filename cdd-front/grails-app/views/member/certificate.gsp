<%@page import="com.cdd.base.enums.AgentType" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="/css/dialog.css">
<link rel="stylesheet" type="text/css" href="/css/member/member.css">
<style type="text/css">
*html { background-image:url(about:blank); background-attachment:fixed; }
* { padding: 0; margin: 0; }
body { font-family:Tahoma,arial,"宋体"; font-size:12px; color:#333; }
p{ margin:0; padding:0; }
a{ color:#333; text-decoration:none;}
a:hover{ text-decoration:underline;}
.father{position: relative;}
#citydiv{position: absolute;top:-150px; left:200px;display: none;}
.Ddz{background: #fff;width:580px; border:1px solid #448aca;}
.Ddz .title{ height:31px; border-bottom:1px solid #ddd; line-height:31px;}
.Ddz .title a{ float:right; width:31px; height:31px; background:url(/images/register/pic_admin_dzx.png) no-repeat 0 0;}
.Ddz .p1{ padding-left:20px; height:30px; line-height:22px;}
.Ddz .p1 a{ display:inline-block; width:50px; height:22px; line-height:22px; text-align:center; color:#06c;}
.Ddz .p1 a:hover{background:#08d; color:#fff;}
.Ddz .p1 b{ margin-right:5px; color:#f90;}
.Ddz .p1 .on{ background:#08d; color:#fff;}
.Ddz .p2{ margin:0 8px 10px; padding:8px; width:548px; border:1px solid #eee; line-height:24px;}
.Ddz .p2 a{ display:inline-block; width:auto; margin:5px 5px 5px 0; padding:0 3px; text-align:center;}
.Ddz .p2 a:hover{background:#08d; color:#fff;}
.Ddz .p2 .on{ background:#08d; color:#fff;}
input {vertical-align:middle;}

#license,#certificate,#firm_code{
  position:absolute;
  right:0;
  top:0;
  height:100%;
  opacity:0;
  filter:alpha(opacity=0);
  -ms-filter:"alpha(opacity=0)";
  cursor:pointer;
  
}
.credential{
padding:4px;
background:#448aca;
color:#fff;
font-size:14px;
font-family:'Microsoft YaHei','宋体';
border-radius:4px;
}
.upload-zone{
  position:relative;
  display:inline-block;
  zoom:1;
  cursor:pointer;
 
  vertical-aligh:middle;
}
.file-msg{
  padding:5px;
}
</style>
<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="/js/common.js"></script>
<script src="/js/dialog.js"></script>
<script src="/js/form.js"></script>
<script type="text/javascript">
$(function(){
    $.get(SITE_URL+"user/getaccount",function(rs)
    {
        if(rs.data)
        {
        	$('#mobile').val(rs.data.mobile);
        	$('#companyName').val(rs.data.companyName);
    		$('#email').val(rs.data.email);
 			$('#firstname').val(rs.data.firstname);
 			$('#city').val(rs.data.city);
 			$("#selectedprovince").html($("#pro_"+rs.data.city.pcode).html());
 			addtotext(rs.data.city.code,rs.data.city.name);
 			$('#address').val(rs.data.address);
 			$('#qq').val(rs.data.qq);
 			$('#phone').val(rs.data.phone);

 			var recList = rs.data.recommendedRoutes || [];
 			var valList = [];
 			for(var i = 0 ; i < recList.length; i++){
 				var $cb = $('#cb_' + recList[i]);
 				if($cb.length != 0){
 					$cb[0].checked = true;
 					valList.push(recList[i]);
 				}
 			}
 			$('#recommendedRoutes').val(valList.join(','));
        }
    });
    
    $('#member_submit').on("click",function()
    {
    	//var companyName=$.trim($("#companyName").val());
    	//var firstname=$.trim($("#firstname").val());
    	//var qq = $.trim($("#qq").val());
    	var b=$("#member_submit");
	     
		var workers=$.trim($("#workers").val());
		var regCapital=$.trim($("#regCapital").val());
		var type=$.trim($(("#type")).val());
		var city=$.trim($(("#city")).val());
		var file1=$.trim($(("#file1")).val());
		var file2=$.trim($(("#file2")).val());
		var file3=$.trim($(("#file3")).val());
		findCompany();
		if(!type){
    		$("#valiResult").css({"color":"red"}).html("<i></i>请选择公司类型");
    		$("#type").focus();
    		return false;
    	} else {
    		$("#valiResult").html("");
    	}
		if(!workers){
    		$("#valiResult").css({"color":"red"}).html("<i></i>请输入公司规模");
    		$("#workers").focus();
    		return false;
    	} else {
    		$("#valiResult").html("");
    	}
		if(!regCapital){
    		$("#valiResult").css({"color":"red"}).html("<i></i>请输入公司注册资本人");
    		$("#regCapital").focus();
    		return false;
    	} else {
    		$("#valiResult").html("");
    	}
	 

    	//*三证是否为空
		if(!file1){
    		$("#valiResult").css({"color":"red"}).html("<i></i>请上传营业执照");
    		$("#city").focus();
    		return false;
    	} else {
    		$("#valiResult").html("");
    	}
		if(!file2){
    		$("#valiResult").css({"color":"red"}).html("<i></i>请输入税务登记证");
    		$("#city").focus();
    		return false;
    	} else {
    		$("#valiResult").html("");
    	}
		if(!file3){
    		$("#valiResult").css({"color":"red"}).html("<i></i>请输入企业代码证");
    		$("#city").focus();
    		return false;
    	} else {
    		$("#valiResult").html("");
    	}
    	//if(!companyName){
    		//$("#valiResult").css({"color":"red"}).html("<i></i>请输入公司名称");
    		//$("#companyName").focus();
    		//return false;
    	//}else{
    		//if(companyName.length<4){
    			//$("#valiResult").css({"color":"red"}).html("<i></i>请正确填写公司名称");
    			//$("#companyName").focus();
    			//return false;
    		//} else {
    			//$("#valiResult").html("");
    		//}
    	//}
    	
    	//if(!firstname){
    	//	$("#valiResult").css({"color":"red"}).html("<i></i>请输入联系人");
    	//	$("#firstname").focus();
    	//	return false;
    	//} else {
    	//	$("#valiResult").html("");
    	//}

    	//if (!checkNumeric("qq") || qq.length < 5){
    	//	$("#valiResult").css({"color":"red"}).html("<i></i>QQ不正确");
    	///	$("#qq").focus();
    	//	return false;
    	//} else {
    	//	$("#qq").html("");
    	//}
    	
    	if (checkBlank("email") && !checkEmail("email")) {
    		$("#valiResult").css({"color":"red"}).html("<i></i>Email不正确");
    		$("#email").focus();
    		return false;
    	} else {
    		$("#email").html("");
    	}
        // if(!b.data("yu"))
        //     return;
	     b.css({background:'grey',display:'none'}) ;
	     $("#valiResult").css({"color":"red"}).html("亲，请耐心等待，图片上传中，正在提交...");
	   //  b.val("提交中...");
	  //   b.display='none';
      //   b.prop({disabled:'disabled'});
	     
  /****      $.post(SITE_URL+"company/save",$("#form_account").serialize(),function(rs)
        {
            if(rs.status<0)
            {
                alert(rs.msg);
            }
            else
            {   var submitEl = $('#member_submit');
                    submitEl.attr("disabled","disabled");
                    $('<span>成功提交认证，工作人员审核中...</span>').insertAfter("#member_submit");
                    submitEl.css({
                    background:''
                    })
             ///   $(".Dwt").show();
                 
            }
        },"json");  *******/
    });
});

$(function(){
	var validateImgSuffix = function(imgUrl){
		  if(!imgUrl)return;
		  var supportSuffix = ['jpg','png','jpeg'];
		//  var startPoint = imgUrl.lastIndexOf('\\');
		//  console.log(startPoint);
		  
		  var imgSuffix = imgUrl.match(/\.([a-zA-Z]+)$/)[1];
		  if(supportSuffix.indexOf(imgSuffix)== -1){
			  return false;
		  }
		  return true;
	}
	var showFileUploadMsg = function(file_ele,imgUrl){
		if(file_ele && file_ele instanceof jQuery){
			var isValid =  validateImgSuffix(imgUrl);
			var msg = '';
			var hasMsg = file_ele.parent('.upload-zone').find('.file-msg');
			hasMsg ? hasMsg.remove():'';
			if(isValid){
			   mgs = imgUrl.substring(imgUrl.lastIndexOf('\\')+1,imgUrl.length);//把上传成功的图片显示在上传按钮之后	
			   mgs = "<span class='file-msg' style='color:rgb(89, 223, 27)'>"+mgs+"</span>";
			} else{
	           mgs = "仅支持jpg、png、jpeg格式的图片";
	           alert('上传格式不正确，请重新上传')
	           mgs = "<span class='file-msg' style='color:red'>"+mgs+"</span>";
			}
			 $(mgs).insertAfter(file_ele);
			
		}
	}

	$(':file').change(function(evt){
		var targetFileEl = $(evt.target);
        //var uploadZoneEl = $('.upload-zone');
	    var fileValue = targetFileEl.val().trim();
	    showFileUploadMsg(targetFileEl,fileValue);
		
   })
})

function selectcity(pid,pname,_this){
    $(".p2").html("");
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
                $(".p2").html(inhtml);
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
}

function closediv(co){
    if(co){
        $("#citydiv").show(100);
        $("#sel_regions").attr("disabled","disabled");
    }
    else{
        $("#sel_regions").removeAttr("disabled");
        $("#citydiv").hide(100);
    }
}

function userDataLoadDone(userData) {
	if(userData.role == 'cargo'){ //货主，关注航线
		$('#gzhxTitle').html('关注航线：');
	}else if(userData.role == 'ship'){ //货代，优势货盘
		$('#gzhxTitle').html('优势航线：');
	}
}
function findCompany(){
  var  names=$("#companyName").val();
  $.post("/company/findCompany", {CompanyName:names},
		   function(data){
		     if(data.length>15){
		    	 $("#valiResult").css({"color":"red"}).html(data);
		    		return false;
			     }
		   });
}
</script>

</head>
<body>
	<div class="w960">
		<form id="form_account"  action="${request.contextPath}/company/save" method="post" id="dataForm" enctype="multipart/form-data">
			<div class="right account">
				<p class="headtitle">
					<span>公司认证 <em style="font-size:13px;color:#0000FF;">(*为必填项)</em></span>
				</p>
				<p>
					<span class="s">账号/移动电话：</span><input type="text" name="mobile"  readonly="readonly" id="mobile" class="text w3" maxlength="20"/>
				</p>
				<p>
					<span class="s">公司名称：</span><input type="text" name="companyName" id="companyName" class="text w3" maxlength="20" ></input>
				    <span id="companyNameDisplay"></span>
				</p>
				<p>
					<span class="s">公司 类型：</span> 
					   	<select name="type" class="selectpicker" id="type">
							<option value="">--请选择--</option>
							<g:each in="${AgentType.values()}" var="type">
									<option value="${type.name()}">${type.text}</option>
							</g:each>
						</select>
				</p>
				<p>
					<span class="s">公司规模：</span> <input type="text"/ id="workers" class="text w3"name="workers" maxlength="20"/>(人)<br/>
				</p>
				<p>
					<span class="s">公司资本：</span> <input type="text"/  id="regCapital" class="text w3"name="regCapital" maxlength="20"/>(万)<br/>
				</p>
				<p>
					<span class="s">固定电话：</span><input type="text" value=""
						class="text w3" name="phone" id="phone" maxlength="20">
				</p>
			<!--	<p>
								<span class="s">城市：</span>
				 <input type="text" class="text w3"name="city"/>（如：深圳）
				</p>    -->
				
					<span class="s">所在地址：</span>
		 	          <select class="text w4"
						onfocus="closediv(1);" onclick="closediv(1);" id="sel_regions" name="city" id="city">
						<option id="region_name" ></option>
					</select>    
					
					 <input type="text" class="text w5" value="" id="address" name="address" maxlength="60"/>
				</p>
				<%--新增加三个认证信息--%>
				
				<p>
					<span class="s">营业执照：</span>
					  <span class="upload-zone">
					   
					   <input type="file" class="text w3"   name="file1" id="file1">
					   <span class="file-msg" style="color:red">仅支持jpg、png、jpeg格式的图片</span>
					  </span>
				</p>
				<p>
					<span class="s">税务登记证：</span>
					<span class="upload-zone">
			 
					   <input type="file" class="text w3"    name="file2" id="file2">
					   <span class="file-msg" style="color:red">仅支持jpg、png、jpeg格式的图片</span>
					</span>
				</p>
				<p>
				<span class="s">企业代码证：</span>
				  <span class="upload-zone">
				   
				   <input type="file"  class="text w3"   name="file3" id="file3">
				   <span class="file-msg" style="color:red">仅支持jpg、png、jpeg格式的图片</span>
				  </span>  
				</p>
				<div style="height:70px;line-height:36px;">
					<span class="s" id="gzhxTitle">航线：</span>
					<div style="float:left;">
			            <input id="cb_MeiJia" type="checkbox" class="hxCheckbox" value="MeiJia" name="advancedRoute">&nbsp;<label for="cb_MeiJia">美加线　　　　</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="cb_OuDi" type="checkbox" class="hxCheckbox" value="OuDi" name="advancedRoute">&nbsp;<label for="cb_OuDi">欧地线　　　　　</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="cb_FeiZhou" type="checkbox" class="hxCheckbox" value="FeiZhou" name="advancedRoute">&nbsp;<label for="cb_FeiZhou">非洲线　</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="cb_ZhongNanMei" type="checkbox" class="hxCheckbox" value="ZhongNanMei" name="advancedRoute">&nbsp;<label for="cb_ZhongNanMei">中南美线</label>&nbsp;&nbsp;&nbsp;&nbsp;<br>
			            <input id="cb_YinBa" type="checkbox" class="hxCheckbox" value="YinBa" name="advancedRoute">&nbsp;<label for="cb_YinBa">中东印巴红海线</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="cb_YuanDong" type="checkbox" class="hxCheckbox" value="YuanDong" name="advancedRoute">&nbsp;<label for="cb_YuanDong">日韩港澳台远东线</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="cb_DongNanYa" type="checkbox" class="hxCheckbox" value="DongNanYa" name="advancedRoute">&nbsp;<label for="cb_DongNanYa">东南亚线</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="cb_AoXin" type="checkbox" class="hxCheckbox" value="AoXin" name="advancedRoute">&nbsp;<label for="cb_AoXin">澳新线</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input type="hidden" value="" name="recommendedRoutes" id="recommendedRoutes">
		            </div>
				</div>
				<p style="clear:both;margin: 20px 0 20px 110px;">
					<input type="submit" class="Button" id="member_submit"
						 value="提交认证"  data-yu="yu" >
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="valiResult"></span>
				</p>
				
				
				<div class="Dwt" style="display: none;">
					<p class="title_login" style="padding-left: 20px; font-size: 20px;">修改成功</p>
					<div class="d" style="height: 130px;">
						<p style="font-size: 16px;">
							<i></i><span style="color: red;">成功提交认证，工作人员审核中...</span>
						</p>
						<p style="text-align: center; margin-right: 25px; margin-top: 45px;">
							<input type="button" class="Button" id="close_purchase" value="关闭">	
						</p>
					</div>
				</div>
		
			</div>
			<div style="display: none;">
				<span id="selectedprovince"></span><span id="selectedcity"></span>
			</div>
			<div id="citydiv"
				style="display: none; z-index: 10000; top: 0; left: 0; position: fixed; _display: none; width: 100%; height: f100%; background: #000; filter: alpha(opacity = 30); background: rgba(0, 0, 0, 0.4) !important;">
				<input type="hidden" value="530000" name="province_id"> <input
					type="hidden" value="532900" name="city">
				<div class="Ddz">
					<p class="title">
						<a href="javascript:void(0);" id="cityclose"
							onclick="closediv(0);">
							<!--关闭-->
						</a>&nbsp;&nbsp;&nbsp;&nbsp;请选择地址
					</p>
					<p class="p1" style="margin-top: 10px;">
						<b>A-G</b> <a href="javascript:void(0);" id="pro_110000"
							onclick="selectcity(110000,&#39;北京&#39;,this);">北京</a> <a
							href="javascript:void(0);" id="pro_340000"
							onclick="selectcity(340000,&#39;安徽&#39;,this);">安徽</a> <a
							href="javascript:void(0);" id="pro_350000"
							onclick="selectcity(350000,&#39;福建&#39;,this);">福建</a> <a
							href="javascript:void(0);" id="pro_440000"
							onclick="selectcity(440000,&#39;广东&#39;,this);">广东</a> <a
							href="javascript:void(0);" id="pro_450000"
							onclick="selectcity(450000,&#39;广西&#39;,this);">广西</a> <a
							href="javascript:void(0);" id="pro_500000"
							onclick="selectcity(500000,&#39;重庆&#39;,this);">重庆</a> <a
							href="javascript:void(0);" id="pro_520000"
							onclick="selectcity(520000,&#39;贵州&#39;,this);">贵州</a> <a
							href="javascript:void(0);" id="pro_620000"
							onclick="selectcity(620000,&#39;甘肃&#39;,this);">甘肃</a> <a
							href="javascript:void(0);" id="pro_820000"
							onclick="selectcity(820000,&#39;澳门&#39;,this);">澳门</a>
					</p>
					<p class="p1" style="margin-top: 10px;">
						<b>H-J</b> <a href="javascript:void(0);" id="pro_130000"
							onclick="selectcity(130000,&#39;河北&#39;,this);">河北</a> <a
							href="javascript:void(0);" id="pro_220000"
							onclick="selectcity(220000,&#39;吉林&#39;,this);">吉林</a> <a
							href="javascript:void(0);" id="pro_230000"
							onclick="selectcity(230000,&#39;黑龙江&#39;,this);">黑龙江</a> <a
							href="javascript:void(0);" id="pro_320000"
							onclick="selectcity(320000,&#39;江苏&#39;,this);">江苏</a> <a
							href="javascript:void(0);" id="pro_360000"
							onclick="selectcity(360000,&#39;江西&#39;,this);">江西</a> <a
							href="javascript:void(0);" id="pro_410000"
							onclick="selectcity(410000,&#39;河南&#39;,this);">河南</a> <a
							href="javascript:void(0);" id="pro_420000"
							onclick="selectcity(420000,&#39;湖北&#39;,this);">湖北</a> <a
							href="javascript:void(0);" id="pro_430000"
							onclick="selectcity(430000,&#39;湖南&#39;,this);">湖南</a> <a
							href="javascript:void(0);" id="pro_460000"
							onclick="selectcity(460000,&#39;海南&#39;,this);">海南</a>
					</p>
					<p class="p1" style="margin-top: 10px;">
						<b>L-S</b> <a href="javascript:void(0);" id="pro_140000"
							onclick="selectcity(140000,&#39;山西&#39;,this);">山西</a> <a
							href="javascript:void(0);" id="pro_150000"
							onclick="selectcity(150000,&#39;内蒙古&#39;,this);">内蒙古</a> <a
							href="javascript:void(0);" id="pro_210000"
							onclick="selectcity(210000,&#39;辽宁&#39;,this);">辽宁</a> <a
							href="javascript:void(0);" id="pro_310000"
							onclick="selectcity(310000,&#39;上海&#39;,this);">上海</a> <a
							href="javascript:void(0);" id="pro_370000"
							onclick="selectcity(370000,&#39;山东&#39;,this);">山东</a> <a
							href="javascript:void(0);" id="pro_510000"
							onclick="selectcity(510000,&#39;四川&#39;,this);">四川</a> <a
							href="javascript:void(0);" id="pro_610000"
							onclick="selectcity(610000,&#39;陕西&#39;,this);">陕西</a> <a
							href="javascript:void(0);" id="pro_630000"
							onclick="selectcity(630000,&#39;青海&#39;,this);">青海</a> <a
							href="javascript:void(0);" id="pro_640000"
							onclick="selectcity(640000,&#39;宁夏&#39;,this);">宁夏</a>
					</p>
					<p class="p1" style="margin-top: 10px;">
						<b>T-Z</b> <a href="javascript:void(0);" id="pro_120000"
							onclick="selectcity(120000,&#39;天津&#39;,this);">天津</a> <a
							href="javascript:void(0);" id="pro_330000"
							onclick="selectcity(330000,&#39;浙江&#39;,this);">浙江</a> <a
							href="javascript:void(0);" id="pro_530000"
							onclick="selectcity(530000,&#39;云南&#39;,this);">云南</a> <a
							href="javascript:void(0);" id="pro_540000"
							onclick="selectcity(540000,&#39;西藏&#39;,this);">西藏</a> <a
							href="javascript:void(0);" id="pro_650000"
							onclick="selectcity(650000,&#39;新疆&#39;,this);">新疆</a> <a
							href="javascript:void(0);" id="pro_810000"
							onclick="selectcity(810000,&#39;香港&#39;,this);">香港</a>
					</p>
					<p class="p2"></p>
				</div>
			</div>
		</form>

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

		
	<div class="backpage backcertificate needtop"></div>

	</div>
<script>
(function(){
	$('.hxCheckbox').change(function(){
        var hxList = [];
        $('.hxCheckbox').each(function(){
            if($(this)[0].checked){
                hxList.push($(this).val());
            }
        });
        $('#recommendedRoutes').val(hxList.join(','));
    });
})();
 
</script>
</body>
</html>