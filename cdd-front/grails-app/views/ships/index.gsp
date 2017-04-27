<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/index/index.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap-table.css">
<link rel="stylesheet" type="text/css"
	href="../css/font-awesome/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="../css/biz/biz.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">
<style type="text/css">
.ui-datepicker-title {
	color: #555555;
}

.indexsearch, .logo_img2{
	margin-top: 36px;
}

.sear_head, .sear_inp {
	font-family: Arial;
	font-size: 13px;
}

.sear_head {
	height: 40px;
	line-height: 40px;
}
</style>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/biz/biz.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>
<body>
<div id="xhzysx" class="clearfix">
	<div class="xhzysx_content">
		<div class="content_theme">
			<h3 class="xhzysx_title">
				<span class="fcolor_0">运价查询</span>
			</h3>
		</div>
	</div>
</div>


<!-----现货资源列表-------->
<div id="xhzy_list" class="mar_t20">
	<div class="xhzy_list_content">
		<div class="content_top_xhzy_list">
			<div class="content_public_list">
				<div class="row">
					<div class="col-lg-12">
						<div class="block">


							<div class="marketCategory">
								<div id="filters">

									<div class="list" style="height:60px">
										<b class="textTit">箱型：</b>
										<div class="cateOneWrap">
											<div class="cateOneBox default-cate" >
												<ul id="whichTransType">
												<img src="/images/ajax-loader.gif" />
												</ul>
											</div>
											<a class="btnSlide" style="" href="javascript:void(0)"></a>
										</div>
									</div>
									<div class="list">
										<b class="textTit">起始港：</b>
										<div class="cateOneWrap">
											<div class="cateOneBox default-cate" >
												<ul id="fromTerminals">
												<img src="/images/ajax-loader.gif" />
												</ul>
											</div>
											<a class="btnSlide" style="" href="javascript:void(0)"></a>
										</div>
									</div>
									<div class="list">
										<b class="textTit">目的港：</b>
										<div id="toTerminalList" class="cateOneWrap">
											<div id="toTerminalABC" class="cateABC">
												<a href="javascript:void(0);"
													onclick="toTerminalCharSelect('A');">A</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('B');">B</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('C');">C</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('D');">D</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('E');">E</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('F');">F</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('G');">G</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('H');">H</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('I');">I</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('J');">J</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('K');">K</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('L');">L</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('M');">M</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('N');">N</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('O');">O</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('P');">P</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('Q');">Q</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('R');">R</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('S');">S</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('T');">T</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('U');">U</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('V');">V</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('W');">W</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('X');">X</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('Y');">Y</a> <a
													href="javascript:void(0);"
													onclick="toTerminalCharSelect('Z');">Z</a>
											</div>
											<div class="cateOneBox default-cate" >
												<ul id="toTerminals">
												<img src="/images/ajax-loader.gif" />
												</ul>
											</div>
											<a class="btnSlide" style="" href="javascript:void(0)"></a>
										</div>
									</div>
								</div>
							</div>


							<table id="list"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {

	var transType = $.getUrlVar("transType") ? decodeURI($.getUrlVar("transType")) : "Whole";
	var startPort = $.getUrlVar("startPort") ? decodeURI($.getUrlVar("startPort")) : "";
	var endPort = $.getUrlVar("endPort") ? decodeURI($.getUrlVar("endPort")) : "";
	var startDate = $.getUrlVar("startDate") ? decodeURI($.getUrlVar("startDate")) : "";
	var endDate = $.getUrlVar("endDate") ? decodeURI($.getUrlVar("endDate")) : "";
   
	var transTypeSelect = $([
   		'<span style="float:right; margin: 0 10px;" >运输种类：<select id="query_transType" class="selectpicker" >',
   		'<option value="Whole">整箱</option>', 
   		'<option value="Together">拼箱</option>', 
   		'</select></span>' 
   	].join(''))
   	
   	var portInput = $([
   		'<span style="float:right; margin: 0 10px;">',
   		'<input type="text" id="query_startPort" placeholder="起始港" class="form-control" style="display: inline; width: 150px;" value=""/>',
   		'  至  ',
   		'<input type="text" id="query_endPort" placeholder="目的港" class="form-control"  style="display: inline; width: 150px;" value=""/>',
   		'</span>' 
   	].join(''))
   	
  	var dateInput = $([
   		'<span style="float:right; margin: 0 10px;">',
   		'起止日期：<input type="text" id="query_startDate" class="bd datepicker form-control" style="display: inline; width: 150px;" value=""/>',
   		'  -  ',
   		'<input type="text" id="query_endDate" class="bd datepicker form-control" style="display: inline; width: 150px;" value=""/>',
   		'</span>' 
   	].join(''))
	                	
	$('#list').bootstrapTable({
		url : SITE_URL+'ship/list',
		sidePagination : 'server', // client or server
	    pageSize: 25,
		formatSearch : function() {
			return '';
		},
		columns : [{
			field : 'startPort',
			title : '起始港',
			sortable : true,
			'class': 'table_first_td',
			formatter : function (value, row, index) {
				var startPort = row.startPort ? row.startPort : '';
				var startPort = startPort.toUpperCase();
				var startPortCn = row.startPortCn ? row.startPortCn : '';
				var issueDayHtml = '';
				/*if(!isNaN(row.issueDaysAgo)){
					if(row.issueDaysAgo > 0){
						issueDayHtml = '<div class="issue_day">'+row.issueDaysAgo+'天之前</div>';
					}else if(row.issueDaysAgo == 0){
						issueDayHtml = '<div class="issue_day">今天</div>';
					}
				}*/
				return ["<span style=\"color:#0000FF;\">"+startPort+"<br />"+startPortCn+"</span>"+issueDayHtml];
			}
		}, {
			field : 'endPort',
			title : '目的港',
			sortable : true,
			formatter : function (value, row, index) {
				var endPort = row.endPort ? row.endPort : '';
				var endPort = endPort.toUpperCase();
				var endPortCn = row.endPortCn ? row.endPortCn : '';
				return ["<span style=\"color:#3366FF;\">"+endPort+"<br />"+endPortCn+"</span>"];
			}
		}
		, {
			field : 'pinServiceType',
			title : '服务类型',
			width : 90,
			sortable : false
		}, {
			field : 'cbm',
			title : 'CBM/USD',
			width : 90,
			sortable : false,
			formatter : function (value, row, index) {
				var cbm = row.cbm ? row.cbm : 0;
				return ["<span style=\"color:#ff540c;font-weight: bold;\">"+cbm+"</span>"];
			}
		}, {
			field : 'lowestCost',
			title : '最低消费',
			width : 90,
			sortable : false,
			formatter : function (value, row, index) {
				var lowestCost = row.lowestCost ? row.lowestCost : '';
				return ["<span style=\"color:#ff540c;font-weight: bold;\">"+lowestCost+"</span>"];
			}
		}
		, {
			field : 'gp20',
			title : '20\'GP',
			width : 90,
			sortable : true,
			formatter : function (value, row, index) {
				var gp20 = row.gp20 ? row.gp20 : '--';
				return ["<span style=\"color:#ff540c;font-weight: bold;\">"+gp20+"</span>"];
			}
		}, {
			field : 'gp40',
			title : '40\'GP',
			width : 90,
			sortable : true,
			formatter : function (value, row, index) {
				var gp40 = row.gp40 ? row.gp40 : '--';
				return ["<span style=\"color:#ff540c;font-weight: bold;\">"+gp40+"</span>"];
			}
		}, {
			field : 'hq40',
			title : '40\'HQ',
			width : 90,
			sortable : true,
			formatter : function (value, row, index) {
				var hq40 = row.hq40 ? row.hq40 : '--';
				return ["<span style=\"color:#ff540c;font-weight: bold;\">"+hq40+"</span>"];
			}
		}, {
			field : 'middlePort',
			title : '中转',
			sortable : false,
			formatter : function (value, row, index) {
				var middlePort = row.middlePort ? row.middlePort : '';
				var middlePortCn = row.middlePortCn ? row.middlePortCn : '';
				if(middlePort == ''){
					return ['--'];
				}else{
					return [middlePort+"<br />"+middlePortCn];
				}
			}
		}, {
			field : 'shipCompany',
			title : '船公司',
			width : 90,
			sortable : false,
			formatter : function (value, row, index) {
				var shipCompany = row.shipCompany ? row.shipCompany : '--';
				return [shipCompany];
			}
		}, {
			field : 'shippingDays',
			title : '航程',
			sortable : false,
			formatter : function (value, row, index) {
				var shippingDays = row.shippingDays ? row.shippingDays : '--';
				return [shippingDays];
			}
		}, {
			field : 'shippingDay',
			title : '船期',
			width : 90,
			sortable : false
		}, /*{
			field : 'companyName',
			title : '公司信誉',
			width : 120,
			sortable : false,
			formatter : function (value, row, index) {
				var companyName = row.companyName ? row.companyName : '';
				var companyFullName = row.companyFullName ? row.companyFullName : '';
				var contactName = row.contactName ? row.contactName : '';

				var avgScore = row.score.avgScore ? row.score.avgScore : '-';
				var hornest = row.score.hornest ? 'margin: 5px 3px;display:inline-block;' : 'display: none;';
				var safety = row.score.safety ? 'margin: 5px 3px;display:inline-block;' : 'display: none;';
				var verified = row.score.verified ? 'margin: 5px 3px;display:inline-block;' : 'display: none;';
				
				var avgScoreClass1 = avgScore < 2 ? ' class="rating-cur" ' : '';
				var avgScoreClass2 = avgScore >= 2 && avgScore < 3  ? ' class="rating-cur" ' : '';
				var avgScoreClass3 = avgScore >= 3 && avgScore < 4  ? ' class="rating-cur" ' : '';
				var avgScoreClass4 = avgScore >= 4 && avgScore <= 4.5   ? ' class="rating-cur" ' : '';
				var avgScoreClass5 = avgScore > 4.5  ? ' class="rating-cur" ' : '';
				
				var avgScoreHtml = (avgScore != '-') ? [
					'<div class="compose-rating-single">',
					'<span class="rating-star-single"></span>',
					'<span class="rating-star-score">'+avgScore+'分</span></div>'
				].join('') : ((!row.score.hornest && !row.score.safety && !row.score.verified) ? avgScore : "");
				
				var xinyu = 
					[
					avgScoreHtml,
					'<img src="/images/index/cheng.jpg" width="20" height="20" title="诚信" style="' + hornest + '" />',
					'<img src="/images/index/xin.jpg" width="20" height="20" title="保障" style="' + safety + '" />',
					'<img src="/images/index/zheng.jpg" width="20" height="20" title="认证用户" style="' + verified + '" />'
					].join('');
				
				return [
					xinyu
				].join('');
			}//,
		}, */ {
			field : 'endDate',
			title : '截止日期',
			sortable : false,
			width : 150,
			formatter : function (value, row, index) {
				 /*  var issueDayHtml = '';
				if(!isNaN(row.issueDaysAgo)){
					if(row.issueDaysAgo > 0){
						issueDayHtml = '<span style="font-size:12px;">'+row.issueDaysAgo+'天之前</span>';
					}else if(row.issueDaysAgo == 0){
						issueDayHtml = '<span style="font-size:12px;">今天</span>';
					}
				} 
				 
				return [issueDayHtml];
			}*/
			    var endDateHtml = '';
			    if(row.endDate){
			    	endDateHtml = '<span style="font-size:12px;">'+row.endDate+'</span>';
			    }else{
			     	endDateHtml =  '<span style="font-size:12px;">--</span>';
			    }
				return [endDateHtml];
			}
						
		}, {
			field : 'id',
			title : '',
			width : 148,
			formatter : function (value, row, index) {
				var infoId = row.infoId ? row.infoId : '';
				var startPort = row.startPort ? row.startPort : '';
				var endPort = row.endPort ? row.endPort : '';
   				var startPortCn = row.startPortCn ? row.startPortCn : '';
				var endPortCn = row.endPortCn ? row.endPortCn : '';
				var startDate = row.startDate ? row.startDate : '';
				var endDate = row.endDate ? row.endDate : '';
				return [
					'<p class="sp_w60"><a href="/publish/findship?infoId='+infoId+'&startPort='+startPort+'&endPort='+endPort+'&startPortCn='+startPortCn+'&endPortCn='+endPortCn+'" class="supply_button" target="_blank">详细信息</a><a href="/ships?startPort='+startPort+'&endPort='+endPort+'" class="more_button" style="width:38px;margin-left:8px;">更多</a></p>'
				].join('');
			}//,
			//events : operateEvents
		}],
		queryParams: function (params) {
			if ($("#query_transType").length > 0) {
				params.transType = $("#query_transType").val();
			} else {
				params.transType = transType;
			}
			if ($("#query_startPort").length > 0) {
				params.startPort = $("#query_startPort").val();
			} else {
				params.startPort = startPort;
			}
			if ($("#query_endPort").length > 0) {
				params.endPort = $("#query_endPort").val();
			} else {
				params.endPort = endPort;
			}
			if ($("#query_startDate").length > 0) {
				params.startDate = $("#query_startDate").val();
			} else {
				params.startDate = startDate;
			}
			if ($("#query_endDate").length > 0) {
				params.endDate = $("#query_endDate").val();
			} else {
				params.endDate = endDate;
			}
			return params;
		},
		onLoadSuccess: function (data) {
			var transTypeVal = $("#query_transType").val();
			if (transTypeVal == 'Whole') {
				$("#list thead").find("tr th").eq(2).hide();
				$("#list thead").find("tr th").eq(3).hide();
				$("#list thead").find("tr th").eq(4).hide();
				$("#list thead").find("tr th").eq(5).show();
				$("#list thead").find("tr th").eq(6).show();
				$("#list thead").find("tr th").eq(7).show();
				
				$("#list tbody tr").each(function(){
					$(this).find("td").eq(2).hide();
					$(this).find("td").eq(3).hide();
					$(this).find("td").eq(4).hide();
					$(this).find("td").eq(5).show();
					$(this).find("td").eq(6).show();
					$(this).find("td").eq(7).show();
				});
				
			} else {
				$("#list thead").find("tr th").eq(2).show();
				$("#list thead").find("tr th").eq(3).show();
				$("#list thead").find("tr th").eq(4).show();
				$("#list thead").find("tr th").eq(5).hide();
				$("#list thead").find("tr th").eq(6).hide();
				$("#list thead").find("tr th").eq(7).hide();
				
				$("#list tbody tr").each(function(){
					$(this).find("td").eq(2).show();
					$(this).find("td").eq(3).show();
					$(this).find("td").eq(4).show();
					$(this).find("td").eq(5).hide();
					$(this).find("td").eq(6).hide();
					$(this).find("td").eq(7).hide();
				});
			}
		}
	});

	$(".datatable-search-input").hide();
	$(".datatable-search-btn").after(transTypeSelect);
	$(".datatable-search-btn").after(portInput);
	$(".datatable-search-btn").after(dateInput);

	$("#query_transType").val(transType);
	$("#query_startPort").val(startPort);
	$("#query_endPort").val(endPort);
	$("#query_startDate").val(startDate);
	$("#query_endDate").val(endDate);
	
	$(".datepicker").datepicker({
		yearRange: "2015:+10"
	});
		
	iePlaceHolder();
});

