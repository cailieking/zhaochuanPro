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
<link rel="stylesheet" type="text/css" href="../css/news/news.css">
<script src="../js/jquery.js"></script> 
<script src="../js/js.js"></script>
<script src="../js/common.js"></script> 
<script src="../js/dialog.js"></script>
<body>
	<div class="main"> 
		<div class="info"> 
			<div class="Text" style="min-height: 400px">
			<g:if test="${data}">
				<h1>${data.title}</h1>
				<p class="p1">
					发布日期：${new java.text.SimpleDateFormat('yyyy-MM-dd').format(data.lastUpdated)}&nbsp;&nbsp;来源：${data.comes}
					<!--<a href="" target="_blank">我要评论</a>(0条评论)&nbsp;&nbsp;-->
					<!--<a href="" target="_blank">我要举报</a>&nbsp;&nbsp;-->
					<!--<span>分享到：</span>-->  
				</p>
				<div class="content">
					<p>
					${data.content?.encodeAsRaw()}
					</p>
				</div>
				<div class="disclaimer">
					<span>【免责声明】</span>
					<p>1、找船网发布此信息目的在于传播更多信息，与本网站立场无关。</p>
					<p>2、找船网不保证该信息（包括但不限于文字、数据及图表）全部或者部分内容的准确性、真实性、完整性、有效性、
						及时性、原创性等。</p>
					<p>3、相关信息并未经过本网站证实，不对您构成任何投资建议，据此操作，风险自担。</p>
					<p>4、如有侵权请直接与作者联系或书面发函至本公司转达、处理。</p>
				</div>
			</g:if>
			<g:else>
			</g:else>
			</div>
		</div>

	</div>
<div class="newspage needtop needsearch"></div>
</body>
</html>