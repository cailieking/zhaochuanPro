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
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">修改订单审核信息</div>
			<form action="${request.contextPath}/orderAudit/update" method="post" id="dataForm">
			<input type="hidden" name="id" value="${data.data.id}" />
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
			</div>
				<formTable:table>
					<formTable:tr title='货盘编号:'>
						<input type="text"  value="${data.data.number}" readonly="readonly" />
					</formTable:tr>
					
					<formTable:tr title='审核状态:'>
						<select name="status" id="statusSelect" class="selectpicker">
							<g:each in="${Status.values()}" var="status">
								<g:if test="${data.data.status == status}">
									<option selected="selected" value="${status.name()}">${status.text}</option>
								</g:if>
								<g:else>
									<option value="${status.name()}">${status.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='货物:'>
						<input name="cargoName" type="text"  value="${data.data.cargoName}" placeholder="货物"/>
					</formTable:tr>
					<formTable:tr title='公司:'>
						<input  name="companyName" type="text" value="${data.data.companyName}" placeholder="公司"/>
					</formTable:tr>
					<formTable:tr title='所在地:'>
						<select name="cityId" class="selectautocomplete">
							<option value="">--请选择--</option>
							<g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
										<g:if test="${data.data.city?.id == city.id}">
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
						<input type="text" name="contactName" value="${data.data.contactName}" placeholder="联系人"/>
					</formTable:tr>
					<formTable:tr title='联系方式:'>
						<input type="text" name="phone"  value="${data.data.phone}" placeholder="联系方式"/>
					</formTable:tr>
					<formTable:tr title='始发港:'>
						<input name="startPort" type="text"  value="${data.data.startPort}" placeholder="始发港"/>
					</formTable:tr>
					<formTable:tr title='始发港(中文):'>
						<input name="startPortCn" type="text"  value="${data.data.startPortCn}" placeholder="始发港(中文)"/>
					</formTable:tr>
					<formTable:tr title='目的港:'>
						<input name="endPort" type="text"  value="${data.data.endPort}" placeholder="目的港"/>
					</formTable:tr>
					<formTable:tr title='目的港(中文):'>
						<input name="endPortCn" type="text"  value="${data.data.endPortCn}" placeholder="目的港(中文)"/>
					</formTable:tr>
					<formTable:tr title='走货开始日期:'>
						<input type="text" name="startDate" class="datepicker"  placeholder="走货开始日期" value="${data.data.startDate ? dateFormat.format(data.data.startDate): ''}" />
					</formTable:tr>
					<formTable:tr title='走货结束日期:'>
						<input type="text" name="endDate" class="datepicker"  placeholder="走货结束日期" value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" />
					</formTable:tr>
					<formTable:tr title='报价截止日期:'>
						<input type="text" name="biteEndDate" class="datepicker"  placeholder="报价截止日期" value="${data.data.biteEndDate ? dateFormat.format(data.data.biteEndDate): ''}" />
					</formTable:tr>
					<formTable:tr title='订单类型:'>
						<input name="orderType" type="text"  value="${data.data.orderType}" placeholder="订单类型:"/>
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
								<g:if test="${data.data.transType == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					
					<%-- <formTable:tr title='箱型'>
						<select name="trans" id="trans_Whole" class="selectpicker">
							<g:each in="${CargoBoxType.values()}" var="cargoboxtype">
								<g:if test="${data.data.cargoBoxType == cargoboxtype}">
									<option selected="selected" value="${cargoboxtype.name()}">${cargoboxtype.text}</option>
								</g:if>
								<g:else>
									<option value="${cargoboxtype.name()}">${cargoboxtype.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					--%>
					<g:if test="${data.str!=null }">
						<formTable:tr type="trans" name="trans_Whole" title="箱型:">
							<b>${data.GP20 }：</b><input type="number" name="cargoBoxNums" value="${data.GP20CargoBoxNums }"/>
							<b>${data.GP40 }：</b><input type="number" name="cargoBoxNums" value="${data.GP40CargoBoxNums }"/>
							<b>${data.HQ40 }：</b><input type="number" name="cargoBoxNums" value="${data.HQ40CargoBoxNums }"/>
							<b>${data.HQ45 }：</b><input type="number" name="cargoBoxNums" value="${data.HQ45CargoBoxNums }"/>
						</formTable:tr>
					</g:if>
					<g:if test="${data.str==null }">
						<g:if test="${data.data.cargoBoxType=='GP20' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型:">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
						<g:if test="${data.data.cargoBoxType=='GP40' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型:">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
						<g:if test="${data.data.cargoBoxType=='HQ40' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型:">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
						<g:if test="${data.data.cargoBoxType=='HQ45' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型:">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
							</formTable:tr>
							
						</g:if>
						
						<g:if test="${data.data.cargoBoxType==null }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型:">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
					</g:if>
					<formTable:tr type="trans" name="trans_Together" title='件数:'>
						<input name="cargoNums" type="text" class="transData" value="${data.data.cargoNums}" placeholder="件数"/>
					</formTable:tr>
					<formTable:tr title='毛重(KG):'>
						<input name="cargoWeight" type="text" class="transData" value="${data.data.cargoWeight}" placeholder="毛重(KG)"/>
					</formTable:tr>
					<formTable:tr title='体积(CBM):'>
						<input name="cargoCube" type="text" class="transData" value="${data.data.cargoCube}" placeholder="体积(CBM)"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='长(CM):'>
						<input name="cargoLength" type="text" class="transData" value="${data.data.cargoLength}" placeholder="长(CM"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='宽(CM):'>
						<input name="cargoWidth" type="text" class="transData" value="${data.data.cargoWidth}" placeholder="宽(CM)"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='高(CM):'>
						<input name="cargoHeight" type="text" class="transData" value="${data.data.cargoHeight}" placeholder="高(CM)"/>
					</formTable:tr>
					<formTable:tr title='货主备注:'>
						<textarea name="remark" placeholder="货主备注">${data.data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='员工备注:'>
						<textarea name="memo"  placeholder="员工备注">${data.data.memo}</textarea>
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
	$("#transTypeSelect").change(function() {
		var value = $(this).val();
		$("tr[type='trans']").hide();
		$("tr[name='trans_" + value + "']").show();
	});
	$("#transTypeSelect").change();
</script>
</body>
</html>