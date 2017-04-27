<%@page import="com.cdd.base.enums.TransportationType"%>
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>订单信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">垃圾货代信息</div>
			<form id="dataForm">
			<formTable:table>
				<formTable:tr title='航线:'>
					<input type="text" readonly="readonly" value="${data.routeName}" />
				</formTable:tr>
				<formTable:tr title='审核状态:'>
					<input type="text" readonly="readonly" value="${data.status?.text}" />
				</formTable:tr>
				<formTable:tr title='负责客服:'>
					<input type="text" readonly="readonly" value="${data.service?.firstname}" />
				</formTable:tr>
				<formTable:tr title='航线:'>
					<input type="text" readonly="readonly" value="${data.routeName}" />
				</formTable:tr>
				<formTable:tr title='公司:'>
					<input type="text" readonly="readonly" value="${data.companyName}" />
				</formTable:tr>
				<formTable:tr title='所在地:'>
					<input type="text" readonly="readonly" value="${data.city?.name}" />
				</formTable:tr>
				<formTable:tr title='地址:'>
					<input type="text" readonly="readonly" value="${data.address}" />
				</formTable:tr>
				<formTable:tr title='联系人:'>
					<input type="text" readonly="readonly" value="${data.contactName}" />
				</formTable:tr>
				<formTable:tr title='联系方式:'>
					<input type="text" readonly="readonly" value="${data.phone}" />
				</formTable:tr>
				<formTable:tr title='始发港:'>
					<input type="text" readonly="readonly" value="${data.startPort}" />
				</formTable:tr>
				<formTable:tr title='始发港(中文):'>
					<input type="text" readonly="readonly" value="${data.startPortCn}" />
				</formTable:tr>
				<formTable:tr title='目的港:'>
					<input type="text" readonly="readonly" value="${data.endPort}" />
				</formTable:tr>
				<formTable:tr title='目的港(中文):'>
					<input type="text" readonly="readonly" value="${data.endPortCn}" />
				</formTable:tr>
				<formTable:tr title='中转港:'>
					<input type="text" readonly="readonly" value="${data.middlePort}" />
				</formTable:tr>
				<formTable:tr title='中转港(中文):'>
					<input type="text" readonly="readonly" value="${data.middlePortCn}" />
				</formTable:tr>
				<formTable:tr title='船公司:'>
					<input type="text" readonly="readonly" value="${data.shipCompany}" />
				</formTable:tr>
				<formTable:tr title='船期:'>
					<input type="text" readonly="readonly" value="${data.shippingDay}" />
				</formTable:tr>
				<formTable:tr title='航程:'>
					<input type="text" readonly="readonly" value="${data.shippingDays}" />
				</formTable:tr>
				<formTable:tr title='开始日期:'>
					<input type="text" readonly="readonly" value="${data.startDate ? dateFormat.format(data.startDate): ''}" />
				</formTable:tr>
				<formTable:tr title='结束日期:'>
					<input type="text" readonly="readonly" value="${data.endDate ? dateFormat.format(data.endDate): ''}" />
				</formTable:tr>
				<formTable:tr title='运输类型:'>
					<input type="text" readonly="readonly" value="${data.transType?.text}" />
				</formTable:tr>
				<formTable:tr title='USD/20GP:'>
					<input type="text" readonly="readonly" value="${data.prices?.gp20}" />
				</formTable:tr>
				<formTable:tr title='USD/40GP:'>
					<input type="text" readonly="readonly" value="${data.prices?.gp40}" />
				</formTable:tr>
				<formTable:tr title='USD/40HQ:'>
					<input type="text" readonly="readonly" value="${data.prices?.hq40}" />
				</formTable:tr>
				<formTable:tr title='USD/45HQ:'>
					<input type="text" readonly="readonly" value="${data.prices?.hq45}" />
				</formTable:tr>
				<formTable:tr title='附加费:'>
					<textarea  readonly="readonly">${data.prices?.extra}</textarea>
				</formTable:tr>
				<formTable:tr title='限重:'>
					<textarea readonly="readonly">${data.weightLimit}</textarea>
				</formTable:tr>
				<formTable:tr title='货主备注:'>
					<textarea readonly="readonly">${data.remark}</textarea>
				</formTable:tr>
				<formTable:tr title='员工备注:'>
					<textarea readonly="readonly">${data.memo}</textarea>
				</formTable:tr>
			</formTable:table>
			</form>
		</div>
	</div>
<%--</div>
--%></body>
</html>