<%@page import="com.cdd.base.domain.BackUser"%>
<%@page import="com.cdd.base.enums.AdvertisementType"%>
<!DOCTYPE>
<html>
<head>
<title>合作商信息</title>
<meta name="layout" content="main">
<ckeditor:resources/>
<asset:javascript src="jquery.multi-select.js" />
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="role/data.css" />     
<asset:javascript src="replace.js" />
</head> 
<body> 

<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">货代信息</div>
			<form action="${request.contextPath}/advCorp/save" method="post" id="dataForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${data.id}" />
				<div class="buttons">
					<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
					<div class="clearfix"></div>
				</div>
				<formTable:table>
					<formTable:tr title='类型:'>
						<select name="type" class="selectpicker">
							<option value="">--请选择--</option>
							<g:each in="${AdvertisementType.values()}" var="type">
								<g:if test="${data.type == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='顺序:'>
						<input type="text" name="order" value="${data.order}" />
					</formTable:tr>
					<formTable:tr title='图片:'>
						<g:if test="${data.image}">
							<div>
								<img src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${data.image}" />
							</div>
						</g:if>
						<div style="margin: 10px 0">
							<input type="file" name="file" />
						</div>
					</formTable:tr>
					<formTable:tr title='内容:'>
						<textarea  cols="80" id="content" name="content" rows="10">  ${data.content?.encodeAsRaw()}</textarea> 
						 <script>
						 <%-- CKEDITOR.replace(${profile.catName});--%>
						 		$(function(){
						 			replace("content")
							 	})
						 		
						 </script>
						<%-- <ckeditor:editor  height="300px" width="1000px" name="content">
						${data.content}
						</ckeditor:editor>--%>
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 1080px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%></body>
</html>