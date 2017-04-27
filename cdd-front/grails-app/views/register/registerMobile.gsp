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
		<script src="../js/c_js/mobile/show1.js"></script>
		<script src="../js/c_js/mobile/register.js"></script>
		
    </head>
    <body>
        <div id="layout" style="background: rgba(0, 0, 0, 0) url('/images/c_images/register/rg_bg.png') no-repeat scroll 0 0 / 100% 100%;margin: 0 auto;max-width: 768px;
    min-height: 480px;
    min-width: 320px;
    padding-top: 0px;"><%--
            <span>推浪网账号注册</span>
            
            --%><form  method="post" id="myform">
            <ul>
                <p id="err_msg"></p>
                <li><i class="un"></i><input class="username" type="text" placeholder="邀请码（可选项）" name="invitationCode" id="invitationCode"/></li>
                <li><i class="yz"><img src="/images/smart_phone.png" style="width:25px"></i><input class="yzm" type="text" placeholder="请输入手机号" name="mobile" id="mobile" /></li>
                <li><i class="yz"><img src="/images/image.png" style="width:20px;padding:3px"></i><input class="yzm" type="text" placeholder="验证码" name="captcha" id="captcha" />
                	 <img onclick="this.src=&#39;/captcha/image?&#39; + Math.round(Math.random()*100000000)" alt="点击更换"  id="captchaimage" src="/captcha/image?&#39; + Math.round(Math.random()*100000000)" style="border: 1px solid #79b235;border-radius: 3px;cursor: pointer;font-family: Microsoft YaHei;font-size: 12px;height: 30px;margin: 5px 0 0 -87px;position: absolute; width: 87px;">
                </li>
                <li><i class="yz"><img src="/images/image.png" style="width:20px;padding:3px"></i><input class="yzm"  placeholder="请输入短信验证码" name="verifycode" id="verifycode" />
                <input type="button" id="send" value="获取短息验证码" style="display:true"/><%--
                <a href="javascript:void(0);" class="activation" >免费获取短信激活码</a>
                --%><span id="hide_tip" style="display: none;"></span><span id="success_tip"></span>
                </li>
                <div class="queren"><input class="fx" type="checkbox" checked="checked"  id="is_agree" /><p>我已阅读《找船网用户服务协议》</p></div>
            </ul>
                <div class="reg_btn" style="margin-top:20px">
               		 <%--<a id="submit_register" href="javascript:void(0);" class="button1 buttonpos"> 注册账号 </a>
                     --%><%--<button class="submit" type="submit" id="submit_register">注册账号</button>
                    --%><a   id="submit_register" href="javascript:void(0);"><div class="submit"><p>注册账号</p></div></a>
                    <a href="/login"><div class="reg-login" style="padding-top:20px;margin:0 auto"><p id="return_p">已有帐号，立即登陆</p></div></a>
                </div>
            </form>
        </div>
<script>
$(function(){   
       // 邀请码实现地方
       var invitationCodeReg = /(?:^|\?|&)invitationCode=(\d+|[a-zA-Z]+)(?:&*)/ig;
	   var urlParams = window.location.search;
	   var invitationCodeEl = $('#invitationCode'); 
	       if(urlParams){
	          invitationCodeEl.val(invitationCodeReg.exec(urlParams)[1]);
	       }   
	   var mobileVal = '';
	   $("#mobile").on("focus",function(){
	      var mobileEL  = $(this);
          mobileEL.next('span').removeClass('wrong').css({background:'',float:'',paddingLeft:'',height:''}).html("");
       })
     
     
    /* $("#mobile").on("change",function(){
           
             var mobileEL  = $(this);
             mobileEL.next('span').removeClass('wrong').css({background:'',float:'',paddingLeft:'',height:''}).html("");
             mobileVal = mobileEL.val().trim() + '';
             if(!(/(?:\+86)?1[0-9]{10}/.test(mobileVal))){
               mobileEL.next('span').addClass("wrong").html("请输入正确的手机号");  
             }else{
                $.post( SITE_URL+"register/isOldMobile",{"mobile":mobileVal},function(rs){
                    rs.status < 0 ? mobileEL.next('span').addClass("wrong").html(rs.msg):
                    mobileEL.next('span').css({
                           background:'url("../../images/register/pic_register.png") no-repeat 10px -800px',
                           float:'left',
                           paddingLeft:'30px',
                           height:'32px'
                        });             
                }) 
             }  
                 
         
      });*/
      
    $('#captcha').focus(function(){
          var  verifyCodeInputEl = $('#captcha');
         verifyCodeInputEl.next().next().removeClass('verify-wrong').html('');
    });
 

    /*times=60,
    timer=null;
    /*send.onclick=function(){      
      // 计时开始 
        timer = setInterval(djs,1000);
    } */
   /* var send 
    function djs(){
        alert(send)
		send.value = times+"秒后重试";
		send.setAttribute('disabled','disabled');
        send.style.background='#ccc';
        send.style.border='1px solid #ccc';
		times--;
		if(times <= 0){
			send.value = "发送验证码";
			send.removeAttribute('disabled');
			times = 60;
			clearInterval(timer);
		}
	}*/
	
    /*$("#send").on("click",function(){  
    	//timer = setInterval(djs,1000);
    	var send=document.getElementById('send')
    	alert(send)
        var  verifyCodeInputEl = $('#captcha');
             verifyCodeInputEl.next().next().removeClass('verify-wrong').html('');
        if(!(verifyCodeInputEl.val().trim())){
            verifyCodeInputEl.next().next().addClass('verify-wrong').html('请输入验证码');
             return
        } 

        var mobile=$.trim($("#mobile").val());
        if(!$.ismobile(mobile))
         {
             $("#mobile").next('span').addClass("wrong").html("请输入正确的手机号");
             $("#mobile").focus();
             //countdown.stop();
             return false;
         } 

        $.getJSON(SITE_URL+"captcha/sms",{"mobile":mobile},function(rs){
            if(rs.status<0){
                //countdown.stop();
                alert(rs.msg);
            }
            else{
                $("#success_tip").html("验证码发送成功");
            }
        });
        
        timer = setInterval(djs,1000)
        //countdown.init($(this));//倒计时

     /*var mobile=$.trim($("#mobile").val());
      if(!$.ismobile(mobile))
       {
           $("#mobile").next('span').addClass("wrong").html("请输入正确的手机号");
           $("#mobile").focus();
           //countdown.stop();
           return false;
       } 
       
       $.getJSON(SITE_URL+"captcha/sms",{"mobile":mobileVal},function(rs){
           if(rs.status<0){
               //countdown.stop();
               alert(rs.msg);
           }
           else{
               $("#success_tip").html("验证码发送成功");
           }
       });
       
   });*/
   

});
</script>
    </body>
</html>