<%@page import="com.cdd.base.domain.BackUser"%>
<!DOCTYPE>
<html>
<head>
<title>角色信息</title>
<meta name="layout" content="main">
<asset:javascript src="jquery.multi-select.js" />
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="role/data.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">角色信息</div>
			<form action="${request.contextPath}/role/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='角色名'>
						<input type="text" name="name" value="${data.name}" placeholder="角色名"/>
					</formTable:tr>
					<formTable:tr title='描述'>
						<input type="text" name="description" value="${data.description}" placeholder="描述"/>
					</formTable:tr>
					<formTable:tr title='用户列表'>
						<select id="userIds" multiple="multiple" name="userIds">
							<g:each in="${BackUser.all}" var="user">
								<g:if test="${user in data.users}">
									<option value="${user.id}" selected="selected">${user.username} (${user.firstname})</option>
								</g:if>
								<g:else>
									<option value="${user.id}">${user.username} (${user.firstname})</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='权限列表'>
						<select id="mapIds" multiple="multiple" name="mapIds">
							<g:each in="${allReqeustmap}" var="map">
								<g:if test="${map.used}">
									<option value="${map.id}" selected="selected">${map.description} (${map.uri})</option>
								</g:if>
								<g:else>
									<option value="${map.id}">${map.description} (${map.url})</option>
								</g:else>
							</g:each>
						</select>
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
--%><script>
	$('#userIds').add($("#mapIds")).multiSelect();
</script>
</body>
</html>