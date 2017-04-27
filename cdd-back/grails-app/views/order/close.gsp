<g:set var="springSecurityService" bean="springSecurityService" />
<g:set var="userService" bean="userService" />
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
<title>关闭货盘信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="block">
			<form action="${request.contextPath}/order/sureClosed" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.data.id}" />
				<formTable:table>
					<%-- <g:if test="${data.data.number}">
						<formTable:tr title='货盘编号'>
							<input type="text" readonly="readonly" value="${data.data.number}" />
						</formTable:tr>
					</g:if>--%>
					<g:if test="${springSecurityService.currentUser.isSupervisor() || springSecurityService.currentUser.isManager()}">
						<formTable:tr title='委派客服'>
							<select name="serviceId" class="selectpicker">
								<option value="">--请选择--</option>
								<g:each in="${userService.serviceList}" var="service">
									<g:if test="${data.data.service?.id == service.id}">
										<option selected="selected" value="${service.id}">${service.firstname}</option>
									</g:if>
									<g:else>
										<option value="${service.id}">${service.firstname}</option>
									</g:else>
								</g:each>
							</select>
						</formTable:tr>
					</g:if>
					<g:if test="${springSecurityService.currentUser.isService() && Status.VerifyPassed == data.data.status}">
						<formTable:tr title='委派业务员'>
							<select name="salesId" class="selectpicker">
								<option value="">--请选择--</option>
								<g:each in="${userService.salesList}" var="sales">
									<g:if test="${data.data.sales?.id == sales.id}">
										<option selected="selected" value="${sales.id}">${sales.firstname}</option>
									</g:if>
									<g:else>
										<option value="${sales.id}">${sales.firstname}</option>
									</g:else>
								</g:each>
							</select>
						</formTable:tr>
					</g:if>
					<formTable:tr title="起始港">
						<input name="startPort" type="text" value="${data.data.startPort}" readonly="readonly"/>
					</formTable:tr>
					
					<formTable:tr title="目的港">
						<input name="endPort" type="text" value="${data.data.endPort}" readonly="readonly"/>
					</formTable:tr>
					
					<formTable:tr title="货物类型">
						<input type="text" value="${data.data.orderType }" readonly="readonly"/>
						<%-- <g:if test="${data.data.orderType=='家具' }">
							<input type="radio"  name="orderType" class="radio-box" value="家具" checked="checked"/>
							<b class="box-style">家具</b>
							<input type="radio"  name="orderType" class="radio-box"  value="建材"/>
							<b class="box-style" >建材</b>
							<input type="radio" name="orderType" class="radio-box" value="服装"/>
							<b class="box-style">服装</b>
							<input type="radio" name="orderType" class="radio-box" value="其他"/>
							<b class="box-style">其他</b>
						</g:if>
						<g:elseif test="${data.data.orderType=='建材' }">
							<input type="radio"  name="orderType" class="radio-box" value="家具"/>
							<b class="box-style">家具</b>
							<input type="radio"  name="orderType" class="radio-box"  value="建材" checked="checked"/>
							<b class="box-style" >建材</b>
							<input type="radio" name="orderType" class="radio-box" value="服装"/>
							<b class="box-style">服装</b>
							<input type="radio" name="orderType" class="radio-box" value="其他"/>
							<b class="box-style">其他</b>
						</g:elseif>
						<g:elseif test="${data.data.orderType=='服装' }">
							<input type="radio"  name="orderType" class="radio-box" value="家具"/>
							<b class="box-style">家具</b>
							<input type="radio"  name="orderType" class="radio-box"  value="建材"/>
							<b class="box-style" >建材</b>
							<input type="radio" name="orderType" class="radio-box" value="服装" checked="checked"/>
							<b class="box-style">服装</b>
							<input type="radio" name="orderType" class="radio-box" value="其他"/>
							<b class="box-style">其他</b>
						</g:elseif>
						<g:else>
							<input type="radio"  name="orderType" class="radio-box" value="家具"/>
							<b class="box-style">家具</b>
							<input type="radio"  name="orderType" class="radio-box"  value="建材"/>
							<b class="box-style" >建材</b>
							<input type="radio" name="orderType" class="radio-box" value="服装"/>
							<b class="box-style">服装</b>
							<input type="radio" name="orderType" class="radio-box" value="其他" checked="checked"/>
							<b class="box-style">其他</b>
						</g:else>
						--%>
					</formTable:tr>
					<formTable:tr title="公司名称">
						<input name="companyName" type="text" value="${data.data.companyName}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title="船公司">
						<input name="shipCompany" type="text" value="${data.data.shipCompany}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title="联系人">
						<input name="contactName" type="text" value="${data.data.contactName}" readonly="readonly"/>
					</formTable:tr>
					
					<formTable:tr title="联系方式">
						<input name="phone" type="text" value="${data.data.phone}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title='货物名称'>
						<input name="cargoName" type="text" value="${data.data.cargoName}" readonly="readonly"/>
					</formTable:tr>
					<formTable:tr title="运输类型">
						<g:if test="${data.data.transType == TransportationType.Together }">
							<input type="text" value="拼箱" readonly="readonly"/>
							<formTable:tr title="预计出货日">
								<input name="endDate" type="text" value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" readonly="readonly"/>
							</formTable:tr>
							<formTable:tr title='件数'>
								<input name="cargoNums" type="text" class="transData" value="${data.data.cargoNums}" readonly="readonly"/>
							</formTable:tr>
							<formTable:tr title='毛重(KG)'>
								<input name="cargoWeight" type="text" class="transData" value="${data.data.cargoWeight}" readonly="readonly"/>
							</formTable:tr>
							<formTable:tr title='体积(CBM)'>
								<input name="cargoCube" type="text" class="transData" value="${data.data.cargoCube}" readonly="readonly"/>
							</formTable:tr>
						</g:if>
						
						<g:if test="${data.data.transType == TransportationType.Whole }">
							<input type="text" value="整箱" readonly="readonly"/>
							<formTable:tr title="预计出货日">
								<input name="endDate" type="text" value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" readonly="readonly"/>
							</formTable:tr>
							<g:if test="${data.str!=null }">
								<formTable:tr type="trans" name="trans_Whole" title="箱型">
									<b>${data.GP20 }：</b><input type="number" name="cargoBoxNums" value="${data.GP20CargoBoxNums }" readonly="readonly"/>
									<b>${data.GP40 }：</b><input type="number" name="cargoBoxNums" value="${data.GP40CargoBoxNums }" readonly="readonly"/>
									<b>${data.HQ40 }：</b><input type="number" name="cargoBoxNums" value="${data.HQ40CargoBoxNums }" readonly="readonly"/>
									<b>${data.HQ45 }：</b><input type="number" name="cargoBoxNums" value="${data.HQ45CargoBoxNums }" readonly="readonly"/>
								</formTable:tr>
							</g:if>
							<g:if test="${data.str==null }">
								<g:if test="${data.data.cargoBoxType == 'GP20' }">
									<formTable:tr type="trans" name="trans_Whole" title="箱型">
										<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
									</formTable:tr>
							
								</g:if>
								<g:if test="${data.data.cargoBoxType == 'GP40' }">
									<formTable:tr type="trans" name="trans_Whole" title="箱型">
										<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }" readonly="readonly"/>
										<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
									</formTable:tr>
								
								</g:if>
								<g:if test="${data.data.cargoBoxType == 'HQ40' }">
									<formTable:tr type="trans" name="trans_Whole" title="箱型">
										<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }" readonly="readonly"/>
										<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
									</formTable:tr>
								
								</g:if>
								<g:if test="${data.data.cargoBoxType == 'HQ45' }">
									<formTable:tr type="trans" name="trans_Whole" title="箱型">
										<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0" readonly="readonly"/>
										<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }" readonly="readonly"/>
									</formTable:tr>
								
								</g:if>
							</g:if>
							<formTable:tr title='毛重(KG)'>
								<input name="cargoWeight" type="text" class="transData" value="${data.data.cargoWeight}" readonly="readonly"/>
							</formTable:tr>
							<formTable:tr title='体积(CBM)'>
								<input name="cargoCube" type="text" class="transData" value="${data.data.cargoCube}" readonly="readonly"/>
							</formTable:tr>
						</g:if>
						
						<%-- <g:if test="${data.data.transType=='Whole' }">
							<input type="radio" name="transType" class="radio-box" value="Whole" id="zx" checked="checked"/> 
							<b class="box-style">整箱</b> 
							<input type="radio" name="transType" class="radio-box" id="px"/> 
							<b class="box-style">拼箱</b>
						</g:if>
						<g:if test="${data.data.transType=='Together' }">
							<input type="radio" name="transType" class="radio-box" value="Whole" id="zx"/> 
							<b class="box-style">整箱</b>
							<input type="radio" name="transType" class="radio-box" value="Together" id="px" checked="checked"/>
							 <b class="box-style">拼箱</b>
						</g:if>
						--%>
					</formTable:tr>
					
					<%-- <formTable:tr title='公司'>
						<input name="companyName" type="text" value="${data.data.companyName}" />
					</formTable:tr>--%>
					<%--<formTable:tr title='所在地'>
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
					<formTable:tr title='联系人'>
						<input name="contactName" type="text" value="${data.data.contactName}" />
					</formTable:tr>
					<formTable:tr title='联系方式'>
						<input name="phone" type="text" value="${data.data.phone}" />
					</formTable:tr>
					<formTable:tr title='始发港'>
						<input name="startPort" type="text" value="${data.data.startPort}" />
					</formTable:tr>
					<formTable:tr title='始发港(中文)'>
						<input name="startPortCn" type="text" value="${data.data.startPortCn}" />
					</formTable:tr>
					<formTable:tr title='目的港'>
						<input name="endPort" type="text" value="${data.data.endPort}" />
					</formTable:tr>
					<formTable:tr title='目的港(中文)'>
						<input name="endPortCn" type="text" value="${data.data.endPortCn}" />
					</formTable:tr>
					<formTable:tr title='走货开始日期'>
						<input name="startDate" class="datepicker" type="text" value="${data.data.startDate ? dateFormat.format(data.data.startDate): ''}" />
					</formTable:tr>
					<formTable:tr title='走货结束日期'>
						<input name="endDate" class="datepicker" type="text" value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" />
					</formTable:tr>
					<formTable:tr title='报价截止日期'>
						<input name="biteEndDate" class="datepicker" type="text" value="${data.data.biteEndDate ? dateFormat.format(data.data.biteEndDate): ''}" />
					</formTable:tr>
					<formTable:tr title='报价'>
						<input name="dealPrice" type="text" value="${data.data.dealPrice}" />
					</formTable:tr>
					<formTable:tr title='订单类型'>
						<input name="orderType" type="text" value="${data.data.orderType}" />
						
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
						 
					</formTable:tr>--%>
					<%--<formTable:tr title='运输类型'>
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
					 <formTable:tr type="trans" name="trans_Whole" title='箱型'>
						<select name="cargoBoxType" class="selectpicker transData">
							<option value="">--请选择--</option>
							<g:each in="${CargoBoxType.values()}" var="type">
								<g:if test="${data.data.cargoBoxType == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='数量'>
						<input name="cargoBoxNums" type="text" class="transData" value="${data.data.cargoBoxNums}" />
					</formTable:tr>--%>
					
					<%-- <formTable:tr type="trans" name="trans_Together" title='长(CM)'>
						<input name="cargoLength" type="text" class="transData" value="${data.data.cargoLength}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='宽(CM)'>
						<input name="cargoWidth" type="text" class="transData" value="${data.data.cargoWidth}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='高(CM)'>
						<input name="cargoHeight" type="text" class="transData" value="${data.data.cargoHeight}" />
					</formTable:tr>--%>
					<formTable:tr title='备注'>
						<textarea name="remark" readonly="readonly">${data.data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='关闭理由'>
						<textarea name="closeReason" id="closeReason"></textarea>
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="guanbi()" class="button button-glow button-rounded button-raised button-primary" style="margin-left: 500px;">确认关闭</a>
				<a href="javascript:;" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 80px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%><script>
	function guanbi(){
			
			if($("#closeReason").val()==""){
				BootstrapDialog.show({
					message: '关闭理由不能为空'
					});
					return false;
			}
		  $('#dataForm').submit();
		}

	$("#back").click(function(){
		
		window.close()

	})

</script>
</body>
</html>
