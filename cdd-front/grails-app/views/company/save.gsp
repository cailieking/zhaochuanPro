<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="layout" content="main"/>
<title>Insert title here</title>
</head>
<body style="align:center">
  <div class="body" >

 <form name=loading> 
　<p align=center> <font color="#0066ff" size="2">  三证上传成功正在跳转，请稍等........ </font><font color="#0066ff" size="2" face="Arial">...</font>
　　<input type=text name=chart size=46 style="font-family:Arial; font-weight:bolder; color:#0066ff; background-color:#fef4d9; padding:0px; border-style:none;"> 
　　<input type=text name=percent size=47 style="color:#0066ff; text-align:center; border-width:medium; border-style:none;"> 
　　<script>　 
var bar=0　 
var line="||"　 
var amount="||"　 
count()　 
function count(){　 
bar=bar+2　 
amount =amount + line　 
document.loading.chart.value=amount　 
document.loading.percent.value=bar+"%"　 
if (bar<99)　 
{setTimeout("count()",100);}　 
else　 
{window.location = "${request.contextPath}/member";}　 
}</script> 
　</p> 
</form> 
<p align="center"> 如果您的浏览器不支持跳转,<a style="text-decoration: none" href="${request.contextPath}/member"><font color="#FF0000">请点这里</font></a>.</p>
  </div>
</body>
</html>