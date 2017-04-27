<!DOCTYPE>
<html>
<head>
<title>权限信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="role/data.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">权限信息</div>
			<form action="${request.contextPath}/authority/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='权限值'>
						<input type="text" name="authority" value="${data.authority}" style="width:150%" placeholder="权限值"/>
					</formTable:tr>
					<formTable:tr title='链接'>
						<input type="text" name="url" value="${data.url}" style="width:150%" placeholder="连接"/>
					</formTable:tr>
					<formTable:tr title='名称'>
						<input type="text" name="description" value="${data.description}" placeholder="描述"/>
					</formTable:tr>
					<formTable:tr title='http method'>
						<input type="text" name="method" value="${data.method}" placeholder="method"/>
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