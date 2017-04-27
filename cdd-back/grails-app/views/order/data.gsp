<%@page import="com.cdd.base.enums.TransportationType"%>
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>货盘信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">货盘信息</div>
			<form id="dataform">
			<table>
			 <tr class="only-tr">
			   
				<td>货盘编号</td><td   title='货盘编号'>
					<input type="text" readonly="readonly" value="${data.data.number}" />
				</td >
				 
				<td>审核状态</td><td   title='审核状态'>
					<input type="text" readonly="readonly" value="${data.data.status?.text}" />
				</td >
				 
				<td>负责客服</td><td   title='负责客服'>
					<input type="text" readonly="readonly" value="${data.data.service?.firstname}" />
				</td >
				</tr>
				 <tr class="only-tr">
				 
				<td>交易状态</td><td   title='交易状态'>
					<input type="text" readonly="readonly" value="${data.data.orderStatus?.text}" />
				</td >
				 
				<td>负责业务员</td><td   title='负责业务员'>
					<input type="text" readonly="readonly" value="${data.data.sales?.firstname}" />
				</td >
				<g:if test="${data.data.certFilePath}">
					<td>凭证</td><td   title='凭证'>
						<a href="${request.contextPath}/${data.data.certFilePath}" target="_blank">查看文件</a>
					</td >
				</g:if>
				</tr>
				 <tr class="only-tr">
				<td>货物</td><td   title='货物'>
					<input type="text" readonly="readonly" value="${data.data.cargoName}" />
				</td >
				<td>公司</td><td   title='公司名称'>
					<input type="text" readonly="readonly" value="${data.data.companyName}" />
				</td >
				<td>所在地</td><td   title='所在地'>
					<input type="text" readonly="readonly" value="${data.data.city?.name}" />
				</td >
				</tr>
				 <tr class="only-tr">
				<td>联系人</td><td   title='联系人'>
					<input type="text" readonly="readonly" value="${data.data.contactName}" />
				</td >
				<td>联系方式</td><td   title='联系方式'>
					<input type="text" readonly="readonly" value="${data.data.phone}" />
				</td >
				<td>始发港</td><td   title='始发港'>
					<input type="text" readonly="readonly" value="${data.data.startPort}" />
				</td >
				</tr>
				 <tr class="only-tr">
				<td>始发港(中文)</td><td   title='始发港(中文)'>
					<input type="text" readonly="readonly" value="${data.data.startPortCn}" />
				</td >
				<td>目的港</td><td   title='目的港'>
					<input type="text" readonly="readonly" value="${data.data.endPort}" />
				</td >
				<td>目的港(中文)</td><td   title='目的港(中文)'>
					<input type="text" readonly="readonly" value="${data.data.endPortCn}" />
				</td >
				</tr>
				 <tr class="only-tr">
				<td>走货开始日期</td><td   title='走货开始日期'>
					<input type="text" readonly="readonly" value="${data.data.startDate ? dateFormat.format(data.data.startDate): ''}" />
				</td >
				<td>走货结束日期</td><td   title='走货结束日期'>
					<input type="text" readonly="readonly" value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" />
				</td >
				<td>报价截止日期</td><td   title='报价截止日期'>
					<input type="text" readonly="readonly" value="${data.data.biteEndDate ? dateFormat.format(data.data.biteEndDate): ''}" />
				</td >
				</tr>
				 <tr class="only-tr">
				<td>订单类型</td><td   title='订单类型'>
					<input type="text" readonly="readonly" value="${data.data.orderType}" />
				</td >
				<td>运输类型</td><td   title='运输类型'>
					<input type="text" readonly="readonly" value="${data.data.transType?.text}" />
				</td >
				<g:if test="${data.data.transType == TransportationType.Whole}">
					<g:if test="${data.str!=null }">
						<tr class="only-tr">
							<td>箱型</td>
							<td title="GP20">
											<span>${data.GP20 }：</span>
											<span style="margin-left: 15px;color: orange;">${data.GP20CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
							<td title="GP40">
											<span>${data.GP40 }：</span>
											<span style="margin-left: 15px;color: orange;">${data.GP40CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
							<td title="HQ40">
											<span>${data.HQ40 }：</span>
											<span style="margin-left: 15px;color: orange;">${data.HQ40CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
							<td title="HQ45">
											<span>${data.HQ45 }：</span>
											<span style="margin-left: 15px;color: orange;">${data.HQ45CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
						</tr>
					</g:if>
					<g:if test="${data.str==null }">
						<tr class="only-tr">
							<td>箱型</td>
							<td>
								<span>${data.data.cargoBoxType}：</span>
								<span style="margin-left: 15px;color: orange;">${data.data.cargoBoxNums }</span>
								<span style="margin-left: 15px;">TEU</span>
							</td>
							
						</tr>
					</g:if>
					
				</g:if>
				
				 
				<g:elseif test="${data.data.transType == TransportationType.Together}">
					<td>件数</td><td   title='件数'>
						<input type="text" readonly="readonly" value="${data.data.cargoNums}" />
					</td >
					
					<%-- <td>长(CM)</td><td   title='长(CM)'>
						<input type="text" readonly="readonly" value="${data.data.cargoLength}" />
					</td >
					<td>宽(CM)</td><td   title='宽(CM)'>
						<input type="text" readonly="readonly" value="${data.data.cargoWidth}" />
					</td >
					</tr>
					 <tr class="only-tr">
					<td>高(CM)</td><td   title='高(CM)'>
						<input type="text" readonly="readonly" value="${data.data.cargoHeight}" />
					</td >--%>
				</g:elseif>
				<td>毛重(KG)</td><td   title='毛重(KG)'>
						<input type="text" readonly="readonly" value="${data.data.cargoWeight}" />
					</td >
					</tr>
					 <tr class="only-tr">
					<td>体积(CBM)</td><td   title='体积(CBM)'>
						<input type="text" readonly="readonly" value="${data.data.cargoCube}" />
					</td >
				<g:if test="${shipInfos}">
					<td>意向报价</td><td   title="意向报价">
						<ul>
							<g:each in="${shipInfos}" var="ship">
								<li><a href="${request.contextPath}/shipInfo/data/${ship.id}" target="ship_info">${info.startPort} | ${info.endPort} | ${info.shippingDay}</a></li>
							</g:each>
						</ul>
					</td >
				</g:if>
				<td>货主备注</td><td   title='货主备注'>
					<textarea readonly="readonly">${data.data.remark}</textarea>
				</td >
				</tr>
				 <tr class="only-tr">
				<td>员工备注</td><td   title='员工备注'>
					<textarea readonly="readonly">${data.data.memo}</textarea>
				</td >
				</tr>
				<tr class="only-tr">
				<td>关闭理由</td><td   title='关闭理由'>
					<textarea readonly="readonly">${data.data.closeReason}</textarea>
				</td >
				</tr>
			</table>
			</form>
		</div>
	</div>
<%--</div>
--%></body>
</html>