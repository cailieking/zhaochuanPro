<%@page import="com.cdd.base.enums.TransportationType"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<%@page import="com.cdd.base.enums.OrderType"%>
<%@page import="com.cdd.base.enums.CargoBoxType"%>
<g:set var="cityService" bean="cityService" />
<g:set var="cargoShipInformationService" bean="cargoShipInformationService" />
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
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">撮合交易信息</div>	
			<form action="${request.contextPath}/orderTrade/update" method="post" id="dataForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${data.id}" />
				<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
				</div>
				<formTable:table>
					<formTable:tr title='订单号:'>
						<input type="text" readonly="readonly" value="${data.number}" />
					</formTable:tr>
					<formTable:tr title='交易状态:'>
						<select id="orderStatusSelect" name="orderStatus" class="selectpicker">
							<g:each in="${OrderStatus.values()}" var="status">
								<g:if test="${data.orderStatus == status}">
									<option selected="selected" value="${status.name()}">${status.text}</option>
								</g:if>
								<g:else>
									<option value="${status.name()}">${status.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='凭证:'>
						<g:if test="${data.certFilePath}">
							<a href="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${data.certFilePath}" target="_blank">查看文件</a>
						</g:if>
						<g:else>
							<input type="file" name="file" style="display: inline; margin-right: 10px;"/>
						</g:else>
					</formTable:tr>
					<formTable:tr title='委托单:'>
						<g:if test="${data.bookingFilePath}">
							<a href="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${data.bookingFilePath}" target="_blank">查看文件</a>
						</g:if>
					</formTable:tr>
					<formTable:tr title='货物:'>
						<input name="cargoName" type="text" value="${data.cargoName}" />
					</formTable:tr>
					<formTable:tr title='公司:'>
						<input readonly="readonly" name="companyName" type="text" value="${data.companyName}" />
					</formTable:tr>
					<formTable:tr title='所在地:'>
						<select name="cityId" class="selectautocomplete">
							<option value="">--请选择--</option>
							<g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
										<g:if test="${data.city?.id == city.id}">
											<option selected="selected" value="${city.id}">${city.name}</option>
										</g:if>
										<g:else>
											<option value="${city.id}">${city.name}</option>
										</g:else>
									</g:each>
								</optgroup>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='联系人:'>
						<input type="text" readonly="readonly" value="${data.contactName}" />
					</formTable:tr>
					<formTable:tr title='联系方式:'>
						<input type="text" readonly="readonly" value="${data.phone}" />
					</formTable:tr>
					<formTable:tr title='始发港:'>
						<input name="startPort" type="text" value="${data.startPort}" />
					</formTable:tr>
					<formTable:tr title='始发港(中文):'>
						<input name="startPortCn" type="text" value="${data.startPortCn}" />
					</formTable:tr>
					<formTable:tr title='目的港:'>
						<input name="endPort" type="text" value="${data.endPort}" />
					</formTable:tr>
					<formTable:tr title='目的港(中文):'>
						<input name="endPortCn" type="text" value="${data.endPortCn}" />
					</formTable:tr>
					<formTable:tr title='走货开始日期:'>
						<input name="startDate" class="datepicker" type="text" value="${data.startDate ? dateFormat.format(data.startDate): ''}" />
					</formTable:tr>
					<formTable:tr title='走货结束日期:'>
						<input name="endDate" class="datepicker" type="text" value="${data.endDate ? dateFormat.format(data.endDate): ''}" />
					</formTable:tr>
					<formTable:tr title='报价截止日期:'>
						<input name="biteEndDate" class="datepicker" type="text" value="${data.biteEndDate ? dateFormat.format(data.biteEndDate): ''}" />
					</formTable:tr>
					<formTable:tr title='成交价格(USD):'>
						<input name="dealPrice" type="text" value="${data.dealPrice}" />
					</formTable:tr>
					<formTable:tr title='订单类型:'>
						<input name="orderType" type="text" value="${data.orderType}" />
						<%-- 
							<select name="orderType" class="selectpicker">
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
						<select name="transType" id="transTypeSelect" class="selectpicker">
							<g:each in="${TransportationType.values()}" var="type">
								<g:if test="${data.transType == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='箱型:'>
						<select name="cargoBoxType" class="selectpicker transData">
							<option value="">--请选择--</option>
							<g:each in="${CargoBoxType.values()}" var="type">
								<g:if test="${data.cargoBoxType == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='数量:'>
						<input name="cargoBoxNums" type="text" class="transData" value="${data.cargoBoxNums}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='件数:'>
						<input name="cargoNums" type="text" class="transData" value="${data.cargoNums}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='毛重(KG):'>
						<input name="cargoWeight" type="text" class="transData" value="${data.cargoWeight}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='体积(CBM):'>
						<input name="cargoCube" type="text" class="transData" value="${data.cargoCube}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='长(CM):'>
						<input name="cargoLength" type="text" class="transData" value="${data.cargoLength}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='宽(CM):'>
						<input name="cargoWidth" type="text" class="transData" value="${data.cargoWidth}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='高(CM):'>
						<input name="cargoHeight" type="text" class="transData" value="${data.cargoHeight}" />
					</formTable:tr>
					<formTable:tr title='货主备注:'>
						<textarea readonly="readonly">${data.remark}</textarea>
					</formTable:tr>
					<g:if test="${shipInfos}">
						<formTable:tr title="意向报价:">
							<ul>
								<g:each in="${shipInfos}" var="ship">
									<li><a href="${request.contextPath}/shipInfo/data/${ship.id}" target="ship_info">${ship.shipCompany} | ${ship.shippingDay}</a></li>
								</g:each>
							</ul>
						</formTable:tr>
					</g:if>
					<formTable:tr title='货代信息:'>
	
						 <g:if test="${data.orderStatus == OrderStatus.UnTrade}">
						 	<g:if test="${data.owner}">
								<a id="recommendBtn" style="margin-left: 10px;" href="javascript:;">推送货代</a>
						 	</g:if>
						 	<g:else>
								<a id="recommendBtn" style="margin-left: 10px;" href="javascript:;">撮合货代</a>
						 	</g:else>
						 </g:if>
						 <g:else>
						 	<a id="agentDetailBtn" style="margin-left: 10px;" href="javascript:;">查看货代</a>
						 </g:else>
					</formTable:tr>
					<formTable:tr title='货主备注:'>
						<textarea name="remark">${data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='员工备注:'>
						<textarea name="memo">${data.memo}</textarea>
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

--%><script>

	 <g:if test="${data.orderStatus == OrderStatus.UnTrade}">
		$("#recommendBtn").click(function() {
			window.open('${request.contextPath}/recommendAgent/list/${data.id}');
		});
	 </g:if>
	 <g:else>
		$("#agentDetailBtn").click(function() {
			window.open('${request.contextPath}/shipInfo/data/${data.info?.id}');
		});
	 </g:else>

	<%--
	$("#infoIdSelect").change(function() {
		var value = $(this).val();
		if(value == '') {
			$("#detailBtn").hide();
		} else {
			$("#detailBtn").show();
		}
	}).change(); 
	--%>

	$("#transTypeSelect").change(function() {
		//$(".transData").val('').change();
		var value = $(this).val();
		$("tr[type='trans']").hide();
		$("tr[name='trans_" + value + "']").show();
	});
	$("#transTypeSelect").change();
</script>
</body>
</html>