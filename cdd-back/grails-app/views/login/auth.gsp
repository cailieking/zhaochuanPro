<!DOCTYPE>
<%@page import="org.springframework.security.web.WebAttributes"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${grailsApplication.config.appInfo.title} - 登录</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}"
	type="image/x-icon">
<asset:stylesheet src="application.css" />
<asset:stylesheet src="login.css" />
<asset:javascript src="application.js" />
</head>
<body class="container bg-img-num1">
	<div class="login-block">
		<div class="login-block-inner">
			<form action="${request.contextPath}/j_spring_security_check" method="post">
				<div class="col-md-12">
					<div class="input-group login-form-row text-center h2 text-logo">
						<img src="${assetPath(src: 'logo.jpg')}" width="40" height="40" /></i>&nbsp;&nbsp; <strong>${grailsApplication.config.appInfo.title}</strong>
					</div>
				</div>
				<div class="login-form-row"></div>
				<div class="login-form-row"></div>
				<div class="login-form-row"></div>
				<div class="col-md-12">
					<div class="input-group login-form-row">
						<div class="input-group-addon login-input-group">
							<i class="fa fa-user"></i>
						</div>
						<input id="username" type="text" class="form-control input-border"
							name="j_username" placeholder="用户名" autofocus>
					</div>
				</div>
				<div class="col-md-12">
					<div class="input-group login-form-row">
						<div class="input-group-addon login-input-group">
							<i class="fa fa-key"></i>
						</div>
						<input id="password" type="password" class="form-control input-border"
							name="j_password" placeholder="密&nbsp;&nbsp;&nbsp;码">
					</div>
				</div>
				<div class="login-form-row">
					<g:if test='${session[WebAttributes.AUTHENTICATION_EXCEPTION]}'>
						<div class="alert alert-warning">
							<div>
								${session[WebAttributes.AUTHENTICATION_EXCEPTION].message}
								<% session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION) %>
							</div>
						</div>
					</g:if>
				</div>
				<div class="input-group login-form-row">
					<div class="col-xs-6 text-white vertical-align">
						<input type="checkbox" name="${rememberMeParameter}"
							class="vertical-checkbox" /> <small>两周内自动登录</small>
					</div>
					<div class="col-xs-6 text-right text-white">
						<small>忘记密码？</small>
					</div>
				</div>
				<div class="input-group login-form-row">
					<%--
					<div class="col-xs-6">
						<button id="resetBtn" type="button" onclick="clearForm()" class="btn btn-block btn-vk">重 置</button>
					</div>
					 --%>
					<div class="col-xs-12">
						<button type="submit" class="btn btn-block btn-vk"">登 录</button>
					</div>
				</div>

			</form>
		</div>
		<div class="login-form-row login-shadow"></div>
	</div>
	<div class="page-footer text-lightblue">
		<small>版权所有 © ${grailsApplication.config.appInfo.year} ${grailsApplication.config.appInfo.title} 推荐使用谷歌(chrome)，火狐(firefox)，IE9+浏览器</small>
	</div>
	
	<script>
		function clearForm() {
			$("input").val("");
		}
	</script>
</body>

</html>





