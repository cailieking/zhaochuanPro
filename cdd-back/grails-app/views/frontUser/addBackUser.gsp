<%@page import="com.cdd.base.enums.Provinces"%>
<g:set var="cityService" bean="cityService" />
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">      
<title>找船网</title>
<title>导入用户信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="addBackUser.css" />
<style>
 .red { 
            display: inline-block;
            font-weight: normal;
            color: #ff0000;
            margin-left: 5px;
        }
 .hint-msg{
	font-size:12px;
	color:red;
	width:120px;
}

.can-register{
	display:inline-block;
	background:url("../../images/pic-register.png") 0px -808px no-repeat ;
	position:relative;
	top:12px;
	width:25px;
	height:25px;                              
	
}

input[type="checkbox"]  + span{
	padding-right:15px;
}

</style>	
</head>


<body>
   <div class="col-lg-12">
   <div class="lump">
   <div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">注册用户修改</div>
 	 <form action="${request.contextPath}/frontUser/saveBackUser" method="post" id="dataForm" >
      		<h3>注册资料填写</h3>
     	 <formTable:table>
				<formTable:tr title='手机号码:'>
						<input type="text" id="mobile"  name="mobile"  maxlength="11" placeholder="请输入正确的手机号码" style="width:65%"/><b class="red">*</b><span></span>
					</formTable:tr>
					<formTable:tr title='真实姓名:'>
						<input type="text" name="username" id="username" placeholder="请输入真实姓名" style="width:65%"/><b class="red" style="disabled">*</b>
					</formTable:tr>
					<formTable:tr title='公司名:'>
						<input type="text" name="companyName" id="companyName" placeholder="请输入公司名称" style="width:65%"/><b class="red">*</b>
					</formTable:tr>
					<formTable:tr title='QQ:'>
						<input type="text" name="qq" id="qq" placeholder="请输入qq" style="width:65%"/><b class="red">*</b>
					</formTable:tr>
					<formTable:tr title='email:'>
						<input type="text" name="email" id="email" placeholder="请输入正确email" style="width:65%"/><b class="red">*</b><span></span>
					</formTable:tr>
					<formTable:tr title='公司地址:'>
						<input type="text" name="address" id="address" placeholder="请输入公司的地址" style="width:65%"/><b class="red">*</b>
					</formTable:tr>
					<formTable:tr title='公司城市:'>
						 <select name="cityId" id="cityId" class="selectautocomplete">
                       	 <option  class="td-opt" >--请选择--</option>
                       	 <g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
											<option value="${city.id}">${city.name}</option>
									</g:each>
								</optgroup>
							</g:each>
                    </select><b class="red">*</b>
					</formTable:tr>
					<formTable:tr title='公司类型:'>
						<input type="radio" name="type" value="Cargo"  id="huozhu" checked/><span >货主</span>
            		    <input type="radio" name="type"  id="huodai" value="Agent"/><span>货代</span>
					</formTable:tr>
					<formTable:tr title='关注航线:'>
						<input type="checkbox" value="cb_MeiJia" id="cb_MeiJia" /><span>美加线</span>
                		 <input type="checkbox" value="cb_OuDi" id="cb_OuDi"/><span>欧地线</span>
                		 <input type="checkbox" value="cb_ZhongNanMei" id="cb_ZhongNanMei"/><span>中南美线</span>
					</formTable:tr>
					<formTable:tr title="">
						<input type="checkbox" value="cb_AoXin" id="cb_AoXin"/><span>澳新线</span>
                   		 <input type="checkbox" value="cb_ZhongNanMei" id="cb_ZhongNanMei"/><span>东南亚线</span>
                    		<input type="checkbox" value="cb_ZhongNanMei" id="cb_ZhongNanMei"/><span>日韩港澳台远东线</span>
					</formTable:tr>
					<formTable:tr title="">
						 <input type="checkbox" value="cb_ZhongNanMei" id="cb_ZhongNanMei"/><span>非洲线</span>
	                		<input type="checkbox" value="cb_ZhongNanMei" id="cb_ZhongNanMei"/><span>中东印巴红海线</span>
	               		 <input type="hidden" value="" name="recommendedRoutes" id="recommendedRoutes"/>
					</formTable:tr>
					
				
     	 </formTable:table>
     	 <p style="margin-bottom: -25px;">带有*的为必填项</p>
       </form>
       
       <div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-left">保存</a>
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 20px;">返回</a>
				
				<div class="clearfix"></div>
			</div>
       </div>
     </div>
    
    
<script>
$(function(){
    $('#huozhu').click(function(){
        $('#gzhxTitle').html('关注航线');
    });
    $('#huodai').click(function(){
        $('#gzhxTitle').html('优势航线');
    });
    $("#email").blur(function(){
        console.log("333");
    	var emailVal = $("#email").val().trim()+"";
    	 var myreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    	if(!myreg.test(emailVal)){ 
    		$("#reg-btn").prop({disabled:"disabled"});
    		$("#email").next('b').hide();
    		$("#email").next().next('span').html("请输入正确的email").removeClass('can-register').addClass("hint-msg");	
    		
    		 }
    })
    $("#mobile").blur(function(){
        console.log("222");
    	var mobileVal = $("#mobile").val().trim()+"";
    	
    	
    	//console.log(mobileVal);
    	//if(!(/(?:\+86)?1[0-9]{10}/.test(mobileVal))){ 
    	 if(!(/^(13[0-9]{9})|(15[0-9]{9})|(18[0-9]{9})$/.test(mobileVal))){ 
    		$("#reg-btn").prop({disabled:"disabled"});
    		$("#mobile").next('b').hide();
    		$("#mobile").next().next('span').html("请输入正确的手机号").removeClass('can-register').addClass("hint-msg");	
    		
    		 }else{
				$.post(location.origin+"/frontUser/isOldMobile",{"mobile":mobileVal},function(rs){
					if(rs.status < 0){
						$("#reg-btn").prop({disabled:"disabled"});
						$("#mobile").next('b').hide();
			    		$("#mobile").next().next('span').removeClass().html(rs.msg).addClass("hint-msg");     
						}else{
							$("#reg-btn").attr("disabled",false);
							$("#mobile").next('b').hide();
							$("#mobile").next().next('span').removeClass("hint-msg").html("").addClass("can-register");
							
							}
				
						});
					


        		 }
    	 /*$.post( location.origin+"/FrontUser/isOldMobile",{"mobile":mobileVal},function(rs){
             rs.status < 0 ? $("#mobile").next('span').html("123"):
            	 $("#mobile").next('span').css({
                    background:'url("../../images/register/pic_register.png") no-repeat 10px -800px', 
                    paddingLeft:'30px',
                    height:'32px'
                 });         
		
        });*/
    });
    $('input[type="checkbox"]').change(function(){
        var hxList = [];
        $('input[type="checkbox"]').each(function(){
            if($(this)[0].checked){
                hxList.push($(this).val());
                console.log(hxList);
            }
        });
        
        $('#recommendedRoutes').val(hxList.join(','));
    });
});

</script>
</body>
</html>