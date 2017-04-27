<%@page import="com.cdd.base.enums.FrontUserType"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<%@page import="com.cdd.base.enums.Sex"%>
<g:set var="cityService" bean="cityService" />
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>导入用户信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
			<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">用户信息</div>
			<form action="${request.contextPath}/fakeFrontUser/update" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
				</div>
				<formTable:table>
					<formTable:tr title='用户名:'>
						<input type="text" name="username" value="${data.username}" placeholder="用户名" />
					</formTable:tr>
					<formTable:tr title='新密码（不输入则密码不变）:'>
						<input type="text" name="newPassword" placeholder=""/>
					</formTable:tr>
					<formTable:tr title='类型:'>
						<select name="type" class="selectpicker">
							<option value="">--请选择--</option>
							<g:each in="${FrontUserType.values()}" var="type">
								<g:if test="${data.type == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='姓名:'>
						<input name="firstname" type="text" value="${data.firstname}" placeholder="姓名"/>
					</formTable:tr>
					<formTable:tr title='公司:'>
						<input name="companyName" type="text" value="${data.companyName}" placeholder="公司" />
					</formTable:tr>
					<formTable:tr title='所在地:'>
						<select name="cityId" class="selectautocomplete">
							<option value="">--请选择--</option>
							<g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
										<g:if test="${data.city?.id == city.id}">
											<option selected="selected" value="${city.id}">${city.name}</option>
										</g:if>
										<g:else>
											<option value="${city.id}">${city.name}</option>
										</g:else>
									</g:each>
								</optgroup>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='地址:'>
						<input type="text" name="address" value="${data.address}" placeholder="地址"/>
					</formTable:tr>
					<formTable:tr title='固话:'>
						<input type="text" name="phone" value="${data.phone}" placeholder="固话"/>
					</formTable:tr>
					<formTable:tr title='qq:'>
						<input type="text" name="qq" value="${data.qq}" placeholder="qq"/>
					</formTable:tr>
					<formTable:tr title='email:'>
						<input type="text" name="email" value="${data.email}" placeholder="EMAIL" />
					</formTable:tr>
					<formTable:tr title='性别:'>
						<select name="sex" class="selectpicker">
							<option value="">--请选择--</option>
							<g:each in="${Sex.values()}" var="sex">
								<g:if test="${data.sex == sex}">
									<option selected="selected" value="${sex.name()}">${sex.text}</option>
								</g:if>
								<g:else>
									<option value="${sex.name()}">${sex.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='备注:'>
						<textarea name="remark" placeholder="备注">${data.remark}</textarea>
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 1080px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>

--%></body>
</html>