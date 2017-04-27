<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>找船网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/shiplist.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<style>

.content .title{
	color:#ff9900;
	font-weight:normal;
}
.port-area{
 height:35px;
 background:#ff9900;
 width:100%;
 border: 1px solid #ff9900;
}
.port-area .start_port,.port-area .end_port{
	display:inline-block;
	*display:inline;
	*zoom:1;
	width:380px;
	//border:1px solid red;
	height:35px;
	line-height:35px;
	color:#FEFEFE;
	font-size:18px;
	font-weight:700;

}
.port-area .start_port{
	text-align:right;
}
.port-area .end_port{

}
.port-area .arrowhead{
	display:inline-block;
	*display:inline;
	*zoom:1;
	width:120px;
	height:11px;
	background:url("../../../images/arrowhead.png") no-repeat;
}
.list_first{
width:90px;
height:65px;
text-align:right;
color:#777;


}
/***公共部分***/
.border_notop{
border:1px solid #d1d1d1;
border-top:none;
color:#777;

}
.commom_style{
display:inline-block;
*display:inline;
*zoom:1;
 font-weight:normal;
 margin-right:20px;
 width:80px;
 text-align:right;
 float:left;
}
.textLt{
text-align:left;
	
}

.list_commom{
	width:250px;
	text-align:center;
	color:#777;
}
.list_commom .box_style{
		padding:8px 0;
		font-size:18px;
		font-weight:bold;
		color:#6a6464;
}
.list_commom .box_price{
		color:#f00;
}

/**********/

/*****用户信息*****/
.message{
	width: 160px;
    height: 200px;
    vertical-align: top;
    text-align: right;
    font-size: 14px;
    color: #666;

}
.message>span{
    display: inline-block;
    *display: inline;
    *zoom: 1;
    margin-top: 15px;
    margin-right: 20px;
    color:#444;
}
.td-list-one{
 width: 130px;
    text-align: right;
    height: 50px;
    line-height: 50px;
    color: #666;
}
.td-list-one>b{
 color:red;
}
.td-list-one>span{
    margin-right: 35px;

}
.td-list-two{
    width: 400px;
    height: 50px;
}
.td-list-two>input{
    display: inline-block;
    *display: inline;
    *zoom: 1;
    width: 200px;
    height: 30px;
    border: 1px solid #b4b4b4;
    margin-top: 0px;
    margin-left: 3px;
    text-align:center;

}
.td-list-three{
    width: 150px;
    height: 200px;
    vertical-align: top;
    text-align: right;
    font-size: 14px;
    color: #666;
}
.td-list-three>span{
    display: inline-block;
    *display: inline;
    *zoom: 1;
    margin-top: 15px;
    margin-right: 40px;
}
.pallet_info{
	width:100%;
	padding:5px;
	//border:1px solid red;
}
.pallet_info .title{
	width:100%;
	height:25px;
	//border:1px solid red;
}
.pallet_info .title>li{
float:left;
}
.pallet_info .title_name{
	
    margin:0 auto;
    width:140px;
    height:26px;
    border:1px solid #d1d1d1;
    border-bottom:none;
    text-align:center;
    line-height:26px;
}
.pallet_info .containter{
	width:350px;
	height:27px;
	border-bottom:1px solid #d1d1d1
}
.introductions{
 	width: 530px;
 	margin:10px auto;
 	font-size: 13px;
    color:#48A2DA;
 	
}
.remark{
	width:100%;
}

.remark>textarea{
    padding: 10px;
    width: 500px;
    height: 68px;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #999;
    margin-left:200px;
    resize:none;

}
.suggestion{
	width:100%;
	height:30px;
	margin:20px 0 0 0;
}
.suggestion .title{
margin-left:200px;
}
.btn-area{
	width:100%;
	height:36px;	

}
.btn-area>a{
	display: block;
    *display: inline;
    *zoom: 1;
    width:100px;
    height:36px;
    margin:20px auto;
    background:url("../../../images/check_back_btn.png") no-repeat

}
</style>
</head>

<body>

