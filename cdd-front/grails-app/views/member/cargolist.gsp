<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap-table.css">
<link rel="stylesheet" type="text/css"
	href="../css/font-awesome/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<style>
#select-hd-modal table thead th{
	padding: 10px 0;
	text-align: center;
	vertical-align: middle;
}
#select-hd-modal table{
	border: 1px solid #e5e5e5;
}
.right .Button{font-size:12px;}
</style>
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script>
var huodaiInfoCache = {};
$(function() {
	
	var statusSelect = $([
  		'<span style="float:right; margin: 0 10px;">状态：<select id="query_status" class="selectpicker" >',
  		'<option value="">全部</option>', 
  		<g:each in="${Status.values()}" var="status">
  		'<option value="${status.name()}">${status.text}</option>', 
  		</g:each>
   		<g:each in="${OrderStatus.values()}" var="status">
   		'<option value="${status.name()}">${status.text}</option>', 
   		</g:each>
  		'</select></span>' 
  	].join(''))

	                 	
	$('#list').bootstrapTable({
		url : SITE_URL+'order/myOrders',
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '搜索 起始港 | 目的港';
		},
		columns : [
         //{
   			//field : 'cargoName',
   			//title : '货物名称',
   			//sortable : true
   		//},
		{
			field : 'startPort',
			title : '起始港',
			sortable : true,
			formatter : function (value, row, index) {
				var startPort = row.startPort ? row.startPort : '';
				var startPortCn = row.startPortCn ? row.startPortCn : '';
				return [startPort+"<br />"+startPortCn];
			}
		}, {
			field : 'endPort',
			title : '目的港',
			sortable : true,
			formatter : function (value, row, index) {
				var endPort = row.endPort ? row.endPort : '';
				var endPortCn = row.endPortCn ? row.endPortCn : '';
				return [endPort+"<br />"+endPortCn];
			}
		}, {
			field : 'startDate',
			title : '走货日期',
			width: 95,
			sortable : true,
			formatter : function (value, row, index) {
				return [
					row.startDate?row.startDate:''
					//((row.startDate?row.startDate:'')+'至<br/>'+(row.endDate?row.endDate:''))
				].join('');
			}//,
		}, {
			field : 'id',
			title : '订单信息',
			//width : 70,
			formatter : function (value, row, index) {
				var startPort = row.startPort ? row.startPort : '';
				var endPort = row.endPort ? row.endPort : '';
				var cargoName = row.cargoName ? row.cargoName : '';
				var remark = row.remark ? row.remark : '';
				var cargoBoxType = row.cargoBoxType ? row.cargoBoxType : '';
				var cargoBoxNums = row.cargoBoxNums ? row.cargoBoxNums : '';
				var transType = row.transType ? row.transType : '';	
				var wholeStyle = transType == '整箱' ?  ""  : "display:none;";
				var togetherStyle = transType == '整箱' ? "display:none;" : "" ;
				var canScore = row.canScore ? row.canScore : '';
				var orderId = (row.info && row.info.orderId) ? row.info.orderId : '';
				var contactName = (row.info && row.info.contactName) ? row.info.contactName : '';
				var companyFullName = (row.info && row.info.companyFullName)  ? row.info.companyFullName : '';

				var shipInTimeVal = (row.info && row.info.score)  ? row.info.score.shipInTime : '';
				var docInTimeVal = (row.info && row.info.score)  ? row.info.score.docInTime : '';
				var infoInTimeVal = (row.info && row.info.score)  ? row.info.score.infoInTime : '';
				var serviceQualityVal = (row.info && row.info.score)  ? row.info.score.serviceQuality : '';
				var serviceContentVal = (row.info && row.info.score)  ? row.info.score.serviceContent : '';

				var scoreLink = ""
				var scoreButton = ""
				if (!shipInTimeVal) {
					scoreLink = '<span class="glyphicon glyphicon-star fa fa-star table-icon"></span>评分';
					scoreButton = '<span id="valScore'+orderId+'" style="padding-right:10px;color:red;"></span><input type="button" class="Button" id="submit_score" style="margin: 3px 0 3px 0" value="提交评分" onclick="submitScore('+orderId+')">'
				} else {
					scoreLink = '已评分'
					scoreButton = '<a style="color: red">已评分</a>'
				}
				
				var canScoreStyle = "";
				if (canScore != '1')  {
					canScoreStyle = 'visibility:hidden;';
				}

				var shipInTimeClass1 = shipInTimeVal == '1' ? ' class="rating-cur" ' : (shipInTimeVal == '' ? ' onclick="clickScore(this, \'shipInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var shipInTimeClass2 = shipInTimeVal == '2' ? ' class="rating-cur" ' : (shipInTimeVal == '' ? ' onclick="clickScore(this, \'shipInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var shipInTimeClass3 = shipInTimeVal == '3' ? ' class="rating-cur" ' : (shipInTimeVal == '' ? ' onclick="clickScore(this, \'shipInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var shipInTimeClass4 = shipInTimeVal == '4' ? ' class="rating-cur" ' : (shipInTimeVal == '' ? ' onclick="clickScore(this, \'shipInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var shipInTimeClass5 = shipInTimeVal == '5' ? ' class="rating-cur" ' : (shipInTimeVal == '' ? ' onclick="clickScore(this, \'shipInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				
				var docInTimeClass1 = docInTimeVal == '1' ? ' class="rating-cur" ' : (docInTimeVal == '' ? ' onclick="clickScore(this, \'docInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var docInTimeClass2 = docInTimeVal == '2' ? ' class="rating-cur" ' : (docInTimeVal == '' ? ' onclick="clickScore(this, \'docInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var docInTimeClass3 = docInTimeVal == '3' ? ' class="rating-cur" ' : (docInTimeVal == '' ? ' onclick="clickScore(this, \'docInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var docInTimeClass4 = docInTimeVal == '4' ? ' class="rating-cur" ' : (docInTimeVal == '' ? ' onclick="clickScore(this, \'docInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var docInTimeClass5 = docInTimeVal == '5' ? ' class="rating-cur" ' : (docInTimeVal == '' ? ' onclick="clickScore(this, \'docInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');

				var infoInTimeClass1 = infoInTimeVal == '1' ? ' class="rating-cur" ' : (infoInTimeVal == '' ? ' onclick="clickScore(this, \'infoInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var infoInTimeClass2 = infoInTimeVal == '2' ? ' class="rating-cur" ' : (infoInTimeVal == '' ? ' onclick="clickScore(this, \'infoInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var infoInTimeClass3 = infoInTimeVal == '3' ? ' class="rating-cur" ' : (infoInTimeVal == '' ? ' onclick="clickScore(this, \'infoInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var infoInTimeClass4 = infoInTimeVal == '4' ? ' class="rating-cur" ' : (infoInTimeVal == '' ? ' onclick="clickScore(this, \'infoInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var infoInTimeClass5 = infoInTimeVal == '5' ? ' class="rating-cur" ' : (infoInTimeVal == '' ? ' onclick="clickScore(this, \'infoInTime'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');

				var serviceQualityClass1 = serviceQualityVal == '1' ? ' class="rating-cur" ' : (serviceQualityVal == '' ? ' onclick="clickScore(this, \'serviceQuality'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceQualityClass2 = serviceQualityVal == '2' ? ' class="rating-cur" ' : (serviceQualityVal == '' ? ' onclick="clickScore(this, \'serviceQuality'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceQualityClass3 = serviceQualityVal == '3' ? ' class="rating-cur" ' : (serviceQualityVal == '' ? ' onclick="clickScore(this, \'serviceQuality'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceQualityClass4 = serviceQualityVal == '4' ? ' class="rating-cur" ' : (serviceQualityVal == '' ? ' onclick="clickScore(this, \'serviceQuality'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceQualityClass5 = serviceQualityVal == '5' ? ' class="rating-cur" ' : (serviceQualityVal == '' ? ' onclick="clickScore(this, \'serviceQuality'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');


				var serviceContentClass1 = serviceContentVal == '1' ? ' class="rating-cur" ' : (serviceContentVal == '' ? ' onclick="clickScore(this, \'serviceContent'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceContentClass2 = serviceContentVal == '2' ? ' class="rating-cur" ' : (serviceContentVal == '' ? ' onclick="clickScore(this, \'serviceContent'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceContentClass3 = serviceContentVal == '3' ? ' class="rating-cur" ' : (serviceContentVal == '' ? ' onclick="clickScore(this, \'serviceContent'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceContentClass4 = serviceContentVal == '4' ? ' class="rating-cur" ' : (serviceContentVal == '' ? ' onclick="clickScore(this, \'serviceContent'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');
				var serviceContentClass5 = serviceContentVal == '5' ? ' class="rating-cur" ' : (serviceContentVal == '' ? ' onclick="clickScore(this, \'serviceContent'+orderId+'\')" onmouseover="showScore(this)" onmouseout="recoverScore(this)" ':'');

				return [
						'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;" onmouseover="viewDetail(this)" onmouseout="hideDetail(this)" > <span class="glyphicon glyphicon-eye fa fa-eye table-icon"></span>',
						'查看', 
						'<div class="dt_oper_view_div pos1" style="display: none;right:-319px;top:-120px;">',
						'<table>',
							'<tr><td class="td4">起始港:</td><td title='+startPort+'><a class="td1">'+startPort+'</a></td><td class="td0">目的港:</td><td title='+endPort+'><a class="td1">'+endPort+'</a></td><td class="td0">运输种类:</td><td><a class="td1">'+transType+'</a></td></tr>',
							'<tr><td class="td4">走货日期:</td><td colspan="3"><a class="td2">'+((row.startDate?row.startDate:'')+' 至 '+(row.endDate?row.endDate:''))+'</a></td><td class="td0">报价截至:</td><td><a class="td1">'+(row.biteEndDate?row.biteEndDate:'')+'</a></td></tr>',
							'<tr><td class="td4">货物名称:</td><td colspan="3" title='+cargoName+'><a class="td2">'+cargoName+'</a></td><td class="td0">货物类型:</td><td><a class="td1">'+(row.orderType?row.orderType:'')+'</a></td></tr>',
							'<tr style="'+togetherStyle+'"><td class="td4">件数:</td><td><a class="td1">'+(row.cargoNums?row.cargoNums:'')+'</a></td><td class="td0">毛重:</td><td><a class="td1">'+(row.cargoWeight?row.cargoWeight:'')+'</a></td><td class="td0">体积:</td><td><a class="td1">'+(row.cargoCube?row.cargoCube:'')+'</a></td></tr>',
							'<tr style="'+togetherStyle+'"><td class="td4">单位尺寸:</td><td colspan="5"><a class="td3">'+((row.cargoWidth?("宽"+row.cargoWidth+"CM   "):'')+(row.cargoHeight?("高"+row.cargoHeight+"CM   "):'')+(row.cargoLength?("长"+row.cargoLength+"CM   "):''))+'</a></td></tr>',
							'<tr style="'+wholeStyle+'"><td class="td4">柜型:</td><td colspan="5"><a class="td3">20GP: '+cargoBoxNums[0]+';40GP: '+cargoBoxNums[2]+';40HQ: '+cargoBoxNums[4]+';45HQ: '+cargoBoxNums[6]+'</a></td></tr>',
							'<tr><td class="td4">备注:</td><td colspan="5" title='+remark+'><a class="td3">'+remark+'</a></td></tr>',
						'</table>',
		             	'</div>' ,
						'</div>',

						'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;'+canScoreStyle+'" onmouseover="viewScore(this)" onmouseout="hideScore(this)" >',
						
						scoreLink,
						
						'<div class="dt_oper_view_div dt_oper_view_div2 pos3" style="display: none;">',

						'<input type="hidden" id="shipInTime'+orderId+'"  value="'+shipInTimeVal+'" />',
						'<input type="hidden" id="docInTime'+orderId+'"  value="'+docInTimeVal+'" />',
						'<input type="hidden" id="infoInTime'+orderId+'"  value="'+infoInTimeVal+'" />',
						'<input type="hidden" id="serviceQuality'+orderId+'"  value="'+serviceQualityVal+'" />',
						'<input type="hidden" id="serviceContent'+orderId+'"  value="'+serviceContentVal+'" />',
						
						'<table>',
							'<tr><td class="td5">货代公司:</td><td title='+companyFullName+'><a class="td6">'+companyFullName+'</a></td></tr>',
							'<tr><td class="td5"><a>联系人：</a></td><td><a class="td6">'+contactName+'</a></td></tr>',
							'<tr><td class="td5"><a>放舱效率：</a></td><td>',

							'<div class="compose-rating"><div class="rating-content">',
							'<span class="rating-star">',
							'<span class="star-1"><a href="javascript:void(0)" data-star-value="1" '+shipInTimeClass1+'>1</a></span>',
							'<span class="star-2"><a href="javascript:void(0)" data-star-value="2" '+shipInTimeClass2+'>2</a></span>',
							'<span class="star-3"><a href="javascript:void(0)" data-star-value="3" '+shipInTimeClass3+'>3</a></span>',
							'<span class="star-4"><a href="javascript:void(0)" data-star-value="4" '+shipInTimeClass4+'>4</a></span>',
							'<span class="star-5"><a href="javascript:void(0)" data-star-value="5" '+shipInTimeClass5+'>5</a></span>',
							'</span><span class="rating-result" ></span></div></div>',

							'</td></tr>',
							'<tr><td class="td5"><a>单证及时率：</a></td><td>',

							'<div class="compose-rating"><div class="rating-content">',
							'<span class="rating-star">',
							'<span class="star-1"><a href="javascript:void(0)" data-star-value="1" '+docInTimeClass1+'>1</a></span>',
							'<span class="star-2"><a href="javascript:void(0)" data-star-value="2" '+docInTimeClass2+'>2</a></span>',
							'<span class="star-3"><a href="javascript:void(0)" data-star-value="3" '+docInTimeClass3+'>3</a></span>',
							'<span class="star-4"><a href="javascript:void(0)" data-star-value="4" '+docInTimeClass4+'>4</a></span>',
							'<span class="star-5"><a href="javascript:void(0)" data-star-value="5" '+docInTimeClass5+'>5</a></span>',
							'</span><span class="rating-result" ></span></div></div>',
							
							'</td></tr>',
							'<tr><td class="td5"><a>性价比：</a></td><td>',
							
							'<div class="compose-rating"><div class="rating-content">',
							'<span class="rating-star">',
							'<span class="star-1"><a href="javascript:void(0)" data-star-value="1" '+infoInTimeClass1+'>1</a></span>',
							'<span class="star-2"><a href="javascript:void(0)" data-star-value="2" '+infoInTimeClass2+'>2</a></span>',
							'<span class="star-3"><a href="javascript:void(0)" data-star-value="3" '+infoInTimeClass3+'>3</a></span>',
							'<span class="star-4"><a href="javascript:void(0)" data-star-value="4" '+infoInTimeClass4+'>4</a></span>',
							'<span class="star-5"><a href="javascript:void(0)" data-star-value="5" '+infoInTimeClass5+'>5</a></span>',
							'</span><span class="rating-result" ></span></div></div>',
							
							'</td></tr>',
							'<tr><td class="td5"><a>付款速度：</a></td><td>',
							
							'<div class="compose-rating"><div class="rating-content">',
							'<span class="rating-star">',
							'<span class="star-1"><a href="javascript:void(0)" data-star-value="1" '+serviceQualityClass1+'>1</a></span>',
							'<span class="star-2"><a href="javascript:void(0)" data-star-value="2" '+serviceQualityClass2+'>2</a></span>',
							'<span class="star-3"><a href="javascript:void(0)" data-star-value="3" '+serviceQualityClass3+'>3</a></span>',
							'<span class="star-4"><a href="javascript:void(0)" data-star-value="4" '+serviceQualityClass4+'>4</a></span>',
							'<span class="star-5"><a href="javascript:void(0)" data-star-value="5" '+serviceQualityClass5+'>5</a></span>',
							'</span><span class="rating-result" ></span></div></div>',
							
							'</td></tr>',
							
							'<tr><td class="td5"><a>服务内容：</a></td><td>',
							
							'<div class="compose-rating"><div class="rating-content">',
							'<span class="rating-star">',
							'<span class="star-1"><a href="javascript:void(0)" data-star-value="1" '+serviceContentClass1+'>1</a></span>',
							'<span class="star-2"><a href="javascript:void(0)" data-star-value="2" '+serviceContentClass2+'>2</a></span>',
							'<span class="star-3"><a href="javascript:void(0)" data-star-value="3" '+serviceContentClass3+'>3</a></span>',
							'<span class="star-4"><a href="javascript:void(0)" data-star-value="4" '+serviceContentClass4+'>4</a></span>',
							'<span class="star-5"><a href="javascript:void(0)" data-star-value="5" '+serviceContentClass5+'>5</a></span>',
							'</span><span class="rating-result" ></span></div></div>',
							
							'</td></tr>',
							
							'<tr><td colspan="2" style="text-align:right;">',
							scoreButton,
							'</td></tr>',
						'</table>',


		             	'</div>' ,
						'</div>'
						
				].join('');
			}//,
			//events : operateEvents
		}, {
			field : 'info',
			title : '货代信息',
			width: 150,
			sortable : false,
			formatter : function (value, row, index) {
				//row.statusKey.name='InTrade';
				//row.recommendedInfos = [{'aaa':'aaa', 'bbb':'bbb', 'ccc':'ccc', 'ddd':'ddd', 'eee':'eee', 'fff':'fff'},{'aaa':'aaa1', 'bbb':'bbb1', 'ccc':'ccc1', 'ddd':'ddd1', 'eee':'eee1', 'fff':'fff1'},{'aaa':'aaa2', 'bbb':'bbb2', 'ccc':'ccc2', 'ddd':'ddd2', 'eee':'eee2', 'fff':'fff2'}];
				if(row.statusKey.name=='InTrade'){
					if(!!row.recommendedInfos && row.recommendedInfos.length > 0){
						huodaiInfoCache['o_' + row.id] = row.recommendedInfos;
						return '<a href="javascript:;" style="padding:0 5px" class="Button selectHdBtn" data-orderid="'+row.id+'">请选择货代公司</a>';
					}else{
						return '-';
					}
				}
				if (row.info) {
					var startPort = row.info.startPort ? row.info.startPort : '';
					var endPort = row.info.endPort ? row.info.endPort : '';
					var shipCompany = row.info.shipCompany ? row.info.shipCompany : '';
					var companyName = row.info.companyName ? row.info.companyName : '';
					var contactName = row.info.contactName ? row.info.contactName : '';
					var middlePort = row.info.middlePort ? row.info.middlePort : '';
					var routeName = row.info.routeName ? row.info.routeName : '';
					var companyFullName = row.info.companyFullName  ? row.info.companyFullName : '';
					
					return [
							'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;" onmouseover="viewDetail(this)" onmouseout="hideDetail(this)" >',
							companyName, 
							'<div class="dt_oper_view_div pos2" style="display: none;right:-200px;top:-120px;">',
							'<table>',
								'<tr><td class="td4">货代公司:</td><td colspan="5" title='+companyFullName+'><a class="td3">'+companyFullName+'</a></td></tr>',
								'<tr><td class="td4">联系人:</td><td colspan="5" title='+contactName+'><a class="td3">'+contactName+'</a></td></tr>',
								'<tr><td class="td4">起始港:</td><td title='+startPort+'><a class="td1">'+startPort+'</a></td><td class="td0">目的港:</td><td title='+endPort+'><a class="td1">'+endPort+'</a></td><td class="td0">船公司:</td><td title='+shipCompany+'><a class="td1">'+shipCompany+'</a></td></tr>',
								'<tr><td class="td4">运输种类:</td><td><a class="td1">'+(row.info.transType?row.info.transType:'')+'</a></td><td class="td0">开船日:</td><td><a class="td1">'+(row.info.shippingDay?row.info.shippingDay:'')+'</a></td><td class="td0">中转港:</td><td title='+middlePort+'><a class="td1">'+middlePort+'</a></td></tr>',
								'<tr><td class="td4">航线名称:</td><td colspan="3" title='+routeName+'><a class="td2">'+routeName+'</a></td><td class="td0">航程:</td><td><a class="td1">'+(row.info.shippingDays?row.info.shippingDays:'')+'</a></td></tr>',
							'</table>',
			             	'</div>' ,
							'</div>'
					].join('');
				}
			}//,
		}, {
			field : 'id',
			title : '相关文件',
			formatter : function (value, row, index) {
				var htmlList = [];
				if(!!row.bookingFilePath){
					htmlList.push('<p><a style="color:#6699FF;text-decoration:underline;" href="'+row.bookingFilePath+'" target="_blank">委托单</a></p>');
				}
				if(!!row.isoFilePath || !!row.certFilePath){
					htmlList.push('<p>')
					if(!!row.isoFilePath){
						htmlList.push('<a style="color:#6699FF;text-decoration:underline;" href="'+row.isoFilePath+'" target="_blank">I/S</a>&nbsp;&nbsp;');
					}
					if(row.statusKey.name=='CertPassed' && !!row.certFilePath){
						htmlList.push('<a style="color:#6699FF;text-decoration:underline;" href="'+row.certFilePath+'" target="_blank">凭证</a>');
					}
					htmlList.push('</p>')
				}
				if(htmlList.length == 0){
					htmlList.push('-');
				}
				return htmlList.join('');
			}
		}, {
			field : 'status',
			title : '状态',
			sortable : false
		}, {
			field : 'id',
			title : '操作',
			//width : 70,
			formatter : function (value, row, index) {
				/*
				未审核 UnVerify
				审核中 InVerify
				审核通过 VerifyPassed
				审核未通过 VerifyFailed
				----------------------
				交易未撮合  UnTrade
				交易撮合中 InTrade
				交易撮合成功 TradeSuccess
				交易关闭 CloseTrade
				凭证待上传 CertUnupload
				凭证待审核 CertUploaded
				凭证审核中 CertInVerify
				凭证审核不通过 CertFailed
				交易成功 CertPassed
				*/
				//row.statusKey.name='TradeSuccess';
				var operationArr = [];
				if(row.statusKey.name=='TradeSuccess'){
					operationArr.push('<a href="/member/bookingform?id='+row.id+'" style="padding:0 5px;margin-top:2px;" class="Button">填写委托单</a>');
				}
				if(row.statusKey.name=='UnVerify' || row.statusKey.name=='InVerify' || row.statusKey.name=='VerifyPassed' || row.statusKey.name=='VerifyFailed' || row.statusKey.name=='UnTrade' || row.statusKey.name=='InTrade' || row.statusKey.name=='TradeSuccess'){
					operationArr.push('<a href="javascript:;" data-orderid="'+row.id+'" style="padding:0 5px;margin-left:5px;margin-top:2px;" class="Button cancelOrderBtn">取消订单</a>');
				}
				if(operationArr.length == 0){
					operationArr.push('-');
				}
				return operationArr.join('');
			}
			//events : operateEvents
		}],
		queryParams: function (params) {
			params.status = $("#query_status").val()
			return params;
		}
		
	});

	$(".datatable-search-btn").after(statusSelect);
		statusSelect.change(function() {
		$(".datatable-search-btn").click()
	});
	
	
	iePlaceHolder();

});

function clickScore(target, shipValId) {
	$(target).parent().parent().find("a").removeClass("rating-cur");
	$(target).addClass("rating-cur");
	showScore(target);
	$("#"+shipValId).val($(target).attr("data-star-value"));
}

function showScore(target) {
	return;
	/*var score = $(target).attr("data-star-value");
	var scoreStr = "";
	switch(parseInt(score)) {
		case 5 : scoreStr = "很棒  "+score+"分"; break;
		case 4 : scoreStr = "满意  "+score+"分"; break;
		case 3 : scoreStr = "一般  "+score+"分"; break;
		case 2 : scoreStr = "失望  "+score+"分"; break;
		case 1 : scoreStr = "很差  "+score+"分"; break;
	}
	$(target).parent().parent().parent().find(".rating-result").html('<span style="color: red">'+scoreStr+'</span>');*/
}

function recoverScore(target) {
	var currentScore = $(target).parent().parent().find(".rating-cur");
	showScore(currentScore);
	$(target).parent().parent().parent().find(".rating-result").html('');
}

function viewDetail(target) {
	$(target).find('.dt_oper_view_div').show();
}
function hideDetail(target) {
	$(target).find('.dt_oper_view_div').hide();
}

function viewScore(target) {
	$(target).find('.dt_oper_view_div').show();
}
function hideScore(target) {
	$(target).find('.dt_oper_view_div').hide();
}

function submitScore(orderId) {

	var shipInTime = $("#shipInTime"+orderId).val();
	if (!shipInTime) {
		$("#valScore"+orderId).html("请给 放舱效率 评分");
		return;
	}
	var docInTime = $("#docInTime"+orderId).val();
	if (!docInTime) {
		$("#valScore"+orderId).html("请给 单证及时率 评分");
		return;
	}
	var infoInTime = $("#infoInTime"+orderId).val();
	if (!infoInTime) {
		$("#valScore"+orderId).html("请给 性价比 评分");
		return;
	}
	var serviceQuality = $("#serviceQuality"+orderId).val();
	if (!serviceQuality) {
		$("#valScore"+orderId).html("请给 付款速度 评分");
		return;
	}
	var serviceContent = $("#serviceContent"+orderId).val();
	if (!serviceContent) {
		$("#valScore"+orderId).html("请给 付款速度 评分");
		return;
	}
	$.ajax({
		url:SITE_URL+'cargoShipScore/saveCargoShipItemScore', 
		type:'post',         
		dataType:'json',  
		async: false,
		data :{shipInTime:shipInTime,docInTime:docInTime,infoInTime:infoInTime,serviceQuality:serviceQuality,serviceContent:serviceContent,orderId:orderId},
		success:function(rs){
			if(rs.status==1){
				alert("评分成功，感谢您的参与")
				location.reload();
			}else{
				alert(rs.msg);
			}
		}
	});
}
</script>

</head>
<body>
	<div class="w960">


		<div class="right my_buy">
			<p class="headtitle">
				<span>我的订单</span>
			</p>

			<div class="row">
				<div class="col-lg-12">
					<div class="block">
						<table id="list"></table>
						<br/>
					</div>
				</div>
				<br/>
			</div>
		</div>
	</div>
	<div class="aui_state_focus"
		style="position: absolute; left: -9999em; top: 305px; width: auto; z-index: 1987;">
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
													<div class="aui_title" style="cursor: move;">消息</div>
													<a class="aui_close" href="javascript:/*artDialog*/;">×</a>
												</div></td>
										</tr>
										<tr>
											<td class="aui_icon" style="display: none;"><div
													class="aui_iconBg" style="background: none;"></div></td>
											<td class="aui_main" style="width: auto; height: auto;"><div
													class="aui_content" style="padding: 20px 25px;">
													<div class="aui_loading">
														<span>loading..</span>
													</div>
												</div></td>
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

	<div class="modal fade" id="select-hd-modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" style="width:800px;">
			<div class="modal-content">
				<div class="modal-header">请选择货代公司</div>
				<div class="modal-body">
					<table class="table table-hover table-striped"></table>
				</div>
				<div class="modal-footer">
					<!-- <button type="button" class="btn btn-primary" id="select-hd-modal-change-btn">换一批</button> -->
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>


	<div class="backpage backcargolist needtop"></div>

<script>
(function(){
	//取消订单
	var isCancelIng = false;
	$('#list').on('click', '.cancelOrderBtn', function(){
		if(isCancelIng){
			return false;
		}
		if(!confirm('您确定要取消订单吗？')){
			return false;
		}
		var orderId = $(this).data('orderid');
		isCancelIng = true;
		$.ajax({
			url:SITE_URL+'order/cancel/'+orderId, 
			type:'post',         
			dataType:'json',  
			async: false,
			data :{},
			success:function(rs){
				if(rs.status==1){
					alert("取消订单成功");
					location.reload();
				}else{
					alert(rs.msg);
				}
			},
			error: function() {
				alert("系统繁忙，请重试");
			},
			complete: function() {
				isCancelIng = false;
			}
		});
		return false;
	});
})();

(function(){
	//选择货代
	$selectHdModal = $('#select-hd-modal');
	//$selectHdModalChangeBtn = $('#select-hd-modal-change-btn');
	$('#list').on('click', '.selectHdBtn', function(){
		var orderId = $(this).data('orderid');
		var hdList = huodaiInfoCache['o_' + orderId];
		if(!hdList){
			alert('暂时没有货代信息哦');
			return false;
		}
		var htmlList = [];
		htmlList.push('<thead>\
			<tr>\
				<th></th>\
				<th width="20%">优势航线</th>\
				<th>20\'GP</th>\
				<th>40\'GP</th>\
				<th>40\'HQ</th>\
				<th width="30%">附加费</th>\
				<th width="20%">特色服务</th>\
				<th width="10%">限重</th>\
				<th width="10%">船期</th>\
				<th>操作</th>\
			</tr>\
		</thead>');
		
		htmlList.push('<tbody>');
		for(var i = 0 ; i < hdList.length; i++){
			var item = hdList[i];
			item.prices = item.prices || {};
			htmlList.push('<tr>\
					<td>'+(i+1)+'</td>\
					<td>'+(!!item.recommendedRoutes ? item.recommendedRoutes.join('，') : '')+'</td>\
					<td>$'+(item.prices.gp20 || '')+'</td>\
					<td>$'+(item.prices.gp40 || '')+'</td>\
					<td>$'+(item.prices.hq40 || '')+'</td>\
					<td>'+(item.prices.extra || '')+'</td>\
					<td>'+(item.remark || '')+'</td>\
					<td>'+(item.weightLimit || '')+'</td>\
					<td>'+(item.shippingDay || '')+'</td>\
					<td><a href="javascript:;" data-orderid="'+orderId+'" data-hdid="'+item.id+'" class="btn btn-primary weiTuoBtn">委托</a></td>\
				</tr>');
		}
		htmlList.push('</tbody>');
		$selectHdModal.find('table').html(htmlList.join(''));
		//$selectHdModalChangeBtn.data('orderid', orderId);
		$selectHdModal.modal('show');
		return false;
	});
	
	//委托货代
	var isDoWTing = false;
	$selectHdModal.on('click', '.weiTuoBtn', function(){
		if(isDoWTing){
			return false;
		}
		if(!confirm('您确定选择该货代吗？')){
			return false;
		}
		isDoWTing = true;
		var orderId = $(this).data('orderid');
		var hdId = $(this).data('hdid');
		$.ajax({
			url:SITE_URL+'order/toDelegate/'+orderId, 
			type:'post',         
			dataType:'json',  
			async: false,
			data :{'infoId':hdId},
			success:function(rs){
				if(rs.status==1){
					alert("委托成功");
					location.reload();
				}else{
					alert(rs.msg);
				}
			},
			error: function() {
				alert("系统繁忙，请重试");
			},
			complete: function() {
				isDoWTing = false;
			}
		});
		return false;
	});

	//换一批
	/*$selectHdModalChangeBtn.click(function() {
		if(isDoWTing){
			return false;
		}
		if(!confirm('换一批需要等待交易员撮合哦，您确定要换一批吗？')){
			return false;
		}
		isDoWTing = true;
		var orderId = $selectHdModalChangeBtn.data('orderid');
		$.ajax({
			url:SITE_URL+'xxx/xxx', 
			type:'post',         
			dataType:'json',  
			async: false,
			data :{'orderId':orderId},
			success:function(rs){
				if(rs.status==1){
					alert("操作成功，请等待交易员撮合");
					location.reload();
				}else{
					alert(rs.msg);
				}
			},
			error: function() {
				alert("系统繁忙，请重试");
			},
			complete: function() {
				isDoWTing = false;
			}
		});
		return false;
	});*/
	
})();
</script>

</body>
</html>