<!DOCTYPE html>
<html>
    <head>
        <title>注册页面</title>
        <meta charset="utf-8">
        <meta name="format-detection" content="telephone=no">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-touch-fullscreen" content="yes">
        <meta http-equiv="Access-Control-Allow-Origin" content="*">
        <link href="../css/mobile/register.css" type="text/css" rel="stylesheet">
        <link href="../css/mobile/global.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/dialog.css">
		<link rel="stylesheet" type="text/css" href="../css/user/user.css">
		<link rel="stylesheet" type="text/css" href="../css/mobile/common.css">
		<%--<link rel="stylesheet" type="text/css" href="/css/mobile/show1.css">
		--%><link rel="stylesheet" type="text/css" href="../css/mobile/register.css">
        <script src="../js/jquery.js"></script>
		<script src="../js/js.js"></script>
		<script src="../js/dialog.js"></script>
		<script src="../js/c_js/mobile/common.js"></script>
		<script src="../js/c_js/register.js"></script>
    </head>
    <body>
        <div id="layout" style="background: rgba(0, 0, 0, 0) url('/images/c_images/register/rg_bg.png') no-repeat scroll 0 0 / 100% 100%;margin: 0 auto;max-width: 768px;
    		min-height: 480px;
    		min-width: 320px;
    		padding-top: 0px;text-align:left">
     		<div class="registerRemind" style="display:block;">
            	<div class="remindTitle">注册成功</div>
                <div class="remindBg">
                	<div class="label" id="regSuccess" style="font-size:18px;color:#0f0;">xxx,恭喜你注册成功</div>
                	<div class="label">请保管好您的账号信息</div>
                    <div class="label account">账号：<span id="regUsername"></span></div>
                    <div class="label passwd">密码：<span id="regPassword"></span></div>
                    <div class="btn1" id="goCenterBtn" style="margin-top:40px;">进入会员中心</div>
                    <div class="btn1" id="goIndexBtn" style="margin-top:10px;">进入找船网</div>
                </div>
            </div>
      </div>
<script>
$(function(){
	$.ajax(
	{
		url:SITE_URL+"register/info",
		type:"get",
		success:function(rs)
		{
			console.log(rs);
			$("#regSuccess").html(rs.data.firstname + "，恭喜您注册成功！")
			$("#regUsername").html(rs.data.username)
			$("#regPassword").html(rs.data.password)
			$("#goCenterBtn").click(function() {
				window.location='/register/goCenter?username='+rs.data.username  
				//window.location='/index3.html';  
			})
			$("#goIndexBtn").click(function() {
				window.location='/index3.html';  
			})
		},
		error:function(rs){
			console.log('注册数据读取失败',rs);
		}
	});
});
</script>
    </body>
</html>