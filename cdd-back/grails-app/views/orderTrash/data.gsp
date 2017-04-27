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
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">无效货盘信息</div>
			<form id="dataform">
			<formTable:table>
				<formTable:tr title='订单号:'>
					<input type="text" readonly="readonly" value="${data.number}" />
				</formTable:tr>
				<formTable:tr title='审核状态:'>
					<input type="text" readonly="readonly" value="${data.status?.text}" />
				</formTable:tr>
				<formTable:tr title='负责客服:'>
					<input type="text" readonly="readonly" value="${data.service?.firstname}" />
				</formTable:tr>
				<formTable:tr title='交易状态:'>
					<input type="text" readonly="readonly" value="${data.orderStatus?.text}" />
				</formTable:tr>
				<formTable:tr title='负责业务员:'>
					<input type="text" readonly="readonly" value="${data.sales?.firstname}" />
				</formTable:tr>
				<g:if test="${data.certFilePath}">
					<formTable:tr title='凭证:'>
						<a href="${request.contextPath}/${data.certFilePath}" target="_blank">查看文件</a>
					</formTable:tr>
				</g:if>
				<formTable:tr title='货物:'>
					<input type="text" readonly="readonly" value="${data.cargoName}" />
				</formTable:tr>
				<formTable:tr title='公司:'>
					<input type="text" readonly="readonly" value="${data.companyName}" />
				</formTable:tr>
				<formTable:tr title='所在地:'>
					<input type="text" readonly="readonly" value="${data.city?.name}" />
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
				<formTable:tr title='走货开始日期:'>
					<input type="text" readonly="readonly" value="${data.startDate ? dateFormat.format(data.startDate): ''}" />
				</formTable:tr>
				<formTable:tr title='走货结束日期:'>
					<input type="text" readonly="readonly" value="${data.endDate ? dateFormat.format(data.endDate): ''}" />
				</formTable:tr>
				<formTable:tr title='报价截止日期:'>
					<input type="text" readonly="readonly" value="${data.biteEndDate ? dateFormat.format(data.biteEndDate): ''}" />
				</formTable:tr>
				<formTable:tr title='订单类型:'>
					<input type="text" readonly="readonly" value="${data.orderType}" />
				</formTable:tr>
				<formTable:tr title='运输类型:'>
					<input type="text" readonly="readonly" value="${data.transType?.text}" />
				</formTable:tr>
				<g:if test="${data.transType == TransportationType.Whole}">
					<formTable:tr title='箱型:'>
						<input type="text" readonly="readonly" value="${data.cargoBoxType?.text}" />
					</formTable:tr>
					<formTable:tr title='数量:'>
						<input type="text" readonly="readonly" value="${data.cargoBoxNums}" />
					</formTable:tr>
				</g:if>
				<g:elseif test="${data.transType == TransportationType.Together}">
					<formTable:tr title='件数:'>
						<input type="text" readonly="readonly" value="${data.cargoNums}" />
					</formTable:tr>
					<formTable:tr title='毛重(KG):'>
						<input type="text" readonly="readonly" value="${data.cargoWeight}" />
					</formTable:tr>
					<formTable:tr title='体积(CBM):'>
						<input type="text" readonly="readonly" value="${data.cargoCube}" />
					</formTable:tr>
					<formTable:tr title='长(CM):'>
						<input type="text" readonly="readonly" value="${data.cargoLength}" />
					</formTable:tr>
					<formTable:tr title='宽(CM):'>
						<input type="text" readonly="readonly" value="${data.cargoWidth}" />
					</formTable:tr>
					<formTable:tr title='高(CM):'>
						<input type="text" readonly="readonly" value="${data.cargoHeight}" />
					</formTable:tr>
				</g:elseif>
				<g:if test="${shipInfos}">
					<formTable:tr title="意向报价:">
						<ul>
							<g:each in="${shipInfos}" var="ship">
								<li><a href="${request.contextPath}/shipInfo/data/${ship.id}" target="ship_info">${info.startPort} | ${info.endPort} | ${info.shippingDay}</a></li>
							</g:each>
						</ul>
					</formTable:tr>
				</g:if>
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