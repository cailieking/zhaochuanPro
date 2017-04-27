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
<link rel="stylesheet" type="text/css" href="/css/bootstrap-table.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<style type="text/css">
	#recList td{padding: 8px 12px;}
	#recList th{text-align: left;}
</style>
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="/js/bootstrap-table.js"></script>
<script src="/js/bootstrap.min.js"></script>

<script>
$(function() {
	$.ajax({
		url : SITE_URL + "user/index",
		type : "get",
		cache:false,
		dataType:'json', 
		success : function(rs) {
			if (rs.data) {
				$("#member_company_name").html(rs.data.user.companyName);
				$("#member_firstname").html(rs.data.user.firstname);
				$("#member_inVerifyNum").html(rs.data.inVerifyNum);
				$("#member_welcomeinfo").html(rs.data.user.firstname + "（" + rs.data.user.username + "）");
			}
		}
	});

});


function userDataLoadDone(userData) {
	if(userData.role == 'cargo'){ //货主，推荐航线
		$('.w960 .right').append('<p class="headtitle recBox" style="clear:both;margin-bottom:20px;display:none;">\
			<span>推荐航线</span>\
		</p>\
		<div class="row recBox" style="display:none;">\
			<div class="col-lg-12">\
				<div class="block">\
					<table id="recList"></table>\
				</div>\
			</div>\
		</div>');
		$('#recList').bootstrapTable({
			url : SITE_URL+'route/recommend',
			sidePagination : 'server', // client or server
			cache: false,
			sortable : false,
			search : false,
			showColumns : false,
			showRefresh : false,
			showToggle : false,
			pagination:false,
			idField: 'id',
			responseHandler : function(res) {
				var data = [];
				for(var i = 0; i < res.length; i++){
					if(!!res[i]){
						data.push(res[i]);
					}
				}
				if(data.length > 0){
					$('.recBox').show();
				}
		        return {
		            rows: data,
		            total: data.length
		        }
		    },
			columns : [
			{
				field : 'category',
				title : '航线'
			},{
				field : 'startPort',
				title : '起始港'
			}, {
				field : 'endPort',
				title : '目的港'
			}, {
				field : 'transType',
				title : '运输种类',
				formatter : function (value, row, index) {
					if(value == 'Whole'){
						return '整箱';
					}else if(value == 'Together'){
						return '拼箱';
					}else{
						return '-';
					}
				}
			}, {
				field : 'shippingDay',
				title : '开船日'
			}, {
				field : 'shippingDays',
				title : '航程'
			}, {
				field : 'id',
				title : '',
				formatter : function (value, row, index) {

					var companyName = row.companyName;
					var firstname = row.firstname;
					var mobile = row.mobile;
					var verified = row.verified;
					var contactInfo = "";
					if (verified) {
						contactInfo = [
										'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;margin-bottom:4px;" onmouseover="viewDetail(this)" onmouseout="hideDetail(this)" >',
										'&nbsp;&nbsp;联系方式', 
										'<div class="dt_oper_view_div dt_oper_view_div2 pos4" style="display: none;">',
										'<table>',
											'<tr><td class="td4">公司名称:</td><td title='+companyName+'><a class="td6">'+companyName+'</a></td></tr>',
											'<tr><td class="td4">联系人:</td><td title='+firstname+'><a class="td6">'+firstname+'</a></td></tr>',
											'<tr><td class="td4">联系电话:</td><td title='+mobile+'><a class="td6">'+mobile+'</a></td></tr>',
										'</table>',
						             	'</div>' ,
										'</div>'].join('');
					}
					
					return [
							contactInfo,
							'<a href="/member/cargo?infoId='+row.id+'&startPort='+row.startPort+'&endPort='+row.endPort+'&startPortCn=&endPortCn=" style="padding:0 8px" class="Button">我要发货</a>'
					].join('');
					
				}
			}]
		});


	}else if(userData.role == 'ship'){ //货代，推荐货盘
		$('.w960 .right').append('<p class="headtitle recBox" style="clear:both;margin-bottom:20px;display:none;">\
			<span>推荐货盘</span>\
		</p>\
		<div class="row recBox" style="display:none;">\
			<div class="col-lg-12">\
				<div class="block">\
					<table id="recList"></table>\
				</div>\
			</div>\
		</div>');
		$('#recList').bootstrapTable({
			url : SITE_URL+'route/recommend',
			sidePagination : 'server', // client or server
			cache: false,
			sortable : false,
			search : false,
			showColumns : false,
			showRefresh : false,
			showToggle : false,
			pagination:false,
			idField: 'id',
			responseHandler : function(res) {
				var data = [];
				for(var i = 0; i < res.length; i++){
					if(!!res[i]){
						data.push(res[i]);
					}
				}
				if(data.length > 0){
					$('.recBox').show();
				}
		        return {
		            rows: data,
		            total: data.length
		        }
		    },
			columns : [
			{
				field : 'category',
				title : '航线'
			},{
				field : 'startPort',
				title : '起始港'
			}, {
				field : 'endPort',
				title : '目的港'
			}, {
				field : 'orderType',
				title : '货物类型'
			}, {
				field : 'transType',
				title : '运输种类',
				formatter : function (value, row, index) {
					if(value == 'Whole'){
						return '整箱';
					}else if(value == 'Together'){
						return '拼箱';
					}else{
						return '-';
					}
				}
			}, {
				field : 'shippingDays',
				title : '走货日期',
				formatter : function (value, row, index) {
					if(row.startDate != null ){
						return row.startDate.substr(5,5).replace('-','.') + ' - ' + row.endDate.substr(5,5).replace('-','.')
					}
				}
			}, {
				field : 'id',
				title : '',
				formatter : function (value, row, index) {
					var companyName = row.companyName;
					var firstname = row.firstname;
					var mobile = row.mobile;
					var verified = row.verified;
					var contactInfo = "";
					if (verified) {
						contactInfo = [
										'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;margin-bottom:4px;" onmouseover="viewDetail(this)" onmouseout="hideDetail(this)" >',
										'&nbsp;&nbsp;联系方式', 
										'<div class="dt_oper_view_div dt_oper_view_div2 pos4" style="display: none;">',
										'<table>',
											'<tr><td class="td4">公司名称:</td><td title='+companyName+'><a class="td6">'+companyName+'</a></td></tr>',
											'<tr><td class="td4">联系人:</td><td title='+firstname+'><a class="td6">'+firstname+'</a></td></tr>',
											'<tr><td class="td4">联系电话:</td><td title='+mobile+'><a class="td6">'+mobile+'</a></td></tr>',
										'</table>',
						             	'</div>' ,
										'</div>'].join('');
					}
					return [
							contactInfo,
							'<a href="/member/ship?orderId='+row.id+'&startPort='+row.startPort+'&endPort='+row.endPort+'&startPortCn=&endPortCn=" style="padding:0 8px" class="Button">我要报价</a>'
					].join('');

					
				}
			}]
		});
	}
	
}
</script>

</head>
<body>

	<div class="w960">
		<div class="right index">
			<div class="one">
				<p class="p1">
					<i></i>&nbsp;&nbsp;尊敬的&nbsp;<span id="member_welcomeinfo"></span>，欢迎来到找船网会员中心！
				</p>
				<p class="t" style="margin-bottom: 10px;">
					<i></i>用户信息
				</p>
				<p>
					<i class="ico1"></i>公司名称：<b><span id="member_company_name"></span></b>
				</p>
				<p>
					<i class="ico2"></i>联系人：<span id="member_firstname"></span>&nbsp;&nbsp;<span
						class="s"><i class="ico3"></i>正在处理的需求：<b
						style="color: #f90;"><span id="member_inVerifyNum"></span></b>条</span>
				</p>
			</div>
			<div class="two">
				<p>
					<img alt="交易热线" src="../images/member/trade_hot.jpg"
						style="margin: 0px;">
				</p>
			</div>


		</div>
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
	<div class="backpage needtop"></div>
</body>
</html>
<script>
function viewDetail(target) {
	$(target).find('.dt_oper_view_div').show();
}
function hideDetail(target) {
	$(target).find('.dt_oper_view_div').hide();
}
</script>
