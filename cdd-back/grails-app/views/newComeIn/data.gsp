<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>新增信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<div class="row">
	<div class="col-md-12">
		<div class="block">
			<form action="${request.contextPath}/newComeIn/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<input type="hidden" name="manual" value="true" />
				<formTable:table>
					<formTable:tr title='新增订单'>
						<input name="orders" type="text" value="${data.orders}" />
					</formTable:tr>
					<formTable:tr title='新增货代'>
						<input name="agent" type="text" value="${data.agent}" />
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>