<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <meta name="layout" content="main">
    <asset:stylesheet src="form-table.css" />
    <asset:javascript src="jquery-1.8.0.min.js" />
    <asset:javascript src="jquery.validate.js" />
    
    <style type="text/css">
    	 .red { 
            display: inline-block;
            font-weight: normal;
            color: #ff0000;
            margin-left: 5px;
        }
    </style>
    <script type="text/javascript">
		function validate(form){
			var companyName=$.trim($("#companyName").val());
			var companyEnglish=$.trim($("#companyEnglish").val());
			var city =$.trim($("#city").val());
			var address =$.trim($("#address").val());
			var email = $.trim($("#email").val());
			var mobile = $.trim($("#mobile").val());
			var contactName = $.trim($("#contactName").val());
			var telephone = $.trim($("#telephone").val());
			var qq=$.trim($("#qq").val());

			if(companyName==""||companyName==null){
				$("#span_companyName").text("请输入公司名称!");
				companyName.focus();
				return false;
			}
			else {
				$("#span_companyName").text(" ");
			}
			if(companyEnglish==""||companyEnglish==null){
				$("#span_companyEnglish").text("请输入公司名称(英文)!");
				companyEnglish.focus();
				return false;
			}
			else {
				$("#span_companyEnglish").text(" ");	
			}
			if(city==""||city==null){
				$("#span_city").text("请输入所属城市!");
				city.focus();
				return false;
			}else{
				$("#span_city").text(" ");
			}
			if(address==""||address==null){
				$("#span_address").text("请输入地址!");
				address.focus();
				return false;
			}else{
				$("#span_address").text(" ");
			}
			if(email==""||email==null){
				$("#span_email").text("请输入邮箱!");
				email.focus();
				return false;
			}
			else{
				 var mail = /^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$/;
				if(!mail.test(email)){
					$("#span_email").text("请输入正确邮箱!");
						email.focus();
						return false;
					}
				$("#span_email").text("");
			}
			if(mobile==""||mobile==null){
				$("#span_mobile").text("请输入联系电话!");
				mobile.focus();
				return false;
			}else{
				 var phone = /^0\d{2,3}-\d{7,8}$/;
				 if(!phone.test(mobile)){
					 $("#span_mobile").text("请输入正确联系电话!");
					 mobile.focus();
					 return false;
					 }
				$("#span_mobile").text("");
			}
			if(contactName==""||contactName==null){
				$("#span_contactName").text("请输入货主姓名!");
				contactName.focus();
				return false;
			}else{
				$("#span_contactName").text("");
			}
			if(telephone==""||telephone==null){
				$("#span_telephone").text("请输入手机号码");
				telephone.focus();
				return false;
			}
			else{
				var reg=/^1[3|4|5|8][0-9]{9}$/;
				if(!reg.test(telephone)){
					$("#span_telephone").text("请输入正确手机号码!");
					telephone.focus();
					return false;
			}
				$("#span_telephone").text(" ");
		}
			$("#dataForm").submit();	
		}
    </script>
</head>
<body>
        <%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">新增用户</div>
			<div class="panel-body pn">
	<form action="${request.contextPath}/enterpriseDirectory/save" method="post" id="dataForm">
		
			<formTable:table>
						<input type="hidden" name="id" value="${data.id}" />
				<formTable:tr title='公司名称:'>
					<input type="text" name="companyName" value="${data.companyName}" placeholder="公司名称" id="companyName"/>
					<span  class="red" id="span_companyName">*</span>
				</formTable:tr>
				<formTable:tr title='公司名称(英文):'>
					<input type="text" name="companyEnglish" value="${data.companyEnglish}" placeholder="公司名称（英文）" id="companyEnglish"/>
					<span class="red" id="span_companyEnglish">*</span>
				</formTable:tr>
				<formTable:tr title='所属城市:'>
					<input type="text" name="city" value="${data.city}" placeholder="所属城市" id="city"/>
					<span class="red" id="span_city">*</span>
				</formTable:tr>
				<formTable:tr title='地址:'>
					<input type="text" name="address" value="${data.address}" placeholder="地址" id="address"/>
					<span class="red" id="span_address">*</span>
				</formTable:tr>
				<formTable:tr title='Email:'>
					<input type="text" name="email" value="${data.email}" placeholder="email" id="email" />
					<span class="red" id="span_email">*</span>
				</formTable:tr>
				<formTable:tr title='联系电话:'>
					<input type="text" name="mobile" value="${data.mobile}" placeholder="联系电话" id="mobile" />
					<span class="red" id="span_mobile">*</span>
				</formTable:tr>
				<formTable:tr title='货主姓名:'>
					<input type="text" name="contactName" value="${data.contactName}" placeholder="货主姓名" id="contactName" />
					<span class="red" id="span_contactName">*</span>
				</formTable:tr>
				<formTable:tr title='手机号码:'>
					<input type="text" name="telephone" value="${data.telephone}" placeholder="手机号" maxlength="11" id="telephone" />
					<span class="red" id="span_telephone">*</span>
				</formTable:tr>
				<formTable:tr title='QQ:'>
					<input type="text" name="qq" value="${data.qq}" placeholder="可不填写，我们会主动联系您!" id="qq" />
					<span class="red"></span>
				</formTable:tr>
				<formTable:tr title='备注:'>
					<input type="textarea" name="remark1" value="${data.remark1}" placeholder="备注"/>
				</formTable:tr>
				
			</formTable:table>
			
			<!-- $('#dataForm').submit()  -->
			
			
			<div class="buttons">
				<a href="javascript:;" onclick="return validate(this.form);" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" class="button button-glow button-rounded button-raised button-primary" id="back" onclick="window.history.back()" style="margin-left:920px;">返回</a>
				 <p style="margin-bottom: -25px;">带有*的为必填项</p>
        		<div class="clearfix"></div>
			</div>
			</div>
		</div>
	</div>
	</form>
<%--</div>
--%></body>
</html>