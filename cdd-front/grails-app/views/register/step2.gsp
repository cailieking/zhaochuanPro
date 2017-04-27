<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<!--<link rel="stylesheet" type="text/css" href="../css/common.css">-->
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/user/user.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/register.css">
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script> 
<!--<script src="../js/common.js"></script>-->
<script src="../js/dialog.js"></script>
<script src="../js/form.js"></script>
<script src="../js/c_js/common.js"></script> 
<script src="../js/c_js/register.js"></script>
<style type="text/css">
*html { background-image:url(about:blank); background-attachment:fixed; }
* { padding: 0; margin: 0; }
body { font-family:"微软雅黑"; font-size:12px; color:#333; }
p{ margin:0; padding:0; }
a{ color:#333; text-decoration:none;}
a:hover{ text-decoration:underline;}
.father{position: relative;}
#citydiv{position: absolute;top:-60px; left:10px;display: none;}
.Ddz{background: #fff;width:580px; border:1px solid #448aca;}
.Ddz .title{ height:31px; border-bottom:1px solid #ddd; line-height:31px;}
.Ddz .title a{ float:right; width:31px; height:31px; background:url(../images/register/pic_admin_dzx.png) no-repeat 0 0;}
.Ddz .p1{ padding-left:20px; height:30px; line-height:22px;}
.Ddz .p1 a{ display:inline-block; width:50px; height:22px; line-height:22px; text-align:center; color:#06c;}
.Ddz .p1 a:hover{background:#08d; color:#fff;}
.Ddz .p1 b{ margin-right:5px; color:#f90;}
.Ddz .p1 .on{ background:#08d; color:#fff;}
.Ddz .p2{ margin:0 8px 10px; padding:8px; width:548px; border:1px solid #eee; line-height:24px;}
.Ddz .p2 a{ display:inline-block; width:auto; margin:5px 5px 5px 0; padding:0 3px; text-align:center;}
.Ddz .p2 a:hover{background:#08d; color:#fff;}
.Ddz .p2 .on{ background:#08d; color:#fff;}
input {vertical-align:middle;}
</style>

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
                    location.href=SITE_URL+'register/step3';
                }
            }
        });
    });
});

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

function closediv(co){
    if(co){
        $("#citydiv").show(100);
        $("#sel_regions").attr("disabled","disabled");
    }
    else{
        $("#sel_regions").removeAttr("disabled");
        $("#citydiv").hide(100);
    }
}
</script>

</head>

<body>

<form id="form_register" method="post">
<div class="contentBg0" >
    <div class="registerBg0">
    	<div class="registerBg md1200">
            <div class="doRegister" style="">
            	<ul class="registerNav">
                	<li class="sel">手机注册</li>
                    <li style="display:none;">邮件注册</li> 
                </ul>
<div class="register" style="height: auto; border:none;">
    <ul class="ul02">
     	
        <li>
            <span class="s">密码：</span> <input type="password" class="text w2" value="" name="password" id="password" maxlength="16"><span></span>
        </li>
        <li>
            <span class="s">确认密码：</span> <input type="password" class="text w2" value="" name="confirmPassword" id="confirmPassword" maxlength="16"> <span></span>
        </li>
        <li>
            <span class="s">真实姓名：</span> <input type="text" class="text w2" style="color:#333;" name="firstname" id="firstname" maxlength="10"><span></span>
        </li>
        <li>
            <span class="s">公司名称：</span> <input type="text" class="text w2" style="color:#333;" name="companyName" id="companyName" maxlength="50"><span></span>
        </li>
        <li>
            <span class="s">QQ：</span> <input type="text" class="text w2" style="color:#333;" name="qq" id="qq" maxlength="50"><span></span>
        </li>
        <li>
            <span class="s">电子邮箱：</span> <input type="text" class="text w2" style="color:#333;" name="email" id="email" maxlength="100"><span></span>
        </li>
        <li class="father">
            <span class="s">公司所在地：</span> 
            <select class="text w2" onfocus="closediv(1);" onclick="closediv(1);" id="sel_regions" style="width:360px;height:40px;">
                <option id="region_name"></option>
            </select>
            <div style="display: none;"><span id="selectedprovince"></span><span id="selectedcity"></span></div>
    <div id="citydiv">
    <input type="hidden" value="" name="province_id"> <input type="hidden" value="" name="city_id" id="city_id">
    <div class="Ddz">
        <p class="title"><a href="javascript:void(0);" id="cityclose" onclick="closediv(0);"><!--关闭--></a>&nbsp;&nbsp;&nbsp;&nbsp;请选择地址</p>
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
            <span></span>
        </li>
        <li style="height:40px;" class="text">
            <span class="s">企业类型：</span>
            <div class="text" style="background:none;">
            <input id="huozhu" type="radio" value="CARGO_OWNER" name="type">&nbsp;<label for="huozhu">货主</label>&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="huodai" type="radio" value="SHIP_AGENT" name="type">&nbsp;<label for="huodai">货代</label>&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
            <span id="type_error"></span>
        </li>
        <li style="height:auto;" class="text">
            <span class="s" id="gzhxTitle">关注航线：</span>
            <div class="text" style="height:auto;">
	            <input id="cb_MeiJia" type="checkbox" class="hxCheckbox" value="MeiJia">&nbsp;<label for="cb_MeiJia">美加线　　　　</label>
	            <input id="cb_OuDi" type="checkbox" class="hxCheckbox" value="OuDi">&nbsp;<label for="cb_OuDi">欧地线　　　　　</label>
	            <input id="cb_FeiZhou" type="checkbox" class="hxCheckbox" value="FeiZhou">&nbsp;<label for="cb_FeiZhou">非洲线　</label>
	            <input id="cb_ZhongNanMei" type="checkbox" class="hxCheckbox" value="ZhongNanMei">&nbsp;<label for="cb_ZhongNanMei">中南美线</label>
	            <input id="cb_YinBa" type="checkbox" class="hxCheckbox" value="YinBa">&nbsp;<label for="cb_YinBa">中东印巴红海线</label>
	            <input id="cb_YuanDong" type="checkbox" class="hxCheckbox" value="YuanDong">&nbsp;<label for="cb_YuanDong">日韩港澳台远东线</label>
	            <input id="cb_DongNanYa" type="checkbox" class="hxCheckbox" value="DongNanYa">&nbsp;<label for="cb_DongNanYa">东南亚线</label>
	            <input id="cb_AoXin" type="checkbox" class="hxCheckbox" value="AoXin">&nbsp;<label for="cb_AoXin">澳新线</label>
            </div>
            <span id="type_error"></span>
            <div style="display:none;"><input type="hidden" value="" name="recommendedRoutes" id="recommendedRoutes"></div>
        </li>
        <li>
            <p class="tc" style="text-align:center;"><input type="button" id="register_form" class="button1" value="完成注册"></p>
        </li>
    </ul>
</div>
			</div>
		</div>
	</div>
</div>
</form>
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
</body></html>