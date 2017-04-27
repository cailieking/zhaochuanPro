<%@page import="com.cdd.base.constant.SpringSecurityConstant"%>
<%@page import="com.cdd.base.domain.Requestmap"%>
<!DOCTYPE>
<html>
<head>
<title>菜单信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="role/data.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">菜单信息</div>
			<form action="${request.contextPath}/menu/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='名称'>
						<input type="text" name="name" value="${data.name}" placeholder="名称"/>
					</formTable:tr>
					<formTable:tr title='父节点'>
						<select name="parentId">
							<option value="">--请选择--</option>
							<g:each in="${parentCandidates}" var="parent">	
								<g:if test="${parent.id == data.parent?.id}">
									<option value="${parent.id}" selected="selected">${parent.name}</option>
								</g:if>
								<g:else>
									<option value="${parent.id}">${parent.name}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='链接'>
						<select name="mapId">
							<option value="">--请选择--</option>
							<g:each in="${Requestmap.findAllByAuthorityNotEqual(SpringSecurityConstant.AUTH_PERMIT_ALL)}" var="map">	
								<g:if test="${map.id == data.map?.id}">
									<option value="${map.id}" selected="selected">${map.uri}</option>
								</g:if>
								<g:else>
									<option value="${map.id}">${map.uri}</option>
								</g:else>
							</g:each>
						</select>&nbsp;&nbsp;<a href="${request.contextPath}/authority/data/new">添加权限</a>
					</formTable:tr>
					<formTable:tr title='图标名称'>
						<input type="text" name="icon" value="${data.icon}" placeholder="图标名称"/>
					</formTable:tr>
					<formTable:tr title='显示顺序'>
						<input type="text" name="orders" value="${data.orders}" placeholder="显示顺序"/>
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