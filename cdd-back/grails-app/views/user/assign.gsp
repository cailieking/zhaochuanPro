<!DOCTYPE>
<html>
<head>
<title>指派任务</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">指派任务</div>
			<form action="${request.contextPath}/user/assignTo" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='指派任务'>
						将${data.firstname}的所有任务指派给 <input type="text" name="username" style="margin: 5px 0;" /> (请填入用户名, 例如：guyuanjun)
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%></body>
</html>