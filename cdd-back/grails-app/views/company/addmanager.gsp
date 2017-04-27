<%@page import="com.cdd.base.enums.AgentType"%>
<%@page import="com.cdd.base.domain.Role"%>
<!DOCTYPE>
<html>
<head>
<title>添加经理</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="block">
			<form action="${request.contextPath}/company/addmanager" method="post" id="dataForm">
				  <input type="hidden" name="id" id="ids"value="${params.id}" />
			手机：<input type="text" name="phone" id="phone"></input>
				 <input type="button" id="find" value="查询该经理人"/>
					 <br/>
					<div id="test"></div>
		    	</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">添加</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%><div>



</div>
<script> 
$("#find").click(function(){
	 var ids=$("#phone").val();
 
	 $.post('${request.contextPath}/company/findmanager',{id:ids}, function (data) { 
		      var datas=data.data;
             $("#test").html(datas); 
		 });
});
 </script>
<script>
 
</script>
</body>
</html> 