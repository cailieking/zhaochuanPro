<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>港口 - 找船网</title>
<meta name="layout" content="main">


    <style type="text/css">
        .register-success-page{
                margin: 40px 30%;
            text-align:center;
        }
        .register-finish-title {
            text-align:center;
           font-size: 20px;
           color:white;
           padding-bottom:5px;
           border-bottom: solid 4px #234A68;
           margin-bottom: 5px;
        }
        .main-content{
            margin-top: 20px;
            background-color: #1e405b;
            border:1px solid #FFA500;
        }
        .register-title{
            font-weight:bold;
            color:#FFA500;
            font-size: 28px;
            margin:30px auto
        }
        .register-row{
            color: white;
            font-size: 20px;
            margin: 20px auto;
        }
        .button-group{
          margin:35px;
        }
        .button-group a{
            display:inline-block;
            text-decoration: none;
            font-size: 16px;
            color: white;
            padding: 5px 8px;
            margin: 5px 10px;
            background-color: #2c5c82;
            border-radius: 4px;
        }
        .button-group a:hover{
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
         $(function(){
             $('#back-previous-page').click(function(){
                 window.location.href = "./list/";
             });
             $('#continue-register-page').click(function(){
                 window.location.href = "./addBackUser";
             });
             $('#replicate-page').click(function(){
                  $('.register-row span').select();
                  document.execCommand('Copy');
             });
             var registerUsername = $('#register-username');
             var registerUsernameVal = registerUsername.html(); 
             var len = registerUsername.html().length;
             if(len != 0){
            	 registerUsernameVal = registerUsername.html().substr(len-6,len);
             }
             $('#register-psd').html(registerUsernameVal);
         })
    </script>
</head>
<body>
<div class="register-success-page">
   <div class="register-finish-title">注册完成</div>
    <div class="main-content">
      <div class="register-title">恭喜您，注册成功！</div>
      <div class="register-row">
          <label>账号&nbsp;：&nbsp</label>
          <span id="register-username">${data.username}</span>
      </div>
      <div class="register-row" style="margin-left: -42px;">
          <label>密码&nbsp;：&nbsp</label>
          <span id="register-psd"></span>
      </div>
       <div class="button-group">
          <a id="back-previous-page">返回列表页列表页</a>
         <a id="continue-register-page">继续注册</a>
          <%--<a id="replicate-page">一键复制</a>
       --%></div>
</div>
</body>
</html>