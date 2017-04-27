<%@page import="com.cdd.base.util.CommonUtils"%>
<%@page import="com.cdd.base.domain.Role"%>
<!DOCTYPE>
<html>
<head>
<title>用户信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
<style>

element.style {
    cursor: move;
}
*::before, *::after {
    box-sizing: border-box;
}
*::before, *::after {
    box-sizing: border-box;
}
.layui-layer-title {
    background-color: #d4dce5;
    border-bottom: 1px solid #d5d5d5;
    color: #333;
    font-size: 14px;
    height: 35px;
    line-height: 35px;
    overflow: hidden;
    padding: 0 80px 0 10px;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin:-20px;
}

</style>
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<%--<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">新增</div>
		--%><div class="lump" >
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">新增用户</div>
			<%--<div class="panel-body pn">
                  
                 --%><form action="${request.contextPath}/user/save${isSelf ? 'Self' : ''}" method="post" id="dataForm" >
                  <input type="hidden" name="id" value="${data.id}" />
				<formTable:table >
					<formTable:tr title='用户名:'>
						<input type="text" name="username" type="text" value="${data.username}"  placeholder="用户名"/>
					</formTable:tr>
					<formTable:tr title='姓名:'>
						<input type="text" name="firstname" value="${data.firstname}"  placeholder="姓名"/>
					</formTable:tr>
					<formTable:tr title='邮箱:'>
						<input type="text" name="email" value="${data.email}" placeholder="email" style="width:150%"/>
					</formTable:tr>
					
					<formTable:tr title='性别:'>
						<formTable:radio enumName="com.cdd.base.enums.Sex" name="sex" value="${data.sex}" />
					</formTable:tr>
					<formTable:tr title='出生日期:'>
						<input type="text" name="birth" class="datepicker" value="${CommonUtils.formatDate(data.birth)}"  placeholder="出生日期" />
					</formTable:tr>
					<formTable:tr title='手机:'>
						<input type="text" name="mobile" class="numberTextbox" maxLength="11" value="${data.mobile}" placeholder="手机" />
					</formTable:tr>
					<g:if test="${!isSelf}">
						<formTable:tr title='所属角色:'>
							<select id="roleIdValue" name="roleIdValue">
								<option value="">--请选择--</option>
								<g:each in="${Role.all}" var="role">
									<g:if test="${data.role?.id == role.id}">
										<option selected="selected" value="${role.id}">${role.name}</option>
									</g:if>
									<g:else>
										<option value="${role.id}">${role.name}</option>
									</g:else>
								</g:each>
							</select>
						</formTable:tr>
						<formTable:tr title='所属上级:'>
							<select id="superiorLevel" name="superiorLevel">
								<option value="">--请选择--</option>
								<g:each in="${superiors}" var="superior">
									<g:if test="${data.superiorLevel && data.superiorLevel == superior.positionLevel}">
										<option selected="selected" value="${superior.positionLevel}">${superior.firstname}</option>
									</g:if>
									<g:else>
										<option value="${superior.positionLevel}">${superior.firstname}</option>
									</g:else>
								</g:each>
							</select>
						</formTable:tr>
					</g:if>
					<g:else>
						<formTable:tr title='新密码:'>
							<input type="password" style="width:100%" name="newPass" />
						</formTable:tr>
						<formTable:tr title='确认密码:'>
							<input type="password" style="width:100%" name="confirmPass" />
						</formTable:tr>
					</g:else>
				</formTable:table>
                  </form>
                  <%-- </div>--%><%--
                </div>
			
			--%><div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" class="button button-glow button-rounded button-raised button-primary" id="back" onclick="window.history.back()" style="margin-left: 1080px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%><script>
	$(document).ready(function() {
		$("#roleIdValue").change(function() {
			var roleId = $(this).val();
			if(roleId) {
				$.ajax({
					url: '${request.contextPath}/user/superiors/' + roleId,
					cache: false,
				    contentType: "application/json"
				}).done(function(list) {
					$("#superiorLevel").children().remove();
					$("#superiorLevel").append($("<option selected='selected' value=''>--请选择--</option>"))
					for(var i = 0; i < list.length; i++) {
						var data = list[i]
						$("#superiorLevel").append($("<option value=" + data.positionLevel + ">" + data.firstname + "</option>"))
					}
				});
			}
		});
	}); 
</script>
</body>
</html>