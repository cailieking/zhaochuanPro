<%@page import="com.cdd.base.enums.TransportationType"%>
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<%@page import="com.cdd.base.enums.OrderType"%>
<%@page import="com.cdd.base.enums.CargoBoxType"%>
<g:set var="cityService" bean="cityService" />
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
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">订单审核信息</div>
				<form id="dataform">
				<formTable:table>
					<formTable:tr title='货盘编号:'>
						<input type="text"  value="${data.data.number}" readonly="readonly"/>
					</formTable:tr>
					
					<formTable:tr title='审核状态:'>
						<input type="text" readonly="readonly" value="${data.data.status?.text }"/>
					</formTable:tr>
					<formTable:tr title='货物:'>
						<input name="cargoName" type="text"  value="${data.data.cargoName}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='公司:'>
						<input  name="companyName" type="text" value="${data.data.companyName}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='所在地:'>
						<input type="text" readonly="readonly" value="${data.data.city?.name}" />
					</formTable:tr>
					<formTable:tr title='联系人:'>
						<input type="text"  value="${data.data.contactName}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='联系方式:'>
						<input type="text"  value="${data.data.phone}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='始发港:'>
						<input name="startPort" type="text"  value="${data.data.startPort}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='始发港(中文):'>
						<input name="startPortCn" type="text"  value="${data.data.startPortCn}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='目的港:'>
						<input name="endPort" type="text"  value="${data.data.endPort}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='目的港(中文):'>
						<input name="endPortCn" type="text"  value="${data.data.endPortCn}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='走货开始日期:'>
						<input type="text" readonly="readonly" value="${data.data.startDate ? dateFormat.format(data.data.startDate): ''}" />
					</formTable:tr>
					<formTable:tr title='走货结束日期:'>
						<input type="text" readonly="readonly"  value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" />
					</formTable:tr>
					<formTable:tr title='报价截止日期:'>
						<input type="text" readonly="readonly"  value="${data.data.biteEndDate ? dateFormat.format(data.data.biteEndDate): ''}" />
					</formTable:tr>
					<formTable:tr title='订单类型:'>
						<input name="orderType" type="text"  value="${data.data.orderType}" readonly="readonly"/>
							<%-- <select name="orderType" class="selectpicker">
								<g:each in="${OrderType.values()}" var="type">
									<g:if test="${data.orderType == type}">
										<option selected="selected" value="${type.name()}">${type.text}</option>
									</g:if>
									<g:else>
										<option value="${type.name()}">${type.text}</option>
									</g:else>
								</g:each>
							</select>
							--%>
					</formTable:tr>
					<formTable:tr title='运输类型:'>
						<input type="text" readonly="readonly" value="${data.data.transType?.text}" />
					</formTable:tr>
					<g:if test="${data.data.transType == TransportationType.Whole}">
							<g:if test="${data.str!=null }">
							<formTable:tr title='箱型'>
												<span>${data.GP20 }：</span>
												<span style="margin-left: 15px;color: orange;">${data.GP20CargoBoxNums }</span>
												<span style="margin-left: 15px;">TEU</span>
												<span>${data.GP40}：</span>
												<span style="margin-left: 15px;color: orange;">${data.GP40CargoBoxNums }</span>
												<span style="margin-left: 15px;">TEU</span>
												<span>${data.HQ40}：</span>
												<span style="margin-left: 15px;color: orange;">${data.HQ40CargoBoxNums }</span>
												<span style="margin-left: 15px;">TEU</span>
												<span>${data.HQ45}：</span>
												<span style="margin-left: 15px;color: orange;">${data.HQ45CargoBoxNums }</span>
												<span style="margin-left: 15px;">TEU</span>
							</formTable:tr>
						</g:if>
						<g:if test="${data.str==null }">
							<formTable:tr title='箱型:'>
									<span>${data.data.cargoBoxType}：</span>
									<span style="margin-left: 15px;color: orange;">${data.data.cargoBoxNums }</span>
									<span style="margin-left: 15px;">TEU</span>
							</formTable:tr>
						</g:if>
					</g:if>
					<g:elseif test="${data.data.transType == TransportationType.Together}">
						<formTable:tr type="trans" name="trans_Together" title='件数:'>
							<input name="cargoNums" type="text"  class="transData" value="${data.data.cargoNums}" readonly="readonly"/>
						</formTable:tr>
						<formTable:tr type="trans" name="trans_Together" title='毛重(KG):'>
							<input name="cargoWeight" type="text"  class="transData" value="${data.data.cargoWeight}" readonly="readonly"/>
						</formTable:tr>
						<formTable:tr type="trans" name="trans_Together" title='体积(CBM):'>
							<input name="cargoCube" type="text"  class="transData" value="${data.data.cargoCube}" readonly="readonly"/>
						</formTable:tr>
						<formTable:tr type="trans" name="trans_Together" title='长(CM):'>
							<input name="cargoLength" type="text"  class="transData" value="${data.data.cargoLength}" readonly="readonly"/>
						</formTable:tr>
						<formTable:tr type="trans" name="trans_Together" title='宽(CM):'>
							<input name="cargoWidth" type="text"  class="transData" value="${data.data.cargoWidth}" readonly="readonly"/>
						</formTable:tr>
						<formTable:tr type="trans" name="trans_Together" title='高(CM):'>
							<input name="cargoHeight" type="text"  class="transData" value="${data.data.cargoHeight}" readonly="readonly"/>
						</formTable:tr>
					</g:elseif>
					<formTable:tr title='货主备注:'>
						<textarea name="remark" readonly="readonly">${data.data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='员工备注:'>
						<textarea name="memo" readonly="readonly">${data.data.memo}</textarea>
					</formTable:tr>
				</formTable:table>
				</form>
		</div>
	</div>
<%--</div>
--%></body>
</html>