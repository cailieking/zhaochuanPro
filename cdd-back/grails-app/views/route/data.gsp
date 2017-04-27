<%@page import="com.cdd.base.enums.RouteType"%>
<%@page import="com.cdd.base.enums.RouteCategory"%>
<!DOCTYPE>
<html>
<head>
<title>航线分类信息</title>
<meta name="layout" content="main">
<ckeditor:resources/>
<asset:javascript src="jquery.multi-select.js" />
<asset:stylesheet src="form-table.css" />
<asset:javascript src="jquery-1.8.0.min.js"/>
<asset:javascript src="jquery.validate.js"/>

 <style type="text/css">
		 .red { 
            display: inline-block;
            font-weight: normal;
            color: #ff0000;
            margin-left: 5px;
        }
    </style>
<script type="text/javascript">
	
	function validate(form)
	{
		var port = $("#port").val();
		if(port==""||port==null){
			$("#port_span").text("请输入港口名!");
			port.focus();
			return false;
		}else{
			$("#port_span").text(" ");
		}
		$("#dataForm").submit();
	}
</script>
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">航线信息</div>
			<form action="${request.contextPath}/route/save" method="post" id="dataForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='港口:'>
						<input type="text" name="port" value="${data.port}" placeholder="港口" id="port" />
						<span class="red" id="port_span">*</sapn>
					</formTable:tr>
					<formTable:tr title='类别:'>
						<select name="category" class="selectpicker">
							<option value="">--请选择--</option>
							<g:each in="${RouteCategory.values()}" var="category" placeholder="类别">
								<g:if test="${data.category == category}">
									<option selected="selected" value="${category.name()}">${category.text}</option>
								</g:if>
								<g:else>
									<option value="${category.name()}">${category.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='类型:'>
						<select name="type" class="selectpicker">
							<option value="">--请选择--</option>
							<g:each in="${RouteType.values()}" var="type">
								<g:if test="${data.type == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='城市:'>
						<input type="text" name="city" value="${data.city}" placeholder="城市"/>
					</formTable:tr>
					<formTable:tr title='简写:'>
						<input type="text" name="shortName" value="${data.shortName}" placeholder="简写"/>
					</formTable:tr>
				</formTable:table>
			</form><!-- onclick="$('#dataForm').submit();" -->
			<div class="buttons">
				<a href="javascript:;"  onclick="return validate(this.form);"  class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 1030px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%></body>
</html>