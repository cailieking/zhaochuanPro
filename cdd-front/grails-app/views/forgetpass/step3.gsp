<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">itle>
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<!-- <link rel="stylesheet" type="text/css" href="../css/common.css"> -->
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/user/user.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/common.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<!-- <script src="../js/common.js"></script> -->
<script src="../js/dialog.js"></script>
<script src="../js/user/user.js"></script>
<script src="../js/c_js/common.js"></script>
<script type="text/javascript">
$(function(){
	addZcTopUI(-3);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
   $.ajax(
   {
       url:SITE_URL+"user/resetpassinfo",
       type:"get",
       success:function(rs)
       {
    	   $("#resetSuccess").html(rs.data.firstname)
    	   $("#resetPassword").html(rs.data.password)
       }
   });
});
</script>
</head>
<body>
<div class="forgot_password">
    <p class="step03"></p>
    <form id="myform" method="post">
    <p class="step"></p>
    <div class="success">
        <p class="text1">您已修改了<span class="color_9" id="resetSuccess"></span>的密码！</p>
        <p class="p1"><span></span>请妥善保管好您的密码信息</p>
        <p class="p1"><span></span>新密码：<span class="text2" id="resetPassword"></span></p>
        <p><a href="/" class="button1">返回首页</a><a href="/member" class="button2">进入会员中心</a></p>
    </div>
    </form>
</div>
<script>
$(function()
{
    $(".activation").on("click",function()
    {
        countdown.init($(this));//倒计时

        var mobile=$.trim($("#mobile").val());
        if(!$.ismobile(mobile))
        {
            $("#mobile").next('span').addClass("wrong").html("请输入正确的手机号");
            $("#mobile").focus();
            countdown.stop();
            return false;
        }
        $.getJSON(SITE_URL+"captcha/sms",{"mobile":mobile},function(rs)
        {
            if(rs.status<0)
            {
                countdown.stop();
                alert(rs.msg);
            }
            else
            {
                $("#mobile").next('span').addClass("right").html("验证码发送成功");
            }
        });
    });

    $("#find_submit").on("click",function()
    {
        var password=$.trim($("#password").val());

        $.ajax(
        {
            url:SITE_URL+"user/resetForgottenPass",
            type:"post",
            data:$("#myform").serialize(),
            dataType:"json",
            beforeSend:function()
            {
                $("#myform").prop("disabled",true);
            },
            success:function(rs)
            {
                $("#myform").prop("disabled",false);
                if(rs.status<0)
                {
                    alert(rs.msg);
                }
                else
                {
                    location.href=SITE_URL+'forgetpass/step3';
                }
            }
        });

    });

});
</script>

<div class="" style="display: none; position: absolute;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;"></div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div></body></html>