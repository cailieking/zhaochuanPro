<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/news/news.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
</head>
<body>
	<div align="center">
		<span style="font-size: 20">新闻类: ${map.articleType} <!--  没有效果
		 <g:if test="${map.articleType.equals('Transportation')}">交通</g:if>  
		<g:if test="${map.articleType=='Company'}">公司</g:if>  
		<g:if test="${map.articleType=='ForeignTrade'}">外贸</g:if> 
		 -->
		</span> <br />
		<hr />
		<% 
				int pagesize=map.pagesize ;
                int total=map.total;
				int curPages=map.curPage;
                int start=map.start;
                int end=map.end;
				int  pagesall=Math.ceil(total/pagesize);
                %>
		<g:each in="${map.list[start..end]}" var="d" status="i">

			<div class="${i%2==0?'odd':'edd' }"
				style="width: 700px; font-size: 30px">
				<div
					style="width: 640px; float: left; text-align: left; font-size: 15px">
					<a target="_blank" href="/article/data?id=${d.id }"> ${d.title}
					</a>
				</div>
				<div style="width: 48px; float: left;">
					${
								d.dateCreatedStr
							}
				</div>
			</div>
			<br />
		</g:each>
		<br /> <a
			href="/news/articleList1?type=ftlist&curPage=<%=curPages-1>=0?curPages-1:curPages%>">上一页</a>&nbsp;&nbsp;
		当前页[${curPages+1}]&nbsp;&nbsp;&nbsp;<a
			href="/news/articleList1?type=ftlist&curPage=<%=curPages+1>=pagesall?pagesall-1:curPages+1%>">下一页</a>
		&nbsp;&nbsp;&nbsp;go<input id="pagenum" type="text" 
			size="1" style="border: 1px solid green" />页 <input type="button"
			value="go" onclick="go()"/> &nbsp;&nbsp;&nbsp;共${pagesall}页
		<script>
			function go() {
				var page = $("#pagenum").val();
				window.location.href = "/news/articleList1?type=ftlist&curPage="
						+(page-1)
			}
		</script>
	</div>
	<br />
	<br />
	<div class="newspage needtop needsearch"></div>
</body>
</html>