function viewDetail(target) {
	$(".Dwt").show();
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

function toTerminalCharSelect(word) {
	$("#toTerminals").find("li a").each(function(){
		if (word) {
		   if ($(this).html().indexOf(word) == 0) {
			   $(this).parent().show();
		   } else {
			   $(this).parent().hide();
		   }
		} else {
		   $(this).parent().show();
		}
	});

	$("#toTerminalABC").find("a").each(function(){
	   if ($(this).html() == word) {
		   $(this).css("color", "#3399EE");
	   } else {
		   $(this).css("color", "#666666");
	   }
	});
}

if ($(".backpage").length < 1) {
	var startPort = $.getUrlVar("startPort") ? decodeURI($.getUrlVar("startPort")) : "";
	var endPort = $.getUrlVar("endPort") ? decodeURI($.getUrlVar("endPort")) : "";
   var transType = $.getUrlVar("transType") ? decodeURI($.getUrlVar("transType")):"";
    /** 航线分类 ****/
    $.ajax(
    {
        url:SITE_URL+'route/list',
        type:"get",
        success:function(rs)
        {
          var rss=new Array("整箱","拼箱") 
           var rssv=new Array("Whole","Together") 
  	         if (rss) {
        		var transTypeArr = new Array(); 
				for (var i=0; i < rss.length; i++) {
					transTypeArr.push('<li><a href="/ships?transType=');
					transTypeArr.push(rssv[i]);
					!!endPort && transTypeArr.push('&endPort='+endPort);
					!!startPort && transTypeArr.push('&startPort='+startPort);
					transTypeArr.push('">');
					transTypeArr.push(rss[i]);
					transTypeArr.push('</a></li>');
				}
				$("#whichTransType").html(transTypeArr.join(""));
            }
        
        	if (rs.startPortList) {
        	 
        		var startPortArr = new Array(); 
				for (var i=0; i < rs.startPortList.length; i++) {
					var route = rs.startPortList[i];
					startPortArr.push('<li><a href="/ships?startPort=');
					startPortArr.push(route.port);
					!!endPort && startPortArr.push('&endPort='+endPort);
					!!transType &&  startPortArr.push('&transType='+transType);
					startPortArr.push('">');
					startPortArr.push(route.port);
					startPortArr.push('</a></li>');
				}
				$("#fromTerminals").html(startPortArr.join(""));
            }

           	if (rs.endPortList) {
        		var endPortArr = new Array(); 
				for (var i=0; i < rs.endPortList.length; i++) {
					var route = rs.endPortList[i];
					endPortArr.push('<li><a href="/ships?endPort=');
					endPortArr.push(route.port);
					!!startPort && endPortArr.push('&startPort='+startPort);
				    !!transType && endPortArr.push('&transType='+transType);
					endPortArr.push('">');
					endPortArr.push(route.port);
					endPortArr.push('</a></li>');
				}
				$("#toTerminals").html(endPortArr.join(""));
        		toTerminalCharSelect('A');
            }
        }
    })
} 

$(".btnSlide").click(
	function(){
		if ($(this).hasClass("btnUp")) {
			$(this).removeClass("btnUp");
			$(this).prev().height("84px");
			$(this).prev().css("overflow-y", "hidden");
		} else {
			$(this).addClass("btnUp");
			$(this).prev().height("112px");
			$(this).prev().css("overflow-y", "auto");
		}
		
	}
)
</script>

<div class="shippage needtop needsearch needservice"></div>
</body>
</html>