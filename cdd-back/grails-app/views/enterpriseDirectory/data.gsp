<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <meta name="layout" content="main">
    <asset:stylesheet src="form-table.css" />
</head>
<body><%--
        <div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">新增用户</div>
			<form id="dataform">
			<formTable:table>
				<formTable:tr title='公司名称:'>
					<input type="text" readonly="readonly" value="${data.companyName}" style="width:150%"/>
				</formTable:tr>
				<formTable:tr title='公司名称(英文):'>
					<input type="text" readonly="readonly" value="${data.companyEnglish}" style="width:150%"/>
				</formTable:tr>
				<formTable:tr title='所属城市:'>
					<input type="text" readonly="readonly" value="${data.city}" />
				</formTable:tr>
				<formTable:tr title='地址:'>
					<input type="text" readonly="readonly" value="${data.address}" />
				</formTable:tr>
				<formTable:tr title='Email:'>
					<input type="text" readonly="readonly" value="${data.email}" style="width:150%"/>
				</formTable:tr>
				<formTable:tr title='联系电话:'>
					<input type="text" readonly="readonly" value="${data.mobile}" />
				</formTable:tr>
				<formTable:tr title='货主姓名:'>
					<input type="text" readonly="readonly" value="${data.contactName}" />
				</formTable:tr>
				<formTable:tr title='手机号码:'>
					<input type="text" readonly="readonly" value="${data.telephone}" />
				</formTable:tr>
				<formTable:tr title='QQ:'>
					<input type="text" readonly="readonly" value="${data.qq}" />
				</formTable:tr>
				<formTable:tr title='备注:'>
					<input type="text" readonly="readonly" value="${data.remark1}" />
				</formTable:tr>
							<%--
				--%>
			</formTable:table>
			<div class="buttons">
			
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary pull-right">后退</a>
				
				<div class="clearfix"></div>
			</div>
			</form>
		</div>
	</div>
<%--</div>
--%></body>
</html>