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
.merchant-credit{
display: inline;
	width: 23px;
	height: 23px;
	padding: 5px;
}
.merchant-safty{
display: inline;
	width: 23px;
	height: 23px;
	position: relative;
	left: -5px;}

#special-offer-zone {
	width: 80%;
	margin: 0 auto;
	padding-top: 20px;
}

 
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
#list tr td{
  word-break:keep-all;
  white-space:nowrap;
  
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
				<span class="fcolor_0">货代公司信息</span>
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
  	var companyInput = $([
   		'<span style="float:right; margin: 0 10px;">',
   		'公司名称：<input type="text" id="companyName" name="companyName" style="display: inline; width: 300px; border:1px solid #3399EE" value=""/>',
   		'</span>' 
   	].join(''))
	                    	
	
	$('#list').bootstrapTable({
		url : SITE_URL + "company/list",
		sidePagination : 'server', // client or server
	    pageSize: 10,
		formatSearch : function() {
			return '';
		},
		 columns : [
								{
									field : "company_name",
									title : "公司名称",
									
								//   height:56,
								// formatter : function(value,row,index){
								/* var me = this;*/
								//  var chineseRe = /^[\u4E00-\u9FA5]+$/;
								//   var result = [];
								//      if(chineseRe.test(value)){ // 中文 深圳花心***公司
								//        result = value.match(/^[\u4E00-\u9FA5]{2,4}/); 
								//       // result.push("***公司");
								//result = result.join("") ;
								//      }else if(value.match(/^[a-zA-Z]{4,8}/)){ //英文  champion***Co., Ltd.
								//         result = value.match(/^[a-zA-Z]{4,8}/);
								//  result.push("***Co.,Ltd.");
								// result = result.join("");
								//      }else{
								//  	   result = value
								//         }
								//     return result;
								// }
								},
								{
									field : "advantage_route", //次字段根据是否是认证用户显示
									class : "a-b-c", //这儿只是增加一个标记，在onLoadSuccess中找到
									title : "优势航线",
									formatter:function(value,row,index){
										if(value && value.length > 9){
											return value.substring(0,10)+'...';
										}else{
											return value;
										}
									}

								},
								{
									field : "advance_service", //次字段根据是否是认证用户显示
									title : "特色服务",
									class : "a-b-c",
									formatter:function(value,row,index){
										if(value && value.length > 15){
                                           return value.substring(0,10) + '...';
										} else {
											return value;
										}
									}
								},
							//	{
								//	field : "hornest",
								//	title : "公司信誉",
								//	formatter : function(value, row, index) {
									//	var safety = row.safety, verified = row.verified, hornest = row.hornest, result = [], str = "";
										//if (verified) {
									//		str = "<div class='merchant-credit'><img src='images/company/verfied.png' title='认证用户'/></div>";// alt='找船网-认证商家'
										//	result.push(str);
									//	} else {
											
										//	result.push('-');
									//	}
										//if (hornest) {
										//	str = "<div class='merchant-credit'><img src='images/company/honest.png' title='诚信用户'/></div>";// alt='找船网-诚信商家'
										//	result.push(str);
									//	} else {
									//		
									//	}
									//	if (safety) {
										//	str = "<div class='merchant-safty'><img src='images/company/heart.png' title='信誉用户'/></div>";//alt='找船网-安全商家'
											//result.push(str);
									//	} else {
									//		
										//}
									//	return result.join('');
								//	}
							//	},
								{
									field : "city",
									title : "公司所在地"

								},
								{
									width : 100,
									field : "infoId",
									title : "",
									formatter : function(value, row, index) {
										var infoId = row.infoId ? row.infoId : '';

										var startDate = row.startDate ? row.startDate
												: '';
										var endDate = row.endDate ? row.endDate
												: '';
										var id = row.infoId ? row.infoId : '';
										return [ '<p class="sp_w60"><a href="/company/data?id='
												+ id
												+ '" class="supply_button" target="_blank">详情</a></p>' ]
												.join('');
									}
								} ],
		queryParams: function (params) {
			params.companyName = $("#companyName").val();
			return params;
		}
	});
 $(".datatable-search-input").hide();
 $(".datatable-search-btn").after(companyInput);
});




</script>

<div class="companypage needtop needsearch needservice"></div>
</body>
</html>