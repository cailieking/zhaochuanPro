<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="org.springframework.security.web.WebAttributes"%>
<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<!-- <link rel="stylesheet" type="text/css" href="../css/common.css"> -->
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/user/user.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/login.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<!-- <script src="../js/common.js"></script> -->
<script src="../js/dialog.js"></script>
<script src="../js/user/user.js"></script>
<script src="../js/c_js/common.js"></script>
<script src="../js/c_js/login.js"></script>
</head>
<body>

<div class="contentBg0">
	<!--登录-->
    <div class="loginBg0">
    	<div class="loginBg md1200">
       <%-- <form id="form_login" method="post" action="/j_spring_security_check">
        <div class="d">
            <p class="p1">
                <span>没有账号？<a href="../register/step1" style="color:#06c; text-decoration:underline;">免费注册</a>&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;会员登录
            </p>
            <div id="error" style="color:red;height: 10px;margin:0px 0px 10px 80px;">
    		<g:if test='${session[WebAttributes.AUTHENTICATION_EXCEPTION]}'>
				<div class="alert alert-warning">
					<div>
						${session[WebAttributes.AUTHENTICATION_EXCEPTION].message}
						<% session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION) %>
					</div>
				</div>
			</g:if>
            </div>
            <ul>
                <li>
                    <span class="s">账&nbsp;&nbsp;&nbsp;&nbsp;号：</span><input type="text" class="text" id="j_username" name="j_username">
                </li>
                <li>
                    <span class="s">密&nbsp;&nbsp;&nbsp;&nbsp;码：</span><input type="password" class="text" id="j_password" name="j_password">
                </li>
                <%-- <li id="captcha_num">
                    <span class="s">验证码：</span><input type="text" class="text" style="width:78px;" name="captcha" id="captcha" /><img onclick="this.src='/captcha/image'" alt="点击更换" width="90" height="30" id="captchaimage" src="/captcha/image" style="cursor: pointer;" />
                </li> 
                </ul>
            <div class="b">
                <input name="redirect" id="redirect" value="/" type="hidden">
                <p><input type="button" value="登录" id="submit_login" class="button"></p>
                <p><a href="../forgetpass/step1" class="a">忘记密码？</a><input type="checkbox" style="vertical-align:middle;" value="1" name="${rememberMeParameter}" >&nbsp;2周自动登录</p>
            </div>
        </div>
        </form>--%>
        	 <form id="form_login" class="login" method="post" action="/j_spring_security_check">
                <div class="title">登录找船网</div>
                <div id="error" class="error">
                <g:if test='${session[WebAttributes.AUTHENTICATION_EXCEPTION]}'>
				<div class="alert alert-warning">
					<div>
						${session[WebAttributes.AUTHENTICATION_EXCEPTION].message}
						<% session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION) %>
					</div>
				</div>
			</g:if>
                
                </div>
                <div class="boxes">
                    <div class="boxbg account">
                        <input id="j_username" name="j_username" class="box" type="text" placeholder="手机" />
                    </div>
                    <div class="boxbg password">
                        <input id="j_password" name="j_password" class="box" type="password" placeholder="密码" />
                    </div>
                </div>
                <div class="forgetBg">
                	<input type="checkbox" class="check" style="vertical-align:middle;" value="1" name="${rememberMeParameter}" ><%--
                    <input id="rememberPwd" class="check" type="checkbox" />
                    --%><label for="rememberPwd">2周自动登录</label>
                    <div class="forget"><a href="/forgetpass/step1">忘记密码？<a></a></div>
                </div>
                <div id="submit_login" class="loginBtn">登&nbsp;&nbsp;&nbsp;&nbsp;录</div>
                <div class="registerBg">
                	<div class="thirdlogin" style="display:none;">第三方注册</div>
                    <div class="qqIcon" style="display:none;"></div>
                    <div class="c_register"><a href="/register/step1" >立即注册<a></a></div>
                </div>
            </form> 
        </div>
    </div>
    <!--登录 end-->
</div>