<div class="w960">
	<div class=" right release_single">
		<div class="head-title">
			<b></b> 
			<span class="adds">询价管理</span> <span class="model">(查看)</span>
		</div>
		<div class="content">
			<h3>
				<span style="margin-left:5px">编号：</span>
			<b class="title">${cargoInfo.id}</b>
			</h3>
			<table>
				<tr>	
					<td class="port-area" colspan="4">
					<span class="start_port">${cargoInfo.startPort}</span>
					<b class="arrowhead"></b>
					<span class="end_port">${cargoInfo.endPort}</span>
					</td>			
				</tr>
				<tr style="border:1px solid #d1d1d1;width:887px">
						<td  class="list_first">运费：</td>
						<td class="list_commom">
							<div class="box_style">20GP</div>
							<div class="box_price">$<g:if test="${cargoInfo.prices && cargoInfo.prices.gp20}">
											${cargoInfo.prices.gp20}
										</g:if></div>
						</td>
						<td class="list_commom">
							<div class="box_style">40GP</div>
							<div class="box_price">$<g:if test="${cargoInfo.prices && cargoInfo.prices.gp40}">
											${cargoInfo.prices.gp40}
										</g:if></div>
						</td>
						<td class="list_commom">
							<div class="box_style">40HQ</div>
							<div class="box_price">$<g:if test="${cargoInfo.prices && cargoInfo.prices.hq40}">
											${cargoInfo.prices.hq40}
										</g:if></div>
						</td>
					</tr>
				<tr>
						<td  class="list_first border_notop"  style="height:39px;border-right:none;">有效期：</td>
						<td class="list_commom border_notop" style="border-left:none">${startDate}- ${endDate}</td>
						<td class="list_commom border_notop">
							<b class="commom_style">船期：</b>
							<span class="commom_style textLt">${cargoInfo.shippingDay}</span>
						</td>
						<td class="list_commom border_notop">
							<b class="commom_style">航程：</b>
							<span class="commom_style textLt">${cargoInfo.shippingDays}天</span>
						</td>
				</tr>
				<tr>
					<td  class="list_first border_notop"  style="height:39px;border-right:none;">船公司：</td>
					<td class="list_commom border_notop" style="border-left:none">${cargoInfo.shipCompany}</td>
					<td class="list_commom border_notop">
						<b class="commom_style">运输类型：</b>
						<span class="commom_style textLt">${cargoInfo.transType.text}</span>
					</td>
					<td class="list_commom border_notop">
						<b class="commom_style">限重：</b>
						<span class="commom_style textLt">${cargoInfo.weightLimit?cargoInfo.weightLimit:"---"}</span>
					</td>
				</tr>
				<tr>
					<td  class="list_first border_notop"  style="height:39px;border-right:none;">中转港：</td>
					<td class="list_commom border_notop" style="border-left:none;border-left:none;border-right:none">${cargoInfo.middlePort}</td>
					<td  colspan="2"  style="border-right:1px solid #d1d1d1;border-bottom:1px solid #d1d1d1;">	
					</td>
					
				</tr>
				<tr>
					<td  class="list_first border_notop"  style="height:39px;border-right:none;">附加费：</td>
					<td class="list_commom border_notop " style="border-left:none;" colspan="3">
						<span  style="float:left;width:100%;text-align:center"><g:if test="${cargoInfo.prices && cargoInfo.prices.extra}">
										${cargoInfo.prices.extra}
									</g:if></span>			
					</td>
					
					
				</tr>
				<tr style="height:90px">
					<td  class="list_first border_notop"  style="height:39px;border-right:none;">备注：</td>
					<td class="list_commom border_notop " style="border-left:none;" colspan="3">
						<span  style="float:left;width:100%;text-align:center">${cargoInfo.remark}</span>			
					</td>
					
					
				</tr>
			
			</table>
			<div>
				<h3 style="margin-top: 20px;">询价信息</h3>
					<table width="100%" style="margin-top: 10px;" id="common-input">
					<tr>
						<td rowspan="4" class="message"><span>询价人详情:</span></td>
						<td class="td-list-one"><b></b> <span>姓名:</span></td>
						<td class="td-list-two"><input type="text" name="userName" value="${inquerprice.contactMan}"/>
						</td>
						<td rowspan="4" class="td-list-three">
							<!-- <span>使用注册信息，将自动为您填写您的个人信息</span> -->
						</td>
					</tr>
					<tr>
						<td class="td-list-one"><b></b> <span>公司名称:</span></td>
						<td class="td-list-two"><input type="text" name="companyName" value="${inquerprice.companyName}"/>
						</td>
					</tr>
					<tr>
						<td class="td-list-one"><b></b> <span>联系电话:</span></td>
						<td class="td-list-two"><input type="text" maxlength="11"
							name="mobile" value="${inquerprice.mobile}"/></td>
					</tr>
					<tr>
						<td class="td-list-one"><span>QQ号码:</span></td>
						<td class="td-list-two"><input type="text" name="qq" value="${inquerprice.qq}"/></td>
					</tr>
				</table>
			
			</div>
			<div class="pallet_info">
					<ul class="title">
						<li class="containter"></li>
						<li class="title_name">货盘描述</li>
						<li class="containter"></li>
					</ul>
					<div>
						<div class="introductions">
							<p>对货盘的总要信息进行简述，我们会根据您填写的信息，为您匹配报价，您还可以通过新增货盘进行询价。货盘的信息越详细，找到合适报价的几率就越高。赶快去发布新的货盘吧。</p>
						</div>
						<div class="remark">
							<textarea name="remark" id="" cols="120" rows="10" placeholder="例如货盘信息，起始港 目的港等信息" >${inquerprice.remark}</textarea>
						</div>
						<div>
							<div class="suggestion">
								<div class="title">处理意见：</div>
							</div>
							<div class="remark">
							<textarea name="remark" id="" cols="120" rows="10"  >${inquerprice.operateOpinion}</textarea>
							</div>
						</div>
						<div class="btn-area">
						  <a href="javascipt:void(0)" id="back"></a><%--  查看页面的按钮
						
						--%></div>
					</div>
			
			</div>
		</div>
	</div>	

</div>
<script>
	$(function(){
		var $backBtn =$("#back");
		var $inputEL =$("input");
		var $textarea =$("textarea");
		$inputEL .prop("disabled",true);
		$textarea .prop("disabled",true);
		$backBtn.click(function(){
			history.back();
		

			})
		

		})


</script>


<div class="" style="display: none; position: absolute;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;"></div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div>

<div class="backpage enquiryList needtop"></div>

</body></html>