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
		<link rel="stylesheet" type="text/css" href="/css/user/user.css">
		<link rel="stylesheet" type="text/css" href="../css/mobile/common.css">
		<link rel="stylesheet" type="text/css" href="/css/mobile/show1.css">
		<link rel="stylesheet" type="text/css" href="../css/mobile/register.css">
		<link rel="stylesheet" type="text/css" href="../css/mobile/Mobile_s_step.css">
        <script src="../js/jquery.js"></script>
		<script src="../js/js.js"></script>
		<script src="../js/dialog.js"></script>
		<script src="../js/c_js/mobile/common.js"></script>
		<script src="../js/c_js/mobile/show1.js"></script>
		<script src="../js/c_js/mobile/register.js"></script>
		<script type="text/javascript">
$(function(){

	
	
    $('#register_form').on("click",function()
    {   
        var data = $("#form_register").serializeArray();
        $.ajax(
        {
            url:SITE_URL+"register/finish",
            type:"post",
            data:$("#form_register").serialize(),
            dataType:"json",
            beforeSend:function()
            {
                $("#register_form").prop("disabled",true);
            },
            success:function(rs)
            {
                $("#register_form").prop("disabled",false);
                if(rs.status<0)
                {
                    alert(rs.msg);
                }
                else
                {
                    location.href=SITE_URL+'register/registerMobile3';
                }
            }
        });
    });
});

function closediv(co,target){
	if(co == 1){
		top_height = $("#sel_regions").offset().top +target.offsetHeight
	}
    if(co){
    	$("#citydiv").css("top",top_height)
        $("#citydiv").show(100);
        $("#sel_regions").attr("disabled","disabled");
    }
    else{
        $("#sel_regions").removeAttr("disabled");
        $("#citydiv").hide(100);
    }
}

function selectcity(pid,pname,_this){
    $(".p2").html("");
    $("#selectedprovince").html(pname);
    $("input[name='city_id']").attr("value","");
    $("#region_name").html(pname);
    $("input[name='province_id']").attr("value",pid);
    $('a').removeClass("on");
    $(_this).addClass("on");
    $.ajax({
            url:SITE_URL+'city/getCitys?pcode='+pid, 
            type:'GET',         
            dataType:'json',    
            success:function(data){
                var k;
                var regs=data;
                var inhtml='';
                for(k in regs){
                    inhtml +='<a href="javascript:void(0);" onclick="addtotext('+regs[k].code+',\''+regs[k].name+'\');"';
                    if(regs[k].hot==1) inhtml+='style="color:red;"';
                    inhtml+='>'+regs[k].name+'</a>';    
                }
                $(".p2").html(inhtml);
            }
        }); 
}

function addtotext(cid,cname){
    $("#selectedcity").html("-"+cname);
    var cp=$("#selectedprovince").html()+$("#selectedcity").html();
    $("input[name='city_id']").attr("value",cid);
    $("#region_name").html(cp);
    $("#citydiv").hide(100);
    $("#sel_regions").removeAttr("disabled");
}


