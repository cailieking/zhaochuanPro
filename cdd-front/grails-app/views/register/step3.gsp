<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<!-- <link rel="stylesheet" type="text/css" href="../css/common.css"> -->
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/user/user.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/register.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<!-- <script src="../js/common.js"></script> -->
<script src="../js/dialog.js"></script>
<script src="../js/c_js/common.js"></script>
<script src="../js/c_js/register.js"></script>
<script type="text/javascript">
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
</head>
<body>
<div class="contentBg0">
    <div class="registerBg0">
    	<div class="registerBg md1200">
    		<!--注册成功提醒-->
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
            <!--注册成功提醒 end-->
<!-- <div class="register">
    <div class="success">
        <p id="regSuccess" class="text1"></p>
        <p style=" color:#333;">请妥善保管好您的注册信息</p>
        <p>账号：<span class="text2" id="regUsername"></span></p>
        <p>密码：<span class="text2" id="regPassword"></span></p>
        <p><a href="/" class="button">返回首页</a><a id="goCenterBtn" href="javascript:;" class="button">进入会员中心</a></p>
    </div>
</div> -->

		</div>
	</div>
</div>
</body></html>