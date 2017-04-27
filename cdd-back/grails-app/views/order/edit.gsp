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
<title>货盘信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
			<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">货盘信息</div>
			<form action="${request.contextPath}/order/save" method="post" id="dataForm">
				<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
				</div>
				<input type="hidden" name="id" value="${data.data.id}" />
				<formTable:table>
					
					<g:if test="${springSecurityService.currentUser.isSupervisor() || springSecurityService.currentUser.isManager()}">
						<formTable:tr title='委派客服:'>
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
						<formTable:tr title='委派业务员:'>
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
					<formTable:tr title="起始港:">
						<input name="startPort" type="text" value="${data.data.startPort}" placeholder="起始港"/>
					</formTable:tr>
					
					<formTable:tr title="目的港:">
						<input name="endPort" type="text" value="${data.data.endPort}" placeholder="目的港"/>
					</formTable:tr>
					
					<formTable:tr title="货物类型:">
						<g:if test="${data.data.orderType=='家具' }">
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
					</formTable:tr>
					<formTable:tr title="公司:">
						<input name="companyName" type="text" value="${data.data.companyName}" placeholder="公司"/>
					</formTable:tr>
					<formTable:tr title="船公司:">
						<input name="shipCompany" type="text" value="${data.data.shipCompany}" placeholder="船公司"/>
					</formTable:tr>
					<formTable:tr title='货物名称:'>
						<input name="cargoName" type="text" value="${data.data.cargoName}" placeholder="货物名称"/>
					</formTable:tr>
					<formTable:tr title="运输类型:">
						<g:if test="${data.data.transType == TransportationType.Whole }">
							<input type="radio" name="transType" class="radio-box" value="Whole" id="zx" checked="checked"/> 
							<b class="box-style">整箱</b> 
							<input type="radio" name="transType" class="radio-box" id="px"/> 
							<b class="box-style">拼箱</b>
						</g:if>
						<g:if test="${data.data.transType == TransportationType.Together }">
							<input type="radio" name="transType" class="radio-box" value="Whole" id="zx"/> 
							<b class="box-style">整箱</b>
							<input type="radio" name="transType" class="radio-box" value="Together" id="px" checked="checked"/>
							 <b class="box-style">拼箱</b>
						</g:if>
						<g:if test="${data.data.transType == null }">
							<input type="radio" name="transType" class="radio-box" value="Whole" id="zx" checked="checked"/> 
							<b class="box-style">整箱</b> 
							<input type="radio" name="transType" class="radio-box" id="px"/> 
							<b class="box-style">拼箱</b>
						</g:if>
					</formTable:tr>
					<formTable:tr title="预计出货日:">
						<input name="endDate" class="datepicker" type="text" value="${data.data.endDate ? dateFormat.format(data.data.endDate): ''}" placeholder="预计出货日"/>
					</formTable:tr>
					
					<formTable:tr title="联系人:">
						<input name="contactName" type="text" value="${data.data.contactName}" placeholder="联系人"/>
					</formTable:tr>
					
					<formTable:tr title="联系方式:">
						<input name="phone" type="text" value="${data.data.phone}" placeholder="联系方式"/>
					</formTable:tr>
					
					<g:if test="${data.str!=null }">
						<formTable:tr type="trans" name="trans_Whole" title="箱型">
							<b>${data.GP20 }：</b><input type="number" name="cargoBoxNums" min="0" value="${data.GP20CargoBoxNums }"/>
							<b>${data.GP40 }：</b><input type="number" name="cargoBoxNums" min="0" value="${data.GP40CargoBoxNums }"/>
							<b>${data.HQ40 }：</b><input type="number" name="cargoBoxNums" min="0" value="${data.HQ40CargoBoxNums }"/>
							<b>${data.HQ45 }：</b><input type="number" name="cargoBoxNums" min="0" value="${data.HQ45CargoBoxNums }"/>
						</formTable:tr>
					</g:if>
					<g:if test="${data.str==null }">
						<g:if test="${data.data.cargoBoxType=='GP20' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
						<g:if test="${data.data.cargoBoxType=='GP40' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
						<g:if test="${data.data.cargoBoxType=='HQ40' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
						<g:if test="${data.data.cargoBoxType=='HQ45' }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="${data.data.cargoBoxNums }"/>
							</formTable:tr>
							
						</g:if>
						
						<g:if test="${data.data.cargoBoxType==null }">
							<formTable:tr type="trans" name="trans_Whole" title="箱型">
								<b>GP20：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>GP40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ40：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
								<b>HQ45：</b><input type="number" name="cargoBoxNums" min="0" value="0"/>
							</formTable:tr>
							
						</g:if>
					</g:if>
					<formTable:tr title='毛重(KG):'>
						<input name="cargoWeight" type="text" class="transData" value="${data.data.cargoWeight}" placeholder="毛重(KG)"/>
					</formTable:tr>
					<formTable:tr title='体积(CBM):'>
						<input name="cargoCube" type="text" class="transData" value="${data.data.cargoCube}" placeholder="体积(CBM)"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='件数:'>
						<input name="cargoNums" type="text" class="transData" value="${data.data.cargoNums}" placeholder="件数"/>
					</formTable:tr>
					<formTable:tr title='货主备注:'>
						<textarea name="remark" placeholder="货主备注">${data.data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='员工备注:'>
						<textarea name="memo" placeholder="员工备注">${data.data.memo}</textarea>
					</formTable:tr>
					<formTable:tr title='关闭理由:'>
						<textarea name="closeReason" placeholder="关闭理由">${data.data.closeReason}</textarea>
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
	$(function(){
		if($("#zx").attr("checked")){
			var value = $("#zx").val();
			$("tr[type='trans']").hide();
			$("tr[name='trans_" + value + "']").show();
		}

		if($("#px").attr("checked")){
			var value = $("#px").val();
			$("tr[type='trans']").hide();
			$("tr[name='trans_" + value + "']").show();
		}

	})
	
	$("#zx").click(function(){
		var value = $("#zx").val();
		$("tr[type='trans']").hide();
		$("tr[name='trans_" + value + "']").show();

	})
	
	$("#px").click(function(){
		var value = $("#zx").val();
		$("tr[type='trans']").show();
		$("tr[name='trans_" + value + "']").hide();

	})
	
</script>
</body>
</html>

