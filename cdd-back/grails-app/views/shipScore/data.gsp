<%@page import="com.cdd.base.domain.BackUser"%>
<!DOCTYPE>
<html>
<head>
<title>图片广告</title>
<meta name="layout" content="main">
<ckeditor:resources/>
<asset:javascript src="jquery.multi-select.js" />
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="role/data.css" />
</head>
<body>
<div class="row">
	<div class="col-md-12">
		<div class="block">
			<form action="${request.contextPath}/shipScore/save" method="post" id="dataForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='公司名称'>
						<input type="text" readonly="readonly" value="${data.companyName}" />
					</formTable:tr>
					<formTable:tr title='放舱效率'>
						<input type="text" readonly="readonly" value="${data.shipInTime}" />
					</formTable:tr>
					<formTable:tr title='单证及时率'>
						<input type="text" readonly="readonly" value="${data.docInTime}" />
					</formTable:tr>
					<formTable:tr title='性价比'>
						<input type="text" readonly="readonly" value="${data.infoInTime}" />
					</formTable:tr>
					<formTable:tr title='付款速度'>
						<input type="text" readonly="readonly" value="${data.serviceQuality}" />
					</formTable:tr>
					<formTable:tr title='服务内容'>
						<input type="text" readonly="readonly" value="${data.serviceContent}" />
					</formTable:tr>
					<formTable:tr title='诚信'>
						<g:if test="${data.hornest}">
							<input type="radio" name="hornest" value="true" checked="checked" />是 
							<input style="margin-left: 20px;" type="radio" name="hornest" value="false" />否 
						</g:if>
						<g:else>
							<input type="radio" name="hornest" value="true"/>是 
							<input style="margin-left: 20px;" type="radio" name="hornest" value="false" checked="checked" />否 
						</g:else>
					</formTable:tr>
					<formTable:tr title='保障'>
						<g:if test="${data.safety}">
							<input type="radio" name="safety" value="true" checked="checked" />是 
							<input style="margin-left: 20px;" type="radio" name="safety" value="false" />否 
						</g:if>
						<g:else>
							<input type="radio" name="safety" value="true"/>是 
							<input style="margin-left: 20px;" type="radio" name="safety" value="false" checked="checked" />否 
						</g:else>
					</formTable:tr>
					<formTable:tr title='认证'>
						<g:if test="${data.verified}">
							<input type="radio" name="verified" value="true" checked="checked" />是 
							<input style="margin-left: 20px;" type="radio" name="verified" value="false" />否 
						</g:if>
						<g:else>
							<input type="radio" name="verified" value="true"/>是 
							<input style="margin-left: 20px;" type="radio" name="verified" value="false" checked="checked" />否 
						</g:else>
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>