</script>
    </head>
    <body>
        <div id="layout" style="background: rgba(0, 0, 0, 0) url('/images/c_images/register/rg_bg.png') no-repeat scroll 0 0 / 100% 100%;margin: 0 auto;max-width: 768px;
    min-height: 480px;
    min-width: 320px;
    padding-top: 0px;
        width: 100%;
    text-align: center"><%--
            <span>推浪网账号注册</span>
            
            --%><form  method="post" id="form_register">
            <ul>
                <p id="err_msg"></p>
                <li><i class="pw"><img src="/images/lock.png" style="width:20px;padding:3px"></i><input class="pwd" type="password" placeholder="请输入密码" id="password" name="password"/></li>
                <li><i class="pw2"><img src="/images/lock.png" style="width:20px;padding:3px"></i><input class="pwd2" type="password" placeholder="请输入确认密码" id="confirmPassword" name="confirmPassword"/></li>
                <li><i class="un"><img src="/images/user_1.png" style="width:20px;padding:3px"></i><input class="username" type="text" placeholder="真实姓名" name="firstname" id="firstname"/></li>
                <li><i class="un"><img src="/images/company1.png" style="width:22px;padding:3px"></i><input class="username" type="text" placeholder="公司名称" name="companyName" id="companyName"/></li>
                <li><i class="un"><img src="/images/qq_1.png" style="width:22px;padding:3px"></i><input class="username" type="text" placeholder="QQ" name="qq" id="qq"/></li>
                <li><i class="un"><img src="/images/mail.png" style="width:22px;padding:3px"></i><input class="username" type="text" placeholder="Email" name="email" id="email"/></li>
                <li><i class="yz"><img src="/images/smart_phone.png" style="width:22px;padding:3px" ></i><input class="yzm" type="text" placeholder="请输入手机号" name="mobile" id="mobile" /></li>
              	<li class="father">
          			<%--<span class="s">公司所在地：</span> 
          			
            		--%><i class="yz"></i>
            		<select class="text w2" onfocus="closediv(1,this);" onclick="closediv(1,this);" id="sel_regions" style="">
                		<option id="region_name"></option>
            		</select>
               		<div style="display: none;"><span id="selectedprovince"></span><span id="selectedcity"></span></div>
    		  		
            		<span></span>
       			 </li>
			     <li style="height:40px;text-align:center" class="text" >
			     	<div class="text_1" style="background:none;"><span class="s">企业类型：</span>
			            <div style="float:left">
			            <input id="huozhu" type="radio" value="CARGO_OWNER" name="type">&nbsp;<label for="huozhu">货主</label>&nbsp;&nbsp;&nbsp;&nbsp;
			            <input id="huodai" type="radio" value="SHIP_AGENT" name="type">&nbsp;<label for="huodai">货代</label>&nbsp;&nbsp;&nbsp;&nbsp;
			           	</div>
			         </div>
			          <span id="type_error"></span>
			      </li>  
			      <li style="text-align:center" class="text" >
			     		<div class="text_1" style="height:170px;margin: 0 auto;" ><span class="s">关注航线：</span><!-- width: 80%; -->
			            	<div style="float:left" style="height:auto;" id="line">
								<div style="float:left"><input id="cb_MeiJia" type="checkbox" class="hxCheckbox" value="MeiJia">&nbsp;<label for="cb_MeiJia" style="padding-right:20px;">美加线</label></div>
				           		<div style="float:left"><input id="cb_OuDi" type="checkbox" class="hxCheckbox" value="OuDi">&nbsp;<label for="cb_OuDi" style="padding-right:20px;">欧地线</label></div>
				           		<div style="float:left"><input id="cb_FeiZhou" type="checkbox" class="hxCheckbox" value="FeiZhou">&nbsp;<label for="cb_FeiZhou" style="padding-right:20px;">非洲线</label></div>
				            	<div style="float:left"><input id="cb_ZhongNanMei" type="checkbox" class="hxCheckbox" value="ZhongNanMei">&nbsp;<label for="cb_ZhongNanMei" style="padding-right:20px;">中南美线</label></div>
				            	<div style="float:left"><input id="cb_YinBa" type="checkbox" class="hxCheckbox" value="YinBa">&nbsp;<label for="cb_YinBa" style="padding-right:20px;">中东印巴红海线</label></div>
				            	<div style="float:left"><input id="cb_YuanDong" type="checkbox" class="hxCheckbox" value="YuanDong">&nbsp;<label for="cb_YuanDong" style="padding-right:20px;">日韩港澳台远东线</label></div>
				            	<div style="float:left"><input id="cb_DongNanYa" type="checkbox" class="hxCheckbox" value="DongNanYa">&nbsp;<label for="cb_DongNanYa" style="padding-right:20px;">东南亚线</label></div>
				            	<div style="float:left"><input id="cb_AoXin" type="checkbox" class="hxCheckbox" value="AoXin">&nbsp;<label for="cb_AoXin" style="padding-right:20px;">澳新线</label></div>
			           		</div>
			         	</div>	
			          <span id="type_error"></span>
			      </li><%-- 
			     	
			         <li style="height:auto;text-align: center" class="text">
			        	<div style="height: 180px;width: 80%;margin: 0 auto"><span class="s" id="gzhxTitle" style="padding-right: 0px; padding-left: 0px; margin-left: -92px;">关注航线：</span>
			           		<div class="text" style="height:auto;" id="line">
				            	<div style="float:left"><input id="cb_MeiJia" type="checkbox" class="hxCheckbox" value="MeiJia">&nbsp;<label for="cb_MeiJia" style="padding-right:20px;">美加线</label></div>
				          	 	<div style="float:left"><input id="cb_OuDi" type="checkbox" class="hxCheckbox" value="OuDi">&nbsp;<label for="cb_OuDi" style="padding-right:20px;">欧地线</label></div>
				            	<div style="float:left"><input id="cb_FeiZhou" type="checkbox" class="hxCheckbox" value="FeiZhou">&nbsp;<label for="cb_FeiZhou" style="padding-right:20px;">非洲线</label></div>
				           	 	<div style="float:left"><input id="cb_ZhongNanMei" type="checkbox" class="hxCheckbox" value="ZhongNanMei">&nbsp;<label for="cb_ZhongNanMei" style="padding-right:20px;">中南美线</label></div>
				           	 	<div style="float:left"><input id="cb_YinBa" type="checkbox" class="hxCheckbox" value="YinBa">&nbsp;<label for="cb_YinBa" style="padding-right:20px;">中东印巴红海线</label></div>
				          	 	<div style="float:left"><input id="cb_YuanDong" type="checkbox" class="hxCheckbox" value="YuanDong">&nbsp;<label for="cb_YuanDong" style="padding-right:20px;">日韩港澳台远东线</label></div>
				           	 	<div style="float:left"><input id="cb_DongNanYa" type="checkbox" class="hxCheckbox" value="DongNanYa">&nbsp;<label for="cb_DongNanYa" style="padding-right:20px;">东南亚线</label></div>
				            	<div style="float:left"><input id="cb_AoXin" type="checkbox" class="hxCheckbox" value="AoXin">&nbsp;<label for="cb_AoXin" style="padding-right:20px;">澳新线</label></div>
			            	</div>
			            <span id="type_error"></span>
			            
			            <div style="display:none;"><input type="hidden" value="" name="recommendedRoutes" id="recommendedRoutes"></div>
			            </div>
			        </li> 
        		--%></ul>
        		 <div id="citydiv" >
    					<input type="hidden" value="" name="province_id" > <input type="hidden" value="" name="city_id" id="city_id">
    					<div class="Ddz" style="height:200px;overflow:auto">
		        			<p class="title"><a href="javascript:void(0);" id="cityclose" onclick="closediv(0,this);"><!--关闭--></a>&nbsp;&nbsp;&nbsp;&nbsp;请选择地址</p>
			                <p class="p1" style="margin-top:10px;"><b>A-G</b>
			                <a href="javascript:void(0);" onclick="selectcity(110000,&#39;北京&#39;,this);">北京</a>
			                <a href="javascript:void(0);" onclick="selectcity(340000,&#39;安徽&#39;,this);">安徽</a>
			                <a href="javascript:void(0);" onclick="selectcity(350000,&#39;福建&#39;,this);">福建</a>
			                <a href="javascript:void(0);" onclick="selectcity(440000,&#39;广东&#39;,this);">广东</a>
			                <a href="javascript:void(0);" onclick="selectcity(450000,&#39;广西&#39;,this);">广西</a>
			                <a href="javascript:void(0);" onclick="selectcity(500000,&#39;重庆&#39;,this);">重庆</a>
			                <a href="javascript:void(0);" onclick="selectcity(520000,&#39;贵州&#39;,this);">贵州</a>
			                <a href="javascript:void(0);" onclick="selectcity(620000,&#39;甘肃&#39;,this);">甘肃</a>
			                <a href="javascript:void(0);" onclick="selectcity(820000,&#39;澳门&#39;,this);">澳门</a>
			                </p>
			                <p class="p1" style="margin-top:10px;"><b>H-J</b>
			                <a href="javascript:void(0);" onclick="selectcity(130000,&#39;河北&#39;,this);">河北</a>
			                <a href="javascript:void(0);" onclick="selectcity(220000,&#39;吉林&#39;,this);">吉林</a>
			                <a href="javascript:void(0);" onclick="selectcity(230000,&#39;黑龙江&#39;,this);">黑龙江</a>
			                <a href="javascript:void(0);" onclick="selectcity(320000,&#39;江苏&#39;,this);">江苏</a>
			                <a href="javascript:void(0);" onclick="selectcity(360000,&#39;江西&#39;,this);">江西</a>
			                <a href="javascript:void(0);" onclick="selectcity(410000,&#39;河南&#39;,this);">河南</a>
			                <a href="javascript:void(0);" onclick="selectcity(420000,&#39;湖北&#39;,this);">湖北</a>
			                <a href="javascript:void(0);" onclick="selectcity(430000,&#39;湖南&#39;,this);">湖南</a>
			                <a href="javascript:void(0);" onclick="selectcity(460000,&#39;海南&#39;,this);">海南</a>
			                </p>
			                <p class="p1" style="margin-top:10px;"><b>L-S</b>
			                <a href="javascript:void(0);" onclick="selectcity(140000,&#39;山西&#39;,this);">山西</a>
			                <a href="javascript:void(0);" onclick="selectcity(150000,&#39;内蒙古&#39;,this);">内蒙古</a>
			                <a href="javascript:void(0);" onclick="selectcity(210000,&#39;辽宁&#39;,this);">辽宁</a>
			                <a href="javascript:void(0);" onclick="selectcity(310000,&#39;上海&#39;,this);">上海</a>
			                <a href="javascript:void(0);" onclick="selectcity(370000,&#39;山东&#39;,this);">山东</a>
			                <a href="javascript:void(0);" onclick="selectcity(510000,&#39;四川&#39;,this);">四川</a>
			                <a href="javascript:void(0);" onclick="selectcity(610000,&#39;陕西&#39;,this);">陕西</a>
			                <a href="javascript:void(0);" onclick="selectcity(630000,&#39;青海&#39;,this);">青海</a>
			                <a href="javascript:void(0);" onclick="selectcity(640000,&#39;宁夏&#39;,this);">宁夏</a>
			                </p>
			                <p class="p1" style="margin-top:10px;"><b>T-Z</b>
			                <a href="javascript:void(0);" onclick="selectcity(120000,&#39;天津&#39;,this);">天津</a>
			                <a href="javascript:void(0);" onclick="selectcity(330000,&#39;浙江&#39;,this);">浙江</a>
			                <a href="javascript:void(0);" onclick="selectcity(530000,&#39;云南&#39;,this);">云南</a>
			                <a href="javascript:void(0);" onclick="selectcity(540000,&#39;西藏&#39;,this);">西藏</a>
			                <a href="javascript:void(0);" onclick="selectcity(650000,&#39;新疆&#39;,this);">新疆</a>
			                <a href="javascript:void(0);" onclick="selectcity(810000,&#39;香港&#39;,this);">香港</a>
			                </p>
			                <p class="p2"></p>
    					</div>
					</div>
        <div class="reg_btn" style= "padding-bottom: 20px;border-top-width: 20px; margin-top: 30px;text-align:center">
               		 <%--<a id="submit_register" href="javascript:void(0);" class="button1 buttonpos"> 注册账号 </a>
                     --%><%--<button class="submit" type="submit" id="submit_register">注册账号</button>
                    --%><a   id="register_form" href="javascript:void(0);"><div class="submit" ><p>完成注册</p></div></a>
                    <%--<a href="/login"><div class="reg-login"><p>已有帐号，立即登陆</p></div></a>
                --%></div>
            </form>
        </div>
    </body>
<script>
(function(){
    $('#huozhu').click(function(){
        $('#gzhxTitle').html('关注航线：');
    });
    $('#huodai').click(function(){
        $('#gzhxTitle').html('优势航线：');
    });


    $('.hxCheckbox').change(function(){
        var hxList = [];
        $('.hxCheckbox').each(function(){
            if($(this)[0].checked){
                hxList.push($(this).val());
            }
        });
        $('#recommendedRoutes').val(hxList.join(','));
    });
})();

</script>
</html>