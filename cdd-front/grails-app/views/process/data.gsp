<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<script src="../js/jquery.js"></script>
<script src="../js/common.js"></script>
<style type="text/css">
body {font-family:'Microsoft YaHei','宋体';}
#processDiv{text-align:center;margin:0 auto; width:400px; margin-top: 35px; margin-bottom: 60px;}
li {list-style-type:none;vertical-align:middle;text-align:center;}
.li1 {border:1px solid #FFA300; height: 26px; line-height: 26px;}
.li2 {height: 24px; line-height: 24px;}
.passed {background-color: #E2EDFF;}
.current {background-color: #FFEDE2;color: red; border:1px solid #FFA300;}
</style>
<script>
$(function() {
	$("#processUl").children().last().hide();
	var isOk = false;
	var resultId = '${data.resultId}'
	var chs = $("#processUl").children();	
	for (var i=0; i<chs.length;i++) {
		if ($(chs[i]).attr("id") < resultId) {
			$(chs[i]).addClass("passed");
		} else if ($(chs[i]).attr("id") == resultId) {
			$("#resultStr").html($(chs[i]).html());
			$(chs[i]).addClass("current");
		}
	}
});
</script>
<body>
<g:if test="${data && data.number}">
<div id="processDiv" >
<div style="text-align:center;">订单号（${data.number}）</div><div style="text-align:center;margin: 10px 0;">委托信息当前状态为： [ <font color="red" id="resultStr"></font> ]</div>
<ul id="processUl" >
<g:each in="${data.flow}" var="fl">
<li class="li1" id="${fl.key}">${fl.value}</li>
<li class="li2">↓</li>
</g:each>
</ul>
</div>
</g:if>
<g:else>
<div id="processDiv">
<font color="red">未查到此订单号</font>
</div>
</g:else>
<div class="needtop needsearch"></div>
</body>
</html>