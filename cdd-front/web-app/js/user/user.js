$(function()
{
    //处理登录
    $("#submit_login").on("click",function()
    {
        //初始化
        var j_username=$.trim($("#j_username").val());
        var j_password=$.trim($("#j_password").val());
        var captcha=$.trim($("#captcha").val());

        //检查账号密码
        if(!j_username)
        {
            $("#error").html("账号不能为空");
            $("#j_username").focus();
            return false;
        }
        if(!j_password)
        {
            $("#error").html("密码不能为空");
            $("#j_password").focus();
            return false;
        }
        
        $("#form_login").submit();
        
    });
	$("body").on("keyup",function(e)
    {
		if(e.keyCode==13){
			$("#submit_login").trigger('click');
		}
    });

});