<g:set var="springSecurityService" bean="springSecurityService" />
<%@page import="com.cdd.base.enums.AgentType"%>
<%@page import="com.cdd.base.enums.FrontUserType"%>
<%@page import="com.cdd.base.domain.Role"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<g:set var="cityService" bean="cityService" />
<!DOCTYPE>
<html>
<head>
<title>用户详细信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">后台用户注册</div>
			<form action="${request.contextPath}/frontUser/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
				<formTable:tr title='用户名（必填）:'>
						<input type="text" name=username value="${data.username}" placeholder="用户名"/>
					</formTable:tr>
					<formTable:tr title='姓名（必填）:'>
						<input type="text" name=firstname value="${data.firstname}" placeholder="姓名"/>
					</formTable:tr>
					<formTable:tr title='公司名(必填):'>
						<input type="text" name="companyName" value="${data.companyName}" placeholder="公司名"/>
					</formTable:tr>
					<formTable:tr title='所在地(必填):'>
						<select name="city" class="selectautocomplete">
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
					
					<formTable:tr title='类型（必填）:'>
					    <select name="type" class="selectpicker" style="float:right; margin-left: 10px;">
					    <g:each in="${FrontUserType.values()}" var="type">
	                     <g:if test="${data.type==type}"> 
	                    	<option selected="selected" value="${type.name()}">${type.text}</option>
	                     </g:if>
	                    <g:else>
							<option value="${type.name()}">${type.text}</option>
						</g:else>
	                     </g:each>
	                    </select>
						</formTable:tr>
						
					<formTable:tr title='新密码（不输入则密码不变）:'>
						<input type="text" name="password" value="" placeholder="新密码"/>
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