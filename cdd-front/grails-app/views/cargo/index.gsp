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
				<span class="fcolor_0">货盘信息</span>
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

									<div class="list">
										<b class="textTit">起始港：</b>
										<div class="cateOneWrap">
											<div class="cateOneBox default-cate">
												<ul id="fromTerminals" >
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
											<div class="cateOneBox default-cate">
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

	var transType = $.getUrlVar("transType") ? decodeURI($.getUrlVar("transType")) : "";
	var startPort = $.getUrlVar("startPort") ? decodeURI($.getUrlVar("startPort")) : "";
	var endPort = $.getUrlVar("endPort") ? decodeURI($.getUrlVar("endPort")) : "";

	var transTypeSelect = $([
   		'<span style="float:right; margin: 0 10px;" >运输种类：<select id="query_transType" class="selectpicker" >',
   		'<option value="" selected>全部</option>', 
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
		url : SITE_URL+'order/list',
		sidePagination : 'server', // client or server
	    pageSize: 25,
		formatSearch : function() {
			return '';
		},
		columns : [{
			field : 'startPort',
			title : '起始港',
			sortable : true,
			formatter : function (value, row, index) {
				var startPort = row.startPort ? row.startPort : '';
				var startPortCn = row.startPortCn ? row.startPortCn : '';
				return ["<span style=\"color:#0000FF;\">"+startPort+"<br />"+startPortCn+"</span>"];
			}
		}, {
			field : 'endPort',
			title : '目的港',
			sortable : true,
			formatter : function (value, row, index) {
				var endPort = row.endPort ? row.endPort : '';
				var endPortCn = row.endPortCn ? row.endPortCn : '';
				return ["<span style=\"color:#0000FF;\">"+endPort+"<br />"+endPortCn+"</span>"];
			}
		}, {
			field : 'cargoName',
			title : '货物品名',
			sortable : true
		}, {
			field : 'endPort',
			title : '货量',
			sortable : false,
			formatter : function (value, row, index) {

				if (row.transType == '整箱') {
					return [
						row.cargoBoxNums,
						' * ',
						row.cargoBoxType
			        ].join('');
				} else {
					var arr = [];
					if(row.cargoNums) {
						arr.push(' 件数：');
						arr.push(row.cargoNums);
					}
					if(row.cargoWeight) {
						if(row.cargoNums) {
							arr.push(" / ")
						}
						arr.push(' 重量：');
						arr.push(row.cargoWeight);
						arr.push('KG');
					}
					if(row.cargoCube) {
						if(row.cargoWeight) {
							arr.push(" / ")
						}
						arr.push(' 体积：');
						arr.push(row.cargoCube);
						arr.push('CBM');
					}
					return arr.join('');
				}
			}//,
		}, {
			field : 'transType',
			title : '运输种类',
			sortable : false
		}, {
			field : 'id',
			title : '',
			width : 150,
			formatter : function (value, row, index) {
				var orderId = row.orderId ? row.orderId : '';
				var startPort = row.startPort ? row.startPort : '';
				var endPort = row.endPort ? row.endPort : '';
   				var startPortCn = row.startPortCn ? row.startPortCn : '';
				var endPortCn = row.endPortCn ? row.endPortCn : '';
				return [
					'<p class="sp_w60"><a href="/publish/findcargo?orderId='+orderId+'&startPort='+startPort+'&endPort='+endPort+'&startPortCn='+startPortCn+'&endPortCn='+endPortCn+'" class="supply_button" target="_blank">我要报价</a></p>'
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
			params.startDate = $("#query_startDate").val();
			params.endDate = $("#query_endDate").val();
			return params;
		}
	});

	$(".datatable-search-input").hide();
	$(".datatable-search-btn").after(transTypeSelect);
	$(".datatable-search-btn").after(portInput);
	$(".datatable-search-btn").after(dateInput);

	$("#query_transType").val(transType);
	$("#query_startPort").val(startPort);
	$("#query_endPort").val(endPort);

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
    /** 航线分类 ****/
    $.ajax(
    {
        url:SITE_URL+'route/list',
        type:"get",
        success:function(rs)
        {
        	if (rs.startPortList) {
        		var startPortArr = new Array(); 
				for (var i=0; i < rs.startPortList.length; i++) {
					var route = rs.startPortList[i];
					startPortArr.push('<li><a href="/cargo?startPort=')
					startPortArr.push(route.port)
					startPortArr.push('">')
					startPortArr.push(route.port)
					startPortArr.push('</a></li>');
				}
				$("#fromTerminals").html(startPortArr.join(""));
            }

           	if (rs.endPortList) {
        		var endPortArr = new Array(); 
				for (var i=0; i < rs.endPortList.length; i++) {
					var route = rs.endPortList[i];
					endPortArr.push('<li><a href="/cargo?endPort=')
					endPortArr.push(route.port)
					endPortArr.push('">')
					endPortArr.push(route.port)
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

<div class="cargopage needtop needsearch needservice"></div>
</body>
</html>